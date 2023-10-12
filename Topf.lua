Topf = Class {}

-- Constructor

function Topf:init()
    self.image = gTexture['Topf']
    self.x = 0  -- VIRTUAL_WIDTH / 2 - self.image:getWidth() / 2
    self.y = VIRTUAL_HEIGHT - self.image:getHeight()
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.dx = 0
    self.dy = 0
    self.speed = 5
    self.jump = false
    self.falling = false

end

-- Update

function Topf:update(dt)
    if love.keyboard.isDown('left') then
        self.dx = -self.speed
    elseif love.keyboard.isDown('right') then
        self.dx =  self.speed
    else
        self.dx = 0
    end
   -- if love.keyboard.isDown('up') then
    --    self.dy = - self.speed
    --elseif love.keyboard.isDown('down') then
      --  self.dy = self.speed
   -- else
      --  self.dy = 0
    --end
    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
    else
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
    end
    if self.dy < 0 then
       self.y = math.max(0, self.y + self.dy * dt)
       
    else
        
       self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
   end
   if self.y >= VIRTUAL_HEIGHT - self.height then
       self.jump = false
   else 
        if self.falling then
        self.dy = self.dy + GRAVATY*dt
        end
        self.falling = true
    end
    if (love.keyboard.wasPressed('space') or love.keyboard.wasPressed('up') or love.keyboard.wasPressed('w')) and self.jump == false then
        self.dy = -5
        self.jump = true
        self.falling = true
    end
    

    self.x = self.x + self.dx
    self.y = self.y + self.dy
end

function Topf:collider(object)
    if self.x < object.x + object.width and object.x < self.x + self.width  then
        if self.y < object.y + object.height and object.y < self.y + self.height then
            return true
        else
            
            self.jump = false
            return false
        end
    else
        self.jump = false
        return false
    end

  

end
function Topf:colliderPositionsAnpassung(object)
    if self.x < object.x + object.width/2 and self.dx <0 then
        if self.x > object.x + object.width/2  then
            self.x = object.x + object.width +8
        end
        
    
    elseif object.x < self.x + self.width and self.dx >0 then
        if object.x  +object.width/2> self.x + self.width then
            self.x = object.x - self.width -8
        end
        
    end
    if self.y < object.y + object.height and self.dy <0 then
        if self.y > object.y + object.height/2  then
        self.y = object.y + object.height +8
        end


    elseif object.y < self.y + self.height and self.dy >0 then
        if object.y  +object.height/2> self.y + self.height  then
            self.falling = false
        self.y = object.y - self.height -8
        end
    end
    
end


-- Render

function Topf:render()
    love.graphics.draw(self.image, self.x, self.y)
end