import express from 'express';
import router from './router.js';
import db from './database.js';
import './modelIndex.js';

const app = express();
const port = Number(process.env.PORT || 3000);

app.use(express.json());
app.get('/health', (req, res) => res.status(200).json({ status: 'ok' }));
app.use('/', router);

try {
    await db.authenticate();
    await db.sync();
    console.log('Banco conectado e tabelas sincronizadas.');
} catch (error) {
    console.error('Falha ao conectar ao banco:', error);
    process.exit(1);
}

app.listen(port, () => {
    console.log(`Rodando na porta ${port}.`);
});
