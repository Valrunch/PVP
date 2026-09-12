fix(pvp): respawn du perdant fiable + nettoyage des fichiers morts

## Bug corrige : respawn qui marche mal (feu qui reste, faim pas
## restauree, objets parfois perdus)

Cause probable : end_duel.mcfunction restaurait TOUT LE MONDE tout de
suite, y compris le perdant qui est encore mort (ecran de mort) a cet
instant precis. Un joueur mort ne peut pas etre deplace de facon fiable
entre dimensions par /tp, et le respawn vanilla efface de toute facon les
effets qu'on lui donne pendant qu'il est encore mort. Le systeme
pvp.postduel_shield existait deja pour eviter ce piege sur les EFFETS
(resistance, feu...), mais pas sur le tp/inventaire/dimension du perdant.

Fichiers modifies :
- end_duel.mcfunction : ne restaure (tp, inventaire, gamemode) que les
  duellistes deja vivants (score pvp.health=1..). Le gagnant est traite
  tout de suite comme avant, le perdant est laisse tague pvp.duel.
- tick.mcfunction : le bloc de rattrapage (deja utilise pour les
  deconnexions/reconnexions) recoit la meme condition pvp.health=1.. et
  termine desormais AUSSI la restauration du perdant, au moment exact ou
  son vrai respawn est detecte.
- save_return_state.mcfunction / restore_return_state.mcfunction : la
  dimension d'origine du joueur est maintenant sauvegardee et utilisee au
  retour (avant, l'overworld etait suppose en dur - un joueur qui
  defiait depuis une autre dimension aurait ete mal repositionne).

Aucun changement de comportement pour le gagnant (deja restaure
correctement avant). keepInventory / reset_arena restent immediats,
sans attendre le perdant (voir note dans end_duel.mcfunction).

A savoir : si tu recharges le datapack (/reload) PENDANT un duel deja en
cours, la sauvegarde de ce duel-la n'aura pas le nouveau champ
"dimension" -> attends la fin des duels en cours avant de deployer, ou
le retour de ce joueur-la pourrait echouer une fois (comme deja note
dans load.mcfunction pour tout /reload en plein combat).

## Nettoyage : suppression de 7 fichiers morts (ancien systeme
## boussole / canne a peche pour ouvrir le menu)

Verifie par recherche exhaustive dans tout le depot : plus rien n'y
faisait reference depuis le passage au menu par /trigger pvp.trigger.

- data/pvp/function/ensure_pvp_compass.mcfunction
- data/pvp/function/ensure_pvp_compass_give.mcfunction
- data/pvp/function/ensure_pvp_compass_skip.mcfunction
- data/pvp/function/open_menu_compass.mcfunction
- data/pvp/function/disable_keepinventory.mcfunction (jamais appelee,
  gamerule deja geree en dur dans end_duel.mcfunction)
- data/pvp/advancements/pvp_compass_menu.json
- data/pvp/predicates/menu_item.json (referencait meme un item different,
  warped_fungus_on_a_stick, incoherent avec le fishing_rod du reste du
  systeme - reste d'une iteration encore plus ancienne)

Le compas visible dans le menu principal (main.json) n'est qu'une icone
de GUI, il n'est pas touche.

Version gardee a v1.0 (pack.mcmeta / load.mcfunction), comme demande.
