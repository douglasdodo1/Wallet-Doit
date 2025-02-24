import express from "express";
import UserController from "./controllers/user-controller.js";
import PaymentListController from "./controllers/payment-list-controller.js";
import AuthController from "./controllers/auth-controller.js";
import AuthMiddleWare from "./middlewares/auth-middleware.js";
import dotenv from "dotenv";

dotenv.config();
const app = express();
const port = process.env.PORT || 3000;

const userController = UserController();
const paymentListController = PaymentListController();
const authController = AuthController();
const authenticateToken = AuthMiddleWare();

app.use(express.json());

app.get("/", (req, res) => {
  res.send("Servidor funcionando!");
});

// LOGIN
app.post("/login", async (req, res) => {
  authController.auth(req, res);
});

//USER
app.post("/user", (req, res) => userController.createUser(req, res));

app.get("/user", authenticateToken, (req, res) =>
  userController.readUser(req, res)
);

app.put("/user/:cpf", authenticateToken, (req, res) =>
  userController.updateUser(req, res)
);

//PAYMENTS
app.post("/payments", authenticateToken, (req, res) =>
  paymentListController.createPaymentList(req, res)
);

app.get("/payments", authenticateToken, (req, res) =>
  paymentListController.readPaymentList(req, res)
);

app.get("/payments/all", authenticateToken, (req, res) =>
  paymentListController.readAllpaymentList(req, res)
);

app.put("/payment/:id", authenticateToken, (req, res) =>
  paymentListController.updatePaymentList(req, res)
);

app.delete("/payments/:id", authenticateToken, (req, res) =>
  paymentListController.deletePaymentList(req, res)
);

app.listen(port, () =>
  console.log(`Servidor rodando em http://localhost:${port}`)
);
