$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~ ~ ~ run return 0
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless block ~ ~ ~ minecraft:barrel run return run function pvp:error_restore_missing
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless block ~1 ~ ~ minecraft:barrel run return run function pvp:error_restore_missing
function pvp:restore_apply with storage pvp:tmp key
