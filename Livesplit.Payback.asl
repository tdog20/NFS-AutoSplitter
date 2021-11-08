state("NeedForSpeedPayback")
{
    bool loading: 0x038660D0, 0x88, 0x0, 0x20, 0x28, 0x28, 0x8, 0x3E8; //248813B0 better
}

startup
{
    if(timer.CurrentTimingMethod == TimingMethod.RealTime) { //stolen from RICO, basically asks the runner to set their livesplit to game time
        var message = MessageBox.Show (
            "This game uses Time without Loads (Game Time) as the main\ntiming method. "+
            "Livesplit is currently set to show Real Time (RTA). Would you like to set "+
            "the timing method to Game\nTime, so the loadless timer works?",
            "Livesplit | NFS Payback",
            MessageBoxButtons.YesNo,MessageBoxIcon.Question
        );

        if(message == DialogResult.Yes) {
            timer.CurrentTimingMethod = TimingMethod.GameTime;
        }
    }
}

start
{
    if(!old.loading && current.loading) {
        return true;
    }
}

split
{

}

isLoading
{
    return current.loading;
}

exit
{
    timer.IsGameTimePaused = false;
}