class com.clubpenguin.world.rooms2014.frozen.party.FrozenParty_InterfaceOverrides
{
    var defaultDoCrossHairRelease, defaultSendEmote, defaultShowCrosshair;
    function FrozenParty_InterfaceOverrides()
    {
    } // End of the function
    function partyIconOnRelease()
    {
        com.clubpenguin.party.BaseParty.openQuestUI();
        _global.getCurrentInterface().PARTY_ICON.collectedSparkles.gotoAndStop(1);
    } // End of the function
    function init()
    {
        defaultDoCrossHairRelease = _global.getCurrentInterface().doCrossHairRelease;
        defaultSendEmote = _global.getCurrentInterface().sendEmote;
        defaultShowCrosshair = _global.getCurrentInterface().showCrosshair;
        defaultDoCrossHairRelease = _global.getCurrentInterface().doCrossHairRelease;
    } // End of the function
    function addAirtowerListeners()
    {
    } // End of the function
    function removeAirtowerListeners()
    {
    } // End of the function
    function updateAvatarCard(player_ob)
    {
        _global.getCurrentParty().BaseParty.pebug("PARTY updateAvatarCard");
        var _loc3 = this;
        var _loc4 = player_ob.avatarVO;
        if (_loc4.hasCustomPlayerCard)
        {
            _loc3.PLAYER_WIDGET.art_mc.avatarCard._visible = true;
            if (_loc4.dynamicPlayerCardLabelFunc != null)
            {
                _loc3.PLAYER_WIDGET.art_mc.avatarCard.gotoAndStop(_loc4.dynamicPlayerCardLabelFunc(player_ob));
            }
            else
            {
                _loc3.PLAYER_WIDGET.art_mc.avatarCard.gotoAndStop("id" + player_ob.avatarVO.avatar_id);
            } // end else if
            if (_loc3.PLAYER_WIDGET.art_mc.avatarCard.avatarClip._totalFrames > 1)
            {
                _loc3.PLAYER_WIDGET.art_mc.avatarCard.avatarClip.gotoAndStop(player_ob.colour_id + 1);
            } // end if
            if (player_ob.player_id == _loc3.SHELL.getMyPlayerId())
            {
                _loc3.PLAYER_WIDGET.art_mc.avatarCard.blockerBackground.useHandCursor = false;
                _loc3.PLAYER_WIDGET.art_mc.avatarCard.blockerBackground.onRelease = function ()
                {
                };
                _loc3.PLAYER_WIDGET.art_mc.avatarCard.blockerBackground._visible = true;
                _loc3.closePlayerWidgetTab();
                _loc3.PLAYER_WIDGET.art_mc.tab_btn._visible = false;
            }
            else
            {
                _loc3.PLAYER_WIDGET.art_mc.avatarCard.blockerBackground._visible = false;
            } // end if
        } // end else if
        if (_loc3.SHELL.isMyPlayer(player_ob.player_id))
        {
            if (_loc4.canRevertToDefault || !_loc4.attributes.equalsDefault())
            {
                _loc3.PLAYER_WIDGET.art_mc.revertAvatar_btn._visible = true;
                _loc3.PLAYER_WIDGET.art_mc.revertAvatar_btn.onRelease = com.clubpenguin.util.Delegate.create(this, revertAvatar);
            }
            else
            {
                _loc3.PLAYER_WIDGET.art_mc.revertAvatar_btn._visible = false;
            } // end else if
            if (_global.getCurrentParty().FrozenParty.isActive)
            {
                _loc3.PLAYER_WIDGET.art_mc.marshmallow_mc._visible = false;
                _loc3.PLAYER_WIDGET.art_mc.olaf_mc._visible = false;
                var _loc6 = _loc3.SHELL.getPlayerObjectById(_loc3.SHELL.getMyPlayerId()).avatarVO.avatar_id;
                if (_loc6 == _global.getCurrentParty().FrozenParty.CONSTANTS.OLAF_TRANSFORMATION_ID)
                {
                    _loc3.PLAYER_WIDGET.art_mc.olaf_mc._visible = true;
                } // end if
                if (_loc6 == _global.getCurrentParty().FrozenParty.CONSTANTS.MARSHMALLOW_TRANSFORMATION_ID)
                {
                    _loc3.PLAYER_WIDGET.art_mc.marshmallow_mc._visible = true;
                } // end if
            } // end if
        } // end if
    } // End of the function
    function revertAvatar()
    {
        var _loc3 = this;
        _loc3.hideAvatarCardElements();
        _loc3.PLAYER_WIDGET.art_mc.close_btn.onRelease();
        _loc3.disableSpecialDance();
        _loc3.disableSpecialWave();
        _loc3.ENGINE.avatarManager.transformationManager.sendTransformPlayer(0);
        _global.getCurrentParty().FrozenParty.sendUnTransformBI();
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.playTransformSFX();
    } // End of the function
    function doCrossHairRelease(active)
    {
        var _loc10 = this;
        var _loc8 = _global.getCurrentParty();
        var _loc9 = _global.getCurrentEngine();
        var _loc7 = _global.getCurrentShell();
        var _loc3 = _global.getCurrentInterface();
        var _loc5 = Math.round(_loc3.CROSSHAIR._x + Math.random(20) - 10);
        var _loc4 = Math.round(_loc3.CROSSHAIR._y + Math.random(20) - 10);
        _loc3.stopDrag();
        _loc3.CROSSHAIR._y = -100;
        _loc3.CROSSHAIR._visible = false;
        if (!_loc7.sendThrowEnabled || !_loc8.FrozenParty.isSnowballEnabled || _loc10.CROSSHAIR._currentFrame != 1)
        {
            return;
        } // end if
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.playSnowballThrow();
        _loc9.setPlayerAction("throw");
        _loc9.snowballManager.throwBall(_loc7.getMyPlayerId(), _loc5, _loc4);
        if (_loc8.FrozenParty.hasFrozenPowers(_loc10.SHELL.getMyPlayerId()))
        {
            var _loc6 = _loc9.getRoomMovieClip().room.getTargetAreaIdByPosition(_loc5, _loc4);
            if (_loc6 > 0 && _loc6 != undefined)
            {
                _loc8.FrozenParty.sendUpdateRoomState(_loc6, _loc8.FrozenParty.CONSTANTS.FREEZE_STATE, _loc5, _loc4);
            } // end if
        }
        else
        {
            _loc7.sendThrowBall(_loc5, _loc4);
        } // end else if
    } // End of the function
    function sendEmote(emote_id)
    {
        var _loc7 = _global.getCurrentShell();
        var _loc9 = _global.getCurrentEngine();
        var _loc4 = _global.getCurrentParty();
        var _loc8 = this;
        _loc7.sendEmote(emote_id);
        _loc8.showEmoteBalloon(_loc8.getPlayerId(), emote_id);
        var _loc5 = _loc9.getPlayerMovieClip(_loc7.getMyPlayerId());
        var _loc3 = _loc9.getRoomMovieClip().room.getTargetAreaIdByPosition(_loc5._x, _loc5._y);
        if (_loc3 > 0 && _loc3 != undefined && emote_id == _loc4.FrozenParty.CONSTANTS.HEART_EMOTE_ID)
        {
            _loc4.FrozenParty.sendUpdateRoomState(_loc3, _loc4.FrozenParty.CONSTANTS.THAW_STATE, 0, 0);
        } // end if
    } // End of the function
    function showCrosshair()
    {
        var _loc3 = this;
        var _loc4 = _global.getCurrentParty();
        _loc3.CROSSHAIR._visible = true;
        _loc3.CROSSHAIR.startDrag(true, 20, 20, 740, 440);
        _loc3.CROSSHAIR._x = _loc3._xmouse;
        _loc3.CROSSHAIR._y = _loc3._ymouse;
        _loc3.CROSSHAIR.target_btn.onRelease = com.clubpenguin.util.Delegate.create(this, doCrossHairRelease);
        if (!_loc4.FrozenParty.isSnowballEnabled)
        {
            _loc3.CROSSHAIR.gotoAndStop("deactive");
            var _loc5 = Math.round(_loc3.CROSSHAIR.timer._totalframes * (_loc4.FrozenParty.snowballCoolDownRemainderPercentage / 100));
            _loc3.CROSSHAIR.timer.gotoAndPlay(_loc5);
            _loc3.CROSSHAIR.target_btn.onRelease = com.clubpenguin.util.Delegate.create(this, doCrossHairRelease, false);
        }
        else
        {
            _loc3.CROSSHAIR.gotoAndStop("active");
            _loc3.CROSSHAIR.target_btn.onRelease = com.clubpenguin.util.Delegate.create(this, doCrossHairRelease, true);
        } // end else if
        _loc3.snowballCrosshairShown.dispatch();
    } // End of the function
    function destroy()
    {
    } // End of the function
} // End of Class
