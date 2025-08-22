import { Router } from 'express';
import authRoute from './authRoute';
import flashsaleRoute from './flashsaleRoute';
import activitiesRoute from './activitiesRoute';
import { auth } from '../middlewares/auth';

// import controllers
import ActivitiesController from '../controllers/ActivitiesController';
import AuthController from '../controllers/AuthController';
import BookingsController from '../controllers/BookingsController'

const router = Router();


// declare to const for controllers
const activitiesController = new ActivitiesController();
const authController = new AuthController();
const bookingsController = new BookingsController();


router.post(
    '/rpc/login', 
    authController.login
);

router.post(
    '/rpc/search_detailed_activities', 
    // auth() ,
    activitiesController.getAllActivities
);

router.get(
    '/activity_packages',
    // auth(),
    activitiesController.getActivityPackages
);

router.post(
    '/rpc/get_user_bookings',
    // auth(),
    bookingsController.getBookingsByEmail
);

router.post(
    '/rpc/create_booking',
    // auth(),
    bookingsController.createBooking
);

router.post(
    '/rpc/create_booking',
    // auth(),
    bookingsController.createBooking
);

router.post(
    '/rpc/get_booking_details',
    // auth(),
    bookingsController.getBookingDetailsById
);

router.post(
    '/rpc/get_top_destinations',
    // auth(),
    activitiesController.getTopDestination
);

router.post(
    '/rpc/create_user_bookings',
    // auth(),
    bookingsController.createUserBookingsByEmails
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
