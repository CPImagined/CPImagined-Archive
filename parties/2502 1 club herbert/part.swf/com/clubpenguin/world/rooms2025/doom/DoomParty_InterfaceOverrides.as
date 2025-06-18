
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.world.rooms2025.doom.DoomParty_InterfaceOverrides
    {
        function DoomParty_InterfaceOverrides () {
        }
        function init() {
        }
		function showCrosshair() {
            var _this = this;
            var _PARTY = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
            _this.CROSSHAIR._visible = true;
            _this.CROSSHAIR.startDrag(true, 20, 20, 740, 440);
            _this.CROSSHAIR._x = _this._xmouse;
            _this.CROSSHAIR._y = _this._ymouse;
            _this.CROSSHAIR.target_btn.onRelease = com.clubpenguin.util.Delegate.create(this, doCrossHairRelease);
            if (!_PARTY.isSnowballEnabled) {
                _this.CROSSHAIR.gotoAndStop("deactive");
                _this.CROSSHAIR.timer.gotoAndPlay(_PARTY.snowballCoolDownRemainerPercentage);
                _this.CROSSHAIR.target_btn.onRelease = com.clubpenguin.util.Delegate.create(this, doCrossHairRelease, false);
            } else {
                _this.CROSSHAIR.gotoAndStop("active");
                _this.CROSSHAIR.target_btn.onRelease = com.clubpenguin.util.Delegate.create(this, doCrossHairRelease, true);
            }
            _this.snowballCrosshairShown.dispatch();
        }
        function doCrossHairRelease(active) {
            var _INTERFACE = _global.getCurrentInterface();
            var ballX = Math.round((_INTERFACE.CROSSHAIR._x + random(20)) - 10);
            var ballY = Math.round((_INTERFACE.CROSSHAIR._y + random(20)) - 10);
            if (active) {
                _INTERFACE.sendThrowBall(ballX, ballY);
            };
            _INTERFACE.stopDrag();
            _INTERFACE.CROSSHAIR._y = -100;
            _INTERFACE.CROSSHAIR._visible = false;
            Selection.setFocus(null);
        }
    }
