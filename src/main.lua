player = {}
enemy = {}
ball = {}

function love.load()

    --debug.debug()

    -- Fat lines.
    love.graphics.setLineWidth(2)

    -- Load images.
    images = {
        player = love.graphics.newImage("images/player.png"),
        enemy = love.graphics.newImage("images/enemy.png"),
        ball = love.graphics.newImage("images/ball.png"),
    }


    -- Create the world.
    world = love.physics.newWorld(0, 0)

    -- Create ground body.
    ground = love.physics.newBody(world, 0, 0, "static")

    player.width = images.player:getWidth()
    player.height = images.player:getHeight()
    player.b = love.physics.newBody(world, 10, 10, "kinematic")
    --player.b:setMass(0)
    player.s = love.physics.newPolygonShape(unpack(getVertices()))
    player.f = love.physics.newFixture(player.b, player.s, 1)
    player.f:setFriction(1)
    player.f:setRestitution(0)
    player.i = images.player

    enemy.width = images.enemy:getWidth()
    enemy.height = images.enemy:getHeight()
    enemy.b = love.physics.newBody(world, 50, 50, "dynamic")
    enemy.s = love.physics.newRectangleShape(enemy.width / 10, enemy.height / 10)
    --enemy.f = love.physics.newFixture(enemy.b, enemy.s)
    enemy.i = images.enemy

    ball.radius = images.ball:getWidth() / 2
    ball.b = love.physics.newBody(world, 40, 40, "dynamic")
    ball.s = love.physics.newCircleShape(ball.radius / 10)
    ball.f = love.physics.newFixture(ball.b, ball.s, 1)
    ball.i = images.ball
    ball.f:setFriction(0)
    ball.f:setRestitution(1)
    ball.b:applyLinearImpulse(-1, 0)

    love.graphics.setBackgroundColor(104, 136, 248)

    body = love.physics.newBody(world, 0, 0, "static")
    shape = love.physics.newEdgeShape(0, 0, 0, 80)
    love.physics.newFixture(body, shape)
    shape = love.physics.newEdgeShape(0, 80, 80, 80)
    love.physics.newFixture(body, shape)
    shape = love.physics.newEdgeShape(80, 80, 80, 0)
    love.physics.newFixture(body, shape)
    shape = love.physics.newEdgeShape(80, 0, 0, 0)
    love.physics.newFixture(body, shape)

    love.physics.setMeter(300)
end

function getVertices()
    local vertices = {}
    for i=0,7 do
        n = (i / 7) * math.pi
        table.insert(vertices, 2.5 * math.sin(n))
        table.insert(vertices, 8.1 * math.cos(n))
    end
    return vertices
end

function love.update(dt)
    if love.keyboard.isDown("down") or love.keyboard.isDown("j") then
        player.b:setY(player.b:getY() + dt * 500)
    elseif love.keyboard.isDown("up") or love.keyboard.isDown("k") then
        player.b:setY(player.b:getY() - dt * 500)
    end
    world:update(dt)
end

function love.keypressed(key)
    if key == "down" or key == "j" then
        --player.b:setLinearVelocity(0, 800)
        --player.b:setY(player.b:getY() + 10)
    elseif key == "up" or key == "k" then
        --player.b:setLinearVelocity(0, -800)
        --player.b:setY(player.b:getY() - 10)
    elseif love.keyboard.isDown("lctrl") and key == "[" then
        love.event.push("quit")
    end
end

function love.keyreleased(key)
    if key == "up" or key == "down" or key == "j" or key == "k" then
        player.b:setLinearVelocity(0, 0)
    end
end

function love.draw()
    love.graphics.draw(player.i, player.b:getX() - player.width / 2, player.b:getY() - player.height / 2)
    love.graphics.draw(enemy.i, enemy.b:getX() - enemy.width / 2, enemy.b:getY() - enemy.height / 2)
    love.graphics.draw(ball.i, ball.b:getX() - ball.radius, ball.b:getY() - ball.radius, ball.b:getAngle())
end
