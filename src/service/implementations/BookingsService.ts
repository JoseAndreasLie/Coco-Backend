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

export default class ActivitiesService {
    private userDao: UserDao;
    private userBookingsDao: UserBookingsDao;
    private bookingsDao: BookingsDao;
    private activityPackagesDao: ActivityPackagesDao;

    constructor() {
        this.userDao = new UserDao();
        this.userBookingsDao = new UserBookingsDao();
        this.bookingsDao = new BookingsDao();
        this.activityPackagesDao = new ActivityPackagesDao();
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
                booking: undefined,
                planner: undefined,
                date: item.booking?.date,
                planner_name: item.planner?.planner_name,
                planner_id: item.planner?.id,
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

    getBookingDetailsById = async (booking_id: string) => {
        try {
            const booking = await this.bookingsDao.findBooking(booking_id);

            const b = booking.toJSON();

            const flattened = {
                ...b,
                package: undefined,
                planner: undefined,
                user_booking: undefined,
                planner_name: b.planner?.planner_name,
                activity: undefined,
                activity_title: b.package?.activity?.activity_title,
                package_name: b.package.package_name,
                destination_name: b.package?.activity?.destination?.destination_name,
                destination_image: b.package?.activity?.destination?.destination_image,
                longitude: b.package?.activity?.destination?.longitude,
                latitude: b.package?.activity?.destination?.latitude,
                vendor_contact: b.package?.activity?.host?.host_contact,
                important_notice: b.package?.important_notice,
                included_accessories:
                    b.package?.activity?.accessories?.map((acc) => acc.name) || [],
                member_emails: b.user_booking.map((acc) => acc.member_email) || [],
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

            const booking_details = {
                status: 'confirmed',
                address: selectedPackage.address,
                booking_id: newBooking.id,
                start_time: '12:00:00',
                destination: activityPackages.activity.destination,
                total_price: total_price,
                package_name: selectedPackage.name,
                participants: participants,
                activity_date: newBooking.date,
                activity_title: activityPackages.activity.title,
                booking_created_at: newBooking.created_at,
            };

            await t.commit();
            return booking_details;
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

            for (const email of emails) {
                const user = await this.userDao.findByEmail(email);

                const existing = await models.user_bookings.findOne({
                    where: { booking_id, email },
                    transaction,
                });

                if (existing) {
                    await existing.update({ deleted_at: new Date() }, { transaction });
                }

                newEntries.push({
                    user_id: user ? user.id : null,
                    email,
                    booking_id,
                    status: 'Pending',
                    planner_id,
                });
            }

            const result = await models.user_bookings.bulkCreate(newEntries, { transaction });
            await transaction.commit();

            return result;
        } catch (e) {
            await transaction.rollback();
            logger.error(e);
            throw e;
        }
    };
}
