--
-- _dj = {
--   last = 0,
--   pattern = function(t)
--     local string = 'x'
--     for i = 1, 15 do
--       local r = flr(rnd(2))+1
--       if i % 2 == 0 then
--         r = (rnd() < .5) and 0 or 2
--       end
--       -- local r = flr(rnd(3))
--       string = string..(r == 0 and 'x' or r == 1 and '-' or '_')
--     end
--     printh(string)
--     return string
--   end,
--   ci = 0,
--   chords = {
--     -- e major chord or whatever
--     {
--       _note('e2',7,4,0),
--       _note'f#2',
--       _note'g#2',
--       _note'a2'
--     },
--     {
--       _note'g#2',
--       _note'a2',
--       _note'b2'
--     },
--     {
--       _note'b2',
--       _note'c3',
--       _note'd#3',
--       _note'e2'
--     }
--   },
--   generate_track = function(t)
--     _scribble{
--       pattern = 'x---',
--       notes = fys{
--         _note('c1',5,3,3),
--         _note('c1',7,3,3),
--         -- _note'g#2',
--         -- _note'b2',
--       },
--     }:set(0,16)
--     _scribble{
--       pattern = t:pattern(),
--       notes = t.chords[t.ci+1],
--     }:set(1,16)
--     t.ci = (t.ci+1) %3
--   end,
--   update = function(t)
--     local note_index = stat(20)
--     if note_index != t.last then
--       if note_index == 0 then
--         t:generate_track()
--         _.states.game:beat()
--       end
--     end
--     t.last = note_index
--   end
-- }
-- music(0)