execute store result storage pvp:tmp stat.a int 1 run scoreboard players get @a[tag=pvp.duel,tag=!pvp.loser,limit=1] pvp.id
execute store result storage pvp:tmp stat.b int 1 run scoreboard players get @a[tag=pvp.loser,limit=1] pvp.id
data modify storage pvp:tmp stat.f set value "w"
function pvp:record_stat with storage pvp:tmp stat
execute store result storage pvp:tmp stat.a int 1 run scoreboard players get @a[tag=pvp.loser,limit=1] pvp.id
execute store result storage pvp:tmp stat.b int 1 run scoreboard players get @a[tag=pvp.duel,tag=!pvp.loser,limit=1] pvp.id
data modify storage pvp:tmp stat.f set value "l"
function pvp:record_stat with storage pvp:tmp stat
