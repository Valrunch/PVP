# PvP datapack

Datapack de duels 1v1 pour un serveur Minecraft 1.21.1 (Fabric).

__en developpement__

## Prerequis

- Minecraft 1.21.1 (`pack_format` 48)
- Un mod qui fournit la commande `menu` (menus `data/pvp/menu/*.json`)
- La dimension `multiworld:pvp`
- La structure `pvp:arena` (Structure Block en mode SAVE)
- Cobblemon (recompense du vainqueur)

## Commandes joueurs

| Commande | Effet |
|---|---|
| `/trigger pvp.trigger` | Ouvrir le menu |
| `/trigger pvp.accept` / `pvp.decline` | Accepter / refuser un duel recu |
| `/trigger pvp.cancel` | Annuler sa demande envoyee |
| `/trigger pvp.stats` | Voir ses victoires/defaites, total et contre chaque joueur |
| `/trigger pvp.help` | Liste des commandes |

## Coordonnees en dur

| Quoi | Fichier |
|---|---|
| Points d'apparition des duellistes | `start_duel.mcfunction` |
| Position de la structure de l'arene | `reset_arena.mcfunction` |
| Coffres de sauvegarde (overworld, `x = id * 2`, `y = -50`, `z = 2000`) | `vault_locate.mcfunction` |

## Sauvegarde des inventaires

`/data modify entity` est interdit sur les joueurs : l'inventaire est donc copie avec `item replace` dans 2 tonneaux par joueur (crees tout seuls, chunk force-charge). Au debut du duel : copie, puis `clear`. A la fin : copie inverse des que le joueur est vivant (le perdant doit d'abord reapparaitre).

- Ne supprime pas ces chunks (outil de nettoyage de monde) : ils contiennent les inventaires pendant un duel.
- Le datapack ne touche jamais aux gamerules.
- Un `/reload` pendant un duel ramene les joueurs automatiquement.
