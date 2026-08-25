# Contexte : toujours "as" le joueur qui accepte (pas de changement de
# contexte ici, donc @s reste correct pour les messages d'erreur).
# Filet de securite : le requester peut avoir quitte le serveur ou
# avoir deja lance un autre duel entre l'envoi de la demande et le
# moment ou celle-ci est acceptee.
$execute unless entity @a[scores={pvp.id=$(requester_id)}] run return run tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Ce joueur n'est plus disponible.","color":"red"}]
$execute unless entity @a[scores={pvp.id=$(requester_id)},tag=!pvp.duel] run return run tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Ce joueur est deja en duel avec quelqu'un d'autre.","color":"red"}]
function pvp:launch_from_request with storage pvp:tmp
