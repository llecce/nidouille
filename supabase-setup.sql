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
  "by"    text,                                  -- "louis" | "pauline"
  ratings jsonb default '{"louis":0,"pauline":0}'::jsonb,  -- note 0-5 par personne
  purchased boolean default false,               -- "✅ On l'achète !"
  description text default '',                  -- note/description écrite par le créateur de la fiche
  created bigint                                 -- timestamp en millisecondes
);

-- Si la table existait déjà (versions précédentes du schéma) :
alter table public.items add column if not exists subcat text;
alter table public.items add column if not exists ratings jsonb default '{"louis":0,"pauline":0}'::jsonb;
alter table public.items add column if not exists purchased boolean default false;
alter table public.items add column if not exists description text default '';

-- L'ancien système de votes ❤️ (votes) et le fil de commentaires (comments)
-- sont remplacés respectivement par les notes et la description ci-dessus.
-- Décommente si tu veux nettoyer les colonnes devenues inutiles :
-- alter table public.items drop column if exists votes;
-- alter table public.items drop column if exists comments;

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
