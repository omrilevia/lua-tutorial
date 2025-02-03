function love.load()
  image = love.graphics.newImage("tileset.png")
  
  width = image:getWidth() / 3 - 2
  height = image:getHeight() / 2 - 2-- minus two for bleeding
  
  imageWidth = image:getWidth()
  imageHeight = image:getHeight()
  
  tilemap = {
    {1, 6, 6, 2, 1, 6, 6, 2},
    {3, 0, 0, 4, 5, 0, 0, 3},
    {3, 0, 0, 0, 0, 0, 0, 3},
    {4, 2, 0, 0, 0, 0, 1, 5},
    {1, 5, 0, 0, 0, 0, 4, 2},
    {3, 0, 0, 0, 0, 0, 0, 3},
    {3, 0, 0, 1, 2, 0, 0, 3},
    {4, 6, 6, 5, 4, 6, 6, 5}
}

    --Create a table named colors
    colors = {
        --Fill it with tables filled with RGB numbers
        {1, 1, 1},
        {1, 0, 0},
        {1, 0, 1},
        {0, 0, 1},
        {0, 1, 1}
    }
    
    quads = {}
    
    for i=0,1 do
        for j=0,2 do
          
            table.insert(quads, love.graphics.newQuad(1 + j * (width + 2), 1 + i * (height + 2), width, height, imageWidth, imageHeight))
        end
    end
    
    --Create our player
    player = {
        image = love.graphics.newImage("player.png"),
        tile_x = 2,
        tile_y = 2
    }
end

function love.update(dt)
  
end

function love.draw()
  for i, row in ipairs(tilemap) do
    for j, tile in ipairs(row) do
      if tile ~=0 then
        love.graphics.draw(image, quads[tile], width * j, height * i)
      end
    end
  end
  
  love.graphics.draw(player.image, player.tile_x * width, player.tile_y * height)
  
end

function love.keypressed(key)
  local x = player.tile_x
  local y = player.tile_y
    
  if key == "left" then
    x = x - 1;
  elseif key == "right" then
    x = x + 1;
  elseif key == "down" then
    y = y + 1;
  elseif key == "up" then
    y = y - 1;
  end
  
  if (isEmpty(x, y)) then
    player.tile_x = x
    player.tile_y = y
  end
  
end

function isEmpty(x, y)
    return tilemap[y][x] == 0
end



