 function love.load()
   lume = require "lume"
  
  screenCanvas = love.graphics.newCanvas(400, 600)
    -- Create a player object with an x, y and size
    player1 = {
        x = 100,
        y = 100,
        size = 25
    }
    
    player2 = {
      x = 200,
      y = 200,
      size = 25
    }
    
    score1 = 0
    score2 = 0
    
    shakeDuration = 0
    shakeWait = 0
    shakeOffset = {x = 0, y = 0}
    
    player1.image = love.graphics.newImage("face.png")
    player2.image = love.graphics.newImage("face.png")
    
    coins = {}
    coins.image = love.graphics.newImage("dollar.png")
    
    local seed = math.randomseed(os.time())
    

      -- load coins
    for i = 1, 25 do
      local x = math.random(50, 650, seed)
      local y = math.random(50, 450, seed)
      table.insert(coins, {size = 10, x = x, y = y})
    end
  end


function love.update(dt)
  
  
    -- Make it moveable with keyboard 
    if love.keyboard.isDown("left") then
        player1.x = player1.x - 200 * dt
    elseif love.keyboard.isDown("right") then
        player1.x = player1.x + 200 * dt
    end

    -- Note how I start a new if-statement instead of contuing the elseif
    -- I do this because else you wouldn't be able to move diagonally.
    if love.keyboard.isDown("up") then
        player1.y = player1.y - 200 * dt
    elseif love.keyboard.isDown("down") then
        player1.y = player1.y + 200 * dt
    end
    
     -- Make it moveable with keyboard 
    if love.keyboard.isDown("a") then
        player2.x = player2.x - 200 * dt
    elseif love.keyboard.isDown("d") then
        player2.x = player2.x + 200 * dt
    end


    if love.keyboard.isDown("w") then
        player2.y = player2.y - 200 * dt
    elseif love.keyboard.isDown("s") then
        player2.y = player2.y + 200 * dt
    end
    
    for i = #coins, 1, -1 do
      if checkCollision(player1, coins[i]) then
        table.remove(coins, i)
        player1.size = player1.size + 1
        score1 = score1 + 1
        shakeDuration = 0.3
      end
      
      if checkCollision(player2, coins[i]) then
        table.remove(coins, i)
        player2.size = player2.size + 1
        score2 = score2 + 1
        shakeDuration = 0.3
      end
    end
    
    
end

function love.draw()
  love.graphics.setCanvas(screenCanvas)
  love.graphics.clear()
  drawGame(player1)
  
    love.graphics.setCanvas()
    love.graphics.draw(screenCanvas)
    
    love.graphics.setCanvas(screenCanvas)
        love.graphics.clear()
        drawGame(player2)
    love.graphics.setCanvas()
    love.graphics.draw(screenCanvas, 400)

    -- Add a line to separate the screens
    love.graphics.line(400, 0, 400, 600)
    
    love.graphics.print("Player 1 score: " .. score1, 10, 10)
    love.graphics.print("Player 2 score: " .. score2, 10, 30)
    
end

function drawGame(player)
  love.graphics.push()
  love.graphics.translate(-player.x + 200, -player.y + 300)
  
  
  if (shakeDuration > 0) then
    love.graphics.translate(shakeOffset.x, shakeOffset.y)
  end
  
    -- The players and coins are going to be circles
    love.graphics.circle("line", player1.x, player1.y, player1.size)
    
    -- Set the origin of the face to the center of the image
    love.graphics.draw(player1.image, player1.x, player1.y,
        0, 1, 1, player1.image:getWidth()/2, player1.image:getHeight()/2)
      
      love.graphics.circle("line", player2.x, player2.y, player2.size)
      love.graphics.draw(player2.image, player2.x, player2.y,
            0, 1, 1, player2.image:getWidth()/2, player2.image:getHeight()/2)
      
    for i, coin in ipairs(coins) do
      love.graphics.draw(coins.image, coin.x, coin.y, 0, 1, 1, coins.image:getWidth()/2, coins.image:getHeight()/2)
      love.graphics.circle("line", coin.x, coin.y, coin.size)
    end
    
    love.graphics.pop()
  end
  

function love.keypressed(key)
    if key == "space" then
        saveData()
    elseif key == "q" then
    love.filesystem.remove("savedata.txt")
        love.event.quit("restart")
    end
end


function checkCollision(p1, p2)
  if p1 and p2 then
    local distance = math.sqrt((p1.x - p2.x)^2 + (p1.y - p2.y)^2)
    return distance < p1.size + p2.size
  else 
    return false
  end
end

function saveData()
  data = {}
  data.player = {x = player1.x, y = player1.y, size = player1.size}
  
  data.coins = {}
  for i, v in ipairs(coins) do
    data.coins[i] = {x = v.x, y = v.y, size}
  end
  
  serialized = lume.serialize(data)
  -- The filetype actually doesn't matter, and can even be omitted.
  love.filesystem.write("savedata.txt", serialized)
end

