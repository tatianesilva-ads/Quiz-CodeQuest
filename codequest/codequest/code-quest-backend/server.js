import http from 'http';
import { supabase } from './src/supabase.js';

const PORT = process.env.PORT || 3000;

const server = http.createServer(async (req, res) => {
    // Configuração de CORS para permitir requisições do frontend
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'OPTIONS, GET, POST, PUT');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

    if (req.method === 'OPTIONS') {
        res.writeHead(204);
        res.end();
        return;
    }

    const url = new URL(req.url, `http://${req.headers.host}`);
    const path = url.pathname;

    const parseBody = () => {
        return new Promise((resolve) => {
            let body = '';
            req.on('data', chunk => body += chunk);
            req.on('end', () => resolve(body ? JSON.parse(body) : {}));
        });
    };

    // --- ROTAS DO SISTEMA --- //

    // 1. Cadastrar / Entrar Jogador (POST /api/jogador)
    if (path === '/api/jogador' && req.method === 'POST') {
        const { nickname } = await parseBody();
        if (!nickname) {
            res.writeHead(400, { 'Content-Type': 'application/json' });
            return res.end(JSON.stringify({ erro: 'O nickname é obrigatório.' }));
        }

        let { data: jogador } = await supabase
            .from('tabelajogador')
            .select('*')
            .eq('nickname', nickname)
            .single();

        if (!jogador) {
            const { data: novoJogador, error: insertError } = await supabase
                .from('tabelajogador')
                .insert([{ nickname, senha: 'hash_temporario' }])
                .select()
                .single();
            
            if (insertError) {
                res.writeHead(500, { 'Content-Type': 'application/json' });
                return res.end(JSON.stringify({ erro: insertError.message }));
            }
            jogador = novoJogador;
        }

        res.writeHead(200, { 'Content-Type': 'application/json' });
        return res.end(JSON.stringify({ mensagem: 'Sucesso', id_jogador: jogador.id_jogador }));
    }

    // 2. Listar Categorias (GET /api/categorias)
    if (path === '/api/categorias' && req.method === 'GET') {
        const { data, error } = await supabase.from('tabelacategoria').select('*');
        if (error) {
            res.writeHead(500, { 'Content-Type': 'application/json' });
            return res.end(JSON.stringify({ erro: error.message }));
        }
        res.writeHead(200, { 'Content-Type': 'application/json' });
        return res.end(JSON.stringify(data));
    }

    // 3. Obter Ranking Geral (GET /api/ranking)
    if (path === '/api/ranking' && req.method === 'GET') {
        const { data, error } = await supabase
            .from('tabelapartida')
            .select('pontuacao_final, data_fim, tabelajogador(nickname)')
            .eq('status', 'Concluída')
            .order('pontuacao_final', { ascending: false })
            .limit(10);

        if (error) {
            res.writeHead(500, { 'Content-Type': 'application/json' });
            return res.end(JSON.stringify({ erro: error.message }));
        }
        res.writeHead(200, { 'Content-Type': 'application/json' });
        return res.end(JSON.stringify(data));
    }

    // Rota padrão para erros 404
    res.writeHead(404, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({ erro: 'Rota não encontrada' }));
});

server.listen(PORT, () => {
    console.log(`Servidor rodando na porta ${PORT}`);
});