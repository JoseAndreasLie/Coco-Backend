import models from '../../models';
import IActivitiesDao from '../contracts/IActivitiesDao';
import SuperDao from './SuperDao';

const Activities = models.activities;

export default class ActivitiesDao extends SuperDao implements IActivitiesDao {
    constructor() {
        super(Activities);
    }

    findAllWithDetails() {
        const activities = models.activities.findAll({
            attributes: ['id', 'title', 'pricing', 'cancelable', 'created_at', 'description', 'duration_minutes'],
            include: [
                { 
                    model: models.categories, 
                    as: 'category',
                    attributes: ['id', 'name', 'description']
                },
                { 
                    model: models.destinations, 
                    as: 'destination',
                    attributes: ['id', 'name', 'description', 'image_url']

                },
                { 
                    model: models.accessories, 
                    as: 'accessories',
                    attributes: ['id', 'name'],
                    // to remove the through table attributes
                    through: {
                        attributes: []
                    }
                },
                {
                    model: models.activity_packages,
                    as: 'packages',
                    attributes: {
                        exclude: ['activity_id', 'host_id', 'created_at', 'updated_at', 'deleted_at']
                    },
                    include: [
                        {
                            model: models.hosts,
                            as: 'host',
                            attributes: ['id', 'bio', 'name', 'profile_image_url']
                        }
                    ]
                },
                {
                    model: models.activity_images,
                    as : 'images',
                    attributes: ['id', 'image_url', 'image_type', /* Activity Id not neccessary */ 'activity_id']
                }
            ],
        });
        return activities;
    }
}
