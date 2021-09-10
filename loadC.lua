local sx, sy = guiGetScreenSize()
local x, y = (sx/1366), (sy/768)
local resourceRoot = getResourceRootElement(getThisResource())
local screenWidth, screenHeight = guiGetScreenSize()
local myScreenSource = dxCreateScreenSource(screenWidth, screenHeight)
local root = getRootElement()
local rote = 0
local musica = true
local Tipo = nil
local pLife = {}
local AlphaAB = 0

function pLife.iniciarLoadingScreen()
    PlayMusicLoandig = playSound("olds/sound/music.mp3", true)
    Tipo = "Play"
	setSoundVolume(PlayMusicLoandig,1.0)
	showCursor(true)
	showChat(false)
	addEventHandler("onClientRender", root, pLife.MenuDxLoad)
end
addEventHandler("onClientResourceStart", resourceRoot, pLife.iniciarLoadingScreen)

function pLife.fimLoandingScreen()    
    if isTransferBoxActive() == true then
        setTimer(pLife.fimLoandingScreen, 2000, 1)
    else 
        removeEventHandler("onClientRender", root, pLife.MenuDxLoad)
		destroyElement(PlayMusicLoandig)
		showCursor(false)
		showChat(true)
		musica = false
    end
end
setTimer(pLife.fimLoandingScreen, 2000, 1)

pLife = {}
pLife["img"] = 1
pLife["timer"] = setTimer(function()
	pLife["img"] = 1 and 2
end, 40000, 0)

function pLife.MenuDxLoad()
	rote = rote +12/8
    local seconds = getTickCount() / 6000
    local scale = math.sin(seconds) * 1
    local seconds2 = getTickCount() / 4000
    local scale2 = math.sin(seconds2) * 1
	local rotation2 = 0
	local AnimStouro = getSoundFFTData(PlayMusicLoandig, 2048, 2)
	for i,v in pairs(AnimStouro) do
		rotation1 = math.round((v*530),0)
		rotation2 = math.round((v*430),0) + 7
	end

	AlphaAB = AlphaAB + 0.4
    if AlphaAB >= 255 then 
    	AlphaAB = 255
    end

		dxDrawImage(x*0, y*0, x*1366, y*768, "olds/images/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		dxDrawImage(x*0, y*0, x*1366, y*768, "olds/images/lights.png", 0, 0, 0, tocolor(255, 255, 255, 0*rotation1+rotation2), false)

        dxDrawImage(x*630/scale, y*280, x*94, y*160, "olds/images/logo.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(x*580, y*240/scale, x*117, y*90, "olds/images/coroa.png", 330, 0, 0, tocolor(255, 255, 255, 255), false)

        dxDrawImage(x*30, y*205, x*17, y*34, "olds/images/pausa.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(x*72, y*205, x*32, y*34, "olds/images/play.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)

        if Tipo == "Pausa" then
        	dxDrawImage(x*30, y*205, x*17, y*34, "olds/images/pausa.png", 0, 0, 0, tocolor(0, 111, 255, 255), false)
        elseif Tipo == "Play" then
        	dxDrawImage(x*72, y*205, x*32, y*34, "olds/images/play.png", 0, 0, 0, tocolor(0, 111, 255, 255), false)
    	end

    	dxDrawImage(x*-24/scale2, y*163, x*441, y*636, "olds/images/"..pLife["img"]..".png", 0, 0, 0, tocolor(255, 255, 255, AlphaAB), false)
        
        dxDrawImage(x*623, y*627, x*100, y*100, "olds/images/load.png", rote, 0, 0, tocolor(255, 255, 255, 255), false)
end

addEventHandler('onClientClick', root, function(button, state, _, _, _, _, _, element)
	if button == 'left' and state == 'down' and musica then 
		if cursorPosition(x*30, y*205, x*17, y*34) then
			setSoundPaused(PlayMusicLoandig, true)
			Tipo = "Pausa"
		elseif cursorPosition(x*72, y*205, x*32, y*34) then
			setSoundPaused(PlayMusicLoandig, false)
			Tipo = "Play"
		end
	end
end)

function pLife.OnStop ()
    setPlayerHudComponentVisible("armour", true)
    setPlayerHudComponentVisible("wanted", true)
    setPlayerHudComponentVisible("weapon", true)
    setPlayerHudComponentVisible("money", true)
    setPlayerHudComponentVisible("health", true)
    setPlayerHudComponentVisible("clock", true)
    setPlayerHudComponentVisible("breath", true)
    setPlayerHudComponentVisible("ammo", true)
    setPlayerHudComponentVisible("radar", true)
end
addEventHandler("onClientResourceStop", getResourceRootElement(getThisResource()), pLife.OnStop)
function pLife.OnStart ()
    setPlayerHudComponentVisible("armour", false)
    setPlayerHudComponentVisible("wanted", false)
    setPlayerHudComponentVisible("weapon", false)
    setPlayerHudComponentVisible("money", false)
    setPlayerHudComponentVisible("health", false)
    setPlayerHudComponentVisible("clock", false)
    setPlayerHudComponentVisible("breath", false)
    setPlayerHudComponentVisible("ammo", false)
    setPlayerHudComponentVisible("radar", false)
end
addEventHandler( "onClientResourceStart", getResourceRootElement(getThisResource()), pLife.OnStart )