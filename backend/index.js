import express from 'express';
import UserController from './controllers/user-controller.js';
import PaymentListController from './controllers/payment-list-controller.js';
import AuthController from './controllers/auth-controller.js';
import AuthMiddleWare from './middlewares/auth-middleware.js';
import dotenv from 'dotenv';

dotenv.config();
const app = express();
const port = process.env.PORT || 3000;

const userController = UserController();
const paymentListController = PaymentListController();
const authController = AuthController();
const authenticateToken = AuthMiddleWare();


app.use(express.json());
 
app.get('/', (req, res) => {
    res.send('Servidor funcionando!');
});

app.post('/create-user', (req, res) => {
    userController.createUser(req, res);
});

app.post('/create-payment-list', authenticateToken, (req, res) => {
    paymentListController.createPaymentList(req, res);
});

app.get('/payment-list', authenticateToken, (req, res) => {
    paymentListController.readPaymentList(req, res);
});

app.get('/read-all-payment-list', authenticateToken, (req, res) => {
    paymentListController.readAllpaymentList(req, res);
});

app.put('/update-payment-list/:id', authenticateToken, (req, res) => {
    paymentListController.updatePaymentList(req, res);
});

app.get('/user', authenticateToken, (req, res) => {
    userController.readUser(req, res);
});

app.put('/user/:cpf', authenticateToken, (req, res) =>{
    userController.updateUser(req, res);
})

app.post('/login', async (req, res) =>{
    authController.auth(req, res);
})

app.listen(port, () => {
    console.log(`Servidor rodando em http://localhost:${port}`);
});
