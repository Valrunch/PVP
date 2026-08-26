# ============================================================
# tick.mcfunction — tourne chaque tick (20x/seconde)
# Chaque bloc ne coute quasi rien tant qu'aucun joueur n'a le
# score correspondant : le "if"/selector sort immediatement.
# ============================================================

# --- Trigger management : garder les commandes toujours disponibles ---
scoreboard players enable @a pvp.trigger
scoreboard players enable @a pvp.request
scoreboard players enable @a pvp.accept
scoreboard players enable @a pvp.decline
scoreboard players enable @a pvp.cancel
scoreboard players enable @a pvp.help
scoreboard players enable @a pvp.stats

# --- Detection du clic droit sur l'item PvP ---
# On se base sur l'objective "used:warped_fungus_on_a_stick" qui est plus robuste
# que l'advancement dans 1.21.1. Comme le pack ne donne qu'un seul objet de ce type,
# il ouvre bien le menu sans passer par un predicate externe.
execute as @a[scores={pvp.used_stick=1..}] run function pvp:open_menu_compass
execute as @a[scores={pvp.used_stick=1..}] run scoreboard players set @s pvp.used_stick 0

# --- Attribution paresseuse d'un ID unique (couvre les nouvelles connexions) ---
execute as @a unless score @s pvp.id matches 1.. run function pvp:assign_id

# --- Securite des boussoles PvP : si elle est perdue ou detruite, on la
# restitue instantanement pour tous les joueurs (ancien et nouveau). ---
execute as @a run function pvp:ensure_pvp_compass

# --- Ouverture du menu principal (GUI) ---
execute as @a[scores={pvp.trigger=1..}] run menu pvp:main
execute as @a[scores={pvp.trigger=1..}] run scoreboard players set @s pvp.trigger 0

# --- Envoi d'une demande de duel ciblee ---
execute as @a[scores={pvp.request=1..}] run function pvp:send_request
execute as @a[scores={pvp.request=1..}] run scoreboard players set @s pvp.request 0

# --- Reponse a une demande recue (accepter / refuser) ---
execute as @a[scores={pvp.accept=1..}] run function pvp:accept_request
execute as @a[scores={pvp.accept=1..}] run scoreboard players set @s pvp.accept 0
execute as @a[scores={pvp.decline=1..}] run function pvp:decline_request
execute as @a[scores={pvp.decline=1..}] run scoreboard players set @s pvp.decline 0

# --- Annulation d'une demande envoyee ---
execute as @a[scores={pvp.cancel=1..}] run function pvp:cancel_request
execute as @a[scores={pvp.cancel=1..}] run scoreboard players set @s pvp.cancel 0

# --- Aide (liste des commandes) ---
execute as @a[scores={pvp.help=1..}] run function pvp:help
execute as @a[scores={pvp.help=1..}] run scoreboard players set @s pvp.help 0

# --- Stats persos ---
execute as @a[scores={pvp.stats=1..}] run function pvp:show_stats
execute as @a[scores={pvp.stats=1..}] run scoreboard players set @s pvp.stats 0

# --- Expiration auto d'une demande non traitee (30s = 600 ticks) ---
# Evite qu'une cible qui ignore une demande bloque le systeme pour tout
# le monde indefiniment (le requester ne pourrait plus rien envoyer).
execute as @a[scores={pvp.pending_from=1..,pvp.pendingticks=1..}] run scoreboard players remove @s pvp.pendingticks 1
execute as @a[scores={pvp.pending_from=1..,pvp.pendingticks=..0}] run function pvp:expire_request

# --- Suivi d'un duel en cours (decompte ET combat) ---
# matches 1..2 : 1 = combat, 2 = decompte. Couvrir le decompte aussi
# permet de detecter une deconnexion pendant les 3-2-1 sans attendre
# le debut du combat pour reagir.
execute if score #global pvp.state matches 1..2 run function pvp:check_win
