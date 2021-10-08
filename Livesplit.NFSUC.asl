state("nfs") 
{
    byte loading: "nfs.exe", 0x9A530C;
}  

start
{
    return current.loading == 96;
}

isLoading 
{
    return current.loading != 0;
}

exit
{
    timer.IsGameTimePaused = false;
}