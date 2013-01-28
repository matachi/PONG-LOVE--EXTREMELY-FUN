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
    player.b = love.physics.newBody(world, 100, 100, "kinematic")
    player.s = love.physics.newPolygonShape(unpack(getVertices()))
    player.f = love.physics.newFixture(player.b, player.s, 1)
    player.f:setFriction(1)
    player.f:setRestitution(0)
    player.i = images.player

    enemy.width = images.enemy:getWidth()
    enemy.height = images.enemy:getHeight()
    enemy.b = love.physics.newBody(world, 500, 500, "dynamic")
    enemy.s = love.physics.newRectangleShape(enemy.width, enemy.height)
    --enemy.f = love.physics.newFixture(enemy.b, enemy.s)
    enemy.i = images.enemy

    ball.radius = images.ball:getWidth() / 2
    ball.b = love.physics.newBody(world, 400, 400, "dynamic")
    ball.s = love.physics.newCircleShape(ball.radius)
    ball.f = love.physics.newFixture(ball.b, ball.s, 1)
    ball.i = images.ball
    ball.f:setFriction(0)
    ball.f:setRestitution(1)
    ball.b:applyLinearImpulse(-500, 0)

    love.graphics.setBackgroundColor(104, 136, 248)

    body = love.physics.newBody(world, 0, 0, "static")
    shape = love.physics.newEdgeShape(0, 0, 0, 800)
    love.physics.newFixture(body, shape)
    shape = love.physics.newEdgeShape(0, 800, 800, 800)
    love.physics.newFixture(body, shape)
    shape = love.physics.newEdgeShape(800, 800, 800, 0)
    love.physics.newFixture(body, shape)
    shape = love.physics.newEdgeShape(800, 0, 0, 0)
    love.physics.newFixture(body, shape)
end

function getVertices()
    local vertices = {}
    for i=0,7 do
        n = (i / 7) * math.pi
        table.insert(vertices, 25 * math.sin(n))
        table.insert(vertices, 81 * math.cos(n))
    end
    return vertices
end

function love.update(dt)
    -- Update the world.
    world:update(dt)
end

function love.keypressed(key)
    if key == "down" or key == "j" then
        player.b:setLinearVelocity(0, 400)
    elseif key == "up" or key == "k" then
        player.b:setLinearVelocity(0, -400)
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
    love.graphics.draw(ball.i, ball.b:getX() - ball.radius, ball.b:getY() - ball.radius)
end
