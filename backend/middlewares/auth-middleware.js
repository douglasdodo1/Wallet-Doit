import dotenv from 'dotenv';
import jwt from 'jsonwebtoken';
dotenv.config();

export const AuthMiddleWare = () =>{
    const authenticateToken = (req,res, next) =>{
        const token = req.header('Authorization')

        if (!token) return res.status(401).json({ error: 'Token não fornecido' });

        try {
            const verified = jwt.verify(token, process.env.JWT_SECRET)
            req.user = verified
            next()
        } catch (error) {
            throw new Error(error)
        }
    }

    return authenticateToken
}

export default AuthMiddleWare; 
