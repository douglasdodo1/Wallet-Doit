import UserRepository from '../repositories/user_repository.js';

const userRepo = UserRepository();

class UserService {
    static create = async (data) => {
        if (!data.name || !data.email) {
            throw new Error('Nome e email são obrigatórios');
        }
        return await userRepo.createUser(data);
    }
}

export default UserService;
