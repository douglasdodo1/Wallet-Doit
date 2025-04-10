# 💅 Projeto Studio - Backend

Este é o backend da aplicação **Projeto Studio**, um sistema de gerenciamento de agendamentos e serviços para um estúdio de cuidados femininos. A API foi construída em **ASP.NET Core** com uma arquitetura baseada em **Models,Controllers, Services e Repositories**, e usa **JWT** para autenticação segura.

---

## 🚀 Tecnologias

- ASP.NET Core 9
- Entity Framework Core
- Postgress
- JWT (JSON Web Token)
- Postman (para testar Endpoints)
- Argon2 (para garantir segurança a senhas)


## 🧪 Como rodar o projeto localmente

1. Clone o repositório:
    git clone https://github.com/seu-usuario/projeto-studio-backend.git

2. Navegue até a pasta:
    cd projeto-studio-backend

3. Configure a ConnectionString no appsettings.json:
    "ConnectionStrings": {
    "DefaultConnection": "Server=localhost;Database=ProjetoStudioDb;Trusted_Connection=True;"
    }

4. Aplique as migrations:
    dotnet ef database update

5. Rode o projeto:
    dotnet run

6. 🔐Autenticação
    A API usa JWT para autenticação. Após o login com email e senha, um token será retornado. Esse token deve ser enviado no header das requisições protegidas:
    Authorization: Bearer <seu_token>

7. 📚 Endpoints principais
    👤 Usuários
    POST /user — Cria um novo usuário
    POST /authentication — Autentica e retorna token JWT
    GET  /user/cpf - busca um usuário
    GET  /user - busca todos os usuários
    PUT  /user/cpf - atualiza um usuario
    DEL  /user/cpf - apaga um usuário 
   

    💇‍♀️ Serviços
    POST /service/addService — Cadastra um novo serviço (funcionário)
    GET /service/getById/{id} — Busca um serviço por ID
    GET /service/all — Lista todos os serviços

    📅 Sessões
    POST /session/create — Cria uma nova sessão
    GET /session/user/id — Busca um serviço por id
    GET /session/all/cpf — Lista todas as sessões de uma pessoa

9. 👥 Tipos de usuário
     Tipo	                    Descrição

    Cliente	        Pode agendar e visualizar suas sessões

  Funcionário	    Pode visualizar todos os dados e gerenciar

👨‍💻 BackEnd Desenvolvido por
Douglas Gemir — @douglasdodo1
Backend em .NET com 
