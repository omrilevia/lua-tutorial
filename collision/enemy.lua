Enemy = Object:extend()

function Enemy:new()
  self.x = 100
  self.y = 450
  self.speed = 100
  self.image = love.graphics.newImage("snake.png")
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
end

function Enemy:update(dt)
  self.x = self.x + self.speed * dt
  
  local windowWidth = love.graphics.getWidth()
  
  -- Hit a wall? 
  if self.x + self.image:getWidth() > windowWidth or self.x < 0 then 
    self.speed = -1 * self.speed
  end 
end

function Enemy:draw() 
  love.graphics.draw(self.image, self.x, self.y)
end
