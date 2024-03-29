maxHealth = 10
botsSmallestDist = 99999
mapSize = 800
function trojanBot1whatTo(agent, actorKnowledge, time)
    friends = actorKnowledge:getSeenFriends()
    enemies = actorKnowledge:getSeenFoes()
    nav = actorKnowledge:getNavigation()

    if (actorKnowledge:isMoving() == false) then
        triggToMove = -1
        triggToMoveDist = 99999
        for i = 0, nav:getNumberOfTriggers() - 1, 1 do
            trig = nav:getTrigger(i)
            tempDist = (trig:getPosition() - actorKnowledge:getPosition()):length()
            if (tempDist < 200 and trig:isActive()) then
                if (tempDist < triggToMoveDist) then
                    triggToMoveDist = tempDist
                    triggToMove = i
                end
            end
        end
        if (triggToMove ~= -1) then
            agent:moveTo(nav:getTrigger(triggToMove):getPosition())
        end
        if (time > 5) then
            if (friends:size() > 0) then
                for i = 0, friends:size() - 1, 1 do
                    if ((friends:at(i):getPosition() - actorKnowledge:getPosition()):length() < 15) then
                        dest = Vector4d(agent:randomDouble() * mapSize / 5, agent:randomDouble() * mapSize / 5, 0, 0)
                        agent:moveTo(dest)
                    end
                end
            end
        end
    end
    -- ------get Health------
    if (actorKnowledge:getHealth() < maxHealth / 2) then
        triggToMove = -1
        triggToMoveDist = 99999
        for i = 0, nav:getNumberOfTriggers() - 1, 1 do
            trig = nav:getTrigger(i)
            if (trig:isActive()) then
                if (trig:getType() == Trigger.Health or trig:getType() == Trigger.Armour) then
                    tempDist2 = trig:getPosition() - actorKnowledge:getPosition()
                    tempDist = tempDist2:length()
                    if (tempDist < triggToMoveDist) then
                        triggToMoveDist = tempDist
                        triggToMove = i
                    end
                end
            end
        end
        if (triggToMove ~= -1) then
            agent:moveTo(nav:getTrigger(triggToMove):getPosition())
        end
    end
    -- ------get Ammo------
    if (actorKnowledge:getAmmo(Enumerations.RocketLuncher) == 0 and actorKnowledge:getAmmo(Enumerations.Railgun) == 0 and
        actorKnowledge:getAmmo(Enumerations.Shotgun) == 0 and actorKnowledge:getAmmo(Enumerations.Chaingun) == 0) then
        triggToMove = -1
        triggToMoveDist = 9999
        for i = 0, nav:getNumberOfTriggers() - 1, 1 do
            trig = nav:getTrigger(i)

            if (trig:getType() == Trigger.Weapon) then
                tempDist = (trig:getPosition() - actorKnowledge:getPosition()):length()
                if (tempDist < triggToMoveDist) then
                    triggToMoveDist = tempDist
                    triggToMove = i
                end
            end

        end
        if (triggToMove ~= -1) then
            agent:moveTo(nav:getTrigger(triggToMove):getPosition())
        end
    end

    whichShoot = -1
    whichShootDist = 9999
    if (enemies:size() > 0) then
        for j = 0, enemies:size() - 1, 1 do
            enemyDir = enemies:at(j):getPosition() - actorKnowledge:getPosition()
            enemyDist = enemyDir:length()

            canShoot2 = true
            if (friends:size() > 0) then
                for i = 0, friends:size() - 1, 1 do
                    friendEnemyDir = enemies:at(j):getPosition() - friends:at(i):getPosition()
                    friendlyFire = (enemyDir:value(0) * friendEnemyDir:value(0) + enemyDir:value(1) *
                                       friendEnemyDir:value(1)) / (enemyDir:length() * friendEnemyDir:length())
                    if (friendlyFire > 0.993 and friendEnemyDir:length() < enemyDir:length()-5) then
                        canShoot2 = false
                    end
                end
            end
            if (canShoot2 == true) then
                whichShoot = j
                whichShootDist = enemyDist
                if (whichShoot ~= -1) then
                    if (enemyDist < whichShootDist - 30) then
                        whichShoot = j
                        whichShootDist = enemyDist
                    end
                else
                    whichShoot = j
                    whichShootDist = enemyDist
                end
            end
        end
    end
    if (actorKnowledge:getAmmo(actorKnowledge:getWeaponType()) == 0) then
        if (actorKnowledge:getAmmo(Enumerations.RocketLuncher) ~= 0) then
            agent:selectWeapon(Enumerations.RocketLuncher);
        elseif (actorKnowledge:getAmmo(Enumerations.Railgun) ~= 0) then
            agent:selectWeapon(Enumerations.Railgun);
        elseif (actorKnowledge:getAmmo(Enumerations.Shotgun) ~= 0) then
            agent:selectWeapon(Enumerations.Shotgun);
        elseif (actorKnowledge:getAmmo(Enumerations.Chaingun) ~= 0) then
            agent:selectWeapon(Enumerations.Chaingun);
        end
    elseif (whichShoot ~= -1) then
        dir = enemies:at(whichShoot):getPosition() - actorKnowledge:getPosition()
        if (whichShootDist < 150 and enemies:at(whichShoot):getHealth() > actorKnowledge:getHealth()) then
            dest = Vector4d(agent:randomDouble() * mapSize, agent:randomDouble() * mapSize, 0, 0)
            agent:moveTo(dest)
        end

        if (whichShootDist < 140) then
            -- if (enemies:at(whichShoot):getHealth() > actorKnowledge:getHealth() and actorKnowledge:getHealth() <
            --     maxHealth / 2) then
            --     agent:moveDirection(dir * (-1))
            if (actorKnowledge:getWeaponType() ~= Enumerations.Shotgun and actorKnowledge:getAmmo(Enumerations.Shotgun) >
                0) then
                agent:selectWeapon(Enumerations.Shotgun)
            else
                agent:shootAt(enemies:at(whichShoot))
            end
            -- end
        elseif (whichShootDist < 350) then
            if (actorKnowledge:getWeaponType() ~= Enumerations.Chaingun and
                actorKnowledge:getAmmo(Enumerations.Chaingun) > 0) then
                agent:selectWeapon(Enumerations.Chaingun)
            else
                agent:shootAt(enemies:at(whichShoot))
            end
        else
            if (actorKnowledge:getWeaponType() ~= Enumerations.Railgun and actorKnowledge:getAmmo(Enumerations.Railgun) >
                0) then
                agent:selectWeapon(Enumerations.Railgun)
            else
                agent:shootAt(enemies:at(whichShoot))
            end
        end

    end

end

function trojanBot1onStart(agent, actorKnowledge, time)
    if (maxHealth < actorKnowledge:getHealth()) then
        maxHealth = actorKnowledge:getHealth()
    end
    agent:selectWeapon(1)
end
