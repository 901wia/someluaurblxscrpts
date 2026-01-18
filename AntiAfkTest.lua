local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local plr=Players.LocalPlayer
local idled=plr.Idled
local getconnections=getconnections or get_signal_cons or nil
if not getconnections then return end
for _,conn in pairs(getconnections(idled))do
    if conn and conn.Disable then
        coroutine.wrap(function()
            pcall(function()conn:Disable()end)
        end)()
    end
end
local lastDisable=0
RunService.Heartbeat:Connect(function()
    if tick()-lastDisable>60 then
        if getconnections then
            for _,conn in pairs(getconnections(idled))do
                if conn and conn.Disable then
                    pcall(function()conn:Disable()end)
                end
            end
        end
        lastDisable=tick()
    end
end)
