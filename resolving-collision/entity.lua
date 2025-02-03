Entity = Object:extend()

function Entity:new(x, y, imagePath)
  self.x = x
  self.y = y 
  self.image = love.graphics.newImage(imagePath)
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  
  self.last = {}
  self.last.x = self.x
  self.last.y = self.y
  
  self.strength = 0
  self.tempStrength = 0
end

function Entity:update(dt)
  self.last.x = self.x
  self.last.y = self.y
  self.tempStrength = self.strength
end

function Entity:draw()
  love.graphics.draw(self.image, self.x, self.y)
end

function Entity:resolveCollision(e)
  if self.tempStrength > e.tempStrength then
    return e:resolveCollision(self)
  end
  
  
  if self:checkCollision(e) then
    
    self.tempStrength = e.tempStrength
    
    if self:wasVerticallyAligned(e) then
      if self.x + self.width/2 < e.x + e.width/2 then
        local pushback = self.x + self.width - e.x
        self.x = self.x - pushback
      else
        local pushback = e.x + e.width - self.x
        self.x = self.x + pushback
      end
      
    elseif self:wasHorizontallyAligned(e) then
      if self.height/2 + self.y < e.y + e.height/2 then
        local pushback = self.y + self.height - e.y
        self.y = self.y - pushback
      else
        local pushback = e.y + e.height - self.y
        self.y = self.y + pushback
      end
    
  end
  
  return true
  end

  return false
  
end


function Entity:wasVerticallyAligned(e)
  return self.last.y < e.last.y + e.height and
  self.last.y + self.height > e.last.y
end

function Entity:wasHorizontallyAligned(e)
  return self.last.x < e.last.x + e.width and
  self.last.x + self.width > e.last.x
end

function Entity:checkCollision(e)
  if not e then 
    return false
  else
    -- left side is further left than e's right side
    if self.x < e.x + e.width and 
    -- right side is further right than e's left side
    self.x + self.width > e.x and
    -- top side is further up (closer to 0) than e's bottom side
    self.y < e.y + e.height and
    -- bottom side is further down (further from 0) than e's top side
    self.y + self.height > e.y then
      return true
    end
  
    return false
  end
end


