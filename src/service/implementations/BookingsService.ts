import httpStatus from 'http-status';
import * as bcrypt from 'bcrypt';
import { Request, Response } from 'express';
import { logger } from '../../config/logger';
import UserDao from '../../dao/implementations/UserDao';
import UserBookingsDao from '../../dao/implementations/UserBookingsDao';
import responseHandler from '../../helper/responseHandler';

export default class ActivitiesService {
    private userDao: UserDao;
    private userBookingsDao: UserBookingsDao;

    constructor() {
        this.userDao = new UserDao();
        this.userBookingsDao = new UserBookingsDao();
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

            const { booking } = userBookings

            console.log(booking)

            return userBookings;

        } catch (e) {
            logger.error(e);
            throw e;
        }
    };

}
