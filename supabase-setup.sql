-- ============================================================
--  Nidouille — schéma Supabase
--  À coller dans : Supabase → ton projet → SQL Editor → New query → Run
-- ============================================================

create table if not exists public.items (
  id      text primary key,
  name    text not null,
  cat     text,
  subcat  text,                                  -- sous-type (ex. Luminaire → "Suspension")
  price   text,
  vendor  text,
  link    text,
  photo   text,
  "by"    text,                                  -- "moi" | "pauline"
  votes   jsonb default '{"moi":false,"pauline":false}'::jsonb,
  created bigint                                 -- timestamp en millisecondes
);

-- Si la table existait déjà sans la colonne subcat :
alter table public.items add column if not exists subcat text;

-- Sécurité au niveau des lignes
alter table public.items enable row level security;

-- Accès anonyme complet (app privée à 2 personnes).
-- La clé "anon" étant publique, voir la note sécurité du README.
drop policy if exists "nidouille anon all" on public.items;
create policy "nidouille anon all"
  on public.items
  for all
  to anon
  using (true)
  with check (true);

-- Activer la synchro temps réel sur la table
alter publication supabase_realtime add table public.items;
