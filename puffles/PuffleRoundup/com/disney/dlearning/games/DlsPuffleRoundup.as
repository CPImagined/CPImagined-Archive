class com.disney.dlearning.games.DlsPuffleRoundup
{
    function DlsPuffleRoundup()
    {
    } // End of the function
    function init(learnerID)
    {
    } // End of the function
    function startRoundup()
    {
    } // End of the function
    function stopRoundup()
    {
        if (_isInCorral)
        {
            this.stopCorral();
        } // end if
    } // End of the function
    function startCorral()
    {
        _isInCorral = true;
    } // End of the function
    function scoreCorral($score)
    {
        if ($score == NaN)
        {
            $score = 0;
        } // end if
    } // End of the function
    function sendGameScore(status, caught, coins, timer)
    {
    } // End of the function
    function stopCorral()
    {
        _isInCorral = false;
    } // End of the function
    function startInstruction_Screen()
    {
        __instructionsStarted = true;
    } // End of the function
    function stopInstruction_Screen()
    {
    } // End of the function
    function callbackFunc(obj)
    {
    } // End of the function
    var __Puffle_Roundup = "A4AFBDAE-B226-3C10-BEA5-5407587F37CF";
    var __Puffle_Roundup_Corral = "D24E0303-0265-5A30-991A-DDEEA843C6EF";
    var __Puffle_Roundup_Instruction_Screen = "1E907D63-E735-E517-904B-A67C7E4D3670";
    var __Puffle_Roundup_Game_Score = "63568CF0-2420-C0C7-9682-440E7BBE4FD8";
    var __instructionsStarted = false;
    var _isInCorral = false;
} // End of Class
