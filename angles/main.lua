function love.load()
    arrow = {}
    
    arrow.image = love.graphics.newImage("arrow_right.png")
    arrow.width = arrow.image:getWidth()
    arrow.height = arrow.image:getHeight()
    arrow.x = 200
    arrow.y = 200
    arrow.origin_x = arrow.image:getWidth()/2
    arrow.origin_y = arrow.image:getHeight()/2
    arrow.speed = 200
    
end

function love.update(dt)
  local mouseX, mouseY = love.mouse.getPosition()
  arrow.angle = math.atan2(mouseY - arrow.y, mouseX - arrow.x)
  
  local sin = math.sin(arrow.angle)
  local cos = math.cos(arrow.angle)
  
  arrow.x = arrow.x + arrow.speed * cos * dt
  arrow.y = arrow.y + arrow.speed * sin * dt
end

function love.draw()
  love.graphics.draw(arrow.image, arrow.x, arrow.y, arrow.angle, 1, 1, arrow.origin_x, arrow.origin_y)

  
end

function getDistance(x1, y1, x2, y2) 
  return math.sqrt((x2 - x1)^2 + (y2-y1)^2)
end

