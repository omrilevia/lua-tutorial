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
  
  self.gravity = 0
  self.weight = 400
end

function Entity:update(dt)
  self.last.x = self.x
  self.last.y = self.y
  self.tempStrength = self.strength
  
  self.gravity = self.gravity + self.weight * dt
  self.y = self.y + self.gravity * dt
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
                -- Replace these with the functions
                self:collide(e, "right")
            else
                self:collide(e, "left")
            end
        elseif self:wasHorizontallyAligned(e) then
            if self.y + self.height/2 < e.y + e.height/2 then
                self:collide(e, "bottom")
            else
                self:collide(e, "top")
            end
        end
        return true
    end
    return false
end

-- When the entity collides with something with his right side
function Entity:collide(e, direction)
    if direction == "right" then
        local pushback = self.x + self.width - e.x
        self.x = self.x - pushback
    elseif direction == "left" then
        local pushback = e.x + e.width - self.x
        self.x = self.x + pushback
    elseif direction == "bottom" then
        local pushback = self.y + self.height - e.y
        self.y = self.y - pushback
        self.gravity = 0
    elseif direction == "top" then
        local pushback = e.y + e.height - self.y
        self.y = self.y + pushback
    end
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


