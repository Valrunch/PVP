# PvP Arena — squelette de datapack (Minecraft 1.21.1)

Gère automatiquement : défi ciblé entre 2 joueurs (menu cliquable,
accepter/refuser), kit, téléport dans ton arène Multiworld, détection
de victoire, retour au lobby, et reset de l'arène. Zéro mod, zéro
dépendance à WorldEdit — 100% vanilla via `/place template`.

## Ça n'impacte PAS ton overworld — pourquoi

- L'arène vit dans **ta dimension Multiworld**, complètement séparée.
  Aucune fonction de ce pack ne place ou casse de bloc dans l'overworld.
- Les seules interactions avec l'overworld sont les 2 lignes de `tp`
  (aller vers l'arène / revenir au lobby) — un simple déplacement de
  joueur, rien d'autre.
- Les scoreboards/tags (`pvp.duel`, `pvp.id`, etc.) sont juste des
  métadonnées invisibles collées aux entités joueur. Elles n'ont
  aucun effet tant qu'aucune fonction de ce pack ne les lit.
- Le coût par tick (`tick.mcfunction`) est une poignée de comparaisons
  de scores entiers, peu importe la taille du monde — négligeable,
  même avec plusieurs duels/défis en cours.
- Les messages `tellraw` de lancement/victoire sont envoyés à `@a`
  (tout le serveur, effet "annonce publique" façon serveur pro). Si tu
  préfères que ça reste privé aux 2 duellistes, remplace `@a` par
  `@a[tag=pvp.duel]` dans `start_duel.mcfunction` et `end_duel.mcfunction`.

## Installation

1. Copie le dossier `pvparena/` dans `world/datapacks/` de ton serveur.
2. En jeu (en op) : `/reload`
3. Tu dois voir `[PvP Arena] datapack chargé.` dans le chat.

## Checklist AVANT le premier duel (obligatoire)

| Fichier | Quoi changer |
|---|---|
| `start_duel.mcfunction` | `TON_NS:TA_DIM` + les 2 couples de coordonnées de spawn (`/mw list` pour le nom de ta dimension) |
| `end_duel.mcfunction` | Coordonnées de ton lobby dans l'overworld |
| `reset_arena.mcfunction` | `TON_NS:TA_DIM` + coordonnées d'ancrage de la structure |
| `give_kit.mcfunction` | Le kit lui-même |

### Sauvegarder ton arène pour le reset auto

1. `/give @p minecraft:structure_block`
2. Pose-le, clique dessus, mode **Save**.
3. Nom de structure : `pvparena:arena` (exactement, avec les deux-points).
4. Ajuste la taille pour couvrir toute la zone de combat + décors, clique **Save**.
5. ⚠️ Bug Mojang connu (MC-272671) sur le 1.21.1 : le fichier est écrit
   dans `world/generated/pvparena/structures/` (avec un S) alors que
   le datapack attend `structure/` (sans S) — regarde dans les deux si
   tu ne trouves pas le fichier. Copie-le dans
   `data/pvparena/structure/arena.nbt` (sans S, obligatoire ici).

## Comment un joueur lance un duel

1. `/trigger pvp.trigger` → ouvre un menu listant les joueurs
   disponibles, chacun avec un bouton **[Défier]** cliquable.
2. Le joueur défié reçoit un message avec **[Accepter]** / **[Refuser]**.
3. S'il accepte : les deux sont prévenus, téléportés dans l'arène,
   équipés du kit, et le duel démarre.
4. À la fin (mort ou déconnexion) : annonce du gagnant, retour au
   lobby, reset automatique de l'arène.

Aucune commande ne nécessite d'être op — tout passe par `/trigger`,
autorisé à n'importe quel joueur par défaut. Si ça ne répond pas chez
un joueur, en dernier recours (op) : `/scoreboard players enable
<joueur> pvp.trigger` (et pareil pour `pvp.request`/`pvp.accept`/`pvp.decline`).

## Commandes admin

- `/function pvparena:reset_arena` — reconstruit l'arène manuellement
- `/scoreboard players get <joueur> pvp.wins` — voir un score

## Comment ça marche (pour étendre)

- `pvp.id` : identifiant numérique stable par joueur, attribué à la
  connexion. Sert à cibler précisément un joueur depuis un clic de
  chat, chose qu'un simple `/trigger` (qui n'accepte que des nombres)
  ne permet pas de faire directement.
- Le nom affiché dans les messages n'est jamais "extrait" en texte :
  on utilise un sélecteur `@a[scores={pvp.id=...}]` que le jeu résout
  lui-même à l'affichage — plus robuste qu'une chaîne figée si le
  joueur change de pseudo.
- `pvp.pending_from` : stocke qui a défié qui, vérifié à l'acceptation
  pour ignorer un vieux bouton [Accepter] resté affiché après une
  demande périmée.
- Détection de victoire : `deathCount` (stat vanilla) comparé à une
  valeur de référence capturée au lancement du duel.

## Limites connues (pas des bugs, des simplifications volontaires)

- Si le joueur défié se déconnecte entre l'envoi de la demande et sa
  réponse, aucun message d'erreur n'est renvoyé au demandeur — le
  bouton [Défier] cliqué ne produit juste aucun effet visible chez la
  cible. Facile à corriger avec une vérification `unless entity`
  supplémentaire si besoin.
- Un seul menu peut être "en cours de construction" par tick serveur
  (cas limite si 2 joueurs font `/trigger pvp.trigger` exactement au
  même tick — l'un devra refaire la commande).
- Un seul duel à la fois. Pour plusieurs arènes en parallèle, il faut
  dupliquer `pvp.state`/`pvp.slotN` avec un suffixe par arène.
