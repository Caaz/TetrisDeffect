
_.states['game'] = {
  last = -1,
  options = {
    style = 0,
    particle_style = 0,
    player_count = 1
  },
  init = function(t)
    t.players = {}
    -- t.particles = _ps()
    for i = 0, t.options.player_count-1 do
      add(t.players, _player{controller=i})
      merge(t.players[i+1],t.options)
    end
    t.players[1].ps.style = t.options.particle_style
    if t.players[2] then t.players[2].ps = t.players[1].ps end

  end,
  reset_options = function(t) t.options = {} end,
  set_options = function(t,o) merge(t.options, o) end,
  attack = function(t,attacker,attack)
    for i, player in pairs(t.players) do
      if player != attacker then
        player:attack(attack)
      end
    end
  end,
  beat = function(t)
    for i, player in pairs(t.players) do
      player:beat()
    end
  end,
  update = function(t)
    -- local note_index = stat(20)
    -- if note_index != t.last then
    --   if note_index == 0 then
    --     for i, player in pairs(t.players) do
    --       player:beat()
    --     end
    --   end
    -- end
    -- t.last = note_index
    forall(t.players,'update')
  end,
  draw = function(t)
    -- t.clear_style
    for i = 0, 20 do
      circ(rnd(127),rnd(127),rnd(100)+50,t.options.particle_style == 2 and 7 or 0)
    end
    for i = 0, t.options.particle_style == 2 and 200 or 20 do
      pset(rnd(128),rnd(128),t.options.particle_style == 2 and 7 or 0)
    end
    forall(t.players,'draw_bg')
    for index, player in pairs(t.players) do
      player:draw((128/(#t.players+1)*index-20),32)
    end
  end
}
