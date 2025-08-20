import httpStatus from 'http-status';
import * as bcrypt from 'bcrypt';
import { Request, Response } from 'express';
import { logger } from '../../config/logger';
import UserDao from '../../dao/implementations/UserDao';
import UserBookingsDao from '../../dao/implementations/UserBookingsDao';
import BookingsDao from '../../dao/implementations/BookingsDao';
import responseHandler from '../../helper/responseHandler';

export default class ActivitiesService {
    private userDao: UserDao;
    private userBookingsDao: UserBookingsDao;
    private bookingsDao: BookingsDao;

    constructor() {
        this.userDao = new UserDao();
        this.userBookingsDao = new UserBookingsDao();
        this.bookingsDao = new BookingsDao();
    }

    getBookingById = async (user_id: string) => {
        try {
            const user = await this.userDao.findOne(
                { 
                    where: { id : user_id } 
                }
            );

            if (!user) {
                throw { status: httpStatus.NOT_FOUND, message: 'User not found' };
            }

            const userEmail = user.email;
            const userBookings = await this.userBookingsDao.findAllBookings(userEmail);

            const flattened = userBookings.map(item => ({
                ...item,
                booking: undefined,
                planner: undefined,
                date: item.booking?.date,
                planner_name: item.planner?.planner_name,
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
                users: undefined,
                planner_name: b.planner?.planner_name,
                activity: undefined, 
                activity_title: b.package?.activity?.activity_title, 
                package_name: b.package.package_name,
                destination_name: b.package?.activity?.destination?.destination_name,
                destination_image: b.package?.activity?.destination?.destination_image,
                vendor_contact: b.package?.activity?.host?.host_contact,
                important_notice: b.package?.important_notice,
                included_accessories: b.package?.activity?.accessories?.map(acc => acc.name) || [],
                member_emails: b.users.map(acc => acc.member_email) || []
            };

            return flattened;

        } catch (e) {
            logger.error(e);
            throw e;
        }
    };

}
