# Contexte : execute "as" le joueur dont la demande RECUE vient d'expirer
# (pvp.pending_from > 0 et pvp.pendingticks <= 0).
execute store result storage pvp:tmp requester_id int 1 run scoreboard players get @s pvp.pending_from
execute store result storage pvp:tmp target_id int 1 run scoreboard players get @s pvp.id
scoreboard players set @s pvp.pending_from 0
scoreboard players set @s pvp.pendingticks 0
function pvp:expire_notify with storage pvp:tmp
