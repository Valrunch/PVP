# Save the exact pre-duel position, rotation and spawn information so the
# player can be returned to the exact previous spot after the duel.
execute store result storage pvp:tmp.return x double 1 run data get entity @s Pos[0]
execute store result storage pvp:tmp.return y double 1 run data get entity @s Pos[1]
execute store result storage pvp:tmp.return z double 1 run data get entity @s Pos[2]
execute store result storage pvp:tmp.return yaw float 1 run data get entity @s Rotation[0]
execute store result storage pvp:tmp.return pitch float 1 run data get entity @s Rotation[1]
