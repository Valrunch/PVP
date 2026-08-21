execute as @a[tag=pvp.duel] run title @s title {"text":"1","color":"yellow","bold":true}
execute as @a[tag=pvp.duel] run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1
schedule function pvp:countdown_go 20
