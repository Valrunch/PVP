# Contexte : exécuté "as" un candidat éligible (le joueur qui pourrait être défié)
# Seul l'ID numérique doit être "injecté" dans la commande de clic — le nom,
# lui, s'affiche via un sélecteur qui se résout tout seul, pas besoin de
# l'extraire en texte.
execute store result storage pvparena:tmp id int 1 run scoreboard players get @s pvp.id
function pvparena:menu_send_line_msg with storage pvparena:tmp
