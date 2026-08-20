# potatoPVP v1.0 (Minecraft 1.21.1)

Defi cible entre 2 joueurs (menu cliquable, accepter/refuser), decompte
3-2-1-COMBATTEZ avec titres et sons, kit, teleport dans ta dimension
PVP, detection de victoire, stats perso, retour et reset auto de
l'arene. Zero dependance a WorldEdit, 100% vanilla.

## v1.0 - changelog

- Renomme `pvparena` -> `potatopvp` (namespace interne, en minuscules :
  les identifiants Minecraft n'acceptent pas les majuscules, seul le
  nom du dossier/zip peut s'appeler "potatoPVP").
- **Corrige** : `decline_notify.mcfunction` plantait au chargement
  ("Macro without variables on line 1") — la ligne de message n'avait
  pas besoin d'etre une ligne macro, elle etait juste mal prefixee `$`.
- **Corrige** : `start_duel` et `reset_arena` plantaient au chargement
  ("Expected whitespace") — tres probablement un caractere invisible
  introduit en editant `pvp:dimension` depuis un clavier mobile. Les
  fichiers ont ete regeneres proprement pour eliminer le risque.
- **Ajoute** : decompte avant combat (resistance totale + titre 3/2/1
  + son), victoire/defaite trackees separement, titres et sons de fin
  de combat, commande de stats perso.

## Installation

1. Copie le dossier `potatoPVP/` dans `world/datapacks/` de ton
   serveur (ou utilise directement le `.zip`, les deux marchent).
2. En jeu (en op) : `/reload`
3. Tu dois voir `[potatoPVP v1.0] datapack charge.` dans le chat, et
   plus aucune erreur `Failed to load function` dans les logs au
   demarrage.

## Deja configure (pas besoin d'y toucher)

Dimension et coordonnees sont deja renseignees avec tes valeurs :
`pvp:dimension`, spawns `100 65 90` / `100 65 110`, retour au lobby
`pvp:dimension 0 64 0`. Si tu changes un jour la disposition de
l'arene, les fichiers a modifier restent :
`start_duel.mcfunction`, `end_duel.mcfunction`, `reset_arena.mcfunction`.

Le kit se personnalise dans `give_kit.mcfunction`.

### Sauvegarder l'arene pour le reset auto (obligatoire, une fois)

1. `/give @p minecraft:structure_block`
2. Pose-le, clique dessus, mode **Save**.
3. Nom de structure : `potatopvp:arena` (exactement, avec les deux-points).
4. Ajuste la taille pour couvrir toute la zone de combat + decors, clique **Save**.
5. Bug Mojang connu (MC-272671) sur le 1.21.1 : le fichier peut etre
   ecrit dans `world/generated/potatopvp/structures/` (avec un S) au
   lieu de `structure/` (sans S) — regarde dans les deux si tu ne le
   trouves pas. Copie-le dans `data/potatopvp/structure/arena.nbt`
   (sans S, obligatoire ici).

## Commandes joueur (aucun grade requis)

- `/trigger pvp.trigger` — ouvre le menu de defi
- `/trigger pvp.stats` — affiche tes victoires/defaites

Tout le reste (defier, accepter, refuser) se fait par clic sur les
messages de chat generes automatiquement.

## Commandes admin

- `/function potatopvp:reset_arena` — reconstruit l'arene manuellement
- `/scoreboard players get <joueur> pvp.wins` / `pvp.losses`
- Bonus "tableau des scores" a l'ecran (a activer/desactiver a la main,
  affiche TOUS les joueurs, pas trie) :
  `/scoreboard objectives setdisplay sidebar pvp.wins`

## Deroule d'un duel

1. Menu -> [Defier] -> l'autre recoit [Accepter]/[Refuser]
2. Accepte -> teleport + kit + 4s de resistance totale
3. Titre 3... 2... 1... COMBATTEZ (avec son a chaque etape)
4. Resistance retiree pile au "COMBATTEZ", combat reel commence
5. Mort ou deconnexion -> titre VICTOIRE/DEFAITE, son, annonce
   publique, stats mises a jour, retour au lobby, arene reconstruite

## Limites connues (simplifications volontaires, pas des bugs)

- Un seul duel a la fois (pas d'arenes paralleles).
- Une deconnexion pendant le decompte 3-2-1 n'est pas detectee tant
  que le combat n'a pas officiellement commence (quelques secondes
  de delai max avant que le duel ne s'auto-annule).
- Pas de classement trie par victoires : le vanilla ne permet pas de
  trier un scoreboard nativement sans mod ou logique NBT plus lourde.
  `/trigger pvp.stats` couvre le besoin individuel.
- Si le joueur defie se deconnecte juste apres avoir recu la demande,
  aucun message d'erreur n'est renvoye au demandeur (le clic ne fait
  juste rien de visible chez la cible).
