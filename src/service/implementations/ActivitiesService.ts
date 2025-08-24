import httpStatus from 'http-status';
import * as bcrypt from 'bcrypt';
import { Request, Response } from 'express';
import { logger } from '../../config/logger';
import UserDao from '../../dao/implementations/UserDao';
import ActivitiesDao from '../../dao/implementations/ActivitiesDao';
import ActivityPackagesDao from '../../dao/implementations/ActivityPackagesDao';
import responseHandler from '../../helper/responseHandler';

export default class ActivitiesService {
    private userDao: UserDao;
    private activitiesDao: ActivitiesDao;
    private activityPackagesDao: ActivityPackagesDao;

    constructor() {
        this.userDao = new UserDao();
        this.activitiesDao = new ActivitiesDao();
        this.activityPackagesDao = new ActivityPackagesDao();
    }

    getAllActivities = async () => {
        try {
            const activities = await this.activitiesDao.findAllWithDetails();

            return activities;
        } catch (e) {
            logger.error(e);
            throw e;
        }
    };

    getActivityPackages = async (activityId: number) => {
        try {
            const packages = await this.activityPackagesDao.findAllActivityPackages(activityId);
            return packages;
        } catch (e) {
            logger.error(e);
            throw e;
        }
    };
}
