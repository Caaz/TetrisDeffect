reset_pattern = { [7]=0 }


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
    music(1)
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
    depth = 0
    for i, player in pairs(t.players) do
      -- player:beat()
      for j = 1, #player.grid do
        if player.grid[j] != 0 then break end
        depth = max(depth,flr(j/10))
      end
    end

    local note_index = stat(21)
    if note_index != t.last then
      if note_index % 4 == 0 then
        for i, player in pairs(t.players) do
          player:beat()
        end
      end
      if note_index == 31 then
        -- update tempo
        pattern = stat(24)
        pattern = reset_pattern[pattern] or pattern
        pattern_address = 0x3100+(pattern+1)*4
        for i = 0, 3 do
          sfx = peek(pattern_address+i)
          sb = itb(sfx,8)
          sfx_index = pull(sb,5)
          sfx_address = 0x3200 + sfx_index * 68 + 65
          poke(sfx_address,max(8,depth))
        end
      end

      --

    end
    t.last = note_index
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
