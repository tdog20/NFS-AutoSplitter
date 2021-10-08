/*  Original Loadless Remover done by Mr.Mary and now added Autosplitter
    by TDOG20. At the current state this only works for version 1.4,
    because its also the most stable version. */

state("NFSC")
{
    //Displays the current state in which the game is in
    int menuShit : 0x6980B8;
    
    //Displays the current fmv that is played
    string16 fmv : 0x697A88;

    //Displays the current NIS ID that is played
    string20 nisCutsceneID: 0x697AD0;

    //Displays if a race is finished (prevents splits when falling off the canyon)
    bool isFinished: 0x68A284;
}

startup
{
    vars.loadValues = new List<int>{0, 34, 40, 33, 5, 3, 4, 35};
}

split
{
    //Split for a finished race
    if(!old.isFinished && current.isFinished) {
        return true;
    }
    //Split for escaping Cross
    else if(current.nisCutsceneID == "ENDINGCAREER22" && old.nisCutsceneID != current.nisCutsceneID) {
        return true;
    }
    //Split for finishing the escape scene in the beginning of the game
    else if(current.nisCutsceneID == "ENDINGCAREER23NG" && old.nisCutsceneID != current.nisCutsceneID) {
        return true;
    }
    //Split for meeting Samson
    else if(current.fmv == "Seq06_SamsonFlas" && old.fmv != current.fmv) {
        return true;
    }
    //Split for meeting Yumi
    else if(current.fmv == "Seq08_YumiFlashb" && old.fmv != current.fmv) {
        return true;
    }
    //Split for meeting Colin
    else if(current.fmv == "Seq10_ColinFlash" && old.fmv != current.fmv) {
        return true;
    }
    //Split for meeting Darius
    else if(current.fmv == "Seq11_Reversal" && old.fmv != current.fmv) {
        return true;
    }
    else {
        return false;
    }
}

isLoading
{
    return vars.loadValues.Contains(current.menuShit);
}

start
{
    //only works if its a savefile with no progress
    if(old.menuShit == 11 && current.menuShit == 0) {
        return true;
    }
    else {
        return false;
    }
}

exit
{
    timer.IsGameTimePaused = false;
}