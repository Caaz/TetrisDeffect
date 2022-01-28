_.states['credits'] = {
  update = function(t)
    if btnp() != 0 then
      _.states['menu']:transition('menu')
    end
  end,
  draw = function(t)
    cls()
    print('tetris d;fect',38,1,7)
    print('created by daniel caaz!\nmusic by @bibikigl\ni made this while streaming!\n\nyou can catch me at\nhttps://twitch.tv/dcaazy\nhttps://twitter.com/dcaazy\nhttps://8-bit-caaz.tumblr.com',1,10,7)
  end
}
