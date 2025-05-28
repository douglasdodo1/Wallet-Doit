# 💸 walletDOit

![Node.js](https://img.shields.io/badge/Backend-Node.js-green) ![Express](https://img.shields.io/badge/Framework-Express-blue) ![Prisma](https://img.shields.io/badge/ORM-Prisma-brightgreen) ![Flutter](https://img.shields.io/badge/Frontend-Flutter-blueviolet)

## 📃 Descrição

walletDOit é um aplicativo pessoal de controle financeiro que permite cadastrar-se, autenticar-se e gerenciar pagamentos, além de visualizar gráficos e histórico de transações mensalmente. O backend é implementado em Node.js + Express + Prisma (SQLite ou PostgreSQL), enquanto o frontend é desenvolvido em Flutter.

## 📑 Tabela de Conteúdos

1. [Funcionalidades](#funcionalidades)
2. [Tecnologias](#tecnologias)
3. [Requisitos](#requisitos)
4. [Instalação](#instalação)
5. [Configuração de Ambiente](#configuração-de-ambiente)
6. [Estrutura do Projeto](#estrutura-do-projeto)
7. [API Reference](#api-reference)
8. [Modelo de Dados](#modelo-de-dados)
9. [Contribuição](#contribuição)
10. [Licença](#licença)
11. [Autor](#autor)

## 🚀 Funcionalidades

* **Auth**: Cadastro de usuário, login com JWT armazenado em cookie HTTP-only
* **CRUD de Pagamentos**: criar, ler (individual e lista), atualizar e deletar pagamentos
* **Dashboard**: gráficos mensais de pagamentos (frontend)
* **Histórico**: listagem de transações filtrada por mês

## 🛠️ Tecnologias

### Backend

* Node.js
* Express
* Prisma ORM
* SQLite / PostgreSQL
* JWT (jsonwebtoken)
* Yup (validação)
* Bcrypt (hash de senha)
* Dotenv (variáveis de ambiente)

### Frontend

* Flutter
* Provider (gerenciamento de estado)
* flutter\_hooks
* fl\_chart (gráficos)
* month\_picker\_dialog
* http
* flutter\_dotenv

## 🔧 Requisitos

* Node.js v14+
* npm ou yarn
* Flutter SDK
* Git

## ⚙️ Instalação

### Backend

```bash
cd backend
npm install
npx prisma generate
npx prisma migrate dev --name init
npm run dev
```

### Frontend

```bash
cd frontend
flutter pub get
flutter run
```

> Para testar em dispositivo físico, configure o `BASE_URL` no arquivo `.env` apontando para o IP da máquina do backend.

## 🔒 Configuração de Ambiente

### backend/.env

```dotenv
PORT=3000
DATABASE_URL="file:./dev.db"  # ou URL PostgreSQL
JWT_SECRET=seuSegredoAqui
```

### frontend/.env

```dotenv
BASE_URL=http://192.168.0.10:3000  # ajuste conforme seu IP
```

## 📂 Estrutura do Projeto

```
walletDOit/
├── backend/
│   ├── controllers/
│   ├── services/
│   ├── middlewares/
│   ├── prisma/
│   │   └── schema.prisma
│   ├── index.js
│   └── package.json
└── frontend/
    ├── lib/
    │   ├── main.dart
    │   ├── pages/
    │   └── components/
    └── pubspec.yaml
```

## 📜 API Reference

### Auth

| Método | Rota     | Descrição                             |
| ------ | -------- | ------------------------------------- |
| POST   | `/login` | Autentica usuário e define cookie JWT |

### Usuário

| Método | Rota         | Descrição                       |
| ------ | ------------ | ------------------------------- |
| POST   | `/user`      | Cadastrar novo usuário          |
| GET    | `/user`      | Retorna dados do usuário logado |
| PUT    | `/user/:cpf` | Atualiza dados do usuário       |

### Pagamentos

| Método | Rota            | Descrição                          |
| ------ | --------------- | ---------------------------------- |
| POST   | `/payments`     | Criar novo pagamento               |
| GET    | `/payments`     | Buscar pagamento por ID            |
| GET    | `/payments/all` | Listar todos pagamentos do usuário |
| PUT    | `/payment/:id`  | Atualizar pagamento existente      |
| DELETE | `/payments/:id` | Deletar pagamento                  |

## 🗄️ Modelo de Dados

```prisma
model User {
  cpf         String         @id @default(uuid())
  name        String
  email       String         @unique
  password    String
  phone       String
  sale        Float
  credit      Float
  creditUsed  Float
  paymentList PaymentList[]
}

model PaymentList {
  id           Int      @id @default(autoincrement())
  namePayment  String
  value        Float
  userCpf      String
  iconCode     String?
  createdAt    String
  user         User     @relation(fields: [userCpf], references: [cpf])
}
```

## 🤝 Contribuição

1. Fork este repositório
2. Crie uma branch: `git checkout -b feature/nova-funcionalidade`
3. Faça commit das suas alterações: `git commit -m 'Adiciona algo legal'`
4. Push para a branch: `git push origin feature/nova-funcionalidade`
5. Abra um Pull Request


## 👨‍💻 Autor

Desenvolvido por Douglas Gemir
