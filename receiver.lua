function init()
robot.leds.set_single_color(1,"red")
robot.leds.set_single_color(12,"red")
end


function step()
    if robot.range_and_bearing[1].horizontal_bearing >=  0 and math.abs(robot.range_and_bearing[1].horizontal_bearing) >= 0.1 then
        if robot.range_and_bearing[1].data[2] == 2 and robot.range_and_bearing[1].horizontal_bearing >=  0 then
            robot.wheels.set_velocity(-1,1)
        end
    elseif robot.range_and_bearing[1].horizontal_bearing <=  0 and math.abs(robot.range_and_bearing[1].horizontal_bearing) >= 0.1 then
        if robot.range_and_bearing[1].data[2] == 2 and robot.range_and_bearing[1].horizontal_bearing <=  0 then
            robot.wheels.set_velocity(1,-1)
        end
    end

    if math.abs(robot.range_and_bearing[1].horizontal_bearing) <= 0.1 then
        if robot.range_and_bearing[1].range >= 20 then
            robot.wheels.set_velocity(12,12)
        else
            robot.wheels.set_velocity(0,0)
        end
    end
end


function reset()

end


function destroy()

end
