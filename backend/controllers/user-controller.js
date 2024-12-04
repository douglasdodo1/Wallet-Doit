import UserService from '../services/user-service.js';
import { UserSchema } from '../lib/user-schema.js';

const userSchema = UserSchema(); 

const UserController = () => {
    const createUser = async (req, res) => {
            if (!userSchema.validate(req.body,{abortEarly:false})) {
                return res.status(400).json({ error: error.message });
            }
            const user = await UserService.create(req.body);
            return res.status(201).json(user); 
        
    }

    const readUser = async (req,res) =>{
            if (!req.body.cpf || req.body.cpf.length != 11) return res.status(400).json({ error: 'CPF inválido' });
            const user = await UserService.read(req.body.cpf);
            if (!user) {
                return res.status(404).json({ error: 'Usuário não encontrado' });
            }
            return res.status(200).json(user);
    }

    const updateUser = async (req, res) => {
        if (!req.body) {
            return res.status(400).json({ error: 'Nenhum dado enviado' });
        }
    
        const user = await UserService.update(req.params.cpf, req.body);
        if (!user) {
            return res.status(404).json({ error: 'Usuário não encontrado' });
        }
        return res.status(200).json(user);
    };

    return {
        createUser, readUser, updateUser
    }
}

export default UserController; 
