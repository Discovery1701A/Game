Block = Class {}

function Block:init(x,y)
    self.image = gTexture['Stein']
    self.x = VIRTUAL_WIDTH/2 +75
    self.y =  VIRTUAL_HEIGHT/2 +50
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    
    
end

function Block:render()
    love.graphics.draw(self.image, self.x, self.y)
end