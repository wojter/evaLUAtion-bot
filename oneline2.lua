maxHealth = 10
function oneline2whatTo(agent, actorKnowledge, time)
    friends = actorKnowledge:getSeenFriends()
    if (friends:size() > 0) then
        direction = friends:at(0):getPosition() - actorKnowledge:getPosition()
        distance = direction:length()
        if (distance > 40) then
            agent:moveDirection(direction)
            agent:rotate(direction)
        end
        if (distance < 20) then
            agent:wait()
        end
    end
    enemies = actorKnowledge:getSeenFoes()
    -- if (enemies:size() > 0) then
    --     dir = enemies:at(0):getPosition() - actorKnowledge:getPosition()
    --     if (friends:size() > 0) then
    --         vipPos = enemies:at(0):getPosition() - friends:at(0):getPosition()

    --         friendlyFire = (dir:value(0) * vipPos:value(0) + dir:value(1) * vipPos:value(1)) /
    --                            (dir:length() * vipPos:length())
    --         io.write("test1\n", friendlyFire)
    --         if (friendlyFire > 0.997 and vipPos:length() < dir:length()) then

    --             -- dir2 = Vector4d(-dir:value(1), dir:value(0), 0, 0)
    --             -- agent:moveDirection(dir2)

    --         else
    --             agent:shootAtPoint(enemies:at(0):getPosition())
    --         end
    --     else 
    -- 		agent:shootAtPoint(enemies:at(0):getPosition())
    -- 	end
    -- end

    if (enemies:size() > 0) then
        -- agent:moveTo(enemies:at(0):getPosition())
        distance = (enemies:at(0):getPosition() - actorKnowledge:getPosition()):length()
        if (distance < 200) then
            if (actorKnowledge:getWeaponType() ~= Enumerations.Shotgun and actorKnowledge:getAmmo(Enumerations.Shotgun) >
                0) then
                agent:selectWeapon(Enumerations.Shotgun)
            else
                agent:shootAt(enemies:at(0))
            end
        elseif (distance < 500) then
            if (actorKnowledge:getWeaponType() ~= Enumerations.Chaingun and
                actorKnowledge:getAmmo(Enumerations.Chaingun) > 0) then
                agent:selectWeapon(Enumerations.Chaingun)
            else
                agent:shootAt(enemies:at(0))
            end
        else
            if (actorKnowledge:getWeaponType() ~= Enumerations.Railgun and actorKnowledge:getAmmo(Enumerations.Railgun) >
                0) then
                agent:selectWeapon(Enumerations.Railgun)
            else
                agent:shootAt(enemies:at(0))
            end
        end
    end
    -- addew = enemies:at(1):getPosition()
    -- showVector(enemies:at(1):getPosition())
    -- weapon = actorKnowledge:getWeaponType()
    -- io.write("\n weapon", weapon)
    -- weapon = weapon + 1
	io.write(enemies:size())
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
