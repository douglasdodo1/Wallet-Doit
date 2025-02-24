import PaymentListService from "../services/payment-list-service.js";

const paymentListService = PaymentListService();

const PaymentListController = () => {
  const createPaymentList = async (req, res) => {
    try {
      const payment = req.body;
      const cpf = req.user.cpf;
      payment.value = parseFloat(payment.value);

      if (!payment.name_payment || !payment.value) {
        return res.status(400).json({ error: "Name or value is missing" });
      }

      const paymentList = await paymentListService.createPayment(payment, cpf);

      res.status(201).json(paymentList);
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  };

  const readPaymentList = async (req, res) => {
    try {
      const payment = req.body;
      const paymentList = await paymentListService.readPayment(payment.id);
      res.status(201).json(paymentList);
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  };

  const readAllpaymentList = async (req, res) => {
    try {
      const cpf = req.user.cpf;

      const paymentList = await paymentListService.readPayments(cpf);

      res.status(201).json(paymentList);
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  };

  const updatePaymentList = async (req, res) => {
    try {
      const paymentToUpdated = req.body;
      const paymentId = Number(req.params.id);

      if (!paymentToUpdated.name_payment || !paymentToUpdated.value) {
        return res.status(400).json({ error: error.message });
      }

      const paymentUpdated = await paymentListService.updatePayment(
        paymentToUpdated,
        paymentId
      );

      res.status(201).json(paymentUpdated);
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  };

  const deletePaymentList = async (req, res) => {
    try {
      const { id } = req.params;
      console.log("to no controller");

      if (!id) {
        return res.status(400).json({ error: error.message });
      }

      const paymentDeleted = await paymentListService.deletePayment(id);

      res.status(201).json(paymentDeleted);
    } catch (error) {
      res.status(400).json({ error: error.message });
    }
  };

  return {
    createPaymentList,
    readPaymentList,
    readAllpaymentList,
    updatePaymentList,
    deletePaymentList,
  };
};

export default PaymentListController;
