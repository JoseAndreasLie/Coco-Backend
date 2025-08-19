import models from '../../models';
import IUserBookingsDao from '../contracts/IUserBookingsDao';
import SuperDao from './SuperDao';
import { Sequelize } from 'sequelize';

const UserBookings = models.user_bookings;

export default class UserBookingsDao extends SuperDao implements IUserBookingsDao {
    constructor() {
        super(UserBookings);
    }

    findAllBookings(user_id: string) {
        const userBookings = UserBookings.findAll({
            where: { user_id: user_id },
            attributes: [
                'booking_id',
                [Sequelize.col('booking.status'), 'status'],
                [Sequelize.col('booking.participants'), 'participants'],
                [Sequelize.col('booking.total_price'), 'total_price'],
                [Sequelize.col('booking.created_at'), 'booking_created_at'],
                [Sequelize.col('booking.availability.date'), 'activity_date'],
                [Sequelize.col('booking.availability.start_time'), 'start_time'],
                [Sequelize.col('booking.availability.package.name'), 'package_name'],
                [Sequelize.col('booking.availability.package.address'), 'address'],
                [Sequelize.col('booking.availability.package.activity.title'), 'activity_title'],
                [Sequelize.col('booking.availability.package.activity.destination.id'), 'destination_id'],
                [Sequelize.col('booking.availability.package.activity.destination.name'), 'destination_name'],
                [Sequelize.col('booking.availability.package.activity.destination.description'), 'destination_description'],
                [Sequelize.col('booking.availability.package.activity.destination.image_url'), 'destination_image_url']
            ],
            include: [
                {
                    model: models.bookings,
                    as: 'booking',
                    attributes: [],
                    include: [
                        {
                            model: models.activity_availabilities,
                            as: 'availability',
                            attributes: [],
                            include: [
                                {
                                    model: models.activity_packages,
                                    as: 'package',
                                    attributes: [],
                                    include: [
                                        {
                                            model: models.activities,
                                            as: 'activity',
                                            attributes: [],
                                            include: [
                                                {
                                                    model: models.destinations,
                                                    as: 'destination',
                                                    attributes: []
                                                }
                                            ]
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
                }
            ]
        });
        return userBookings;
    }
}
