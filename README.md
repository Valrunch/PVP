# PvP datapack

Datapack de duels 1v1 pour un serveur Minecraft 1.21.1 (Fabric).

__en developpement__

## Prerequis

- Minecraft 1.21.1 (`pack_format` 48)
- Un mod qui fournit la commande `menu` (menus `data/pvp/menu/*.json`)
- La dimension `multiworld:pvp`
- La structure `pvp:arena` (Structure Block en mode SAVE)
- Cobblemon (recompense du vainqueur)

## Commandes

| Commande | Effet |
|---|---|
| `/trigger pvp.trigger` | Ouvrir le menu |
| `/trigger pvp.accept` / `pvp.decline` | Accepter / refuser un duel recu |
| `/trigger pvp.cancel` | Annuler sa demande envoyee |
| `/trigger pvp.stats` | Voir ses victoires/defaites, total et contre chaque joueur |
| `/trigger pvp.help` | Liste des commandes |
