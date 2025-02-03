function love.load()
  song = love.audio.newSource("song.ogg", "stream")
  song:setLooping(true)
  --song:play()
  
  sfx = love.audio.newSource("sfx.ogg", "static")
end

function love.update()
end

function love.draw()
end

function love.keypressed()
  sfx:play()
end

