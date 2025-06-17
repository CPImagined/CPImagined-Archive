class com.clubpenguin.puffleavatar.PuffleAvatarController
{
    var _SHELL, _ENGINE, _puffleAvatarMap;
    function PuffleAvatarController(shellMC, engineMC)
    {
        _SHELL = shellMC;
        _ENGINE = engineMC;
        _puffleAvatarMap = new Object();
        _SHELL.addListener(_SHELL.REMOVE_PLAYER, com.clubpenguin.util.Delegate.create(this, onRemovePlayer));
    } // End of the function
    function attachPuffle(playerObject)
    {
        if (playerObject.attachedPuffle != undefined && playerObject.attachedPuffle != null)
        {
            var _loc2 = playerObject.attachedPuffle;
            var _loc3 = _SHELL.getPath("w.puffle.sprite.walk");
            _loc3 = _loc2.getFormattedAssetURL(_loc3);
            var _loc4;
            if (_puffleAvatarMap[_loc2.id] == undefined || _puffleAvatarMap[_loc2.id] == null)
            {
                _loc4 = new com.clubpenguin.puffleavatar.PuffleAvatar(_loc2, _SHELL, _ENGINE);
                _puffleAvatarMap[_loc2.id] = _loc4;
            }
            else
            {
                _loc4 = _puffleAvatarMap[_loc2.id];
            } // end else if
            _loc4.loadPuffleAsset(_loc3, playerObject.player_id);
        } // end if
    } // End of the function
    function update()
    {
        for (var _loc2 in _puffleAvatarMap)
        {
            _puffleAvatarMap[_loc2].update();
        } // end of for...in
    } // End of the function
    function detachPuffle(puffleId)
    {
        this.destroyPuffleAvatar(puffleId);
    } // End of the function
    function getPuffleClip(puffleId)
    {
        if (this.puffleAvatarExists(puffleId))
        {
            return (_puffleAvatarMap[puffleId].getPuffleClip());
        }
        else
        {
            return (null);
        } // end else if
    } // End of the function
    function getPuffleAvatar(puffleId)
    {
        return (_puffleAvatarMap[puffleId]);
    } // End of the function
    function displayPuffleWidget(puffleId, widgetType, puffleItemId)
    {
        if (this.puffleAvatarExists(puffleId))
        {
            _puffleAvatarMap[puffleId].displayPuffleStatsWidget(widgetType, puffleItemId);
        } // end if
    } // End of the function
    function hidePuffle(puffleId)
    {
        if (this.puffleAvatarExists(puffleId))
        {
            _puffleAvatarMap[puffleId].hide();
        } // end if
    } // End of the function
    function showPuffle(puffleId)
    {
        if (this.puffleAvatarExists(puffleId))
        {
            _puffleAvatarMap[puffleId].show();
        } // end if
    } // End of the function
    function hideHat(puffleId)
    {
        if (this.puffleAvatarExists(puffleId))
        {
            _puffleAvatarMap[puffleId].hideHat();
        } // end if
    } // End of the function
    function showHat(puffleId)
    {
        if (this.puffleAvatarExists(puffleId))
        {
            _puffleAvatarMap[puffleId].showHat();
        } // end if
    } // End of the function
    function loadHat(puffleId, puffleHatVO)
    {
        if (this.puffleAvatarExists(puffleId))
        {
            _puffleAvatarMap[puffleId].loadPuffleHat(puffleHatVO);
        } // end if
    } // End of the function
    function unloadHat(puffleId)
    {
        if (this.puffleAvatarExists(puffleId))
        {
            _puffleAvatarMap[puffleId].unloadPuffleHat();
        } // end if
    } // End of the function
    function isPuffleVisible(puffleId)
    {
        if (this.puffleAvatarExists(puffleId))
        {
            return (_puffleAvatarMap[puffleId].isPuffleVisible());
        }
        else
        {
            return (false);
        } // end else if
    } // End of the function
    function getPuffleCanMove(puffleId)
    {
        if (this.puffleAvatarExists(puffleId))
        {
            return (_puffleAvatarMap[puffleId].puffleCanMove);
        }
        else
        {
            return (false);
        } // end else if
    } // End of the function
    function updatePuffleFrame(puffleId, frameNumber)
    {
        if (this.puffleAvatarExists(puffleId))
        {
            _puffleAvatarMap[puffleId].updatePuffleFrame(frameNumber);
        } // end if
    } // End of the function
    function getPuffleFrame(puffleId)
    {
        if (this.puffleAvatarExists(puffleId))
        {
            return (_puffleAvatarMap[puffleId].getPuffleFrame());
        }
        else
        {
            return (null);
        } // end else if
    } // End of the function
    function setFrameUpdateEnabled(puffleId, enable)
    {
        if (this.puffleAvatarExists(puffleId))
        {
            _puffleAvatarMap[puffleId].setFrameUpdateEnabled(enable);
        } // end if
    } // End of the function
    function addPuffleEffect(puffleId, effect)
    {
        if (this.puffleAvatarExists(puffleId))
        {
            _puffleAvatarMap[puffleId].loadPuffleEffect(effect);
        } // end if
    } // End of the function
    function onRemovePlayer(playerId)
    {
        var _loc2 = _SHELL.getPlayerObjectById(playerId);
        if (_loc2.attachedPuffle != undefined && _loc2.attachedPuffle != null)
        {
            this.destroyPuffleAvatar(_loc2.attachedPuffle.id);
        } // end if
    } // End of the function
    function puffleAvatarExists(puffleId)
    {
        return (_puffleAvatarMap[puffleId] != undefined && _puffleAvatarMap[puffleId] != null);
    } // End of the function
    function destroyPuffleAvatar(puffleId)
    {
        if (this.puffleAvatarExists(puffleId))
        {
            _puffleAvatarMap[puffleId].destroy();
            _puffleAvatarMap[puffleId] = null;
        } // end if
    } // End of the function
} // End of Class
