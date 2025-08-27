import models from '../../models';
import IBookingsDao from '../contracts/IBookingsDao';
import SuperDao from './SuperDao';

const Bookings = models.bookings;

export default class BookingsDao extends SuperDao implements IBookingsDao {
    constructor() {
        super(Bookings);
    }

    findBooking(booking_id: string) {
        const booking = Bookings.findOne({
            where: { id : booking_id },
            attributes: [['id', 'booking_id'], 'date', 'participants', 'total_price', 'status'],
            include: [
                {
                    model: models.activity_packages,
                    as: 'package',
                    attributes: [['name', 'package_name'], 'address', ['notice', 'important_notice']],
                    include: [
                        {
                            model: models.activities,
                            as: 'activity',
                            attributes: [['title', 'activity_title']],
                            include: [
                                {
                                    model: models.accessories, 
                                    as: 'accessories',
                                    attributes: ['name'],
                                    through: {
                                        attributes: []
                                    }
                                },
                                {
                                    model: models.destinations,
                                    as: 'destination',
                                    attributes: [['name', 'destination_name'], ['image_url', 'destination_image'], 'longitude', 'latitude']
                                }
                            ]
                        },
                        {
                            model: models.hosts,
                            as: 'host',
                            attributes: [['name', 'host_name'], ['contact', 'host_contact']]
                        }
                    ]
                },
                {
                    model: models.users,
                    as: 'planner',
                    attributes: [['name', 'planner_name'], 'id', ['email', 'planner_email']]
                },
                {
                    model: models.user_bookings, 
                    as: 'user_booking',
                    attributes: [['email', 'member_email']]
                }
            ]
        });
        return booking;
    }
    
}
