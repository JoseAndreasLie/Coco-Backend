import httpStatus from 'http-status';
import * as bcrypt from 'bcrypt';
import { Request, Response } from 'express';
import { logger } from '../../config/logger';
import UserDao from '../../dao/implementations/UserDao';
import UserBookingsDao from '../../dao/implementations/UserBookingsDao';
import BookingsDao from '../../dao/implementations/BookingsDao';
import ActivityPackagesDao from '../../dao/implementations/ActivityPackagesDao';
import responseHandler from '../../helper/responseHandler';
import { sequelize } from '../../models';
import models from '../../models';
import ActivitiesDao from '../../dao/implementations/ActivitiesDao';

require('dotenv').config();
const nodemailer = require('nodemailer');

export default class ActivitiesService {
    private userDao: UserDao;
    private userBookingsDao: UserBookingsDao;
    private bookingsDao: BookingsDao;
    private activityPackagesDao: ActivityPackagesDao;
    private activitiesDao: ActivitiesDao;

    constructor() {
        this.userDao = new UserDao();
        this.userBookingsDao = new UserBookingsDao();
        this.bookingsDao = new BookingsDao();
        this.activityPackagesDao = new ActivityPackagesDao();
        this.activitiesDao = new ActivitiesDao();
    }

    getBookingById = async (user_id: string) => {
        try {
            const user = await this.userDao.findOne({
                where: { id: user_id },
            });

            if (!user) {
                throw { status: httpStatus.NOT_FOUND, message: 'User not found' };
            }

            const userEmail = user.email;
            const userBookings = await this.userBookingsDao.findAllBookings(userEmail);

            const flattened = userBookings.map((item) => ({
                ...item,
                planner: undefined,
                booking: undefined,
                date: item.booking?.date,
                is_planner: item.planner?.id === user_id,
                planner_name: item.planner?.name,
                // planner_id: item.planner?.id,
                activity_title: item.booking?.package?.activity?.activity_title,
                destination_name: item.booking?.package?.activity?.destination?.destination_name,
                destination_image: item.booking?.package?.activity?.destination?.destination_image,
            }));

            return flattened;
        } catch (e) {
            logger.error(e);
            throw e;
        }
    };

    getBookingDetailsById = async (booking_id: string, user_id: string) => {
        try {
            const booking = await this.bookingsDao.findBooking(booking_id);

            const b = booking.toJSON();

            const flattened = {
                ...b,
                package: undefined,
                planner: undefined,
                user_booking: undefined,
                planner_name: b.planner?.planner_name,
                planner_email: b.planner?.planner_email,
                is_planner: b.planner?.id === user_id,
                activity: undefined,
                activity_title: b.package?.activity?.activity_title,
                package_name: b.package.package_name,
                destination_name: b.package?.activity?.destination?.destination_name,
                destination_image: b.package?.activity?.destination?.destination_image,
                longitude: b.package?.activity?.destination?.longitude,
                latitude: b.package?.activity?.destination?.latitude,
                vendor_name: b.package?.host?.host_name,
                vendor_contact: b.package?.host?.host_contact,
                important_notice: b.package?.important_notice,
                included_accessories:
                    b.package?.activity?.accessories?.map((acc) => acc.name) || [],
                member_emails:
                b.user_booking
                    .map((acc) => acc.member_email)
                    .filter((email) => email && email.toLowerCase() !== b.planner?.planner_email.toLowerCase()) || [],
            };

            return flattened;
        } catch (e) {
            logger.error(e);
            throw e;
        }
    };

    createBooking = async (req: Request, res: Response) => {
        const t = await sequelize.transaction();
        try {
            const bookingData = req.body;

            const {
                p_package_id: package_id,
                p_booking_date: booking_date,
                p_participants: participants,
                p_user_id: user_id,
            } = bookingData;

            const user = await this.userDao.findOne({
                where: {
                    id: user_id,
                },
            });

            if (!user) {
                throw { status: httpStatus.NOT_FOUND, message: 'User not found' };
            }

            const selectedPackage = await this.activityPackagesDao.findOne({
                where: { id: package_id },
            });

            if (!selectedPackage) {
                throw { status: httpStatus.NOT_FOUND, message: 'Activity package not found' };
            }
            const total_price = selectedPackage.price_per_person * participants;
            const data = {
                user_id,
                availability_id: null,
                participants,
                total_price,
                status: 'Upcoming',
                date: booking_date,
                activity_package_id: package_id,
                planner_id: user_id,
            };

            const newBooking = await this.bookingsDao.createWithTransaction(data, {
                transaction: t,
            });
            const userBooking = await this.userBookingsDao.createWithTransaction(
                {
                    user_id,
                    booking_id: newBooking.id,
                    email: user.email,
                    status: 'Upcoming',
                    planner_id: user_id,
                },
                { transaction: t }
            );
            const activityPackages =
                await this.activityPackagesDao.findDestinationByPackageId(package_id);

            const activity = await this.activitiesDao.findOne({
                where: { id: selectedPackage.activity_id },
            });
            // Format the date to yyyy-mm-dd
            const formatDate = (date: Date | string) => {
                const d = new Date(date);
                return d.toISOString().split('T')[0]; // Returns yyyy-mm-dd format
            };

            const booking_details = {
                status: 'confirmed',
                address: selectedPackage.address,
                booking_id: newBooking.id,
                start_time: '12:00:00',
                destination: activityPackages.activity.destination,
                total_price: total_price,
                package_name: selectedPackage.name,
                participants: participants,
                activity_date: formatDate(newBooking.date),
                activity_title: activity.title,
                booking_created_at: newBooking.created_at,
            };

            const result = {
                message: 'Booking confirmed successfully.',
                success: true,
                booking_details,
            };

            await t.commit();
            return result;
        } catch (e) {
            logger.error(e);
            await t.rollback();
            throw e;
        }
    };

    createUserBookingsByEmails = async (booking_id: string, emails: string[]) => {
        const transaction = await models.sequelize.transaction();

        interface NewUserBooking {
            user_id: string;
            email: string;
            booking_id: string;
            status: string;
            planner_id: string;
        }

        const newEntries: NewUserBooking[] = [];

        try {
            const booking = await this.bookingsDao.findBooking(booking_id);
            if (!booking) {
                throw { status: httpStatus.NOT_FOUND, message: 'Booking not found' };
            }

            const planner_id = booking.planner.id;
            // const planner = await this.userDao.findOne({ where: { id: planner_id } });
            // if (!planner) {
            //     throw { status: httpStatus.NOT_FOUND, message: 'Planner not found' };
            // }

            // emails.push(planner.email);

            const existingBookings = await models.user_bookings.findAll({
                where: { booking_id },
            });

            for (const eb of existingBookings) {
                await eb.destroy();
            }

            for (const email of emails) {
                const user = await this.userDao.findByEmail(email);

                const existing = await models.user_bookings.findOne({
                    where: { booking_id, email },
                    transaction,
                });

                newEntries.push({
                    user_id: user ? user.id : null,
                    email,
                    booking_id,
                    status: 'Pending',
                    planner_id,
                });
            }

            const created = await models.user_bookings.bulkCreate(newEntries, { transaction });

            const updatedParticipants = created.length;
            const updatedTotalPrice = (booking.total_price / booking.participants) * created.length;

            // const updated = await models.bookings.update(
            //     {
            //         participants: updatedParticipants,
            //         total_price: updatedTotalPrice,
            //     },
            //     { where: { id: booking_id }, transaction }
            // );

            await transaction.commit();

            // Send email only if email configuration is available
            if (process.env.EMAIL_HOST && process.env.EMAIL_USER && process.env.EMAIL_PASS) {
                try {
                    const transporter = nodemailer.createTransport({
                        host: process.env.EMAIL_HOST,
                        port: process.env.EMAIL_PORT ? parseInt(process.env.EMAIL_PORT) : 587,
                        secure: true,
                        auth: {
                            user: process.env.EMAIL_USER,
                            pass: process.env.EMAIL_PASS,
                        },
                    });

                    const mailOptions = {
                        from: `"Coco.co" <${process.env.EMAIL_USER}>`,
                        to: `"no-reply" <${process.env.EMAIL_USER}>`,
                        bcc: emails,
                        subject: `Invitation to Join a Trip on coco.co`,
                        text: `Dear coco.co Member,

You have been invited to join an upcoming trip through coco.co.

To view more details and confirm your participation, please click the link below:
👉 https://testflight.apple.com/join/u61YVTya

By joining this trip, you will be able to:
• Access all trip details in one place
• Share the trip with friends or family members
• Stay updated with real-time notifications

If you haven't installed the coco.co app yet, you can download it via the App Store to get the full experience.

We look forward to seeing you on this trip! 🚀

Best regards,
The coco.co Team`,
                    };

                    await transporter.sendMail(mailOptions);
                } catch (emailError) {
                    // Log email error but don't fail the entire operation
                    logger.error('Email sending failed:', emailError);
                }
            } else {
                logger.warn('Email configuration not found, skipping email notification');
            }

            return created;
        } catch (e) {
            // Only rollback if transaction is still active
            if (!transaction.finished) {
                await transaction.rollback();
            }
            logger.error(e);
            throw e;
        }
    };
}
