import { isJsxAttribute } from 'typescript';
import models from '../../models';
import IUserBookingsDao from '../contracts/IUserBookingsDao';
import SuperDao from './SuperDao';
import { Sequelize } from 'sequelize';

const UserBookings = models.user_bookings;

export default class UserBookingsDao extends SuperDao implements IUserBookingsDao {
    constructor() {
        super(UserBookings);
    }

    async findAllBookings(email: string) {
        const userBookings = await UserBookings.findAll({
            where : { email : email },
            attributes : {
                exclude: ['created_at', 'updated_at', 'deleted_at']
            },
            include : [
                {
                    model: models.bookings,
                    as: 'booking',
                    attributes: [['id', 'booking_id'], 'date'],
                    include : [
                        {
                            model: models.activity_packages,
                            as: 'package',
                            attributes: [['id', 'activity_package_id'], 'activity_id'],
                            include : [
                                {
                                    model: models.activities,
                                    as: 'activity',
                                    attributes: [['title', 'activity_title'], 'destination_id'],
                                    include : [
                                        {
                                            model: models.destinations,
                                            as: 'destination',
                                            attributes: [['name', 'destination_name'], ['image_url', 'destination_image']]
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
                },
                {
                    model: models.users,
                    as: 'planner',
                    attributes: ['id', 'name']
                }
            ]
        });
        console.log(userBookings.booking);
        const plainBookings = userBookings.map(b => b.toJSON());


        return plainBookings;
    }
}
