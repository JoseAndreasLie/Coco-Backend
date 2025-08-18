import models from '../../models';
import IActivityPackagesDao from '../contracts/IActivityPackagesDao';
import SuperDao from './SuperDao';

const ActivityPackages = models.activity_packages;

export default class ActivityPackagesDao extends SuperDao implements IActivityPackagesDao {
    constructor() {
        super(ActivityPackages);
    }

    findAllActivityPackages(activity_id : number) {
        const activityPackages = ActivityPackages.findAll({
            where: { activity_id: activity_id },
            attributes: {
                exclude: ['created_at', 'updated_at', 'deleted_at']
            }
        });
        return activityPackages;
    }
}
