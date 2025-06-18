//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.july.party.JulyParty_InterfaceOverrides
    {
        function JulyParty_InterfaceOverrides () {
        }
        function init() {
        }
        function showCrosshair() {
            var _local_3 = this;
            var _local_4 = _global.getCurrentParty();
            _local_4.JulyParty.pebug("OVERRIDES showCrosshair");
            _local_4.JulyParty.pebug("_party.JulyParty.isSnowballEnabled " + _local_4.JulyParty.isSnowballEnabled);
            _local_3.CROSSHAIR._visible = true;
            _local_3.CROSSHAIR.startDrag(true, 20, 20, 740, 440);
            _local_3.CROSSHAIR._x = _local_3._xmouse;
            _local_3.CROSSHAIR._y = _local_3._ymouse;
            _local_3.CROSSHAIR.target_btn.onRelease = com.clubpenguin.util.Delegate.create(this, doCrossHairRelease);
            if (!_local_4.JulyParty.isSnowballEnabled) {
                _local_4.JulyParty.pebug("Snowball is currently not enabled " + _local_4.JulyParty.snowballCoolDownRemainderPercentage);
                _local_3.CROSSHAIR.gotoAndStop("deactive");
                _local_3.CROSSHAIR.timer.gotoAndPlay(_local_4.JulyParty.snowballCoolDownRemainerPercentage);
                _local_3.CROSSHAIR.target_btn.onRelease = com.clubpenguin.util.Delegate.create(this, doCrossHairRelease, false);
            } else {
                _local_4.JulyParty.pebug("Snowball is currently enabled");
                _local_3.CROSSHAIR.gotoAndStop("active");
                _local_3.CROSSHAIR.target_btn.onRelease = com.clubpenguin.util.Delegate.create(this, doCrossHairRelease, true);
            }
            _local_3.snowballCrosshairShown.dispatch();
        }
        function doCrossHairRelease(active) {
            var _local_2 = this;
            var _local_5 = Math.round((_local_2.CROSSHAIR._x + random(20)) - 10);
            var _local_4 = Math.round((_local_2.CROSSHAIR._y + random(20)) - 10);
            _local_2.sendThrowBall(_local_5, _local_4);
            _local_2.stopDrag();
            _local_2.CROSSHAIR._y = -100;
            _local_2.CROSSHAIR._visible = false;
            Selection.setFocus(null);
            var _local_3 = com.clubpenguin.world.rooms2015.july.party.JulyParty.localPlayerAvatarID;
            if (_local_3 == com.clubpenguin.world.rooms2015.july.party.JulyParty.CONSTANTS.TRANSFORMATION_ID_BINGBONG) {
                com.clubpenguin.world.rooms2015.july.party.JulyPartySounds.playBingBongSnowballThrow();
            }
            if (_local_3 == com.clubpenguin.world.rooms2015.july.party.JulyParty.CONSTANTS.TRANSFORMATION_ID_UNICORN) {
                com.clubpenguin.world.rooms2015.july.party.JulyPartySounds.playRainbowUnicornSnowballThrow();
            }
        }
        function updateAvatarCard(player_ob) {
            com.clubpenguin.party.BaseParty.pebug("PARTY updateAvatarCard");
            var _local_2 = this;
            var _local_3 = player_ob.avatarVO;
            if (_local_3.hasCustomPlayerCard) {
                _local_2.PLAYER_WIDGET.art_mc.avatarCard._visible = true;
                if (_local_3.dynamicPlayerCardLabelFunc != null) {
                    _local_2.PLAYER_WIDGET.art_mc.avatarCard.gotoAndStop(_local_3.dynamicPlayerCardLabelFunc(player_ob));
                } else {
                    _local_2.PLAYER_WIDGET.art_mc.avatarCard.gotoAndStop("id" + player_ob.avatarVO.avatar_id);
                }
                if (_local_2.PLAYER_WIDGET.art_mc.avatarCard.avatarClip._totalFrames > 1) {
                    _local_2.PLAYER_WIDGET.art_mc.avatarCard.avatarClip.gotoAndStop(player_ob.colour_id + 1);
                }
                if (player_ob.player_id == _local_2.SHELL.getMyPlayerId()) {
                    _local_2.PLAYER_WIDGET.art_mc.avatarCard.blockerBackground.useHandCursor = false;
                    _local_2.PLAYER_WIDGET.art_mc.avatarCard.blockerBackground.onRelease = function () {
                    };
                    _local_2.PLAYER_WIDGET.art_mc.avatarCard.blockerBackground._visible = true;
                    _local_2.closePlayerWidgetTab();
                    _local_2.PLAYER_WIDGET.art_mc.tab_btn._visible = false;
                } else {
                    _local_2.PLAYER_WIDGET.art_mc.avatarCard.blockerBackground._visible = false;
                }
            }
            if (_local_2.SHELL.isMyPlayer(player_ob.player_id)) {
                if (_local_3.canRevertToDefault || (!_local_3.attributes.equalsDefault())) {
                    _local_2.PLAYER_WIDGET.art_mc.revertAvatar_btn._visible = true;
                    _local_2.PLAYER_WIDGET.art_mc.revertAvatar_btn.onRelease = com.clubpenguin.util.Delegate.create(this, revertAvatar);
                } else {
                    _local_2.PLAYER_WIDGET.art_mc.revertAvatar_btn._visible = false;
                }
                if (com.clubpenguin.world.rooms2015.july.party.JulyParty.isActive) {
                    _local_2.PLAYER_WIDGET.art_mc.bingbong_mc._visible = false;
                    _local_2.PLAYER_WIDGET.art_mc.rainbow_unicorn_mc._visible = false;
                    var _local_5 = _local_2.SHELL.getPlayerObjectById(_local_2.SHELL.getMyPlayerId()).avatarVO.avatar_id;
                    if (_local_5 == com.clubpenguin.world.rooms2015.july.party.JulyParty.CONSTANTS.TRANSFORMATION_ID_BINGBONG) {
                        _local_2.PLAYER_WIDGET.art_mc.bingbong_mc._visible = true;
                    } else if (_local_5 == com.clubpenguin.world.rooms2015.july.party.JulyParty.CONSTANTS.TRANSFORMATION_ID_UNICORN) {
                        _local_2.PLAYER_WIDGET.art_mc.rainbow_unicorn_mc._visible = true;
                    }
                }
            }
        }
        function revertAvatar() {
            var _local_2 = this;
            _local_2.hideAvatarCardElements();
            _local_2.PLAYER_WIDGET.art_mc.close_btn.onRelease();
            _local_2.disableSpecialDance();
            _local_2.disableSpecialWave();
            _local_2.ENGINE.avatarManager.transformationManager.sendTransformPlayer(0);
            com.clubpenguin.world.rooms2015.july.party.JulyParty.sendUnTransformBI();
        }
    }
