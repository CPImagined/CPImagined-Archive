//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.party.Party_InterfaceOverrides
    {
        function Party_InterfaceOverrides () {
        }
        function Party_thisOverrides() {
        }
        function showPartyIcon(partyIcon) {
            var _this = this;
            var loader = (new com.clubpenguin.hybrid.HybridMovieClipLoader());
            if (_this.PARTY_ICON) {
                _this.PARTY.BaseParty.partyIconState();
                _this.setPartyIconPositionForLikeWindow();
                return(undefined);
            }
            var icon_file_path = _this.SHELL.getPath(partyIcon);
            var iconURL = com.clubpenguin.util.URLUtils.getCacheResetURL(icon_file_path);
            _this.PARTY_ICON = _this.ICONS.createEmptyMovieClip(_this.PARTY_ICON_INSTANCE_NAME, 1);
            loader.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_COMPLETE, com.clubpenguin.util.Delegate.create(this, _this.onPartyIconLoad));
            loader.loadClip(iconURL, _this.PARTY_ICON, "icons.as loadPartyIcon()");
        }
        function onPartyIconLoad(event) {
            var _this = this;
            if (_this.EGG_TIMER_ICON._visible) {
                _this.PARTY_ICON._x = _this.PARTY_ICON._x - 58;
            }
            _this.defaultPartyIconPos = _this.PARTY_ICON._x;
            _this.setPartyIconPositionForLikeWindow();
            _this.PARTY.BaseParty.partyIconState();
        }
    }
