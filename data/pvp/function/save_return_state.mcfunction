execute store result storage pvp:tmp ret.x double 0.001 run data get entity @s Pos[0] 1000
execute store result storage pvp:tmp ret.y double 0.001 run data get entity @s Pos[1] 1000
execute store result storage pvp:tmp ret.z double 0.001 run data get entity @s Pos[2] 1000
execute store result storage pvp:tmp ret.yaw float 0.001 run data get entity @s Rotation[0] 1000
execute store result storage pvp:tmp ret.pitch float 0.001 run data get entity @s Rotation[1] 1000
data modify storage pvp:tmp ret.dimension set from entity @s Dimension
execute store result storage pvp:tmp ret.levels int 1 run experience query @s levels
execute store result storage pvp:tmp ret.points int 1 run experience query @s points
function pvp:vault_locate
function pvp:save_return_store with storage pvp:tmp key
