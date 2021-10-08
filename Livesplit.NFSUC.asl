state("nfs") 
{
    int loading: "nfs.exe",0xF33FEC, 0x4C0;
    byte loadingEverything: "nfs.exe", 0x9A530C;
}  

init
{

}

start
{
    return current.loadingEverything == 96;
}

isLoading 
{
    return current.loadingEverything != 0;
}

exit
{
    timer.IsGameTimePaused = false;
}