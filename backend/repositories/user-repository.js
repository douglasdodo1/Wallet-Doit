import prisma from '../prisma_client.js';

export const UserRepository = () =>{
    const createUser = async (data) => {
        try {
            return await prisma.user.create({
                data: {
                    cpf: data.cpf,
                    name: data.name,
                    email: data.email,
                    password: data.password,
                    phone: data.phone,
                    sale: data.sale,
                    credit: data.credit,
                    credit_used: 0
                },
            });
        } catch (error) {
            console.error(error);
            throw new Error('Erro ao salvar o usuário');
        }
    }
    return {
        createUser,
    }
}

export default UserRepository;