function init()
    robot.leds.set_single_color(1,"red")
    robot.leds.set_single_color(12,"red")
    state = "waiting"
end
imp_msg = 0

function step()
    log(state)
    if state == "waiting" then
        wait()
    elseif state == "acting" then
        act()
    end
end


function reset()

end


function destroy()

end


function wait()
    if robot.range_and_bearing[1].data[2] == 2 then
        imp_msg = robot.range_and_bearing[1]
        state = "acting"
    end
end

function act()
    if imp_msg.horizontal_bearing >=0 and math.abs(imp_msg.horizontal_bearing - robot.positioning.orientation.angle) >= 0.1 then
        robot.wheels.set_velocity(-1,1)
    end

    if imp_msg.horizontal_bearing <=0 and math.abs(imp_msg.horizontal_bearing - robot.positioning.orientation.angle) >= 0.1 then
        robot.wheels.set_velocity(1,-1)
    end

    if math.abs(imp_msg.horizontal_bearing - robot.positioning.orientation.angle) < 0.1 then
        x = dist()
        log(x)
        if x == 0 then
            robot.wheels.set_velocity(10,10)
        elseif x == 1 then
            robot.wheels.set_velocity(0,0)
        end
    end
end


function dist()
    x = 0
    for i = 1,24 do
        if robot.proximity[i].value == 1 then
            x = 1
        end
    end
    return x
end
