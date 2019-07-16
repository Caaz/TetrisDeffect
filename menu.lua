_menu = _{
  new = function(t,o)
    merge(t,{ selection = 1, },o)
  end,
  update = function(t)
    if btnp(2) then
      t.selection = max(1,t.selection-1)
    elseif btnp(3) then
      t.selection = min(t.selection+1,#t.options)
    elseif btnp(4) then
      local selection = t.options[t.selection]
      selection[1] = selection[2](t)
    end
  end,
  draw = function(t)
    for i = 1, #t.options do
      if t.selection == i then
      end
      rectfill(63-#t.options[i][1]*2,61+i*6-t.selection*6,63+#t.options[i][1]*2,67+i*6-t.selection*6,0)
      print(t.options[i][1],64-#t.options[i][1]*2,62+i*6-t.selection*6,i == t.selection and 7 or 5)
    end
  end,
}
function options_label(label, key, type, default)
  option = _.states['game'].options[key]
  return label..": "..(type == 1 and (option and 'yes' or 'no') or option or default)
end
function options_item(label, key, type, limit, default)
  local options = _.states['game'].options
  return {options_label(label,key,type, default), function(t)
    if type == 0 then
      options[key] = ((options[key] or default)%limit + 1)
    elseif type == 1 then
      options[key] = not options[key]
    end
    return options_label(label,key,type, default)
  end}
end

_.states['menu'] = {
  init = function(t)
    local game = _.states['game']
    merge(t,{
      vfx = {},
      active = 1,
      ps = _ps{max=100},
      menus = {
        _menu{
          -- {'play'}
          options = {
            {'play', function(m) t.active = 2 end},
            {'credits', function(m) t:transition('credits') end}
          }
        },
        _menu{
          options = {
            {
              'start', function(m)
                t:transition('game')
              end,
            },
            options_item('level','level',0,20,1),
            options_item('players','player_count',0,3,1),
            options_item('\x97 rotate','x_mode',1),
            options_item('anime modo','anime_modu',1),
            options_item('zen mode','zen_mode',1),
            options_item('drop preview','shadow',1),
            -- everything past this point has weirder options...
            {
              'block style: standard', function(m)
                -- _.state'game'
                styles = {'standard','invisible','shadow','outline'}
                game:set_options{
                  style = game.options.style and ((game.options.style + 1 )% 4) or 1
                }
                return 'block style: '..styles[game.options.style+1]
                -- t:transition('game')
              end
            },
            {
              'particle style: standard', function(m)
                -- _.state'game'
                styles = {'standard', 'mirrored', 'rorschach'}
                game:set_options{
                  particle_style = game.options.particle_style and ((game.options.particle_style + 1) % 3) or 1
                }
                return 'particle style: '..styles[game.options.particle_style+1]
                -- t:transition('game')
              end
            },
            {
              'bg particle size: random', function(m)
                -- _.state'game'
                game:set_options{
                  particle_size = game.options.particle_size and (game.options.particle_size + 1)%11 or 0
                }
                return 'bg particle size: '..game.options.particle_size
                -- t:transition('game')
              end
            },
          }
        }
      }
    })
  end,
  transition = function(t, state)
    for a = 0, 30 do
      for i = 0, 20 do
        circ(rnd(128),rnd(128),rnd(128),0)
      end
      flip()
    end
    _.state(state)
  end,
  update = function(t)
    t.ps.oy+=.3
    for count = 0, 5 do
      local i = rnd(30)
      add(t.vfx,_halo{
        x=cos(i/30)*60+64,
        y=sin(i/30)*60+64,
        c=colors[t.menus[t.active].selection % 7 + 1],
        parent=t
      })
    end
    for i = 0, 127,127 do
      t.ps:add{
        x=i,
        y=rnd(128),
        c=colors[t.menus[t.active].selection % 7 + 1],
        speed = rnd()+.5,
        scale=50
      }
    end
    t.ps:update()
    forall(t.vfx,'update')
    t.menus[t.active]:update()
  end,
  draw = function(t)
    -- cls()
    for i = 0, 20 do
      circ(rnd(128),rnd(128),rnd(128),0)
    end
    forall(t.vfx,'draw')
    t.ps:draw()
    t.menus[t.active]:draw()
    spr(0,31,10,9,6)
    -- spr(0,31,43,9,6)
  end
}
