import { Router } from 'express';
import AuthController from '../controllers/AuthController';
import ActivitiesController from '../controllers/ActivitiesController';
import { auth } from '../middlewares/auth';

const router = Router();

const activitiesController = new ActivitiesController();

router.get(
    '/', 
    auth(),
    activitiesController.getAllActivities
);

export default router;
