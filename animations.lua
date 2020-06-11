_ae = _{
  new = function(t,o)
    merge(t,{
      clock = 0,
    },o)
  end,
  update = function(t)
    t.clock += 1
    if t.clock > 64 then
      if t.parent.vfx then
        del(t.parent.vfx,t)
      else
        del(t.parent.particles,t)
      end
    end
  end
}


_line_clear = _{
  extends = _ae,
  draw = function(t)
    local x,y = t.clock*4+rnd(5),t.y+1
    circfill(64-x,y,1,7)
    circfill(64+x,y,1,7)
  end
}

_slam = _{
  extends = _ae,
  draw = function(t)
    local x, y = t.x+1, t.y+t.clock*3
    rectfill(x, y, x+3, y+3, t.c)
  end
}

_halo = _{
  extends = _ae,
  update = function(t)
    local angle = atan2(t.x-64,t.y-64)
    t.x += cos(angle)
    t.y += sin(angle)
    _ae.update(t)
  end,
  draw = function(t)
    pset(t.x,t.y,t.c)
  end
}

_halo2 = _{
  extends = _ae,
  -- update = function(t)
    -- local angle = atan2(t.x-64,t.y-64)
    -- t.x += cos(angle)
    -- t.y += sin(angle)
    -- _ae.update(t)
  -- end,
  draw = function(t)
    -- rect(ox+5,oy,ox+36,oy+61)
    grow = t.clock
    rect(t.x+5-grow,t.y-grow,t.x+36+grow,t.y+61+grow,0)
  end
}
