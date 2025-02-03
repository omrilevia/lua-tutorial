function love.load()
  image = love.graphics.newImage("jump.png")
  local frameWidth = 117
  local frameHeight = 233
  
  frames = {}
  
  for i = 0, 4 do
    table.insert(frames, love.graphics.newQuad(i * frameWidth, 0, frameWidth, frameHeight, image:getWidth(), image:getHeight()))
  end
  
  currentFrame = 1
end

function love.update(dt)
  currentFrame = currentFrame + 10 * dt
  
  if currentFrame >= 6 then
    currentFrame = 1
  end
  
end

function love.draw()
  love.graphics.draw(image, frames[math.floor(currentFrame)], 100, 100)
end
