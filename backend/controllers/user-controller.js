import UserService from "../services/user-service.js";
import { UserSchema } from "../lib/user-schema.js";
import bcrypt from "bcrypt";

const userSchema = UserSchema();

const UserController = () => {
  const createUser = async (req, res) => {
    if (!userSchema.validate(req.body, { abortEarly: false })) {
      return res.status(400).json({ error: error.message });
    }
    console.log(req.body);

    req.body.password = await bcrypt.hash(req.body.password, 10);
    const user = await UserService.create(req.body);
    return res.status(201).json(user);
  };

  const readUser = async (req, res) => {
    const userCpf = req.user.cpf;

    if (!userCpf || userCpf.length != 11)
      return res.status(400).json({ error: "CPF inválido" });

    const user = await UserService.read(userCpf);
    if (!user) {
      return res.status(404).json({ error: "Usuário não encontrado" });
    }
    return res.status(200).json(user);
  };

  const updateUser = async (req, res) => {
    if (!req.body) {
      return res.status(400).json({ error: "Nenhum dado enviado" });
    }

    const user = await UserService.update(req.params.cpf, req.body);
    if (!user) {
      return res.status(404).json({ error: "Usuário não encontrado" });
    }
    return res.status(200).json(user);
  };

  return {
    createUser,
    readUser,
    updateUser,
  };
};

export default UserController;
