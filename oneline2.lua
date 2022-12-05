maxHealth = 10
function oneline2whatTo(agent, actorKnowledge, time)
    friends = actorKnowledge:getSeenFriends()
    enemies = actorKnowledge:getSeenFoes()

    -- if (friends:size() > 0) then
    --     direction = friends:at(0):getPosition() - actorKnowledge:getPosition()
    --     distance = direction:length()
    --     if (distance > 40) then
    --         agent:moveDirection(direction)
    --         agent:rotate(direction)
    --     end
    --     if (distance < 20) then
    --         agent:wait()
    --     end
    -- end
    -- if (actorKnowledge:getAmmo(Enumerations.RocketLuncher) ~= 0) then
    --     agent:selectWeapon(Enumerations.RocketLuncher);
    -- elseif (actorKnowledge:getAmmo(Enumerations.Railgun) ~= 0) then
    --     agent:selectWeapon(Enumerations.Railgun);
    -- elseif (actorKnowledge:getAmmo(Enumerations.Shotgun) ~= 0) then
    --     agent:selectWeapon(Enumerations.Shotgun);
    -- elseif (actorKnowledge:getAmmo(Enumerations.Chaingun) ~= 0) then
    --     agent:selectWeapon(Enumerations.Chaingun);
    -- end

    canShoot = false
    if (enemies:size() > 0) then
        enemyDir = enemies:at(0):getPosition() - actorKnowledge:getPosition()
        enemyDist = enemyDir:length()
        if (friends:size() > 0) then
            canShoot2 = true
            for i = 0, friends:size() - 1, 1 do
                friendEnemyDir = enemies:at(i):getPosition() - friends:at(i):getPosition()

                friendlyFire = (enemyDir:value(0) * friendEnemyDir:value(0) + enemyDir:value(1) *
                                   friendEnemyDir:value(1)) / (enemyDir:length() * friendEnemyDir:length())
                io.write("test1\n", friendlyFire)
                if (friendlyFire > 0.997 and friendEnemyDir:length() < dir:length()) then
                    canShoot2 = false
                    -- dir2 = Vector4d(-dir:value(1), dir:value(0), 0, 0)
                    -- agent:moveDirection(dir2)

                else
                    canShoot2 = true
                    -- agent:shootAtPoint(enemies:at(0):getPosition())
                end
            end
            canShoot = canShoot2
        else
            canShoot = true
            -- agent:shootAtPoint(enemies:at(0):getPosition())
        end
    end
    if (actorKnowledge:getAmmo(actorKnowledge:getWeaponType()) == 0) then
        io.write(actorKnowledge:getWeaponType(), "\n change weapon\n")
        if (actorKnowledge:getAmmo(Enumerations.RocketLuncher) ~= 0) then
            agent:selectWeapon(Enumerations.RocketLuncher);
        elseif (actorKnowledge:getAmmo(Enumerations.Railgun) ~= 0) then
            agent:selectWeapon(Enumerations.Railgun);
        elseif (actorKnowledge:getAmmo(Enumerations.Shotgun) ~= 0) then
            agent:selectWeapon(Enumerations.Shotgun);
        elseif (actorKnowledge:getAmmo(Enumerations.Chaingun) ~= 0) then
            agent:selectWeapon(Enumerations.Chaingun);
        end
        -- agent:selectWeapon(2)
        io.write(actorKnowledge:getWeaponType(), "weapon\n")
    elseif (canShoot == true) then
        io.write(" weapon", actorKnowledge:getWeaponType())
        io.write(" ammo", actorKnowledge:getAmmo(actorKnowledge:getWeaponType()))
        agent:shootAt(enemies:at(0))
        io.write("Agentshoot, ammoleft", actorKnowledge:getAmmo(actorKnowledge:getWeaponType()))

        -- agent:shootAt(enemies:at(0))
    end
    -- io.write("ammo", actorKnowledge:getAmmo(Enumerations.Shotgun), "\n")

    -- if (enemies:size() > 0) then
    --     -- agent:moveTo(enemies:at(0):getPosition())
    --     distance = (enemies:at(0):getPosition() - actorKnowledge:getPosition()):length()
    --     if (distance < 200) then
    --         if (actorKnowledge:getWeaponType() ~= Enumerations.Shotgun and actorKnowledge:getAmmo(Enumerations.Shotgun) >
    --             0) then
    --             agent:selectWeapon(Enumerations.Shotgun)
    --         else
    --             agent:shootAt(enemies:at(0))
    --         end
    --     elseif (distance < 500) then
    --         if (actorKnowledge:getWeaponType() ~= Enumerations.Chaingun and
    --             actorKnowledge:getAmmo(Enumerations.Chaingun) > 0) then
    --             agent:selectWeapon(Enumerations.Chaingun)
    --         else
    --             agent:shootAt(enemies:at(0))
    --         end
    --     else
    --         if (actorKnowledge:getWeaponType() ~= Enumerations.Railgun and actorKnowledge:getAmmo(Enumerations.Railgun) >
    --             0) then
    --             agent:selectWeapon(Enumerations.Railgun)
    --         else
    --             agent:shootAt(enemies:at(0))
    --         end
    --     end
    -- end

    -- addew = enemies:at(1):getPosition()
    -- showVector(enemies:at(1):getPosition())
    -- weapon = actorKnowledge:getWeaponType()
    -- io.write("\n weapon", weapon)
    -- weapon = weapon + 1
    io.write(" enemies", enemies:size(), "\n")
    if enemies:size() > 0 then
        -- io.write(enemies:size())
        -- agent:shootAt(addew)
    end
    -- agent:selectWeapon(weapon)

end

function oneline2onStart(agent, actorKnowledge, time)
    -- dir = Vector4d(10,3,1,0)
    -- showVector(dir:normal())
    -- showVector(dir:normalize())
    if (maxHealth < actorKnowledge:getHealth()) then
        maxHealth = actorKnowledge:getHealth()
    end
    -- agent:moveTo(actor2destinationdirection)
end

function showVector(vector)
    io.write("(")
    io.write(vector:value(0))
    io.write(",")
    io.write(vector:value(1))
    io.write(",")
    io.write(vector:value(2))
    io.write(",")
    io.write(vector:value(3))
    io.write(");")
end

function shootOpponent()
end
function chooseWeapon(agent, actorKnowledge, dist)
    -- if (dist < 200) then

    -- end
    -- if (actorKnowledge:getAmmo(Enumerations.RocketLuncher) ~= 0) then
    --     io.write("rocket")
    --     agent:selectWeapon(Enumerations.RocketLuncher);
    -- elseif (actorKnowledge:getAmmo(Enumerations.Railgun) ~= 0) then
    --     io.write("rail")
    --     agent:selectWeapon(Enumerations.Railgun);
    -- elseif (actorKnowledge:getAmmo(Enumerations.Shotgun) ~= 0) then
    --     io.write("shot")
    --     agent:selectWeapon(Enumerations.Shotgun);
    -- elseif (actorKnowledge:getAmmo(Enumerations.Chaingun) ~= 0) then
    --     io.write("chain")
    --     agent:selectWeapon(Enumerations.Chaingun);
    -- end
    -- return "cokolwiek"
end
