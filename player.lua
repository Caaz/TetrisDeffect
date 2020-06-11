-- so the goal here is to build tetris.

shapes = {
  -- line
  0b0000111100000000,
  -- square
  0b0000011001100000,
  -- z
  0b0000011000110000,
  -- s
  0b0000001101100000,
  -- l
  0b0000011100010000,
  -- j
  0b0000111010000000,
  -- t
  0b0000011100100000
}
colors = {12, 10, 8, 11, 13, 9, 2}

_player = _{
  new = function(t,o)
    -- we need a grid
    merge(t,{
      grid = {},
      next = {},
      x = 0,
      y = 0,
      -- piece_id = 7,
      piece = shapes[7],
      color = colors[7],
      clock = 0,
      speed = 40,
      hold = 0,
      grace = 0,
      move_clock = 3,
      ps = _ps{max=50},
      points = 0,
      level = 1,
      line_count = 0,
      outline = 5,
      vfx = {},
      style = 0,
      particle_size = -1,
      rotated = 0,
    },o)
    t:new_piece()
    t:clear_grid()
  end,
  shift_board = function(t, from)
    for i = from*10, from*10+9 do
      local x, y = i % 10, flr(i/10)
      add(t.vfx, _line_clear{y=t.oy+y*3+1,parent=t})
      t.ps:add{
        x=t.ox+x*3+5,
        y=t.oy+y*3+1,
        c=t.grid[i],
        scale = 100,
        speed = rnd(1)+.5
      }
    end

    for x = 0, 9 do
      t.grid[x-10] = 0
    end
    for y = from, 0, -1 do
      for x = 0, 9 do
        t.grid[x+y*10] = t.grid[x+(y-1)*10]
      end
    end
  end,
  update_speed = function(t)
    t.speed = max(1,20-t.level)
  end,
  check_board = function(t)
    local lines = 0
    for y = 0, 19 do
      ::recheck::
      local clear = true
      for x = 0, 9 do
        if t.grid[x+y*10] == 0 then
          clear = false
          break
        end
      end
      if clear then
        lines += 1
        t:shift_board(y)
        goto recheck
      end
    end
    if lines > 0 then
      t.points += 10*((lines*2)-1)*t.level
      t.line_count += lines
      if t.line_count % 10 == 0 then
        t.level += 1
        t:update_speed()
      end
      _.states['game']:attack(t,lines)
      if lines == 4 then
        t:create_halo()
      end
    end
  end,
  beat = function(t) t.outline = 7 end,
  create_halo = function(t)
    for x = 5, 36,2 do
      for y = 0, 61, 61 do
        add(t.vfx, _halo{
          x=t.ox+x,
          y=t.oy+y,
          c=7,
          s=1,
          parent = t
        })
      end
    end
    for x = 5, 36, 31 do
      for y = 0, 61,2 do
        add(t.vfx, _halo{
          x=t.ox+x,
          y=t.oy+y,
          c=7,
          s=1,
          parent = t
        })
      end
    end
  end,
  attack = function(t,attack)
    for i = 1, attack do
      for y = 0, 19 do
        for x = 0, 9 do
          t.grid[x+y*10] = t.grid[x+(y+1)*10]
        end
      end
      for x = 0, 9 do t.grid[x+19*10] = 5 end
      t.grid[flr(rnd(9))+19*10] = 0
      if not t:can_place() then
        t.y -= 1
      end
    end
  end,
  set_piece = function(t, i)
    t.piece_id = i
    t.piece = shapes[i]
    t.color = colors[i]
    t.x = 3
    t.y = -2
    t.outline = 7
    t.rotated = 0
  end,
  new_piece = function(t)
    if #t.next <= 6 then
      local bag = {}
      for i = 0, 7 do bag[i] = i end
      fys(bag)
      for i = 0, 7 do
        add(t.next, shift(bag))
      end
    end

    t:set_piece(shift(t.next))
    t.has_hold = true
  end,
  clear_grid = function(t)
    for i = 0, 199 do
      t.grid[i] = 0
    end
  end,
  can_place = function(t)
    for x = 0, 3 do
      for y = 0, 3 do
        local v = 2^(x+y*4)
        if band(t.piece,v) == v then
          if (not (t.y+y < 0)) and (t.x+x < 0 or t.x+x > 9 or t.y+y > 19 or t.grid[t.x+x + (t.y+y) * 10] != 0) then
            return false
          end
        end
      end
    end
    return true
  end,
  place = function(t)
    for x = 0, 3 do
      for y = 0, 3 do
        local v = 2^(x+y*4)
        if band(t.piece,v) == v then
          local id = x+t.x + (y+t.y)*10
          if t.grid[id] != 0 then
            t.dead = true
          end
          t.grid[id] = t.color
        end
      end
    end
    t:new_piece()
    t:check_board()
    t.grace = 0
    -- sfx(9)
  end,
  move = function(t, x, y)
    t.x += x
    t.y += y
    if not t:can_place() then
      t.x -= x
      t.y -= y
      return false
    end
    return true
  end,
  rotate = function(t, check)
    local rotated_piece = 0
    t.rotated = (t.rotated+1)%4
    for i = 0, 15 do
      if(band(t.piece, 2^i) != 0) then
        rotated_piece = bor(rotated_piece, 2^((3 - flr(i / 4)) + 4 * (i % 4)))
      end
    end
    t.piece = rotated_piece
    if t.piece_id == 7 then
      if t.rotated == 0 then
        t:move(1,0)
      elseif t.rotated == 1 then
        t:move(0,1) -- this can shift you below the screen.. hm.
      elseif t.rotated == 2 then
        t:move(-1,0)
      end
    end
    if check then
      -- sfx(0)
      if not t:can_place() then
        if not t:move(1,0) and
          not t:move(-1, 0) and
          not t:move(2,0) and
          not t:move(-2,0) and
          not t:move(0,-1) then

          for i = 0, t.x_mode and 0 or 2 do
            t:rotate()
          end
        end
      end
    end
  end,
  update = function(t)
    t.ps:update()
    forall(t.vfx,'update')
    t.clock += 1
    t.move_clock += 1
    if t.dead then
      if t.clock % 5 == 0 then
        -- t:shift_board(20-t.grace)
        if t.grace < 22 then
          for x = 0,9 do
            t.grid[x+(21-t.grace)*10] = 0
            add(t.vfx, _line_clear{y=t.oy+(25-t.grace)*3-10,parent=t})

          end
        end
        for i = 0, 10 do
          t.ps:add{
            x=t.ox+rnd(36),
            y=t.oy+rnd(61),
            c=6,
            scale = 100,
            s = rnd(5)+2,
            speed = rnd(3)+1
          }
        end
        -- t.ps.oy -= 100
        t.grace += 1
        if t.grace >= 42 then
          if t.anime_modu then
            _.state'game'
          else
            _.state'menu'
          end
        end
      end
      return
    end
    if btn(0,t.controller) and t.move_clock > 3 then
      t:move(-1,0)
      t.ps.offset += 5
      t.move_clock = 0
    elseif btn(1,t.controller) and t.move_clock > 3 then
      t:move(1,0)
      t.ps.offset += 5
      t.move_clock = 0
    end
    if btnp(2,t.controller) then
      t.ps.offset += 50
      while t:move(0, 1) do
        -- i never noticed this working
        t.ps:add{
          c=t.color,
          x=t.x*3+t.ox+8,
          y=t.y*3+t.oy+8,
          scale=50,
          speed=rnd(2)+.5
        }
      end

      for i = 0, 16 do
        local x, y = i %4 + t.x + 2, flr(i / 4) + t.y
        if band(t.piece,2^i) != 0 then
          add(t.vfx, _slam{
            x=x*3+t.ox,
            y=y*3+1+t.oy,
            c=t.color,
            parent = t
          })
        end
      end

      t:place()
    end
    if btnp(4,t.controller) then
      t:rotate(t,true)
      t.grace = 0
    end
    if btnp(5,t.controller) and t.has_hold then
      if t.x_mode then
        t:rotate(t)
        t:rotate(t)
        t:rotate(t,true)
        t.grace = 0
      else
        if t.has_hold then
          local hold = t.piece_id
          if t.hold != 0 then
            t:set_piece(t.hold)
          else
            t:new_piece()
          end
          t.hold = hold
          t.has_hold = false
        end
      end
    end
    if (not t.zen_mode and t.clock % t.speed == 0) or (btn(3,t.controller) and t.clock % 2 == 0) then
      t:update_speed()
      t.grace = (t:move(0,1) and 0 or t.grace + 1)
    end
    if t.grace != 0 then
      t.grace += 1
      if t.grace >= 60 then
        t:place()
      end
    end
    t.ps:add{
      x=rnd(128),
      y=rnd(128),
      c=t.color,
      s=t.particle_size == -1 and flr(rnd(10)+rnd(10)-10) or t.particle_size
    }
  end,
  draw_small_shape = function(t,ox,oy,id)
    -- can this be done smoother?
    for i = 0, 15 do
      if band(shapes[id], 2^i) != 0 then
        pset(ox+i%4,oy+flr(i/4),colors[id])
      end
    end
  end,
  draw_bg = function(t)
    t.ps:draw()
    forall(t.vfx,'draw')
  end,
  draw = function(t,ox,oy)
    t.ox = ox
    t.oy = oy
    rectfill(ox,oy,ox+5,oy+30,0)
    if t.style != 2 then
      rectfill(ox+5,oy,ox+36,oy+61)
    end
    rect(ox,oy,ox+5,oy+5,flr(t.outline+.5))
    rect(ox+5,oy,ox+36,oy+61)
    rect(ox,oy,ox+5,oy+30)
    print(t.points,ox+38,oy+1)
    print(t.level,ox+38,oy+7)
    print(t.line_count,ox+38,oy+13)
    -- print(t.grace,ox+38,oy+19)
    -- print("points: "..t.points,ox+38,oy+1)
    -- print("level: "..t.level,ox+38,oy+7)
    -- print("lines: "..t.line_count,ox+38,oy+13)
    t.outline = max(t.outline-.2,6)
    -- print("brb food\nbreak",ox+38,oy+7)

    for i = 0, 199 do
      local current = t.grid[i]
      if current != 0 then
        local x, y = i%10+2, flr(i/10)
        local sx,sy = x*3+ox, y*3+oy+1
        if t.style == 2 then current = 0 end
        if t.style != 1 or t.dead then
          rectfill(sx,sy,sx+2,sy+2, current)
          if t.style == 3 then
            -- outline
            -- local ox, oy = flr(i / 3), i % 3
            -- local id, bitfield = 0,0
            -- for ox = x-1, x+1 do
            --   for oy = y-1, y+1 do
            --     if not (ox == x and oy == y) then
            --       if x >= 0 and x < 10 and y > 0 and y <= 20 and t.grid[oy*10+flr(ox/10)] == current then
            --         bitfield = bor(bitfield,2^id)
            --       end
            --       id += 1
            --     end
            --   end
            -- end
            pset(sx+1,sy+1,0)
            -- if band(bitfield,0b11010000) == 0b11010000 then
            --   pset(sx,sy)
            -- end
            if t.grid[i-10] == current then
              pset(sx+1,sy)
            end

            local bitfield = (t.grid[i-10] == current and 1 or 0) +
              (i%10!=0 and t.grid[i-1] == current and 2 or 0) +
              (i%10!=9 and t.grid[i+1] == current and 4 or 0) +
              (t.grid[i+10] == current and 8 or 0)

            bitfield += (band(bitfield,0b0011) == 0b0011 and (t.grid[i-11] == current) and 16 or 0)
            + (band(bitfield,0b0101) == 0b0101 and t.grid[i-9] == current and 32 or 0)
            + (band(bitfield,0b1010) == 0b1010 and t.grid[i+9] == current and 64 or 0)
            + (band(bitfield,0b1100) == 0b1100 and t.grid[i+11] == current and 128 or 0)

            if band(bitfield,1) == 1 then
              pset(sx+1,sy)
            end
            if band(bitfield,2) == 2 then
              pset(sx,sy+1)
            end
            if band(bitfield,4) == 4 then
              pset(sx+2,sy+1)
            end
            if band(bitfield,8) == 8 then
              pset(sx+1,sy+2)
            end
            if band(bitfield,16) == 16 then
              pset(sx,sy)
            end
            if band(bitfield,32) == 32 then
              pset(sx+2,sy)
            end
            if band(bitfield,64) == 64 then
              pset(sx,sy+2)
            end
            if band(bitfield,128) == 128 then
              pset(sx+2,sy+2)
            end
          end
        end
      end
    end

    if t.dead then return end
    -- draw player
    for i = 0, 16 do
      local x, y = i %4 + t.x + 2, flr(i / 4) + t.y
      if band(t.piece,2^i) != 0 then
        rectfill(x*3+ox, y*3+1 + oy, x*3+2 + ox, y*3+3 + oy, t.style == 2 and 0 or t.color)
      end
    end

    -- draw shadow
    if t.shadow and t.clock % 2 == 0 then
      local oldy = t.y
      while t:move(0, 1) do end
      for i = 0, 16 do
        local x, y = i %4 + t.x + 2, flr(i / 4) + t.y
        if band(t.piece,2^i) != 0 then
          pset(x*3+ox+1,y*3+2+oy,t.style == 2 and 0 or t.color)
        end
      end
      t.y = oldy
    end
    -- end

    -- next blocks
    for i = 0, 6 do
      t:draw_small_shape(ox+1, i * 4 + oy+2, t.next[i])
    end
    -- held block
    t:draw_small_shape(ox+1,oy+1,t.hold)

    -- line clear
  end
}
