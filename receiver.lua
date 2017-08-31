pi = math.pi


function round(x)
  if x%2 ~= 0.5
    return math.floor(x+0.5)
  end
  return x-0.5
end


function init()
    robot.leds.set_single_color(1,"red")
    robot.leds.set_single_color(12,"red")
    state = "waiting"
    imp_msg = 0
    t = 0
end

function step()
    log(state)
    if state == "waiting" then
        t = wait()
    elseif state == "turning" then
        turn(t)
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
        t = 4.4*(math.abs(imp_msg.horizontal_bearing)/(2*pi))
        t = round(t)
    end
    return t
end

function turn(t)
    if imp_msg.horizontal_bearing >= -0.1 and imp_msg.horizontal_bearing <= 0.1 then
        state = "lunge"
    elseif imp_msg.horizontal_bearing > 0.1 then
        robot.wheels.set_velocity(-1,1)
        t = t - 1
        if t == 0 then
            state = "lunge"
        end
    elseif imp_msg.horizontal_bearing < -0.1 then
        robot.wheels.set_velocity(1,-1)
        t = t - 1
        if t == 0 then
            state = "lunge"
        end
    end
end

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
