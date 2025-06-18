//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.medieval.MedievalParty_InterfaceOverrides
    {
        var _shell, _airtower, _interface, _engine, _party, defaultUpdatePlayerFrame, defaultCheckIsValidPosition;
        function MedievalParty_InterfaceOverrides () {
        }
        function init() {
            trace("JC: MedievalParty_InterfaceOverrides init");
            _shell = _global.getCurrentShell();
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            _engine = _global.getCurrentEngine();
            _party = _global.getCurrentParty();
            defaultUpdatePlayerFrame = _engine.updatePlayerFrame;
            defaultCheckIsValidPosition = _engine.checkIsValidPosition;
        }
        function showPartyIcon(partyIcon) {
            trace(("MEDIEVAL PARTY INTERFACE: showPartyIcon(" + partyIcon) + ")");
            var _local_2 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            trace("JC party icon " + _interface.PARTY_ICON);
            if (_interface.PARTY_ICON) {
                _party.MedievalParty.instance.medievalPartyIconState();
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
            _party.MedievalParty.instance.medievalPartyIconState();
        }
    }
