$execute unless data storage pvp:stats h2h.p$(a)[{id:$(b)}] run data modify storage pvp:stats h2h.p$(a) append value {id:$(b),w:0,l:0}
$execute store result score #stat pvp.tmp run data get storage pvp:stats h2h.p$(a)[{id:$(b)}].$(f)
scoreboard players add #stat pvp.tmp 1
$execute store result storage pvp:stats h2h.p$(a)[{id:$(b)}].$(f) int 1 run scoreboard players get #stat pvp.tmp
