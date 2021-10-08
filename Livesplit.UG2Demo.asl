state("speed2demo") 
{
    //ingame 1 loading 0
    int loadingScreen: "speed2demo.exe", 0x425E68;

    //in a Race 1
    //Outside of a race 0
    int raceState: "speed2demo.exe", 0x491440;

    // 0 = Main menu
	// 1 = Freeroam or inside a race
	// 2 = Drag Race 
    // 3 = Winner Endscreen
    int finishedRace: "speed2demo.exe", 0x48FA90;

    //in a Shop or Main Menu 1
    //Outside of a shop 0
    int shopState: "speed2demo.exe", 0x3E9D40;
}

startup
{
    settings.Add("shopSplit", false, "Car Lot Split Settings");
    settings.Add("enterCarLot", false, "Split when you enter the Car Lot", "shopSplit");
    settings.Add("leaveCarLot", true, "Split when you leave the Car Lot", "shopSplit");
    settings.Add("enterRace", false, "Split when you enter a race");
    settings.Add("finishRace", true, "Split when you finish a race");
}

start
{
    return (old.loadingScreen == 1 && current.loadingScreen == 0) && (old.shopState == 1 && current.shopState == 0);
}

split
{
    if(settings["shopSplit"]) {
        if(settings["enterCarLot"]) {
            if(old.shopState == 0 && current.shopState == 1) {
                return true;
            }
        }
        if(settings["leaveCarLot"]) {
            if(old.shopState == 1 && current.shopState == 0) {
                return true;
            }
        }
    }
    if(settings["enterRace"]) {
        if(old.raceState == 0 && current.raceState == 1) {
            return true;
        }   
    }
    if(settings["finishRace"]) {
        if(old.finishedRace == 1 && current.finishedRace == 3) {
            return true;
        }
    }
}

isLoading
{
    return current.loadingScreen == 0;
}

exit
{
    timer.IsGameTimePaused = false;
}