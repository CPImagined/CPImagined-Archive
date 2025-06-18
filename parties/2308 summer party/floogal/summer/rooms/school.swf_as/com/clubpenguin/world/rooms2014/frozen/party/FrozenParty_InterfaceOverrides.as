dynamic class com.clubpenguin.world.rooms2014.frozen.party.FrozenParty_InterfaceOverrides
{
    var defaultDoCrossHairRelease;
    var defaultSendEmote;
    var defaultShowCrosshair;

    function FrozenParty_InterfaceOverrides()
    {
    }

    function partyIconOnRelease()
    {
        com.clubpenguin.party.BaseParty.openQuestUI();
        _global.getCurrentInterface().PARTY_ICON.collectedSparkles.gotoAndStop(1);
    }

    function init()
    {
        this.defaultDoCrossHairRelease = _global.getCurrentInterface().doCrossHairRelease;
        this.defaultSendEmote = _global.getCurrentInterface().sendEmote;
        this.defaultShowCrosshair = _global.getCurrentInterface().showCrosshair;
        this.defaultDoCrossHairRelease = _global.getCurrentInterface().doCrossHairRelease;
    }

    function addAirtowerListeners()
    {
    }

    function removeAirtowerListeners()
    {
    }

    function updateAvatarCard(player_ob)
    {
        _global.getCurrentParty().BaseParty.pebug("PARTY updateAvatarCard");
        var __reg3 = this;
        var __reg4 = player_ob.avatarVO;
        if (__reg4.hasCustomPlayerCard) 
        {
            __reg3.PLAYER_WIDGET.art_mc.avatarCard._visible = true;
            if (__reg4.dynamicPlayerCardLabelFunc == null) 
            {
                __reg3.PLAYER_WIDGET.art_mc.avatarCard.gotoAndStop("id" + player_ob.avatarVO.avatar_id);
            }
            else 
            {
                __reg3.PLAYER_WIDGET.art_mc.avatarCard.gotoAndStop(__reg4.dynamicPlayerCardLabelFunc(player_ob));
            }
            if (__reg3.PLAYER_WIDGET.art_mc.avatarCard.avatarClip._totalFrames > 1) 
            {
                __reg3.PLAYER_WIDGET.art_mc.avatarCard.avatarClip.gotoAndStop(player_ob.colour_id + 1);
            }
            if (player_ob.player_id == __reg3.SHELL.getMyPlayerId()) 
            {
                __reg3.PLAYER_WIDGET.art_mc.avatarCard.blockerBackground.useHandCursor = false;
                __reg3.PLAYER_WIDGET.art_mc.avatarCard.blockerBackground.onRelease = function ()
                {
                }
                ;
                __reg3.PLAYER_WIDGET.art_mc.avatarCard.blockerBackground._visible = true;
                __reg3.closePlayerWidgetTab();
                __reg3.PLAYER_WIDGET.art_mc.tab_btn._visible = false;
            }
            else 
            {
                __reg3.PLAYER_WIDGET.art_mc.avatarCard.blockerBackground._visible = false;
            }
        }
        if (__reg3.SHELL.isMyPlayer(player_ob.player_id)) 
        {
            if (__reg4.canRevertToDefault || !__reg4.attributes.equalsDefault()) 
            {
                __reg3.PLAYER_WIDGET.art_mc.revertAvatar_btn._visible = true;
                __reg3.PLAYER_WIDGET.art_mc.revertAvatar_btn.onRelease = com.clubpenguin.util.Delegate.create(this, this.revertAvatar);
            }
            else 
            {
                __reg3.PLAYER_WIDGET.art_mc.revertAvatar_btn._visible = false;
            }
            if (_global.getCurrentParty().FrozenParty.isActive) 
            {
                __reg3.PLAYER_WIDGET.art_mc.marshmallow_mc._visible = false;
                __reg3.PLAYER_WIDGET.art_mc.olaf_mc._visible = false;
                var __reg6 = __reg3.SHELL.getPlayerObjectById(__reg3.SHELL.getMyPlayerId()).avatarVO.avatar_id;
                if (__reg6 == _global.getCurrentParty().FrozenParty.CONSTANTS.OLAF_TRANSFORMATION_ID) 
                {
                    __reg3.PLAYER_WIDGET.art_mc.olaf_mc._visible = true;
                }
                if (__reg6 == _global.getCurrentParty().FrozenParty.CONSTANTS.MARSHMALLOW_TRANSFORMATION_ID) 
                {
                    __reg3.PLAYER_WIDGET.art_mc.marshmallow_mc._visible = true;
                }
            }
        }
    }

    function revertAvatar()
    {
        var __reg3 = this;
        __reg3.hideAvatarCardElements();
        __reg3.PLAYER_WIDGET.art_mc.close_btn.onRelease();
        __reg3.disableSpecialDance();
        __reg3.disableSpecialWave();
        __reg3.ENGINE.avatarManager.transformationManager.sendTransformPlayer(0);
        _global.getCurrentParty().FrozenParty.sendUnTransformBI();
    }

    function doCrossHairRelease(active)
    {
        var __reg10 = this;
        var __reg4 = _global.getCurrentParty();
        var __reg7 = _global.getCurrentEngine();
        var __reg8 = _global.getCurrentShell();
        var __reg3 = _global.getCurrentInterface();
        var __reg5 = Math.round(__reg3.CROSSHAIR._x + Math.random(20) - 10);
        var __reg6 = Math.round(__reg3.CROSSHAIR._y + Math.random(20) - 10);
        __reg3.stopDrag();
        __reg3.CROSSHAIR._y = -100;
        __reg3.CROSSHAIR._visible = false;
        if (!__reg8.sendThrowEnabled || !__reg4.FrozenParty.isSnowballEnabled || __reg10.CROSSHAIR._currentFrame != 1) 
        {
            return undefined;
        }
        com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.playSnowballThrow();
        __reg7.setPlayerAction("throw");
        __reg7.snowballManager.throwBall(__reg8.getMyPlayerId(), __reg5, __reg6);
        if (__reg4.FrozenParty.hasFrozenPowers(__reg10.SHELL.getMyPlayerId())) 
        {
            var __reg9 = __reg7.getRoomMovieClip().room.getTargetAreaIdByPosition(__reg5, __reg6);
            if (__reg9 > 0 && __reg9 != undefined) 
            {
                __reg4.FrozenParty.sendUpdateRoomState(__reg9, __reg4.FrozenParty.CONSTANTS.FREEZE_STATE, __reg5, __reg6);
            }
            return undefined;
        }
        __reg8.sendThrowBall(__reg5, __reg6);
    }

    function sendEmote(emote_id)
    {
        var __reg7 = _global.getCurrentShell();
        var __reg5 = _global.getCurrentEngine();
        var __reg3 = _global.getCurrentParty();
        var __reg6 = this;
        __reg7.sendEmote(emote_id);
        __reg6.showEmoteBalloon(__reg6.getPlayerId(), emote_id);
        var __reg8 = __reg5.getPlayerMovieClip(__reg7.getMyPlayerId());
        var __reg4 = __reg5.getRoomMovieClip().room.getTargetAreaIdByPosition(__reg8._x, __reg8._y);
        if (__reg4 > 0 && __reg4 != undefined && emote_id == __reg3.FrozenParty.CONSTANTS.HEART_EMOTE_ID) 
        {
            __reg3.FrozenParty.sendUpdateRoomState(__reg4, __reg3.FrozenParty.CONSTANTS.THAW_STATE, 0, 0);
        }
    }

    function showCrosshair()
    {
        var __reg3 = this;
        var __reg4 = _global.getCurrentParty();
        __reg3.CROSSHAIR._visible = true;
        __reg3.CROSSHAIR.startDrag(true, 20, 20, 740, 440);
        __reg3.CROSSHAIR._x = __reg3._xmouse;
        __reg3.CROSSHAIR._y = __reg3._ymouse;
        __reg3.CROSSHAIR.target_btn.onRelease = com.clubpenguin.util.Delegate.create(this, this.doCrossHairRelease);
        if (__reg4.FrozenParty.isSnowballEnabled) 
        {
            __reg3.CROSSHAIR.gotoAndStop("active");
            __reg3.CROSSHAIR.target_btn.onRelease = com.clubpenguin.util.Delegate.create(this, this.doCrossHairRelease, true);
        }
        else 
        {
            __reg3.CROSSHAIR.gotoAndStop("deactive");
            var __reg5 = Math.round(__reg3.CROSSHAIR.timer._totalframes * (__reg4.FrozenParty.snowballCoolDownRemainderPercentage / 100));
            __reg3.CROSSHAIR.timer.gotoAndPlay(__reg5);
            __reg3.CROSSHAIR.target_btn.onRelease = com.clubpenguin.util.Delegate.create(this, this.doCrossHairRelease, false);
        }
        __reg3.snowballCrosshairShown.dispatch();
    }

    function destroy()
    {
    }

}
