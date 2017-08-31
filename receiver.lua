function init()
    robot.leds.set_single_color(1,"red")
    robot.leds.set_single_color(12,"red")
    state = "waiting"
    imp_msg = 0
end

function step()
    log(state)
    if state == "waiting" then
        wait()
    elseif state == "turning" then
        turn()
    elseif state == "lunge" then
        drivest()
    end
end


function reset()
end
function destroy()
end


function wait()
    if robot.range_and_bearing[1].data[2] == 2 then
        imp_msg = robot.range_and_bearing[1]
        state = "turning"
    end
end

function turn()
    x = orientation_to_bearing()
    if imp_msg.horizontal_bearing >= -0.05 and imp_msg.horizontal_bearing <= 0.05 then
        state = "lunge"
    end
    log(imp_msg.horizontal_bearing)
    if math.abs(x - imp_msg.horizontal_bearing) <= 0.05 then
        state = "lunge"
    elseif imp_msg.horizontal_bearing > 0 then
        robot.wheels.set_velocity(-0.5,0.5)
    elseif imp_msg.horizontal_bearing < -0 then
        robot.wheels.set_velocity(0.5,-0.5)
    end
end

function drivest()
    x = 0
    for i = 1,24 do
        if robot.proximity[i].value >= x then
            x = robot.proximity[i].value
        end
    end
    robot.wheels.set_velocity((1 - x) * 10,(1 - x) * 10)
end

function orientation_to_bearing()
    angle = robot.positioning.orientation.angle
    rot = robot.positioning.orientation.axis.z
    if rot > 0 then
        angle = math.fmod(angle,(2*math.pi))
        if angle > math.pi then
            angle = 2*math.pi - angle
        end
    end
    if rot < 0 then
        angle = math.fmod(angle,(2*math.pi))
        if angle > math.pi then
            angle = 2*math.pi - angle
        else
            angle = -angle
        end
    end
    log(angle)
    return angle
end
