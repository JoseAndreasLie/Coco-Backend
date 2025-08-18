import { Request, Response } from 'express';
import httpStatus from 'http-status';
import { ApiServiceResponse } from '../@types/apiServiceResponse';
import { logger } from '../config/logger';
import ActivitiesService from '../service/implementations/ActivitiesService';

export default class AuthController {

    private activitiesService: ActivitiesService;

    constructor() {
        this.activitiesService = new ActivitiesService();
    }

    getAllActivities = async (req: Request, res: Response) => {
        try {
            const activities: ApiServiceResponse = await this.activitiesService.getAllActivities();
            
            res.status(httpStatus.OK).send(activities);
        } catch (e) {
            logger.error(e);
            res.status(httpStatus.BAD_GATEWAY).send(e);
        }
    };
}
