clear @s
function pvp:restore_return with storage pvp:tmp key
$execute in minecraft:overworld positioned $(x) $(y) $(z) run function pvp:vault_copy_in
function pvp:restore_finish
