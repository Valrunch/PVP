# ============================================================
# give_kit.mcfunction
# v1.0 — 2 bugs de syntaxe 1.21.1 + 1 probleme d'UX corriges :
#
# 1) Enchantements : "enchantments={sharpness:2}" sans le bloc "levels"
#    est invalide jusqu'a la 1.21.4 incluse -> la commande echoue,
#    l'objet part probablement sans enchantement (voir l'epee, la hache,
#    les 4 pieces d'armure, le bouclier).
#    Fix : "enchantments={levels:{"minecraft:xxx":n}}".
#
# 2) Potions : "potion_contents=\"minecraft:strength\"" (chaine brute)
#    n'est pas le bon format — potion_contents est un objet, pas une
#    chaine. Fix : "potion_contents={potion:\"minecraft:xxx\"}".
#    "strong_healing" et "strong_swiftness"/"strong_strength" restent
#    les variantes niveau II (equivalent de l'ancien amplifier:1).
#
# 3) Armure/epee donnees via /give = dans l'inventaire, pas equipees.
#    Avec ~3s de decompte (voir start_duel.mcfunction), impossible de
#    tout glisser a la main dans les emplacements avant "COMBATTEZ".
#    Fix : "/item replace entity @s armor.X with ..." equipe direct.
#    Bouclier laisse en /give classique (pas equipe en offhand) pour ne
#    pas entrer en conflit avec le totem, que beaucoup de joueurs
#    preferent garder en main gauche pour la resurrection automatique.
#    A confirmer si tu veux un comportement different.
# ============================================================

item replace entity @s armor.head with minecraft:diamond_helmet[enchantments={levels:{"minecraft:protection":2}}]
item replace entity @s armor.chest with minecraft:diamond_chestplate[enchantments={levels:{"minecraft:protection":2}}]
item replace entity @s armor.legs with minecraft:diamond_leggings[enchantments={levels:{"minecraft:protection":2}}]
item replace entity @s armor.feet with minecraft:diamond_boots[enchantments={levels:{"minecraft:protection":2}}]
item replace entity @s weapon.mainhand with minecraft:diamond_sword[enchantments={levels:{"minecraft:sharpness":2,"minecraft:fire_aspect":2}}]

give @s minecraft:diamond_axe[enchantments={levels:{"minecraft:sharpness":1}}]
give @s minecraft:shield[enchantments={levels:{"minecraft:unbreaking":1}}]
give @s minecraft:totem_of_undying 1
give @s minecraft:golden_apple 10
give @s minecraft:enchanted_golden_apple 1

give @s minecraft:splash_potion[potion_contents={potion:"minecraft:strong_strength"}] 3
give @s minecraft:splash_potion[potion_contents={potion:"minecraft:strong_swiftness"}] 3
give @s minecraft:splash_potion[potion_contents={potion:"minecraft:fire_resistance"}] 3
give @s minecraft:splash_potion[potion_contents={potion:"minecraft:strong_healing"}] 5
