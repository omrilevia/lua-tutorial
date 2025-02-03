io.stdout:setvbuf("no")

function love.draw()
  player:draw()
  enemy:draw()
  

    for i, v in ipairs(bulletList) do
      v:draw()
    end


  
end

function love.update(dt)
  player:update(dt)
  enemy:update(dt)
  
 
    for i, v in ipairs(bulletList) do
      v:update(dt)
      v:checkCollision(enemy)
      
      if v.dead then
        table.remove(bulletList, i)
      end
      
    end
 
end

function love.load()
  Object = require "classic"
  require "player"
  require "enemy"
  require "bullet"
  
  player = Player()
  enemy = Enemy()
  
  bulletList = {}
end

function love.keypressed(key) 
  if key == "space" then
    table.insert(bulletList, Bullet(player.x + player.width/2, player.y + player.height))
  end
end
  
  



