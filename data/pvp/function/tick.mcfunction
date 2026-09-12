# ============================================================
# tick.mcfunction — tourne chaque tick (20x/seconde)
# Chaque bloc ne coute quasi rien tant qu'aucun joueur n'a le
# score correspondant : le "if"/selector sort immediatement.
#
# v1.0 — PERF : les 7 "scoreboard players enable @a ..." qui tournaient
# ICI pour TOUS les joueurs a CHAQUE tick ont ete retires. Un trigger
# vanilla reste actif tant qu'il n'a pas ete consomme : le reactiver en
# boucle 20x/seconde ne servait a rien. Il est maintenant active une
# seule fois a la connexion (assign_id.mcfunction) et reactive juste
# apres consommation, uniquement pour le joueur concerne (blocs
# ci-dessous). pvp.accept / pvp.decline n'ont pas besoin de ce
# traitement : ils sont deja reactives, cibles, par
# send_request_notify.mcfunction des qu'une demande arrive.
# ============================================================

# --- Attribution paresseuse d'un ID unique (couvre les nouvelles connexions) ---
execute as @a unless score @s pvp.id matches 1.. run function pvp:assign_id

# --- Rattrapage d'un joueur reconnecte OU d'un perdant qui vient de
# respawn pour de vrai ----------------------------------------------------
# Un seul et meme bloc gere deux cas :
# 1) Un duelliste s'est deconnecte pendant son duel : check_win.mcfunction
#    detecte qu'il ne reste qu'un joueur tague pvp.duel et annule proprement
#    LE DUEL DE CE JOUEUR-LA (cleanup_player, restore_return_state...). Mais
#    ces commandes utilisent toutes le selecteur @a, qui ne cible QUE les
#    joueurs connectes - rien de tout ca n'a jamais pu s'appliquer au joueur
#    qui vient de se deconnecter. Sans ce correctif, il resterait tague
#    pvp.duel a vie (bloque en mode Adventure) a sa reconnexion.
# 2) v1.1 : le PERDANT d'un duel normal. end_duel.mcfunction ne restaure
#    QUE le gagnant tout de suite (un joueur mort ne peut pas etre deplace
#    de facon fiable entre dimensions). Le perdant garde le tag pvp.duel
#    jusqu'a ce que CE bloc detecte son vrai respawn (pvp.health repasse a
#    1..) et termine alors sa restauration - c'est exactement le meme
#    besoin que le cas (1), juste un chemin different pour y arriver.
# Dans les deux cas : arene deja libre (state=0) ET joueur reellement en
# vie (health>=1) = c'est le bon moment, jamais avant. On restaure enfin -
# sans credit de victoire/defaite dans le cas (1), puisque ce duel a ete
# annule et non joue jusqu'au bout.
execute as @a[tag=pvp.duel,tag=pvp.slot1,scores={pvp.health=1..}] if score #global pvp.state matches 0 run function pvp:restore_return_state with storage pvp:tmp.return1
execute as @a[tag=pvp.duel,tag=pvp.slot2,scores={pvp.health=1..}] if score #global pvp.state matches 0 run function pvp:restore_return_state with storage pvp:tmp.return2
execute as @a[tag=pvp.duel,scores={pvp.health=1..}] if score #global pvp.state matches 0 run function pvp:cleanup_player

# --- Ouverture du menu principal (GUI) ---
execute as @a[scores={pvp.trigger=1..}] run menu pvp:main
execute as @a[scores={pvp.trigger=1..}] run scoreboard players enable @s pvp.trigger
execute as @a[scores={pvp.trigger=1..}] run scoreboard players set @s pvp.trigger 0

# --- Envoi d'une demande de duel ciblee ---
execute as @a[scores={pvp.request=1..}] run function pvp:send_request
execute as @a[scores={pvp.request=1..}] run scoreboard players enable @s pvp.request
execute as @a[scores={pvp.request=1..}] run scoreboard players set @s pvp.request 0

# --- Reponse a une demande recue (accepter / refuser) ---
# pvp.accept / pvp.decline : pas de "enable" ici, deja gere par
# send_request_notify.mcfunction au moment ou la demande arrive.
execute as @a[scores={pvp.accept=1..}] run function pvp:accept_request
execute as @a[scores={pvp.accept=1..}] run scoreboard players set @s pvp.accept 0
execute as @a[scores={pvp.decline=1..}] run function pvp:decline_request
execute as @a[scores={pvp.decline=1..}] run scoreboard players set @s pvp.decline 0

# --- Annulation d'une demande envoyee ---
execute as @a[scores={pvp.cancel=1..}] run function pvp:cancel_request
execute as @a[scores={pvp.cancel=1..}] run scoreboard players enable @s pvp.cancel
execute as @a[scores={pvp.cancel=1..}] run scoreboard players set @s pvp.cancel 0

# --- Aide (liste des commandes) ---
execute as @a[scores={pvp.help=1..}] run function pvp:help
execute as @a[scores={pvp.help=1..}] run scoreboard players enable @s pvp.help
execute as @a[scores={pvp.help=1..}] run scoreboard players set @s pvp.help 0

# --- Stats persos ---
execute as @a[scores={pvp.stats=1..}] run function pvp:show_stats
execute as @a[scores={pvp.stats=1..}] run scoreboard players enable @s pvp.stats
execute as @a[scores={pvp.stats=1..}] run scoreboard players set @s pvp.stats 0

# --- Expiration auto d'une demande non traitee (30s = 600 ticks) ---
# Evite qu'une cible qui ignore une demande bloque le systeme pour tout
# le monde indefiniment (le requester ne pourrait plus rien envoyer).
execute as @a[scores={pvp.pending_from=1..,pvp.pendingticks=1..}] run scoreboard players remove @s pvp.pendingticks 1
execute as @a[scores={pvp.pending_from=1..,pvp.pendingticks=..0}] run function pvp:expire_request

# --- Nettoyage des duels fantomes apres un bug ou un tp casse ---
# Si un joueur porte encore le tag pvp.duel alors qu'il n'est plus dans
# la dimension du duel, on le remet au propre pour eviter qu'il soit
# bloque indefiniment comme "en duel".
execute as @a[tag=pvp.duel] unless data entity @s {Dimension:"multiworld:pvp"} run function pvp:cleanup_player
execute unless entity @a[tag=pvp.duel] if score #global pvp.state matches 1..2 run scoreboard players set #global pvp.state 0

# --- Protection post-respawn (voir postduel_shield.mcfunction) ---
# pvp.health (criterion "health") vaut 0 tant que le joueur est mort et
# repasse a >=1 des qu'il clique reellement sur Respawn. On attend ce
# moment precis pour donner la protection, plutot que de la donner trop
# tot pendant qu'il est encore mort (auquel cas le respawn vanilla
# l'effacerait avant qu'elle ne serve a quoi que ce soit).
execute as @a[tag=pvp.postduel_shield,scores={pvp.health=1..}] run function pvp:postduel_shield

# --- Suivi d'un duel en cours (decompte ET combat) ---
# matches 1..2 : 1 = combat, 2 = decompte. Couvrir le decompte aussi
# permet de detecter une deconnexion pendant les 3-2-1 sans attendre
# le debut du combat pour reagir.
execute if score #global pvp.state matches 1..2 run function pvp:check_win

# Fige la faim pendant tout le duel (decompte + combat) : sans ca, courir
# et frapper pendant le combat vide la barre de faim normalement, ce qui
# n'a pas de sens pour un duel cense durer quelques dizaines de secondes.
# On remet foodLevel/saturation au max et l'exhaustion a 0 CHAQUE tick,
# directement en NBT plutot que via un effet (qui pourrait expirer) :
# resultat garanti quoi qu'il se passe pendant le combat.
execute as @a[tag=pvp.duel] if score #global pvp.state matches 1..2 run data merge entity @s {foodLevel:20,foodSaturationLevel:20.0f,foodExhaustionLevel:0.0f}

# Exécute la fonction d'acceptation de manière sécurisée sur le Main Thread
execute as @a[tag=pvp_accept_pending] run function pvp:accept_request
tag @a[tag=pvp_accept_pending] remove pvp_accept_pending