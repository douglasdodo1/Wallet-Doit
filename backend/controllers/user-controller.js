import UserService from '../services/user-service.js';
import * as yup from 'yup';

const userSchema = yup.object({
    cpf: yup.string().min().required(),
    name: yup.string().required(),
    email: yup.string().email().required(),
    password: yup.string().min(0).required(),
    phone: yup.string().min(10).required(),
    sale: yup.number().default(0),
    credit: yup.number().default(0),
    credit_used: yup.number().default(0), 
})

const UserController = () => {
    const createUser = async (req, res) => {
        try {
            if (await userSchema.validate(req.body,{abortEarly:false})) {
                const user = await UserService.create(req.body);
                res.status(201).json(user);
            }
            
        } catch (error) {
            res.status(400).json({ error: error.message });
        }
    }

    return {
        createUser, 
    }
}

export default UserController; 
