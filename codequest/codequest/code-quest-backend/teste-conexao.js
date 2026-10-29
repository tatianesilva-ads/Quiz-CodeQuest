import { supabase } from './src/supabase.js';

async function testarConexao() {
    const { data, error } = await supabase.from('tabelacategoria').select('*');
    if (error) {
        console.error('❌ Erro ao conectar com o Supabase:', error.message);
    } else {
        console.log('✅ Conexão bem-sucedida! Dados encontrados:', data);
    }
}

testarConexao();