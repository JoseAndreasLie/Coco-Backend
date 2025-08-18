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

    getFlashSaleList = async (userInfo) => {
        try {
            // // Assuming there's a method in UserDao to get the flash sale list
            // const flashSaleList = await this.userDao.getFlashSaleList();
            console.log('Fetching flash sale list for user:', userInfo);
            const flashSaleList = [
                {
                    // Sample data structure
                    id: 1,
                    title: 'Flash Sale 1',
                    discount: 50,
                    startTime: new Date(),
                    endTime: new Date(),
                },
                {
                    "userInfo": userInfo, // Include user info in the response
                },
            ];
            return responseHandler.returnSuccess(
                httpStatus.OK,
                'Flash Sale List Retrieved',
                flashSaleList
            );
        } catch (e) {
            logger.error(e);
            return responseHandler.returnError(httpStatus.BAD_GATEWAY, 'Something Went Wrong!!');
        }
    };
}
