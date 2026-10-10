execute unless data storage pvp:tmp list[0] run return 0
data modify storage pvp:tmp cur set from storage pvp:tmp list[0]
function pvp:show_stats_line with storage pvp:tmp cur
data remove storage pvp:tmp list[0]
function pvp:show_stats_loop
