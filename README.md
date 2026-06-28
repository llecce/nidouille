# 🪑 Nidouille

Catalogue de meubles collaboratif pour deux personnes (toi & Pauline).
Une seule page web, sans framework. Ajoute des meubles, vote ❤️, et retrouve le **Top pick** de chaque catégorie.

L'app fonctionne en **deux modes**, automatiquement :

| Mode | Quand | Données |
|------|-------|---------|
| 🟡 **Local** | clés Supabase vides | `localStorage` (cet appareil uniquement) |
| 🟢 **Cloud** | clés Supabase renseignées | Supabase + **synchro temps réel** entre vos 2 téléphones |

La pastille en haut à droite du titre indique le mode actif (jaune = local, vert = cloud).

---

## 1. Tester tout de suite (mode local)

Ouvre simplement `index.html` dans un navigateur.
6 meubles de démo se chargent automatiquement la première fois.

> Astuce : pour repartir de zéro, ouvre la console et tape
> `localStorage.clear()` puis recharge.

---

## 2. Activer la synchro cloud (Supabase gratuit)

1. Crée un compte sur **[supabase.com](https://supabase.com)** → **New project** (le plan gratuit suffit).
2. Dans le projet : **SQL Editor → New query**, colle le contenu de
   [`supabase-setup.sql`](supabase-setup.sql), puis **Run**.
3. Va dans **Project Settings → API** et copie :
   - **Project URL**
   - la clé **`anon` `public`**
4. Ouvre `index.html` et renseigne le bloc config en haut du `<script>` :
   ```js
   const SUPABASE_URL      = "https://xxxx.supabase.co";
   const SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiI...";
   ```
5. Recharge : la pastille passe au **vert**. Ouvre l'app sur 2 appareils → les ajouts et les votes apparaissent en direct des deux côtés. 🎉

---

## 3. Héberger sur GitHub Pages

```bash
git init
git add .
git commit -m "Nidouille"
git branch -M main
git remote add origin https://github.com/<ton-user>/nidouille.git
git push -u origin main
```

Puis sur GitHub : **Settings → Pages → Source : `main` / root**.
L'app sera servie sur `https://<ton-user>.github.io/nidouille/`.

---

## ⚠️ Note sécurité

La clé `anon` est **publique** par nature (elle est dans le code envoyé au navigateur).
Avec la politique RLS ci-dessus, toute personne connaissant l'URL + la clé peut lire/écrire.
Pour une appli privée à deux, sur un repo **public**, garde en tête que :

- ce n'est pas un secret bancaire — juste une liste de meubles ;
- si tu veux verrouiller, options simples : mettre le repo en **privé**, ou ajouter
  l'**authentification Supabase** (email magic-link) et restreindre la policy à
  `auth.uid()`. Dis-le moi et je te le câble.
