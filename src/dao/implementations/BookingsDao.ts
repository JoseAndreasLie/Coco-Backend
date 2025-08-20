import models from '../../models';
import IBookingsDao from '../contracts/IBookingsDao';
import SuperDao from './SuperDao';

const Bookings = models.bookings;

export default class BookingsDao extends SuperDao implements IBookingsDao {
    constructor() {
        super(Bookings);
    }

    findBookingById(booking_id: string) {
        const booking = Bookings.findOne({
            where: { booking_id: booking_id },
            attributes: {
                exclude: ['created_at', 'updated_at', 'deleted_at']
            }
        });
        return booking;
    }
    
}
