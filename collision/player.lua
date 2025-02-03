Player = Object:extend()

function Player:new()
  self.image = love.graphics.newImage("panda.png")
  self.x = 300
  self.y = 20
  self.speed = 500
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
end

function Player:draw()
  love.graphics.draw(self.image, self.x, self.y)
end

function Player:update(dt) 
  if love.keyboard.isDown("left") then
    self.x = self.x - self.speed * dt
  elseif love.keyboard.isDown("right") then
    self.x = self.x + self.speed * dt
  end
  
  local windowWidth = love.graphics.getWidth()
  
  if self.x < 0 then 
    self.x = windowWidth - self.image:getWidth()
  elseif self.x + self.image:getWidth() > windowWidth then
    self.x = 0
    end 
end