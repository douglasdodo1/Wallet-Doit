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

    const readPaymentList = async (cpf) => {
        try {
            return await prisma.paymentList.findUnique({
                where:{
                    cpf: cpf,
                },
            })

        } catch (error) {
            console.error(error);
            throw new Error('Erro ao ler pagamento');
        }
    }
    
    const updatePaymentList = async (cpf, data) => {
        try {
            return await prisma.paymentList.update({
                where: {
                    cpf: cpf
                },
                data: data,
            })

        } catch (error) {
            console.error(error);
            throw new Error('Erro ao atualizar o usuário');
        }
    };


    const deletePaymentList = async (cpf) => {
        try {
            return await prisma.paymentList.delete({
                where: {
                    cpf: cpf
                },
            })
        } catch (error) {
            console.error(error);
            throw new Error('Erro ao deletar pagamento');
        }
    }
    return {
        createPaymentList,
    }
}

export default PaymentListRepository;