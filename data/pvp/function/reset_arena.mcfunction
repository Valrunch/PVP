execute in multiworld:pvp positioned 0 0 0 run kill @e[type=item,distance=0..]
execute in multiworld:pvp positioned 0 0 0 run kill @e[type=experience_orb,distance=0..]
execute store success score #ok pvp.tmp in multiworld:pvp run place template pvp:arena 90 60 80
execute if score #ok pvp.tmp matches 0 run tellraw @a [{"text":"[Duel] ","color":"dark_gray"},{"text":"Arene non reinitialisee : structure pvp:arena introuvable. Previens un admin.","color":"red"}]
