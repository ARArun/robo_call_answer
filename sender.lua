msg={1,2,3,4,5,6,7,8,9,10}
count = 0
function init()

end


function step()
    count = count + 1
    if count >= 5 then
        robot.range_and_bearing.set_data(msg)
    end
end


function reset()

end


function destroy()

end
