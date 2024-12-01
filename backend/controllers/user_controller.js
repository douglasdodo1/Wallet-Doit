import UserService from '../services/user_service.js';

export default class UserController {
    static createUser = async(req,res) => {
        try {
            const user = await UserService.create(req.body);
            res.status(201).json(user);
        } catch (error) {
            res.status(400).json({ error: error.message });
        }
    }
}
