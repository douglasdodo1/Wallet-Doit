import PaymentListService from '../services/payment-list-service.js';

const PaymentListController = () => {
    const createPaymentList = async(req,res) => {
        try {
            const paymentList = await PaymentListService.create(req.body);
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
