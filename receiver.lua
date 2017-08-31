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
    if imp_msg.horizontal_bearing >= -0.1 and imp_msg.horizontal_bearing <= 0.1 then
        state = "lunge"
    elseif imp_msg.horizontal_bearing > 0

function drivest()
    x = 0
    for i = 1,24 do
        if robot.proximity[i].value >= x then
            x = robot.proximity[i].value
        end
    end
    log(x)
    robot.wheels.set_velocity((1 - x) * 10,(1 - x) * 10)
end
