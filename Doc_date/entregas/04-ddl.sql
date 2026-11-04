create table public.perfis (
  id       uuid primary key default auth.uid() references auth.users (id) on delete cascade,
  username text not null unique check (char_length(username) between 3 and 20)
);

create table public.categorias (
  id     bigint generated always as identity primary key,
  nome   text not null unique,
  imagem text
);

create table public.perguntas (
  id           bigint generated always as identity primary key,
  categoria_id bigint not null references public.categorias (id) on delete cascade,
  enunciado    text not null,
  pontos       integer not null default 1 check (pontos > 0),
  multipla     boolean not null default false,
  opcao_a      text not null,
  opcao_b      text not null,
  opcao_c      text not null,
  opcao_d      text not null
);

create table public.gabaritos (
  pergunta_id bigint primary key references public.perguntas (id) on delete cascade,
  corretas    text[] not null check (cardinality(corretas) > 0 and corretas <@ '{a,b,c,d}'),
  explicacao  text not null,
  fonte       text not null,
  fonte_tipo  text not null check (fonte_tipo in ('link', 'texto'))
);

create table public.partidas (
  id           bigint generated always as identity primary key,
  jogador_id   uuid not null default auth.uid() references public.perfis (id) on delete cascade,
  categoria_id bigint not null references public.categorias (id) on delete cascade,
  criada_em    timestamptz not null default now()
);

create table public.respostas (
  partida_id  bigint not null references public.partidas (id) on delete cascade,
  pergunta_id bigint not null references public.perguntas (id) on delete cascade,
  escolhidas  text[] not null check (cardinality(escolhidas) > 0 and escolhidas <@ '{a,b,c,d}'),
  primary key (partida_id, pergunta_id)
);

create index perguntas_categoria_id_idx on public.perguntas (categoria_id);
create index partidas_jogador_id_idx    on public.partidas (jogador_id);
create index partidas_categoria_id_idx  on public.partidas (categoria_id);
create index respostas_pergunta_id_idx  on public.respostas (pergunta_id);

alter table public.perfis     enable row level security;
alter table public.categorias enable row level security;
alter table public.perguntas  enable row level security;
alter table public.gabaritos  enable row level security;
alter table public.partidas   enable row level security;
alter table public.respostas  enable row level security;

create policy "perfis: ler" on public.perfis
  for select using (true);
create policy "perfis: criar o próprio" on public.perfis
  for insert to authenticated with check (id = auth.uid());
create policy "perfis: editar o próprio" on public.perfis
  for update to authenticated using (id = auth.uid()) with check (id = auth.uid());

create policy "categorias: ler" on public.categorias
  for select using (true);
create policy "perguntas: ler" on public.perguntas
  for select using (true);

create policy "gabaritos: ler após responder" on public.gabaritos
  for select to authenticated using (
    exists (
      select 1
        from public.respostas r
        join public.partidas p on p.id = r.partida_id
       where r.pergunta_id = gabaritos.pergunta_id
         and p.jogador_id = auth.uid()
    )
  );

create policy "partidas: criar a própria" on public.partidas
  for insert to authenticated with check (jogador_id = auth.uid());
create policy "partidas: ver as próprias" on public.partidas
  for select to authenticated using (jogador_id = auth.uid());

create policy "respostas: responder na própria partida" on public.respostas
  for insert to authenticated with check (
    exists (
      select 1 from public.partidas p
       where p.id = respostas.partida_id
         and p.jogador_id = auth.uid()
    )
  );
create policy "respostas: ver as próprias" on public.respostas
  for select to authenticated using (
    exists (
      select 1 from public.partidas p
       where p.id = respostas.partida_id
         and p.jogador_id = auth.uid()
    )
  );

create view public.ranking as
with pontuacao as (
  select p.id as partida_id,
         p.jogador_id,
         p.categoria_id,
         p.criada_em,
         coalesce(sum(pg.pontos) filter (
           where r.escolhidas @> g.corretas
             and r.escolhidas <@ g.corretas
         ), 0)    as pontos,
         count(*) filter (
           where r.escolhidas @> g.corretas
             and r.escolhidas <@ g.corretas
         )        as acertos,
         count(*) as respondidas
    from public.partidas p
    join public.respostas r  on r.partida_id = p.id
    join public.perguntas pg on pg.id = r.pergunta_id
    join public.gabaritos g  on g.pergunta_id = r.pergunta_id
   group by p.id
),
melhor_partida as (
  select distinct on (jogador_id, categoria_id) *
    from pontuacao
   order by jogador_id, categoria_id, pontos desc, criada_em asc
)
select m.partida_id,
       pf.username,
       m.categoria_id,
       c.nome as categoria,
       m.pontos,
       m.acertos,
       m.respondidas,
       m.criada_em
  from melhor_partida m
  join public.perfis     pf on pf.id = m.jogador_id
  join public.categorias c  on c.id  = m.categoria_id
 order by c.nome, m.pontos desc, m.criada_em asc;;
