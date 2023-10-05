Topf = Class {}

-- Constructor

function Topf:init()
    self.image = gTexture['Topf']
    self.x = VIRTUAL_WIDTH / 2 - self.image:getWidth() / 2
    self.y = VIRTUAL_HEIGHT - self.image:getHeight()
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.dx = 0
    self.dy = 0
    self.speed = 5
    self.jump = false

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
        self.dy = self.dy + GRAVATY*dt
    end
    if love.keyboard.wasPressed('space') and self.jump == false then
        self.dy = -5
        self.jump = true
    end
    

    self.x = self.x + self.dx
    self.y = self.y + self.dy
end

-- Render

function Topf:render()
    love.graphics.draw(self.image, self.x, self.y)
end