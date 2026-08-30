# v1.0 : commandes rendues cliquables (clickEvent) — la boussole qui
# ouvrait le menu en un clic a ete retiree, il faut desormais taper ou
# cliquer ces commandes a la main.
tellraw @s [{"text":"=== Commandes PvP ===","color":"gold"}]
tellraw @s [{"text":"/trigger pvp.trigger","color":"yellow","clickEvent":{"action":"run_command","value":"/trigger pvp.trigger"}},{"text":" - ouvrir le menu pour le pvp","color":"gray"}]
tellraw @s [{"text":"/trigger pvp.accept","color":"yellow","clickEvent":{"action":"run_command","value":"/trigger pvp.accept"}},{"text":" - accepter un duel recu","color":"gray"}]
tellraw @s [{"text":"/trigger pvp.decline","color":"yellow","clickEvent":{"action":"run_command","value":"/trigger pvp.decline"}},{"text":" - refuser un duel recu","color":"gray"}]
tellraw @s [{"text":"/trigger pvp.cancel","color":"yellow","clickEvent":{"action":"run_command","value":"/trigger pvp.cancel"}},{"text":" - annuler ta demande envoyee","color":"gray"}]
tellraw @s [{"text":"/trigger pvp.stats","color":"yellow","clickEvent":{"action":"run_command","value":"/trigger pvp.stats"}},{"text":" - voir tes victoires/defaites","color":"gray"}]
