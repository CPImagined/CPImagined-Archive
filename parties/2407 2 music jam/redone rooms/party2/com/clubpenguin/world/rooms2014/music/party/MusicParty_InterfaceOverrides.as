//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.music.party.MusicParty_InterfaceOverrides
    {
        function MusicParty_InterfaceOverrides () {
        }
        function init() {
        }
        function showMapIcon() {
            var _this = this;
            if (_this.ICONS._visible == false) {
            }
            _this.MAP_ICON._visible = true;
            _this.mapIsVisible = true;
            var destination;
            if (_global.getCurrentParty().BaseParty.isPartyRoom) {
                destination = _global.getCurrentParty().MusicParty.CONSTANTS.PARTY_MAP;
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
        function showIcons() {
            var _local_2 = this;
            _local_2.ICONS._visible = true;
            _local_2.MAP_ICON._visible = _local_2.mapIsVisible;
            if (_local_2.displayPartyIcon()) {
                _local_2.showPartyIcon("party_icon");
            }
        }
    }
