
_p = _{
  new = function(t,o)
    merge(t,{
      x = 0,
      y = 0,
      ox = 0,
      oy = 0,
      scale = 500,
      speed = 1,
      c = 7,
      s = 1,
      reverse = rnd()>5
    },o)
    t.ox = rnd(t.s*2)
    t.oy = rnd(t.s*2)
    if t.parent.style == 2 then
      t.c = 0
    end
  end,
  update = function(t)
    -- if you think I know what I'm doing here you're wrong
    -- t.ox = t.x
    -- t.oy = t.y
    local angle = t.parent.simplex((t.parent.offset+t.x)/t.scale,(t.parent.oy+t.y)/t.scale)
    t.x += sin(angle)*t.speed
    t.y += cos(angle)*t.speed
    if t.x < 0 or t.x > 127 or t.y < 0 or t.y > 127 then
      del(t.parent.particles,t)
    end
  end,
  draw = function(t)
    -- print("particle drawn?", 65,10, rnd(16))
    -- line(t.ox,t.oy,t.x,t.y,t.c)
    circfill(t.x+t.ox,t.y+t.oy,t.s,t.c)
    if t.parent.style == 1 or t.parent.style == 2 then
      circfill(127-t.x+t.ox,t.y+t.oy,t.s,t.c)
    end
    -- flip()
  end,
}
_ps = _{
  new = function(t,o)
    merge(t,{
      particles = {},
      simplex = _osimplex(rnd()),
      offset = 10,
      max = 10,
      oy = 0
    },o)
  end,
  add = function(t,o)
    o.parent = t
    if o.extends then
      add(t.particles,o)
    else
      if (not o.s or o.s >= 0) and #t.particles < t.max then
        add(t.particles, _p(o))
      end
    end
  end,
  update = function(t)
    -- t.offset += .7
    forall(t.particles,'update')
  end,
  draw = function(t)
    forall(t.particles,'draw')
  end
}


-- system = _ps()
