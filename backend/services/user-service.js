import UserRepository from '../repositories/user-repository.js';

const userRepo = UserRepository();

class UserService {
    static create = async (data) => {
        return await userRepo.createUser(data);
    }
}

export default UserService;
