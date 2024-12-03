import prisma from '../prisma_client.js';


export const PaymentListRepository = () =>{
    const createPaymentList = async (data) => {
        try {
            return await prisma.paymentList.create({
                data: {
                    name_payment: data.name_payment,
                    value: data.value,
                    user:{
                        connect: { cpf: data.cpf},
                    }
                },
            });
        } catch (error) {
            console.error(error);
            throw new Error('Erro ao salvar pagamento');
        }
    }
    return {
        createPaymentList,
    }
}

export default PaymentListRepository;