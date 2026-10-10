scoreboard objectives add pvp.state dummy
scoreboard objectives add pvp.nextid dummy
scoreboard objectives add pvp.candidates dummy
scoreboard objectives add pvp.alive dummy
scoreboard objectives add pvp.tmp dummy
scoreboard objectives add pvp.deaths deathCount
scoreboard objectives add pvp.deaths_start dummy
scoreboard objectives add pvp.left minecraft.custom:minecraft.leave_game
scoreboard objectives add pvp.saved dummy
scoreboard objectives add pvp.wins dummy "PvP Wins"
scoreboard objectives add pvp.losses dummy "PvP Losses"
scoreboard objectives add pvp.id dummy
scoreboard objectives add pvp.stats trigger "Voir mes stats PvP"
scoreboard objectives add pvp.trigger trigger "Ouvrir le menu pour le pvp"
scoreboard objectives add pvp.request trigger "Defier un joueur"
scoreboard objectives add pvp.accept trigger "Accepter un duel"
scoreboard objectives add pvp.decline trigger "Refuser un duel"
scoreboard objectives add pvp.cancel trigger "Annuler ta demande envoyee"
scoreboard objectives add pvp.help trigger "Afficher les commandes"
scoreboard objectives add pvp.pending_from dummy
scoreboard objectives add pvp.pendingticks dummy
scoreboard objectives add pvp.requested_id dummy
scoreboard objectives remove pvp.health
scoreboard players enable @a pvp.trigger
scoreboard players enable @a pvp.request
scoreboard players enable @a pvp.accept
scoreboard players enable @a pvp.decline
scoreboard players enable @a pvp.cancel
scoreboard players enable @a pvp.help
scoreboard players enable @a pvp.stats
scoreboard players set #global pvp.state 0
scoreboard players add #next_id pvp.nextid 0
schedule clear pvp:countdown_2
schedule clear pvp:countdown_1
schedule clear pvp:countdown_go
execute as @a unless score @s pvp.id matches 1.. run function pvp:assign_id
execute as @a run function pvp:vault_prepare
tellraw @a [{"text":"[potatoPVP v1.0] datapack charge.","color":"dark_gray"}]
