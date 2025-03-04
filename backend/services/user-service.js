import UserRepository from "../repositories/user-repository.js";

const userRepo = UserRepository();

class UserService {
  static create = async (data) => {
    return await userRepo.createUser(data);
  };

  static read = async (cpf) => {
    const user = await userRepo.readUser(cpf);
    console.log(user);

    if (!user) {
      return null;
    }
    return user;
  };

  static update = async (cpf, data) => {
    const user = await userRepo.readUser(cpf);
    if (!user) {
      return null;
    }

    return await userRepo.updateUser(cpf, data);
  };
}

export default UserService;
