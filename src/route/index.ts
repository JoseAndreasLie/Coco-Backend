import { Router } from 'express';
import authRoute from './authRoute';
import flashsaleRoute from './flashsaleRoute';
import activitiesRoute from './activitiesRoute';
import { auth } from '../middlewares/auth';

// import controllers
import ActivitiesController from '../controllers/ActivitiesController';
import AuthController from '../controllers/AuthController';

const router = Router();


// declare to const for controllers
const activitiesController = new ActivitiesController();
const authController = new AuthController();


router.post(
    '/rpc/login', 
    authController.login
);

router.get(
    '/', 
    // auth(),
    activitiesController.getAllActivities
);

const defaultRoutes = [
    {
        path: '/auth',
        route: authRoute,
    },
];

defaultRoutes.forEach((route) => {
    router.use(route.path, route.route);
});

export default router;
