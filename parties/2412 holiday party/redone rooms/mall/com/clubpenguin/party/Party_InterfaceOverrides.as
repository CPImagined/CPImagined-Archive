//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.party.Party_InterfaceOverrides
    {
        function Party_InterfaceOverrides () {
        }
        function Party_thisOverrides() {
        }
        function showPartyIcon(partyIcon) {
            var _local_2 = this;
            trace("JC: Party version of showPartyIcon");
            var _local_3 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            if (_local_2.PARTY_ICON) {
                _local_2.PARTY.BaseParty.partyIconState();
                _local_2.setPartyIconPositionForLikeWindow();
                return(undefined);
            }
            var _local_4 = _local_2.SHELL.getPath(partyIcon);
            var _local_5 = com.clubpenguin.util.URLUtils.getCacheResetURL(_local_4);
            _local_2.PARTY_ICON = _local_2.ICONS.createEmptyMovieClip(_local_2.PARTY_ICON_INSTANCE_NAME, 1);
            _local_3.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_COMPLETE, com.clubpenguin.util.Delegate.create(this, _local_2.onPartyIconLoad));
            _local_3.loadClip(_local_5, _local_2.PARTY_ICON, "icons.as loadPartyIcon()");
        }
        function onPartyIconLoad(event) {
            trace("JC: Party version of onPartyIconLoad");
            var _local_2 = this;
            if (_local_2.EGG_TIMER_ICON._visible) {
                _local_2.PARTY_ICON._x = _local_2.PARTY_ICON._x - 58;
            }
            _local_2.defaultPartyIconPos = _local_2.PARTY_ICON._x;
            _local_2.setPartyIconPositionForLikeWindow();
            trace("JC: _this.PARTY.BaseParty " + _local_2.PARTY.BaseParty);
            trace("JC: _this.PARTY.BaseParty.partyIconState " + _local_2.PARTY.BaseParty.partyIconState);
            _local_2.PARTY.BaseParty.partyIconState();
        }
    }
