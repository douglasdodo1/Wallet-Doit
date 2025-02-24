import prisma from "../prisma_client.js";

export const PaymentListRepository = () => {
  const create = async (data, cpf) => {
    console.log(data, cpf);

    try {
      return await prisma.paymentList.create({
        data: {
          name_payment: data.name_payment,
          value: data.value,
          iconCode: data.iconCode,
          user: {
            connect: { cpf: cpf },
          },
        },
      });
    } catch (error) {
      console.error(error);
      throw new Error("Error creating payment");
    }
  };

  const read = async (data) => {
    try {
      return await prisma.paymentList.findUnique({
        where: {
          id: data,
        },
      });
    } catch (error) {
      console.error(error);
      throw new Error("Error reading payment");
    }
  };

  const readAll = async (cpf) => {
    try {
      return await prisma.paymentList.findMany({
        where: {
          userCpf: cpf,
        },
      });
    } catch (error) {
      console.error(error);
      throw new Error("Error reading all payments");
    }
  };

  const update = async (data, id) => {
    try {
      return await prisma.paymentList.update({
        where: {
          id: id,
        },
        data: {
          name_payment: data.name_payment,
          value: data.value,
          iconCode: data.iconCode,
        },
      });
    } catch (error) {
      console.error(error);
      throw new Error("Error updating payment");
    }
  };

  const deletePayment = async (data) => {
    try {
      return await prisma.paymentList.delete({
        where: {
          id: data,
        },
      });
    } catch (error) {
      console.error(error);
      throw new Error("Error when deleting payment");
    }
  };

  return {
    create,
    read,
    readAll,
    update,
    deletePayment,
  };
};

export default PaymentListRepository;
