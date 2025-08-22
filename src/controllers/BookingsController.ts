import { Request, Response } from 'express';
import httpStatus from 'http-status';
import { ApiServiceResponse } from '../@types/apiServiceResponse';
import { logger } from '../config/logger';
import BookingsService from '../service/implementations/BookingsService';

export default class BookingsController {
    private bookingsService: BookingsService;

    constructor() {
        this.bookingsService = new BookingsService();
    }

    getBookingsByEmail = async (req: Request, res: Response) => {
        const { p_user_id } = req.body;

        if (!p_user_id) {
            return res.status(httpStatus.BAD_REQUEST).send('User ID is required');
        }

        try {
            const bookings: ApiServiceResponse = await this.bookingsService.getBookingById(
                p_user_id
            );
            res.status(httpStatus.OK).send(bookings);
        } catch (e) {
            logger.error(e);
            res.status(httpStatus.BAD_GATEWAY).send(e);
        }
    };

    getBookingDetailsById = async (req: Request, res: Response) => {
        const { booking_id } = req.body;

        if (!booking_id) {
            return res.status(httpStatus.BAD_REQUEST).send('Booking ID is required');
        }

        try {
            const bookings: ApiServiceResponse = await this.bookingsService.getBookingDetailsById(
                booking_id
            );
            res.status(httpStatus.OK).send(bookings);
        } catch (e) {
            logger.error(e);
            res.status(httpStatus.BAD_GATEWAY).send(e);
        }
    }

    createUserBookingsByEmails = async (req: Request, res: Response) => {
        const { booking_id } = req.body;
        const { emails } = req.body;

        if (!booking_id) {
            return res.status(httpStatus.BAD_REQUEST).send('Booking ID is required');
        }

        if (!emails) {
            return res.status(httpStatus.BAD_REQUEST).send('Emails are required');
        }

        try {
            const user_bookings: ApiServiceResponse = await this.bookingsService.createUserBookingsByEmails(
                booking_id,
                emails
            );
            res.status(httpStatus.OK).send(user_bookings);
        } catch (e) {
            logger.error(e);
            res.status(httpStatus.BAD_GATEWAY).send(e);
        }
    }
}
