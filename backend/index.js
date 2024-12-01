import express from 'express';
const app = express();
const port = process.env.PORT || 3000;

import userRoutes from './routes/user_route.js';

app.use(express.json());

app.get('/', (req, res) => {
    res.send('Servidor funcionando!');
});

app.use(userRoutes); // Usando o router importado

app.listen(port, () => {
    console.log(`Servidor rodando em http://localhost:${port}`);
});
