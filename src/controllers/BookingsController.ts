import { Request, Response } from 'express';
import httpStatus from 'http-status';
import { ApiServiceResponse } from '../@types/apiServiceResponse';
import { logger } from '../config/logger';
import BookingsService from '../service/implementations/BookingsService';

export default class AuthController {
    private bookingsService: BookingsService;

    constructor() {
        this.bookingsService = new BookingsService();
    }

    getBookingsByEmail = async (req: Request, res: Response) => {
        const { email } = req.query;

        if (!email) {
            return res.status(httpStatus.BAD_REQUEST).send('Email is required');
        }

        try {
            const bookings: ApiServiceResponse = await this.bookingsService.getBookingByEmail(
                String(email)
            );
            res.status(httpStatus.OK).send(bookings);
        } catch (e) {
            logger.error(e);
            res.status(httpStatus.BAD_GATEWAY).send(e);
        }
    };

}
