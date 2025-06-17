class com.clubpenguin.engine.puffletreasure.mediator.PuffleTreasureDigMediator
{
    var _treasureFound, _SHELL, _ENGINE, _INTERFACE;
    function PuffleTreasureDigMediator(treasureFound)
    {
        _treasureFound = treasureFound;
        _treasureFound.add(onTreasureFound, this);
        _SHELL = _global.getCurrentShell();
        _ENGINE = _global.getCurrentEngine();
        _INTERFACE = _global.getCurrentInterface();
    } // End of the function
    function destroy()
    {
        _treasureFound.remove(onTreasureFound, this);
    } // End of the function
    function onTreasureFound(puffleTreasureVO)
    {
        _ENGINE.puffleTricks.cancelCurrentTrick(puffleTreasureVO.puffleId);
        var _loc9 = _ENGINE.getPlayerMovieClip(puffleTreasureVO.playerVO.player_id);
        if (puffleTreasureVO.isCoins())
        {
            if (_SHELL.isMyPlayer(puffleTreasureVO.playerVO.player_id))
            {
                _SHELL.sendAS3DisablePuffleTricksHUD();
                var _loc5 = puffleTreasureVO.quantity;
                if (!isNaN(_loc5))
                {
                    var _loc11 = Number(_SHELL.getMyPlayerTotalCoins()) + _loc5;
                    _SHELL.setMyPlayerTotalCoins(_loc11);
                } // end if
            } // end if
            puffleTreasureVO.assetURL = "";
        }
        else if (puffleTreasureVO.isFood())
        {
            if (_SHELL.isMyPlayer(puffleTreasureVO.playerVO.player_id))
            {
                _SHELL.sendAddPuffleCareItem(puffleTreasureVO.treasureId, puffleTreasureVO.quantity, true);
            } // end if
            var _loc10 = _SHELL.getPuffleHatCollection();
            var _loc12 = _loc10.getPuffleHatVO(puffleTreasureVO.treasureId);
            puffleTreasureVO.assetURL = _SHELL.getGlobalContentPath() + "puffle/care_icons/" + _loc12.assetLinkage;
        }
        else if (puffleTreasureVO.isFurniture())
        {
            puffleTreasureVO.assetURL = _SHELL.getGlobalContentPath() + "furniture/icons/" + puffleTreasureVO.treasureId + ".swf";
        }
        else if (puffleTreasureVO.isClothing())
        {
            if (_SHELL.isMyPlayer(puffleTreasureVO.playerVO.player_id) && !_SHELL.isItemInMyInventory(puffleTreasureVO.treasureId))
            {
                var _loc7 = _SHELL.getInventoryObjectById(puffleTreasureVO.treasureId);
                if (_loc7)
                {
                    var _loc8 = _SHELL.getMyInventoryArray();
                    _loc8.push(_loc7);
                } // end if
            } // end if
            puffleTreasureVO.assetURL = _SHELL.getGlobalContentPath() + "clothing/icons/" + puffleTreasureVO.treasureId + ".swf";
        } // end else if
        if (com.clubpenguin.world.rooms.common.triggers.PlayerAction.isPlayer(puffleTreasureVO.playerVO, com.clubpenguin.world.rooms.common.triggers.PlayerAction.WALKING_PUFFLE) && _ENGINE.puffleAvatarController.isPuffleVisible(puffleTreasureVO.playerVO.attachedPuffle.id))
        {
            var _loc3 = new com.clubpenguin.engine.puffletreasure.view.PuffleTreasureDigView();
            var _loc4 = _SHELL.getPath("w.puffle.sprite.dig");
            _loc4 = puffleTreasureVO.playerVO.attachedPuffle.getFormattedAssetURL(_loc4);
            var _loc6 = new Object();
            _loc6.playerId = puffleTreasureVO.playerVO.player_id;
            _SHELL.updateListeners(_SHELL.DISABLE_PUFFLE_DIG_SEARCH_EMOTE, _loc6);
            _loc3.digAnimationDone.addOnce(onDigAnimationDone, this);
            _loc3.playerMC = _loc9;
            _loc3.puffleTreasureVO = puffleTreasureVO;
            _loc3.playDigAnimation(_loc4);
        } // end if
    } // End of the function
    function onDigAnimationDone(view)
    {
        _SHELL.sendAS3EnablePuffleTricksHUD();
        var _loc2 = new Object();
        _loc2.playerId = view.puffleTreasureVO.playerVO.player_id;
        _SHELL.updateListeners(_SHELL.ENABLE_PUFFLE_DIG_SEARCH_EMOTE, _loc2);
        if (_SHELL.isMyPlayer(view.puffleTreasureVO.playerVO.player_id))
        {
            if (view.puffleTreasureVO.isFirstSuccessfulDig)
            {
                _INTERFACE.showContent("w.puffletreasure.dialog.firstsuccessfuldig");
            } // end if
        } // end if
    } // End of the function
} // End of Class
