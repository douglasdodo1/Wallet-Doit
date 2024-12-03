import PaymentListRepository from '../repositories/payment-list-repository.js';

const paymentListRepository = PaymentListRepository();

class PaymentListService{
    static create = async (data) => {
        return await paymentListRepository.createPaymentList(data);
    }
}

export default PaymentListService;
