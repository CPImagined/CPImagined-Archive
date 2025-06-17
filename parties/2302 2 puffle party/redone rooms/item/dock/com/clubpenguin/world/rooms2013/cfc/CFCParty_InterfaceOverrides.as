//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.cfc.CFCParty_InterfaceOverrides
    {
        var _shell, _airtower, _interface, _engine, _party;
        function CFCParty_InterfaceOverrides () {
        }
        function init() {
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
        }
        function showPartyIcon(partyIcon) {
            var _local_2 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            if (_interface.PARTY_ICON) {
                _party.CFCParty.partyIconState();
                _interface.setPartyIconPositionForLikeWindow();
                return(undefined);
            }
            var _local_3 = _shell.getPath(partyIcon);
            var _local_4 = com.clubpenguin.util.URLUtils.getCacheResetURL(_local_3);
            _interface.PARTY_ICON = _interface.ICONS.createEmptyMovieClip(_interface.PARTY_ICON_INSTANCE_NAME, 1);
            _local_2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_COMPLETE, com.clubpenguin.util.Delegate.create(this, _interface.onPartyIconLoad));
            _local_2.loadClip(_local_4, _interface.PARTY_ICON, "icons.as loadPartyIcon()");
        }
        function onPartyIconLoad(event) {
            if (_interface.EGG_TIMER_ICON._visible) {
                _interface.PARTY_ICON._x = _interface.PARTY_ICON._x - 58;
            }
            _interface.defaultPartyIconPos = _interface.PARTY_ICON._x;
            _interface.setPartyIconPositionForLikeWindow();
            _party.CFCParty.partyIconState();
        }
        function showCrosshair() {
            _interface.CROSSHAIR._visible = true;
            _interface.CROSSHAIR.startDrag(true, 20, 20, 740, 440);
            _interface.CROSSHAIR._x = _interface._xmouse;
            _interface.CROSSHAIR._y = _interface._ymouse;
            _interface.CROSSHAIR.target_btn.onRelease = com.clubpenguin.util.Delegate.create(this, _interface.doCrossHairRelease);
            if (!_party.CFCParty.isSnowballEnabled) {
                _party.CFCParty.pebug("Snowball is currently not enabled " + _party.CFCParty.snowballCoolDownRemainderPercentage);
                _interface.CROSSHAIR.gotoAndStop("deactive");
                _interface.CROSSHAIR.timer.gotoAndPlay(_party.CFCParty.snowballCoolDownRemainerPercentage);
                _interface.CROSSHAIR.target_btn.onRelease = com.clubpenguin.util.Delegate.create(this, _interface.doCrossHairRelease, false);
            } else {
                _interface.CROSSHAIR.gotoAndStop("active");
                _interface.CROSSHAIR.target_btn.onRelease = com.clubpenguin.util.Delegate.create(this, _interface.doCrossHairRelease, true);
            }
            _interface.snowballCrosshairShown.dispatch();
        }
        function doCrossHairRelease(active) {
            var _local_3 = Math.round((_interface.CROSSHAIR._x + random(20)) - 10);
            var _local_2 = Math.round((_interface.CROSSHAIR._y + random(20)) - 10);
            if (active) {
                _interface.sendThrowBall(_local_3, _local_2);
            }
            _interface.stopDrag();
            _interface.CROSSHAIR._y = -100;
            _interface.CROSSHAIR._visible = false;
            Selection.setFocus(null);
        }
    }
