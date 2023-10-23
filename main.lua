push =require('Libiary/push')
Class = require('class')
require 'Topf'
require 'Block'
require 'constanten'
camera = require 'Libiary/camera'
sti = require 'Libiary/sti'

function love.load()
    cam = camera()
    gamMap = sti('map/testkarte.lua')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Topfi')
    math.randomseed(os.time())
    gFonts = {
        ['small'] = love.graphics.newFont('EarthrealmBold-Edmg.ttf', 8),
        ['medium'] = love.graphics.newFont('EarthrealmBold-Edmg.ttf', 14),
        ['large'] = love.graphics.newFont('EarthrealmBold-Edmg.ttf', 28)
    }
    gTexture = {
        ['Topf'] = love.graphics.newImage('Grafiks/Topf.png'),
        ['Stein'] = love.graphics.newImage('Grafiks/Steine.png')
    }

    gSounds = {
        ['jump'] = love.audio.newSource('Sounds/jump.wav', 'static'),
        ['collider'] = love.audio.newSource('Sounds/pupupu.wav', 'static')
    }

    topf = Topf()
    block = Block()
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    }) 
    love.keyboard.keysPressed = {}
end
function love.resize(w, h)
    push:resize(w, h)
end
function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end
function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
    if key == 'escape' then
        love.event.quit()
    end
end
function love.update(dt)
    topf:update(dt)
    --if topf:collider(block) then
      --  topf:colliderPositionsAnpassung(block)
   -- end

    cam:lookAt(topf.x+VIRTUAL_WIDTH, topf.y+VIRTUAL_HEIGHT)
    love.keyboard.keysPressed = {}
end
function love.draw()
   
    push:apply('start')
    cam:attach()
            gamMap:drawLayer(gamMap.layers['Kachelebene 1'])
            gamMap:drawLayer(gamMap.layers['Kachelebene 2'])
            block:render()
            topf:render()
           
            cam:detach()
        
    push:apply('end')
   
    displayFPS()
end
function displayFPS()
    
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0, 1, 0, 1)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5, 5)
    love.graphics.print('X: ' .. tostring(topf.x), 5, 15)
    love.graphics.print('Y: ' .. tostring(topf.y), 5, 25)
    love.graphics.setColor(1, 1, 1, 1)
end