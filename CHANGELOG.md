fix: inventaire perdu apres duel, keepInventory global, stats par adversaire

Corrections
- Inventaire perdu : `data modify entity` est interdit sur les joueurs ("Unable to modify player data"), donc la restauration n'a jamais fonctionne. Remplace par une sauvegarde dans 2 tonneaux par joueur (`item replace`), restauration des que le joueur est vivant.
- keepInventory : le datapack ne modifie plus aucune gamerule (l'overworld n'est plus reinitialise). L'XP est sauvegardee/restauree a la place.
- Faim et feu : `data merge entity` echouait aussi. Faim figee avec l'effet saturation, feu couvert par fire_resistance 10 s.
- reset_arena : `kill @e[type=item]` visait toutes les dimensions, limite maintenant a multiworld:pvp.
- Position de retour : precision 0,001 (avant : tronquee au bloc entier, risque de suffocation).
- spawnpoint retire : ecrasait le lit des joueurs a chaque duel.
- Joueurs arrives apres le dernier /reload absents du menu (pvp.pending_from non initialise).
- Duel annule si un duelliste quitte la dimension ; tags perimes nettoyes a la reconnexion.
- hoverEvent : `contents` au lieu de `value`.

Ajouts
- Stats contre chaque joueur dans /trigger pvp.stats ; message de fin "X a battu Y".
- Messages d'erreur clairs et directs, y compris pour les cas de sauvegarde et d'arene.

Nettoyage
- Tous les commentaires retires.
- Code mort supprime : boussole (ensure_pvp_compass*, open_menu_compass, advancement, predicate), disable_keepinventory, postduel_shield, cleanup_player.
