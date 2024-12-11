import dotenv from 'dotenv';
import UserService from "./user-service.js"
import bcrypt from "bcrypt"
import jwt from 'jsonwebtoken';
dotenv.config();

export const AuthService = () => {
    const login = async(cpf, password) =>{
        const user = await UserService.read(cpf);

        if (!user) {
            console.log('usuario não encontrado');
            return null
        }

        const validPassword = await bcrypt.compare(password, user.password)

        if (!validPassword) {
            console.log('Senha inválida');
            return null
        }

        const token = jwt.sign({ cpf }, process.env.JWT_SECRET, { expiresIn: '1h' });

        return token
        
    }
    return {
        login
    }
}

export default AuthService; 
