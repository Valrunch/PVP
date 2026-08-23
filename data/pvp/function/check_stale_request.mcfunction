# Contexte : execute "as" un joueur qui a un pvp.requested_id > 0.
# Verifie que la demande envoyee est encore reellement active chez la
# cible. Sert de filet de securite : si ce joueur etait deconnecte au
# moment ou la cible a repondu/l'a refuse/la demande a expire, les
# commandes de nettoyage cote cible n'ont pas pu l'atteindre (elles ne
# ciblent que des joueurs en ligne). Sans ce controle, pvp.requested_id
# resterait bloque pour toujours et il ne pourrait plus jamais renvoyer
# de demande.
execute store result storage pvp:tmp requester_id int 1 run scoreboard players get @s pvp.id
execute store result storage pvp:tmp target_id int 1 run scoreboard players get @s pvp.requested_id
function pvp:check_stale_request_clear with storage pvp:tmp
