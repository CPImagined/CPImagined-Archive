//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.may.party.MayParty_InterfaceOverrides
    {
        function MayParty_InterfaceOverrides () {
        }
        function init() {
            trace("MayParty_InterfaceOverrides init()");
        }
        function showCrosshair() {
            var _local_3 = this;
            var _local_4 = _global.getCurrentParty();
            _local_4.MayParty.pebug("OVERRIDES showCrosshair");
            _local_4.MayParty.pebug("_party.MayParty.isSnowballEnabled " + _local_4.MayParty.isSnowballEnabled);
            _local_3.CROSSHAIR._visible = true;
            _local_3.CROSSHAIR.startDrag(true, 20, 20, 740, 440);
            _local_3.CROSSHAIR._x = _local_3._xmouse;
            _local_3.CROSSHAIR._y = _local_3._ymouse;
            _local_3.CROSSHAIR.target_btn.onRelease = com.clubpenguin.util.Delegate.create(this, doCrossHairRelease);
            if (!_local_4.MayParty.isSnowballEnabled) {
                _local_4.MayParty.pebug("Snowball is currently not enabled " + _local_4.MayParty.snowballCoolDownRemainderPercentage);
                _local_3.CROSSHAIR.gotoAndStop("deactive");
                _local_3.CROSSHAIR.timer.gotoAndPlay(_local_4.MayParty.snowballCoolDownRemainerPercentage);
                _local_3.CROSSHAIR.target_btn.onRelease = com.clubpenguin.util.Delegate.create(this, doCrossHairRelease, false);
            } else {
                _local_4.MayParty.pebug("Snowball is currently enabled");
                _local_3.CROSSHAIR.gotoAndStop("active");
                _local_3.CROSSHAIR.target_btn.onRelease = com.clubpenguin.util.Delegate.create(this, doCrossHairRelease, true);
            }
            _local_3.snowballCrosshairShown.dispatch();
        }
        function doCrossHairRelease(active) {
            trace("JC: doCrossHairRelease");
            var _local_2 = _global.getCurrentInterface();
            var _local_4 = Math.round((_local_2.CROSSHAIR._x + random(20)) - 10);
            var _local_3 = Math.round((_local_2.CROSSHAIR._y + random(20)) - 10);
            if (active) {
                _local_2.sendThrowBall(_local_4, _local_3);
            }
            _local_2.stopDrag();
            _local_2.CROSSHAIR._y = -100;
            _local_2.CROSSHAIR._visible = false;
            Selection.setFocus(null);
        }
        function showMapIcon() {
            trace("HSF showMapIcon");
            var _this = this;
            if (_this.ICONS._visible == false) {
            }
            _this.MAP_ICON._visible = true;
            _this.mapIsVisible = true;
            var destination;
            if (com.clubpenguin.world.rooms2015.may.party.MayParty.isFairRoom) {
                destination = com.clubpenguin.world.rooms2015.may.party.MayParty.CONSTANTS.PARTY_MAP_PATH;
            }
            if (destination == null) {
                _this.MAP_ICON.gotoAndStop(1);
                destination = "map";
            }
            _this.MAP_ICON.map_btn.onRelease = function () {
                if (_this.SHELL._localLoginServerData.autoLogin) {
                    _this.SHELL.sendHideNewPlayerGuide();
                    _this.SHELL.sendAS2Clicked(_this.MAP_BUTTON);
                }
                trace("INTERFACE: party ID is " + _this.PARTY.PARTY_ID);
                _this.showContent(destination, null, null, null, true);
            };
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
                if (com.clubpenguin.world.rooms2015.may.party.MayParty.isActive) {
                    _local_2.PLAYER_WIDGET.art_mc.werewolf_mc._visible = false;
                    _local_2.PLAYER_WIDGET.art_mc.crab_mc._visible = false;
                    _local_2.PLAYER_WIDGET.art_mc.dragon_mc._visible = false;
                    _local_2.PLAYER_WIDGET.art_mc.robo_mc._visible = false;
                    var _local_4 = _local_2.SHELL.getPlayerObjectById(_local_2.SHELL.getMyPlayerId()).avatarVO.avatar_id;
                    if (_local_4 == com.clubpenguin.world.rooms2015.may.party.MayParty.CONSTANTS.TRANSFORMATION_ID_COYOTE) {
                        _local_2.PLAYER_WIDGET.art_mc.werewolf_mc._visible = true;
                    } else if (_local_4 == com.clubpenguin.world.rooms2015.may.party.MayParty.CONSTANTS.TRANSFORMATION_ID_CRAB) {
                        _local_2.PLAYER_WIDGET.art_mc.crab_mc._visible = true;
                    } else if (_local_4 == com.clubpenguin.world.rooms2015.may.party.MayParty.CONSTANTS.TRANSFORMATION_ID_DRAGON) {
                        _local_2.PLAYER_WIDGET.art_mc.dragon_mc._visible = true;
                    } else if (_local_4 == com.clubpenguin.world.rooms2015.may.party.MayParty.CONSTANTS.TRANSFORMATION_ID_ROBO) {
                        _local_2.PLAYER_WIDGET.art_mc.robo_mc._visible = true;
                    } else {
                        trace("CAN'T FIND THE CORRECT TRANSFORMATION!!!");
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
            com.clubpenguin.world.rooms2015.may.party.MayParty.sendUnTransformBI();
        }
    }
