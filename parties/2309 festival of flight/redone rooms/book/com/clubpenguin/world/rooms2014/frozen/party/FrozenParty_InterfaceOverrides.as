//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.frozen.party.FrozenParty_InterfaceOverrides
    {
        var defaultDoCrossHairRelease, defaultSendEmote, defaultShowCrosshair;
        function FrozenParty_InterfaceOverrides () {
        }
        function partyIconOnRelease() {
            com.clubpenguin.party.BaseParty.openQuestUI();
            _global.getCurrentInterface().PARTY_ICON.collectedSparkles.gotoAndStop(1);
        }
        function init() {
            defaultDoCrossHairRelease = _global.getCurrentInterface().doCrossHairRelease;
            defaultSendEmote = _global.getCurrentInterface().sendEmote;
            defaultShowCrosshair = _global.getCurrentInterface().showCrosshair;
            defaultDoCrossHairRelease = _global.getCurrentInterface().doCrossHairRelease;
        }
        function addAirtowerListeners() {
        }
        function removeAirtowerListeners() {
        }
        function updateAvatarCard(player_ob) {
            _global.getCurrentParty().BaseParty.pebug("PARTY updateAvatarCard");
            var _local_3 = this;
            var _local_4 = player_ob.avatarVO;
            if (_local_4.hasCustomPlayerCard) {
                _local_3.PLAYER_WIDGET.art_mc.avatarCard._visible = true;
                if (_local_4.dynamicPlayerCardLabelFunc != null) {
                    _local_3.PLAYER_WIDGET.art_mc.avatarCard.gotoAndStop(_local_4.dynamicPlayerCardLabelFunc(player_ob));
                } else {
                    _local_3.PLAYER_WIDGET.art_mc.avatarCard.gotoAndStop("id" + player_ob.avatarVO.avatar_id);
                }
                if (_local_3.PLAYER_WIDGET.art_mc.avatarCard.avatarClip._totalFrames > 1) {
                    _local_3.PLAYER_WIDGET.art_mc.avatarCard.avatarClip.gotoAndStop(player_ob.colour_id + 1);
                }
                if (player_ob.player_id == _local_3.SHELL.getMyPlayerId()) {
                    _local_3.PLAYER_WIDGET.art_mc.avatarCard.blockerBackground.useHandCursor = false;
                    _local_3.PLAYER_WIDGET.art_mc.avatarCard.blockerBackground.onRelease = function () {
                    };
                    _local_3.PLAYER_WIDGET.art_mc.avatarCard.blockerBackground._visible = true;
                    _local_3.closePlayerWidgetTab();
                    _local_3.PLAYER_WIDGET.art_mc.tab_btn._visible = false;
                } else {
                    _local_3.PLAYER_WIDGET.art_mc.avatarCard.blockerBackground._visible = false;
                }
            }
            if (_local_3.SHELL.isMyPlayer(player_ob.player_id)) {
                if (_local_4.canRevertToDefault || (!_local_4.attributes.equalsDefault())) {
                    _local_3.PLAYER_WIDGET.art_mc.revertAvatar_btn._visible = true;
                    _local_3.PLAYER_WIDGET.art_mc.revertAvatar_btn.onRelease = com.clubpenguin.util.Delegate.create(this, revertAvatar);
                } else {
                    _local_3.PLAYER_WIDGET.art_mc.revertAvatar_btn._visible = false;
                }
                if (_global.getCurrentParty().FrozenParty.isActive) {
                    _local_3.PLAYER_WIDGET.art_mc.marshmallow_mc._visible = false;
                    _local_3.PLAYER_WIDGET.art_mc.olaf_mc._visible = false;
                    var _local_6 = _local_3.SHELL.getPlayerObjectById(_local_3.SHELL.getMyPlayerId()).avatarVO.avatar_id;
                    if (_local_6 == _global.getCurrentParty().FrozenParty.CONSTANTS.OLAF_TRANSFORMATION_ID) {
                        _local_3.PLAYER_WIDGET.art_mc.olaf_mc._visible = true;
                    }
                    if (_local_6 == _global.getCurrentParty().FrozenParty.CONSTANTS.MARSHMALLOW_TRANSFORMATION_ID) {
                        _local_3.PLAYER_WIDGET.art_mc.marshmallow_mc._visible = true;
                    }
                }
            }
        }
        function revertAvatar() {
            var _local_3 = this;
            _local_3.hideAvatarCardElements();
            _local_3.PLAYER_WIDGET.art_mc.close_btn.onRelease();
            _local_3.disableSpecialDance();
            _local_3.disableSpecialWave();
            _local_3.ENGINE.avatarManager.transformationManager.sendTransformPlayer(0);
            _global.getCurrentParty().FrozenParty.sendUnTransformBI();
        }
        function doCrossHairRelease(active) {
            var _local_10 = this;
            var _local_8 = _global.getCurrentParty();
            var _local_9 = _global.getCurrentEngine();
            var _local_7 = _global.getCurrentShell();
            var _local_3 = _global.getCurrentInterface();
            var _local_5 = Math.round((_local_3.CROSSHAIR._x + Math.random(20)) - 10);
            var _local_4 = Math.round((_local_3.CROSSHAIR._y + Math.random(20)) - 10);
            _local_3.stopDrag();
            _local_3.CROSSHAIR._y = -100;
            _local_3.CROSSHAIR._visible = false;
            if (((!_local_7.sendThrowEnabled) || (!_local_8.FrozenParty.isSnowballEnabled)) || (_local_10.CROSSHAIR._currentFrame != 1)) {
                return(undefined);
            }
            com.clubpenguin.world.rooms2014.frozen.party.FrozenPartySounds.playSnowballThrow();
            _local_9.setPlayerAction("throw");
            _local_9.snowballManager.throwBall(_local_7.getMyPlayerId(), _local_5, _local_4);
            if (_local_8.FrozenParty.hasFrozenPowers(_local_10.SHELL.getMyPlayerId())) {
                var _local_6 = _local_9.getRoomMovieClip().room.getTargetAreaIdByPosition(_local_5, _local_4);
                if ((_local_6 > 0) && (_local_6 != undefined)) {
                    _local_8.FrozenParty.sendUpdateRoomState(_local_6, _local_8.FrozenParty.CONSTANTS.FREEZE_STATE, _local_5, _local_4);
                }
            } else {
                _local_7.sendThrowBall(_local_5, _local_4);
            }
        }
        function sendEmote(emote_id) {
            var _local_7 = _global.getCurrentShell();
            var _local_9 = _global.getCurrentEngine();
            var _local_4 = _global.getCurrentParty();
            var _local_8 = this;
            _local_7.sendEmote(emote_id);
            _local_8.showEmoteBalloon(_local_8.getPlayerId(), emote_id);
            var _local_5 = _local_9.getPlayerMovieClip(_local_7.getMyPlayerId());
            var _local_3 = _local_9.getRoomMovieClip().room.getTargetAreaIdByPosition(_local_5._x, _local_5._y);
            if (((_local_3 > 0) && (_local_3 != undefined)) && (emote_id == _local_4.FrozenParty.CONSTANTS.HEART_EMOTE_ID)) {
                _local_4.FrozenParty.sendUpdateRoomState(_local_3, _local_4.FrozenParty.CONSTANTS.THAW_STATE, 0, 0);
            }
        }
        function showCrosshair() {
            var _local_3 = this;
            var _local_4 = _global.getCurrentParty();
            _local_3.CROSSHAIR._visible = true;
            _local_3.CROSSHAIR.startDrag(true, 20, 20, 740, 440);
            _local_3.CROSSHAIR._x = _local_3._xmouse;
            _local_3.CROSSHAIR._y = _local_3._ymouse;
            _local_3.CROSSHAIR.target_btn.onRelease = com.clubpenguin.util.Delegate.create(this, doCrossHairRelease);
            if (!_local_4.FrozenParty.isSnowballEnabled) {
                _local_3.CROSSHAIR.gotoAndStop("deactive");
                var _local_5 = Math.round(_local_3.CROSSHAIR.timer._totalframes * (_local_4.FrozenParty.snowballCoolDownRemainderPercentage / 100));
                _local_3.CROSSHAIR.timer.gotoAndPlay(_local_5);
                _local_3.CROSSHAIR.target_btn.onRelease = com.clubpenguin.util.Delegate.create(this, doCrossHairRelease, false);
            } else {
                _local_3.CROSSHAIR.gotoAndStop("active");
                _local_3.CROSSHAIR.target_btn.onRelease = com.clubpenguin.util.Delegate.create(this, doCrossHairRelease, true);
            }
            _local_3.snowballCrosshairShown.dispatch();
        }
        function destroy() {
        }
    }
