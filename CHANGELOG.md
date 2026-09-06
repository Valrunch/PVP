fix(pvp): restaure l'inventaire au respawn + corrige la fuite globale de keepInventory

Bug principal signalé : après un duel (mort en combat), le joueur ne
récupère pas son inventaire d'avant-duel au respawn.

Cause trouvée en comparant l'historique Git du dépôt (commit f71bc8b,
"Refactor cleanup and restoration logic in duel functions", 01/09) : ce
commit a supprimé par erreur les lignes qui restauraient manuellement
l'inventaire (Inventory + SelectedItemSlot) dans restore_return_state.mcfunction.
Le commentaire de save_return_state.mcfunction dit explicitement que ce
système est conçu pour fonctionner "sans dépendre d'un plugin
dimensional-inventory externe" : Dimensional Inventories gère bien le swap
pour un joueur VIVANT qui change de dimension, mais l'échange officiel de
dimension pour un joueur MORT n'a lieu qu'au moment où il clique sur
Respawn - bien après que le /tp du datapack se soit déjà exécuté pendant
qu'il était mort. Sans la restauration manuelle, rien ne garantit que le
mod remette le bon inventaire en place à ce moment précis, et le joueur
ne récupère alors que les restes de son kit de duel.

Fix : les lignes supprimées sont remises (clear @s + restauration
Inventory/SelectedItemSlot) dans restore_return_state.mcfunction.

Bug de sécurité corrigé au passage : "gamerule keepInventory true" est
posé au début de chaque duel (start_duel.mcfunction) mais n'était JAMAIS
remis à "false" nulle part dans le datapack. Comme /gamerule est un
réglage global (pas limité à une dimension), dès le premier duel joué sur
le serveur, TOUS les joueurs, PARTOUT (pas seulement dans l'arène),
cessaient définitivement de perdre leur inventaire en mourant. Corrigé en
ajoutant "gamerule keepInventory false" à la fin de end_duel.mcfunction.

Bug trouvé en audit (pas signalé mais présent) : un joueur qui se
déconnecte PENDANT un duel n'était jamais nettoyé à sa reconnexion. Le
duel de l'adversaire restant est bien annulé (détection de déconnexion déjà
en place), mais toutes les commandes de nettoyage utilisent le sélecteur
@a, qui ne cible que les joueurs connectés - donc rien ne s'appliquait au
joueur qui venait de partir. À la reconnexion, il restait tagué pvp.duel
à vie : bloqué en mode Adventure, incapable de redéfier quelqu'un ou
d'être défié, et sans jamais récupérer sa position ni son inventaire
d'avant-duel. Fix : tick.mcfunction détecte maintenant un joueur encore
tagué pvp.duel alors que l'arène est déjà libre (state=0) et le restaure
proprement, sans crédit de victoire/défaite (duel annulé, pas joué).

Bug signalé après ce premier patch : le perdant meurt à nouveau en
respawnant.

Cause probable : les effets de sécurité (instant_health, saturation)
donnés dans restore_return_state.mcfunction s'appliquent pendant que le
joueur est ENCORE mort (avant qu'il ait cliqué sur Respawn). Or le
respawn vanilla réinitialise les effets actifs - ces effets sont donc
perdus au moment exact où ils seraient utiles, laissant le joueur sans
aucune protection s'il réapparaît dans un endroit à risque (suffocation,
chute résiduelle, feu encore actif s'il est mort avec fire_aspect sur
lui).

Fix : nouvel objectif de score "pvp.health" (critère vanilla "health",
se met à jour tout seul - vaut 0 tant que le joueur est mort, repasse à
1+ dès qu'il clique réellement sur Respawn). tick.mcfunction attend ce
signal précis pour déclencher postduel_shield.mcfunction, qui donne
Résistance III (3s, quasi-immunité), Feu Resistance (3s), et les mêmes
soins - mais cette fois sur un joueur réellement vivant, donc les effets
tiennent.

Fichiers modifiés en plus :
- data/pvp/function/postduel_shield.mcfunction (nouveau)
- data/pvp/function/restore_return_state.mcfunction (tag ajouté)
- data/pvp/function/tick.mcfunction (déclencheur ajouté)
- data/pvp/function/load.mcfunction (nouvel objectif + nettoyage au reload)

Bug signalé après le patch précédent : même le GAGNANT perd son inventaire
(pas seulement le perdant).

Cause : `restore_return_state.mcfunction` restaurait l'inventaire via
`data modify entity @s Inventory set value $(Inventory)` - cette syntaxe
passe TOUT l'inventaire par une substitution de macro, ce qui oblige
Minecraft à le convertir en texte pour l'insérer dans la commande, avant
de le reparser. Avec Cobblemon installé sur ce serveur, une seule Poké
Ball contenant un Pokémon capturé (espèce, IVs, EVs, moves, nature,
forme...) suffit à faire dépasser la limite de longueur d'une commande.
La ligne échoue alors silencieusement (aucun message d'erreur bloquant,
le reste de la fonction continue normalement) - et comme `clear @s`
vient juste de vider l'inventaire, le joueur se retrouve avec rien du
tout, gagnant ou perdant, dès que l'un des deux transporte ce genre
d'objet.

Fix : `save_return_state.mcfunction` sauvegarde en plus le numéro de slot
dans le storage. `restore_return_state.mcfunction` restaure l'inventaire
via `data modify entity @s Inventory set from storage pvp:tmp.returnX
Inventory` - une copie NBT interne, jamais convertie en texte, donc
aucune limite de taille peu importe ce que contient l'inventaire.

Fichiers modifiés en plus :
- data/pvp/function/save_return_state.mcfunction
- data/pvp/function/restore_return_state.mcfunction

Bug signalé après ce patch : le perdant reste en feu après le respawn.

Cause : `postduel_shield.mcfunction` donnait de la Résistance au Feu
temporaire (3s), mais si le compteur de combustion réel ("Fire" en NBT,
posé par le fire_aspect de l'épée du kit) est plus long que ça, le feu
reprend une fois l'effet fini.

Fix : `data merge entity @s {Fire:0}` - extinction immédiate et
définitive du compteur, la fire_resistance ne servant plus que de
sécurité additionnelle pendant la transition.

Fichier modifié en plus :
- data/pvp/function/postduel_shield.mcfunction

Nouvelle fonctionnalité demandée : couper la faim pendant le duel.

Fix : `foodLevel`/`foodSaturationLevel`/`foodExhaustionLevel` sont remis
au max chaque tick, en NBT directe (pas via un effet qui pourrait
expirer), tant que le duel est actif (décompte + combat). Revient au
comportement normal dès la fin du duel.

Fichier modifié en plus :
- data/pvp/function/tick.mcfunction (gel de la faim)

Fichiers modifiés :
- data/pvp/function/restore_return_state.mcfunction
- data/pvp/function/end_duel.mcfunction
- data/pvp/function/tick.mcfunction
Version : reste v1.0 (aucun changement de numéro pour ce patch)
