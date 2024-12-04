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

    const readUser = async (cpf) => {
        try {
            return await prisma.user.findUnique({
                where: {
                    cpf: cpf
                },
            })
        } catch (error) {
            console.error(error);
            throw new Error('Erro ao ler o usuário');
        }
    }

    const updateUser = async (cpf, data) => {
        try {
            return await prisma.user.update({
                where: {
                    cpf: cpf
                },
                data: data, // Atualiza o usuário com os dados fornecidos
            });
        } catch (error) {
            console.error(error);
            throw new Error('Erro ao atualizar o usuário');
        }
    };
    

    return {
        createUser, readUser, updateUser
    }

}

export default UserRepository;