import { Request, Response } from 'express';
import httpStatus from 'http-status';
import { ApiServiceResponse } from '../@types/apiServiceResponse';
import { logger } from '../config/logger';
import ActivitiesService from '../service/implementations/ActivitiesService';

export default class ActivitiesController {
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

    getActivityPackages = async (req: Request, res: Response) => {
        const { activity_id } = req.query;

        // if the activity_id consist of "eq." string, remove it
        if (!activity_id) {
            return res.status(httpStatus.BAD_REQUEST).send('Activity ID is required');
        }
        const cleaned_activity_id = activity_id.toString().replace(/^eq\./, '');

        try {
            const packages: ApiServiceResponse = await this.activitiesService.getActivityPackages(
                Number(cleaned_activity_id)
            );
            res.status(httpStatus.OK).send(packages);
        } catch (e) {
            logger.error(e);
            res.status(httpStatus.BAD_GATEWAY).send(e);
        }
    };

    getTopDestination = async (req: Request, res: Response) => {
        try {
            const topDestinations = 
            [
                {
                    id: 2,
                    name: 'Komodo National Park, NTT',
                    description:
                        'A UNESCO World Heritage site, home to the iconic Komodo dragon and offering dramatic landscapes and vibrant dive sites.',
                    activity_count: 3,
                },
                {
                    id: 3,
                    name: 'Gili Trawangan, Bali',
                    description:
                        'The largest of the three Gili Islands, known for its vibrant nightlife, beautiful beaches, and excellent snorkeling with sea turtles.',
                    activity_count: 2,
                },
                {
                    id: 1,
                    name: 'Raja Ampat, West Papua',
                    description:
                        'An archipelago of over 1,500 islands, famous for its world-class coral reef biodiversity and pristine marine life.',
                    activity_count: 2,
                },
                {
                    id: 5,
                    name: 'Bunaken, North Sulawesi',
                    description:
                        'A marine park at the heart of the Coral Triangle, featuring spectacular, deep coral walls teeming with fish.',
                    activity_count: 2,
                },
                {
                    id: 12,
                    name: 'Yogyakarta, DI Yogyakarta',
                    description:
                        'The cultural soul of Java, home to ancient temples like Borobudur and Prambanan, as well as rich Javanese arts.',
                    activity_count: 2,
                },
            ];
            
            res.status(httpStatus.OK).send(topDestinations);
        } catch (e) {
            logger.error(e);
            res.status(httpStatus.BAD_GATEWAY).send(e);
        }
    };
}
