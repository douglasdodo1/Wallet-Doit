import dotenv from 'dotenv';
import AuthService from '../services/auth-service.js';
dotenv.config();

const authService = AuthService();
export const AuthController =  (req, res) => {
    const auth = async (req, res) => {
        const { cpf, password } = req.body;
        const token = await authService.login(cpf, password);
        if (!token) return res.status(401).json({ error: 'Credenciais inválidas' });
        
        res.cookie('token', token,{
            httpOnly: true,
            secure:process.env.NODE_ENV === 'production',
            sameSite: 'lax',
            maxAge: 3600000
        })

        res.status(200).json({ message: 'Login bem-sucedido' });
    };
    
    return {
        auth
    }
};

export default AuthController;
