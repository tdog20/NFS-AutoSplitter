state("SPEED2")
{
    //Representing the name of the Scene
    string7 fmvName : 0x4382A0;

	// 0 = Main menu
	// 1 = Freeroam or inside a race
	// 2 = Drag Race 
    // 3 = Winner Endscreen
    int raceState : 0x49CE00;
    
	//0 not playing and 1 is playing
	bool fmvPlaying : 0x4383AC;

    //ingame 1 loading 0
    int loading: 0x432E58;

    // 1 = Inside a tuning shop
    // 0 = Not in a tuning shop
    int inAShop : 0x438980;

    // 2 = Star Event
    // 0 = no Event
    int starEvent : 0x438578;
    
    //obsolete, but still here if something happens
    int loadingScreen2: "SPEED2.EXE", 0x432FA8;	//ingame 1 loading 0
    int loadingScreen3: "SPEED2.EXE", 0x463774;	//ingame 2 loading 3
    int loadingScreen4: "SPEED2.EXE", 0x465498;	//ingame 0 loading 1 bad value, because it flickers between 0 and 1 sometimes while loading
    int loadingScreen5: "SPEED2.EXE", 0x46E778;	//ingame 1 loading 0
    int loadingScreen6: "SPEED2.EXE", 0x46E794;	//ingame 1 loading 0
}

startup
{
    settings.Add("Stage1EndSplit", false, "Splits when the finishing cutscene of Stage 1 is playing")
}

start
{
	return current.fmvName == "scene01" && current.fmvPlaying && !old.fmvPlaying;
}

split 
{
    //First Drive to the Car Lot
    if(current.fmvName == "SCENE05" && current.fmvPlaying && !old.fmvPlaying){
        return true;
    }
    //First Drive to the Garage
    else if(current.fmvName == "SCENE06" && current.fmvPlaying && !old.fmvPlaying) {
        return true;
    }
    else if(settings["Stage1EndSplit"]) {
        if(current.fmvName == "Scene07" && current.fmvPlaying && !old.fmvPlaying) {
            return true;
        }
        return false;
    }
    // Split for normal races
    else if(current.raceState == 3 && old.raceState == 1) {
        return true;
    }
    // Split for drag races
    else if(current.raceState == 3 && old.raceState == 2) {
        return true;
    }
    // Split for star events
    else if(old.starEvent == 2 && current.starEvent == 0) {
        return true;
    }
    else {
        return false;
    }
}

isLoading
{
    return current.loading == 0 && !current.fmvPlaying;
}

exit
{
	timer.IsGameTimePaused = false;
}