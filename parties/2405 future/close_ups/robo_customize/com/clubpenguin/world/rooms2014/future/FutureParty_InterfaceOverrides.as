//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.future.FutureParty_InterfaceOverrides
    {
        var defaultShowCrosshair, defaultDoCrossHairRelease;
        function FutureParty_InterfaceOverrides () {
        }
        function init() {
            defaultShowCrosshair = _global.getCurrentInterface().showCrosshair;
            defaultDoCrossHairRelease = _global.getCurrentInterface().doCrossHairRelease;
        }
        function revertAvatar() {
            var _local_3 = this;
            _local_3.hideAvatarCardElements();
            _local_3.PLAYER_WIDGET.art_mc.close_btn.onRelease();
            _local_3.ENGINE.avatarManager.transformationManager.sendTransformPlayer(0);
            _global.getCurrentParty().FutureParty.sendMechUnTransformBI();
        }
        function showCrosshair() {
            var _local_3 = this;
            var _local_4 = _global.getCurrentParty();
            _local_3.CROSSHAIR._visible = true;
            _local_3.CROSSHAIR.startDrag(true, 20, 20, 740, 440);
            _local_3.CROSSHAIR._x = _local_3._xmouse;
            _local_3.CROSSHAIR._y = _local_3._ymouse;
            _local_3.CROSSHAIR.target_btn.onRelease = com.clubpenguin.util.Delegate.create(this, doCrossHairRelease);
            if (!_local_4.FutureParty.isSnowballEnabled) {
                _local_3.CROSSHAIR.gotoAndStop("deactive");
                _local_3.CROSSHAIR.timer.gotoAndPlay(_local_4.FutureParty.snowballCoolDownRemainerPercentage);
                _local_3.CROSSHAIR.target_btn.onRelease = com.clubpenguin.util.Delegate.create(this, doCrossHairRelease, false);
            } else {
                _local_3.CROSSHAIR.gotoAndStop("active");
                _local_3.CROSSHAIR.target_btn.onRelease = com.clubpenguin.util.Delegate.create(this, doCrossHairRelease, true);
            }
            _local_3.snowballCrosshairShown.dispatch();
        }
        function doCrossHairRelease(active) {
            var _local_5 = this;
            var _local_4 = _global.getCurrentParty();
            var _local_3 = _global.getCurrentInterface();
            var _local_7 = Math.round((_local_3.CROSSHAIR._x + random(20)) - 10);
            var _local_6 = Math.round((_local_3.CROSSHAIR._y + random(20)) - 10);
            if ((active || (_local_4.FutureParty.isSnowballEnabled)) && (_local_5.CROSSHAIR._currentFrame == 1)) {
                _local_3.sendThrowBall(_local_7, _local_6);
            }
            _local_3.stopDrag();
            _local_3.CROSSHAIR._y = -100;
            _local_3.CROSSHAIR._visible = false;
        }
        function showMapIcon() {
            var _this = this;
            if (_this.ICONS._visible == false) {
            }
            _this.MAP_ICON._visible = true;
            _this.mapIsVisible = true;
            var destination;
            if (_global.getCurrentParty().FutureParty.isFutureRoom) {
                destination = _global.getCurrentParty().FutureParty.CONSTANTS.PARTY_MAP;
            }
            if (destination == null) {
                _this.MAP_ICON.gotoAndStop(1);
                destination = "map";
            }
            _this.updateQuestRewardsReady(_this.currentRewardCount);
            _this.MAP_ICON.map_btn.onRelease = function () {
                if (_this.SHELL._localLoginServerData.autoLogin) {
                    _this.SHELL.sendHideNewPlayerGuide();
                    _this.SHELL.sendAS2Clicked(_this.MAP_BUTTON);
                }
                _this.showContent(destination, null, null, null, true);
            };
        }
    }
