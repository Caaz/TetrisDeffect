pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

#include ../pico8-lib/ichor.lua
#include ../pico8-lib/table/forall.lua
#include ../pico8-lib/table/merge.lua
#include ../pico8-lib/table/shift.lua
#include ../pico8-lib/table/contains.lua
#include ../pico8-lib/vendor/opensimplex.lua
#include ../pico8-lib/vendor/fys.lua
#include ../pico8-lib/debug.lua
#include ../pico8-lib/vendor/unpack.lua
#include ../pico8-lib/scribble.lua

#include ../pico8-lib/binary/itb.lua
#include ../pico8-lib/binary/bti.lua
#include ../pico8-lib/binary/pull.lua

#include music.lua
#include animations.lua
#include particles.lua
#include player.lua
#include game.lua
#include menu.lua
#include credits.lua

function _update60() _.main'update' end
_.state'menu'
-- music(0,0,1)


__gfx__
77777777777777777777777777777777777777777777777777077777777777777777000000000000000000000000000000000000000000000000000000000000
70000000000007000000000007000000000000700000000007070007000000000007000000000000000000000000000000000000000000000000000000000000
70000000000007000000000007000000000000700000000007070007000000000007000000000000000000000000000000000000000000000000000000000000
70000000000007000000000077000000000000700000000070070007000000000007000000000000000000000000000000000000000000000000000000000000
70000000000007000077777777000000000000700077700070077777000007777707000000000000000000000000000000000000000000000000000000000000
77777000077777000070000007777700007777700070700700000007000007000077000000000000000000000000000000000000000000000000000000000000
00007000070007000077777770000700007000700077000700000000700000700000000000000000000000000000000000000000000000000000000000000000
00007000070007000000000070000700007000700077007000077777700000700000000000000000000000000000000000000000000000000000000000000000
00007000070007000000000070000700007000700070007000070007070000070000000000000000000000000000000000000000000000000000000000000000
00007000070007000000000700000700007000700070007770070007070000070000000000000000000000000000000000000000000000000000000000000000
00007000070007000077777700000700007000700077000070070007007000007000000000000000000000000000000000000000000000000000000000000000
00007000070007000070000000000700007000700077000007070007007000007000000000000000000000000000000000000000000000000000000000000000
00007000070007000070000000000700007000700070700007070007000700000700000000000000000000000000000000000000000000000000000000000000
00007000070007000070000000000700007000700070700000770007000700000700000000000000000000000000000000000000000000000000000000000000
00007000070007000077777777770700007000700070070000770007700070000070000000000000000000000000000000000000000000000000000000000000
00007000070007000000000000070700007000700070070000070007077770000070000000000000000000000000000000000000000000000000000000000000
00007000070007000000000000007700007000700070007000070007000000000007000000000000000000000000000000000000000000000000000000000000
00007000070007000000000000007700007000700070007000007007000000000007000000000000000000000000000000000000000000000000000000000000
00007000070007000000000000000700007000700070000700007007000000000007000000000000000000000000000000000000000000000000000000000000
00007777770007777777777777777777777000777770000777777777777777777777000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000077777700077777777707777777777770777777077777777700000000000000000000000000000000000000000000000000000000000000000000
00000000000070000700070000000707000000000070700007070000000700000000000000000000000000000000000000000000000000000000000000000000
00000000000070777777070777777707777777777770707777077770777700000000000000000000000000000000000000000000000000000000000000000000
00000000000070700707070700000000007070000000707000000070700000000000000000000000000000000000000000000000000000000000000000000000
00000000000070700707070700000000007070000000707000000070700000000000000000000000000000000000000000000000000000000000000000000000
00000000000070700707077777777700007077777770707000000077700000000000000000000000000000000000000000000000000000000000000000000000
00000000000070700707070000000700007000000070707000000070700000000000000000000000000000000000000000000000000000000000000000000000
00000000000077700707070777777700007777777770707000000070700000000000000000000000000000000000000000000000000000000000000000000000
00000000000070700707070700000000007070000000777000000070700000000000000000000000000000000000000000000000000000000000000000000000
00000000000070700707070700000000007070000000707000000070700000000000000000000000000000000000000000000000000000000000000000000000
00000000077770777707077700000000007077777770707777777070700000000000000000000000000000000000000000000000000000000000000000000000
00000000070000000707070700000000007000000070700000007070700000000000000000000000000000000000000000000000000000000000000000000000
00000000077777777777070700000000007777777770777777777070700000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000070700000000000000000000000000000070700000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000070700000000000000000000000000000070700000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000070700000000000000000000000000000070700000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000070700000000000000000000000000000077700000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000077700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777777770000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007077077070000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777777770000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777777770000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007077077070000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777777770000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777777770000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007077077070000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777777770000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777777770000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007077077070000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777777770000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777777770000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007077077070000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007777777770000000
__label__
000000000c00000000000000000000000000000000c0c00000c0000000000000000000000000000000c00000000000000c000000cc0c000000000000c0000000
000c00000cc0000000000000000000000000000000000000000000000000000000000000c00000000000000c0c0000000000c00cc0c00000000000000000000c
000000000000000000000000000000000000000c00000000000000000000000c0000000000000000000000000c000000c00c000c000000000000000000000000
00000000000c000000000000000000000000000000000000000000000000000c000000c0c00000000c000000c0000000000c000c000000000000000c00000000
000000000000000000000000000000000000000000000000000000000000000000000000000c0000c00000000000000000c000c0c000000000000cc0000c0000
00000c000000000000000000000c000000000000c0000000000000000000000000000000000000000000000cc0000000c000000c0000000000000000000c0000
c000000000000000000000000000000000c0000000000000000000000000000000000000000000000000000c00000000cc000000000000000000c00000000000
cc0000cc0c00000c0000000000000c000000000000000000000000000000000000000000000000000000000c0000000c0c00000000000000000c0000c0000000
00c0000c0000000000000000c0000c000000000000000000000000000000000000000000000000000000000000000000c0000000000000000000000000000000
000c0000cc000000c00000000c0000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000c0000000000000c00000000000c000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000c0000000c00000c00000000000000000000000000000000000000000000000000000000000000000000000000c0000c00000000000000000000c0000000
000000c00000c000000c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000cc00000000
00000000c00000000000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c000000000000000000
0000000000000cc000000c000000c000000000000000000000000000000000000000000000000000000000000000000000000c000000000000000c0000000000
0c00000000c000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000c000000000000000000000000000
00cc0000c00cc00c00c0000cc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000c0000000c00000c000000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000c0000000c000c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000ccc0000000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000cc00000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000cc0000
000000000cc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c000c00000
00c0000000cc000000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000cc0000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000cc00c00000000
0000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000c0000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000cc00000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000cc000
00000cc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c000000
cc000000c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00000000
c0c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00c000000cc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000c00000c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00c
cc00c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000cc
0000000c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000cc00
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ccc0000
0c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c0
000000000000000000000000000000077777777777777777777777777777777777777777777777777077777777777777777000000000000000000000000ccc00
c0000000000000000000000000000007000000000000700000000000700000000000070000000000707000700000000000700000000000000000000000c00000
000cc0000000000000000000000000070000000000007000000000007000000000000700000000007070007000000000007000000000000000000000000c0c00
0000000000000000000000000000000700000000000070000000000770000000000007000000000700700070000000000070000000000000000000000000000c
00000000000000000000000000000007000000000000700007777777700000000000070007770007007777700000777770700000000000000000000000000000
00000000000000000000000000000007777700007777700007000000777770000777770007070070000000700000700007700000000000000000000000000000
00000000000000000000000000000000000700007000700007777777000070000700070007700070000000070000070000000000000000000000000000000000
00000000000000000000000000000000000700007000700000000007000070000700070007700700007777770000070000000000000000000000000000000000
00000000000000000000000000000000000700007000700000000007000070000700070007000700007000707000007000000000000000000000000000000000
00000000000000000000000000000000000700007000700000000070000070000700070007000777007000707000007000000000000000000000000000000000
00000000000000000000000000000000000700007000700007777770000070000700070007700007007000700700000700000000000000000000000000000000
00000000000000000000000000000000000700007000700007000000000070000700070007700000707000700700000700000000000000000000000000000000
00000000000000000000000000000000000700007000700007000000000070000700070007070000707000700070000070000000000000000000000000000000
00000000000000000000000000000000000700007000700007000000000070000700070007070000077000700070000070000000000000000000000000000000
00000000000000000000000000000000000700007000700007777777777070000700070007007000077000770007000007000000000000000000000000000000
0000000000000000000000000000000000070000700070000000000000707000070007000700700000700070777700000700000000000000000000000000000c
00000000000000000000000000000000000700007000700000000000000770000700070007000700007000700000000000700000000000000000000000000000
00000000000000000000000000000000000700007000700000000000000770000700070007000700000700700000000000700000000000000000000000000000
000c000000000000000000000000000000070000700070000000000000007000070007000700007000070070000000000070000000000000000000000000c000
00000000000000000000000000000000000777777000777777777777777777777700077777000077777777777777777777700000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000007777770007777777770777777777777077777707777777770000000000000000000000000000000000000
00000000000000000000000000000000000000000007000070007000000070700000000007070000707000000070000000000000000000000000000000000000
00000000000000000000000000000000000000000007077777707077777770777777777777070777707777077770000000000000000000000000000000000000
00000000000000000000000000000000000000000007070070707070000000000707000000070700000007070000000000000000000000000000000000000000
00000000000000000000000000000000000000000007070070707070000000000707000000070700000007070000000000000000000000000000000000000000
00000000000000000000000000000000000000000007070070707777777770000707777777070700000007770000000000000000000000000000000000000000
00000000000000000000000000000000000000000007070070707000000070000700000007070700000007070000000000000000000000000000000000000000
c00c0000000000000000000000000000000000000007770070707077777770000777777777070700000007070000000000000000000000000000000000000000
00000000000000000000000000000000000000000007070070707070000000000707000000077700000007070000000000000000000000000000000000000000
0000000000000000000000000000000000000000000707007070707000000000070700000007070000000707000000000000000000000000000000000000000c
00000000000000000000000000000000000000007777077770707770000000000707777777070777777707070000000000000000000000000000000000000cc0
00000000000000000000000000000000000000007000000070707070000000000700000007070000000707070000000000000000000000000000000000000000
00000000000000000000000000000000000000007777777777707070000000000777777777077777777707070000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000007070000000000000000000000000000007070000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000007070000000000000000000000000000007070000000000000000000000000000000000000000
00000c00000000000000000000000000000000000000000000007070000000000000000000000000000007070000000000000000000000000000000000000000
c000000000000000000000000000000000000000000000000000707000000000000000000000000000000777000000000000000000000000000000000000000c
cc000000000000000000000000000000000000000000000000007070000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000007070000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000007070000000000000000000000000000000000000000000000000000000000000000000000000
0c000000000000000000000000000000000000000000000000007070000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000007770000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00000c0
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00000c
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000cc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c000000000c
00000cc0cc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000cc00000cc
0000c0cc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c0000000
000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0c0000000cc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c000
0000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00
000000000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000c000cc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000c0000c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00
000000000c000c0c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00c0
00c00000c000cc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000cc
00c0000c000c0c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c
cc0c00c000ccc000c00c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0c00c0000c0000000c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000ccc000c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000c0000c00c000000c0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c0000000000000000
00000000000000000000c00c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000cc000000000000000
00000c0000000cc00000c00c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00000000000000
0000000000000000000c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c000000
000000000000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000c0000000c0c0000c000000000000
0000000c00c000000000cc0000000000000000000000000000000000000000000000000000000000000000000000000000000c0000000c000000c00000000000
00000c00c0000000000c0c0000000000000000000000000000000000000000000000000000000000000000000000000000c00000000c00cc00000000000c0000
0000000000000000000c00000000000c0000000000000000000000000000000000000000000000000000000000000000000c00000000000cc000000000000000
00cc000000000000cc00c0000000000000000000000000000000000000000000000000000000000000000000000000000000c00c00000000c000000000000000
00c000000000000ccc0c000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00000000c00000000000000
0c00000000000000c0c0000000000000c000000000000000000000000000000000000000000000000000000000000000000000000000000000c0000000000000
c000000000000000c0c00cc000000c00c000000000000000000000000000000000000000000000000000000000000000000000000c0000000000000000000000
00c000000000000c0c0000000000cc0c000c0000c0000000000000000000000000000000000000000000000000000000000000000c0000000000cc0000000000
0000000000000000c000c0000000000000c00000c0000000000000000000000000000000000000000000000000000000000000000000000000000c0000000000
c0000000000000000000c000000c00c00c000000c000000000000000000000000000000000000000000000000000000000000000000c00000000000000000000
000000000000000000c00000c0c000000c00000000000c00000000000000000000000000000000000000000000000000000000000000000000000000c0000000
000000000000000000c00000c0c000c0000000000c00000000000000000000000c0c000c000000000000000000000000000c000000000000000000000c000000
00000000000000c00c0000000000c0000000000000000000000000c0000000c00ccc000c00000cc0000000000000000000000000000000000000000000000000
00000000000000000c0000c00000000000000000000c00000000000c00000000000c0000c0000ccc000000000000000000000000000000c0000000c0000cc000
000000000000c00cc0000cc00000000000000000000000000000000cc000c0000ccc000000000cc0000000000000000000000c000000000c0000000000000000

__sfx__
000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000a0000233550000500005000051b355000051c355000051e355000001c3511b3511c355000051b355000051c3550000500005000051f3550000500005000052235500005000050000523355000050000500005
000a00000405000000070500000009050000000a050000000405000000070500000009050000000a050000000405000000070500000009050000000a050000000405000000070500000009050000000a05000000
000a00001005300000346230000310053000033462300003100530000334623000031005310053346231065310053000033462300003100530000334623000031005300003346230000310053000001c05300000
000a0000233550000500005000051b355000051c355000051e355000001c3511b3511c355000051b355000051c355000050000500005173550000500005000051035500005000050000510355333513235331353
000a0000233550000500005000051b355000051c355000051e355000001e3511c3511e355000051f355000051c355000050000500005233550000500005000052735527342273322732428355283422833228324
000a0000233550000500005000051b355000051c355000051e355000001c3511b3511c355000051b355000051c355000050000500005173550000500005000051035500005000050000510342103420e3420e342
000a00000005000000070500000009050000000b050000000005000000070500000009050000000b050000000305000000060500000009050000000b050000000305000000060500000009050000000b05000000
000a00000c0530000024633000030c0530000324633000030c0530000324633000030c0530c053246330c65317053000032f6330000317053000032f6330000317053000032f6330000317053000002f03300000
000a00000405000000070500000009050000000a050000000405000000070500000009050000000a050000000405000000070500000009050000000a050000000405000000070500000009050000000a05000000
000a00001c355103551b3550f3551c355103551e355123551f355133551e355123551f355133552235516355233551735521355153551e355123551b3550f355233551735521355153551e355123551b3550f355
000a0000040550405500005000050b0550b0550000500005000550005500005000050b0550b05500005000050b0550f055000050b0550f055000050b0550f055000050b0550f055000050b0550b0550005503055
000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000a00001c3552835500005000051b3552735500005000051a35526355000050000519355253550000500005173552335500005173552335500005173552335500005173552335500005173551b3551e35522355
__music__
00 41424344
01 41020304
00 41050304
00 41060304
00 41070304
00 410b0809
00 410b0809
02 410e0c04
