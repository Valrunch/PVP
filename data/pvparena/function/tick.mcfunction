# ============================================================
# tick.mcfunction — tourne chaque tick (20x/seconde)
# Chaque bloc ne coûte quasi rien tant qu'aucun joueur n'a le
# score correspondant : le "if"/selector sort immédiatement.
# ============================================================

# --- Attribution paresseuse d'un ID unique (couvre les nouvelles connexions) ---
execute as @a unless score @s pvp.id matches 1.. run function pvparena:assign_id

# --- Ouverture du menu de défi ---
execute as @a[scores={pvp.trigger=1..}] run function pvparena:menu
execute as @a[scores={pvp.trigger=1..}] run scoreboard players set @s pvp.trigger 0

# --- Envoi d'une demande de duel ciblée ---
execute as @a[scores={pvp.request=1..}] run function pvparena:send_request
execute as @a[scores={pvp.request=1..}] run scoreboard players set @s pvp.request 0

# --- Réponse (accepter / refuser) ---
execute as @a[scores={pvp.accept=1..}] run function pvparena:accept_request
execute as @a[scores={pvp.accept=1..}] run scoreboard players set @s pvp.accept 0
execute as @a[scores={pvp.decline=1..}] run function pvparena:decline_request
execute as @a[scores={pvp.decline=1..}] run scoreboard players set @s pvp.decline 0

# --- Suivi d'un duel en cours ---
execute if score #global pvp.state matches 1 run function pvparena:check_win
