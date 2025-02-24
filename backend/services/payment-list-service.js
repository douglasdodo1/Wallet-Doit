import PaymentListRepository from "../repositories/payment-list-repository.js";

const paymentListRepository = PaymentListRepository();

export const PaymentListService = () => {
  const createPayment = async (data, cpf) => {
    const payment = await paymentListRepository.create(data, cpf);

    if (!payment) {
      throw new Error("Failed to create Payment List");
    }
    return payment;
  };

  const readPayment = async (data) => {
    const payment = await paymentListRepository.read(data);

    if (!payment) {
      throw new Error("Payment not found");
    }

    return payment;
  };

  const readPayments = async (data) => {
    const payment = await paymentListRepository.readAll(data);

    if (!payment) {
      throw new Error("no payments found");
    }

    return payment;
  };

  const updatePayment = async (data, id) => {
    const paymentChecked = await paymentListRepository.read(id);

    if (paymentChecked === null) {
      throw new Error("payment not found");
    }

    const updatedPayment = await paymentListRepository.update(data, id);
    if (updatedPayment == null) {
      throw new Error("payment not updated");
    }

    return updatedPayment;
  };

  const deletePayment = async (data) => {
    data = parseInt(data);
    console.log("to no service");
    console.log(data);

    const paymentChecked = await paymentListRepository.read(data);
    console.log(paymentChecked);

    if (paymentChecked === null) {
      throw new Error("payment not found");
    }
    const deletedPayment = await paymentListRepository.deletePayment(data);

    if (deletedPayment == null) {
      throw new Error("payment not deleted");
    }

    return deletedPayment;
  };
  return {
    createPayment,
    readPayment,
    readPayments,
    updatePayment,
    deletePayment,
  };
};

export default PaymentListService;
