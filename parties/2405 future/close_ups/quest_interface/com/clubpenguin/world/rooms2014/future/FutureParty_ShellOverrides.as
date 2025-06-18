//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.future.FutureParty_ShellOverrides
    {
        var defaultSendUpdatePlayerNeck;
        function FutureParty_ShellOverrides () {
        }
        function init() {
            defaultSendUpdatePlayerNeck = _global.getCurrentShell().sendUpdatePlayerNeck;
        }
        function sendUpdatePlayerNeck(id) {
            var _local_3 = this;
            if (!isNaN(id)) {
                _local_3.AIRTOWER.send(_local_3.AIRTOWER.PLAY_EXT, (_local_3.AIRTOWER.SETTING_HANDLER + "#") + _local_3.AIRTOWER.UPDATE_PLAYER_NECK, [id], "str", _local_3.getCurrentServerRoomId());
                if (id == _global.getCurrentParty().FutureParty.CONSTANTS.JETPACK_ITEM_ID) {
                    _global.getCurrentParty().FutureParty.sendJetpackEquippedBI();
                }
            } else {
                _local_3.$e("[shell] sendUpdatePlayerNeck() -> Not a real number passed for id! id:" + id);
            }
        }
    }
