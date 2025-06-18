//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty_InterfaceOverrides
    {
        function PrehistoricParty_InterfaceOverrides () {
        }
        function init() {
        }
        function showMapIcon() {
            var _this = this;
            if (_this.ICONS._visible == false) {
                com.clubpenguin.util.Log.debug("\t\tAll icons hidden, map icon will show when all are visible again");
            }
            _this.MAP_ICON._visible = true;
            _this.mapIsVisible = true;
            var destination;
            if (_global.getCurrentParty().PrehistoricParty.isPrehistoricRoom) {
                destination = _global.getCurrentParty().PrehistoricParty.CONSTANTS.PREHISTORIC_MAP;
                _this.MAP_ICON.gotoAndStop(2);
            }
            if (destination == null) {
                _this.MAP_ICON.gotoAndStop(1);
                destination = "map";
            }
            updateQuestRewardsReady(_this.SHELL.currentRewardCount);
            _this.MAP_ICON.map_btn.onRelease = function () {
                if (_this.SHELL._localLoginServerData.autoLogin) {
                    _this.SHELL.sendHideNewPlayerGuide();
                    _this.SHELL.sendAS2Clicked(_this.MAP_BUTTON);
                }
                _this.showContent(destination, null, null, null, true);
            };
        }
        function updateQuestRewardsReady(readyRewards) {
            var _local_3 = this;
            _local_3.currentRewardCount = readyRewards;
            if ((readyRewards > 0) && (!_global.getCurrentParty().PrehistoricParty.isPrehistoricRoom)) {
                _local_3.MAP_ICON.readyRewards._visible = true;
                if (readyRewards > _local_3.ONE_DIGIT_MAX) {
                    _local_3.MAP_ICON.readyRewards.gotoAndStop(_local_3.TWO_DIGITS_FRAME);
                } else {
                    _local_3.MAP_ICON.readyRewards.gotoAndStop(_local_3.ONE_DIGIT_FRAME);
                }
                _local_3.MAP_ICON.readyRewards.amount.text = readyRewards;
            } else {
                _local_3.MAP_ICON.readyRewards._visible = false;
            }
        }
    }
