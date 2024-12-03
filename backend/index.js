import express from 'express';
import UserController from './controllers/user-controller.js';
import PaymentListController from './controllers/payment-list-controller.js';

const app = express();
const port = process.env.PORT || 3000;

const userController = UserController();
const paymentListController = PaymentListController();



app.use(express.json());
 
app.get('/', (req, res) => {
    res.send('Servidor funcionando!');
});

app.post('/create-user', (req, res) => {
    userController.createUser(req, res);
});

app.post('/create-payment-list', (req, res) => {
    paymentListController.createPaymentList(req, res);
    console.log(req);
    
});

app.listen(port, () => {
    console.log(`Servidor rodando em http://localhost:${port}`);
});
