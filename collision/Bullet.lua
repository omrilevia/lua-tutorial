Bullet = Object:extend()

function Bullet:new(x, y)
  self.x = x
  self.y = y
  self.speed = 700
  self.image = love.graphics.newImage("bullet.png")
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
end

function Bullet:update(dt)
  self.y = self.y + self.speed * dt
  
  if self.y > love.graphics.getHeight() then
    love.load()
  end
  
end

function Bullet:draw() 
  love.graphics.draw(self.image, self.x, self.y)
end

function Bullet:checkCollision(obj)
  local bulletLeft = self.x
  local bulletRight = self.x + self.width
  local bulletTop = self.y
  local bulletBottom = self.y + self.height
  
  local objLeft = obj.x
  local objRight = obj.x + obj.width
  local objTop = obj.y
  local objBottom = obj.y + obj.height
  
  if bulletLeft < objRight and
  bulletRight > objLeft and
  bulletBottom > objTop and 
  bulletTop < objBottom then 
    self.dead = true
    
    if obj.speed > 0 then 
      obj.speed = obj.speed + 50
    else
      obj.speed = obj.speed - 50
    end
    
  end
  
end

  