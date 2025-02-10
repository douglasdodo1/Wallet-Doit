import PaymentListService from '../services/payment-list-service.js';

const PaymentListController = () => {
    const createPaymentList = async(req,res) => {
        try {
            const payment = req.body;
            const cpf = req.user.cpf; 
            
            if (!payment.name_payment || payment.value) {
                return res.status(400).json({ error: error.message });
            }
            const paymentList = await PaymentListService.create(payment, cpf);
            res.status(201).json(paymentList);
        } catch (error) {
            res.status(400).json({ error: error.message });
        }
    }

    return {
        createPaymentList,
    }
}

export default PaymentListController;
