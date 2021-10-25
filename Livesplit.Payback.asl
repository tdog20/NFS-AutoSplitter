state("NeedForSpeedPayback")
{
    bool loading: 0x038660D0, 0x88, 0x0, 0x20, 0x28, 0x28, 0x8, 0x3E8; //248813B0 better
}

init
{

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