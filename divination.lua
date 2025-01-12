-- Modified version of AIO Divination by JCurtis
-- Original Author: JCurtis
-- Modified by Goblins to remove long sleeps, remove gui, add inventory check, add timeout, add random events

local API = require("api")
local UTILS = require("utils")

local player = API.GetLocalPlayerName()
local npcs = {
    18150,
    18151,
    18153,
    18155,
    18157,
    18159,
    18161
}
local timeout = os.time() + 300
local idle_time = os.time()


local function idle()
    if os.time() > idle_time then
        print("idle")
        API.PIdle2()
        idle_time = os.time() + math.random(60, 250)
    end
end


while API.Read_LoopyLoop() do
    if not API.InventoryInterfaceCheckvarbit() then
        print("Opening inventory")
        API.DoAction_Interface(0xc2,0xffffffff,1,1431,0,9,5392)
    end

    if API.InvFull_() then
        API.DoAction_Object1(0xc8,0,{ 93489 },50)
        API.DoAction_Object1(0xc8,0,{ 87306 },50)
        timeout = os.time() + 300
        API.RandomSleep2(600, 0, 600)
    end

    if not API.IsPlayerAnimating_(player, 100) and (not API.InvFull_()) then
        print("Harvest")
        API.DoAction_NPC(0xc8, 3120, npcs, 50)
    end

    if os.time() > timeout then
        print("Timeout")
        API.Write_LoopyLoop(false)
        return
    end

    idle()
    API.DoRandomEvents()
end