class com.clubpenguin.world.rooms.common.paperdoll.PaperDollGenerator
{
    function PaperDollGenerator(stage, shell, paperDollContainer)
    {
        _stage = stage;
        _SHELL = shell;
        _paperDollContainer = paperDollContainer;
    } // End of the function
    function clearPaperDoll()
    {
        _paperDoll.clear();
    } // End of the function
    function drawPaperDoll(playerID)
    {
        this.clearPaperDoll();
        _playerID = playerID;
        _paperDollContainer.swapDepths(_stage.getNextHighestDepth());
        var _loc6 = _stage.paper_doll_mc;
        var _loc2 = _SHELL.getPlayerObjectById(_playerID);
        var _loc5 = _paperDollContainer.paper_doll_mc;
        var _loc4 = _paperDollContainer.flag_mc;
        var _loc3 = _paperDollContainer.photo_mc;
        _paperDoll = new com.clubpenguin.ui.PaperDoll(_playerID);
        _paperDoll.__set__paperDollClip(_loc5);
        _paperDoll.__set__shell(_SHELL);
        _paperDoll.__set__isInteractive(false);
        _paperDoll.__set__fadeAfterLoad(false);
        _paperDoll.__set__backgroundClip(_loc3);
        _paperDoll.__set__flagClip(_loc4);
        this.updateBackground(_loc2);
        this.dressPaperDoll(_loc2);
    } // End of the function
    function updateBackground(playerObject)
    {
        var _loc3 = playerObject.colour_id;
        var _loc4 = playerObject.photo_id;
        var _loc5 = playerObject.flag_id;
        _paperDoll.__set__colourID(_loc3);
    } // End of the function
    function dressPaperDoll(playerObject)
    {
        for (var _loc3 in _SHELL.PAPERDOLL_DEFAULT_LAYER_DEPTHS)
        {
            _paperDoll.addItem(_loc3, playerObject[_loc3]);
        } // end of for...in
    } // End of the function
    var _paperDollContainer = null;
    var _paperDoll = null;
    var _stage = null;
    var _SHELL = null;
    var _playerID = 0;
} // End of Class
