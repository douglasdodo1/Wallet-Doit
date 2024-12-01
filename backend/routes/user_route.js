import express from 'express';
import UserController from '../controllers/user_controller.js';

const router = express.Router();

router.post('/users', UserController.createUser);

export default router; 
