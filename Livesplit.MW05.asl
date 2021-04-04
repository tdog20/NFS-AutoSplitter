state("speed", "v1.2") 
{
    //Describes the loading screen state
    int loadingScreen1 : "speed.exe", 0x510ED0;
    int loadingScreen2 : "speed.exe", 0x5112D0;

    //Displays the current state of the game and also helps with the loadless timer
	int gamestateID : "speed.exe" , 0x51CCB4;
}

state("speed", "v1.3")
{
    //Describes the loading screen state
    int loadingScreen1 : "speed.exe", 0x511F10;
    int loadingScreen2 : "speed.exe", 0x512310;

    //Displays the current state of the game and also helps with the loadless timer	 
    int gamestateID : "speed.exe", 0x51DCF4;		
}

startup
{
    settings.Add("30FPSVersion", false, "Sets the refresh rate of the timer to 30 FPS for slower PCs");
}

init
{
    //Original 1.2 speed.exe
    if(modules.First().ModuleMemorySize == 0x67F000)
	{
		version = "v1.2";
	}
    //Original 1.3 speed.exe
    else if(modules.First().ModuleMemorySize == 0x680000)
	{
		version = "v1.3";
	}
    //Cracked 1.3 speed.exe (RELOADED)
    else if(modules.First().ModuleMemorySize == 0x678E4E)
    {
        version = "v1.3";
    }

    if(settings["30FPSVersion"]) {
        refreshRate = 30;
    }
}

update 
{
    if(version == "") {
        return false;
    }
}

isLoading
{
    //Every normal loading screen
    if(current.loadingScreen1 == 32767 || current.loadingScreen2 == 24 || current.loadingScreen2 == 0 || current.gamestateID == 16) {
        return true;
    }
    //Special loading screen being: going to the safehouse with the golf and leaving the tuning shop for the first time
    else if(current.gamestateID == 32) {
        //Exclude FMVs from being counted to loadless
        if(current.loadingScreen2 == 34) {
            return false;
        }
        else {
            return true;
        }
    }
    else {
        return false;
    }  
}

exit
{
    timer.IsGameTimePaused = false;
}