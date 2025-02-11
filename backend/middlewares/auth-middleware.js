import dotenv from 'dotenv';
import jwt from 'jsonwebtoken';
dotenv.config();

export const AuthMiddleWare = () => {
    const authenticateToken = (req, res, next) => {
        const authHeader = req.header('Authorization');
        const token = authHeader?.split(' ')[1];
    
        if (!token) {
            return res.status(401).json({ error: 'Token não fornecido' });
        }
    
        try {
            const verified = jwt.verify(token, process.env.JWT_SECRET);
            req.user = verified;
            next();
        } catch (error) {
            res.status(403).json({ error: 'Token inválido' });
        }
    };
    

    return authenticateToken;
};

export default AuthMiddleWare;
