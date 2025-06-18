//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.prehistoric.HotSpotsController
    {
        var _shell, _engine, _airtower, hotSpots, handleVolcanoStatusBroadcastReceivedDelegate, currentHotSpotIndex, hotSpotHeated, _cooldownCurrentHotSpotIntervalId;
        function HotSpotsController () {
            _shell = _global.getCurrentShell();
            _engine = _global.getCurrentEngine();
            _airtower = _global.getCurrentAirtower();
            hotSpots = new Array();
            activateVolcanoStatusBroadcastReceiver();
        }
        function addHotSpot(hotSpotMC) {
            com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.pebug("HotSpotController - addHotSpot(): " + hotSpotMC);
            hotSpots.push(hotSpotMC);
        }
        function activateVolcanoStatusBroadcastReceiver() {
            handleVolcanoStatusBroadcastReceivedDelegate = com.clubpenguin.util.Delegate.create(this, heatHotSpot);
            _airtower.addListener(_global.getCurrentParty().PrehistoricParty.CONSTANTS.VOLCANO_STATUS_COMMAND, handleVolcanoStatusBroadcastReceivedDelegate);
        }
        function deactivateVolcanoStatusBroadcastReceiver() {
            _airtower.removeListener(_global.getCurrentParty().PrehistoricParty.CONSTANTS.VOLCANO_STATUS_COMMAND, handleVolcanoStatusBroadcastReceivedDelegate);
        }
        function run() {
            com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.pebug("HotSpotController - run() - START - ");
            com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.pebug("HotSpotController - run() - numberOfHotspots= " + hotSpots.length);
        }
        function heatHotSpot(data) {
            var _local_3 = data[0];
            currentHotSpotIndex = Number(data[1]);
            currentHotSpotIndex--;
            com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.pebug(("HotSpotController - heatHotSpot(" + data.toString()) + ") - START - ");
            com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.hotSpotPreviouslyRegistered = false;
            hotSpotHeated = true;
            hotSpots[currentHotSpotIndex].gotoAndPlay(HEATUP_LABEL);
            hotSpots[currentHotSpotIndex].vent_mc.gotoAndPlay(HEATUP_LABEL);
            if (_cooldownCurrentHotSpotIntervalId != null) {
                clearTimeout(_cooldownCurrentHotSpotIntervalId);
            }
            _cooldownCurrentHotSpotIntervalId = setTimeout(com.clubpenguin.util.Delegate.create(this, cooldownHotSpot), HOTSPOT_DURATION);
        }
        function cooldownHotSpot() {
            com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.pebug("HotSpotController - cooldownHotSpot() - START - ");
            hotSpotHeated = false;
            hotSpots[currentHotSpotIndex].gotoAndPlay(COOLDOWN_LABEL);
            hotSpots[currentHotSpotIndex].vent_mc.gotoAndPlay(COOLDOWN_LABEL);
        }
        function isHotSpotActive(hotSpotIndex) {
            return((hotSpotIndex == currentHotSpotIndex) && (hotSpotHeated));
        }
        function hotSpotActivated(players, hotSpotIndex) {
            if (isHotSpotActive(hotSpotIndex)) {
                var _local_5 = _shell.getMyPlayerObject();
                var _local_2 = 0;
                while (_local_2 < players.length) {
                    if (players[_local_2] == _local_5.player_id) {
                        com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.pebug("PrehistoricParty.hotSpotPreviouslyRegistered=" + com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.hotSpotPreviouslyRegistered);
                        if (com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.isDinoPuffleEgg(_local_5.hand) && (!com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.hotSpotPreviouslyRegistered)) {
                            var _local_3 = _engine.getPlayerMovieClip(players[_local_2]);
                            if (_local_3.hand_mc.puffle._currentframe != _local_3.hand_mc.puffle._totalframes) {
                                com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.sendDinoPuffleEggHeated();
                            }
                        }
                    }
                    _local_2++;
                }
            }
        }
        function destroy() {
            com.clubpenguin.world.rooms2014.prehistoric.PrehistoricParty.pebug("HotSpotController - destroy()");
            deactivateVolcanoStatusBroadcastReceiver();
            clearInterval(_cooldownCurrentHotSpotIntervalId);
        }
        var HOTSPOT_DURATION = 7000;
        var HEATUP_LABEL = "heatup";
        var COOLDOWN_LABEL = "cooldown";
    }
