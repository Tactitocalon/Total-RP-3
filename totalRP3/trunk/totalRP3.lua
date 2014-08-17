--[[
	Total RP 3, by Telkostrasz (Kirin Tor - Eu/Fr)
--]]

-- Imports
local Globals = TRP3_API.globals;
local Log = TRP3_API.utils.log;

--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
-- LOADING SEQUENCE
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

-- Called when TRP3 is loaded.
function Globals.addon:OnInitialize()
	
end

-- Called upon PLAYER_LOGIN after all addons are loaded.
function Globals.addon:OnEnable()
	Log.log("OnEnable() START");
	Globals.build(); -- Get info we can't have earlier
	
	 -- Welcome \o/
	TRP3_API.utils.message.displayMessage(TRP3_API.locale.getText("GEN_WELCOME_MESSAGE"):format(Globals.version_display));
	
	TRP3_API.flyway.applyPatches(); -- Adapt saved variables structures between versions
	TRP3_API.module.init();
	TRP3_API.module.initModules(); -- Call the init callback on all modules
	
	-- Inits logic
	TRP3_API.locale.init();
	TRP3_API.communication.init();
	TRP3_API.communication.broadcast.init();
	TRP3_API.profile.init();
	TRP3_API.dashboard.init();
	TRP3_API.target.init();
	TRP3_API.navigation.init();
	TRP3_API.register.init();
	TRP3_API.popup.init();
	
	TRP3_API.events.fireEvent(TRP3_API.events.WORKFLOW_ON_LOAD);
	
	TRP3_API.module.startModules(); -- Call module callback for all modules (onInit)
	TRP3_API.module.onModuleStarted(); -- Call module callback for all modules (onLoaded)
	
	TRP3_API.navigation.menu.selectMenu("main_00_dashboard"); -- Select first menu
	
	TRP3_API.events.fireEvent(TRP3_API.events.WORKFLOW_ON_LOADED);
	TRP3_API.events.fireEvent(TRP3_API.events.WORKFLOW_ON_FINISH);
	
	Log.log("OnEnable() DONE");
end