//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2012.halloween.scavengerhunts.KeyScavengerHunt extends com.clubpenguin.hud.scavengerhunt.ScavengerHunt implements com.clubpenguin.world.rooms2012.halloween.scavengerhunts.IScavengerHunt
    {
        var _INTERFACE, _ENGINE, scavengerHuntClosedSignal, scavengerHuntCompletedSignal, _SHELL;
        function KeyScavengerHunt (isActive) {
            super();
            com.clubpenguin.hud.scavengerhunt.ScavengerHunt.ITEMS_TOTAL = 5;
            _INTERFACE = _global.getCurrentInterface();
            _ENGINE = _global.getCurrentEngine();
            _isActive = isActive;
            scavengerHuntClosedSignal.add(onCloseClicked, this);
        }
        function getScavengerHuntCompleted() {
            return(scavengerHuntCompletedSignal);
        }
        function setupHuntWindow(window) {
            super.setupHuntWindow(window);
            window.content.continue_mc.continueTextHolder.continue_txt.text = window.content.continue_mc.continueTextHolder.continue_txt.text.toUpperCase();
            var _local_2 = 0;
            while (_local_2 < com.clubpenguin.hud.scavengerhunt.ScavengerHunt.ITEMS_TOTAL) {
                window.content["item" + _local_2].onRelease = null;
                _local_2++;
            }
        }
        function claimPrize() {
            _SHELL.stampEarned(_INTERFACE.SCAVENGER_HUNT_STAMP);
            if (_SHELL.getRoomObject().room_key == "party1") {
                _ENGINE.sendPlayerTeleport(301, 201);
                _INTERFACE.closeContent();
            } else {
                teleportToRoom("party1", 301, 201);
            }
        }
        function teleportToRoom(roomKey, x, y) {
            _INTERFACE.closeContent();
            _SHELL.sendJoinRoom(roomKey, x, y);
        }
        function playerClaimedPrize() {
            if (_isActive) {
                scavengerHuntCompletedSignal.dispatch();
                _SHELL.stampEarned(_INTERFACE.SCAVENGER_HUNT_STAMP);
                var _local_2 = new com.clubpenguin.world.rooms2012.halloween.OpcodeJournal();
                _local_2.init(_SHELL.getMyPlayerId());
                _local_2.sendOpcode(com.clubpenguin.world.rooms2012.halloween.OpcodeJournal.MEMBER_COMPLETES_SCAVENGER_HUNT);
            }
        }
        function reset() {
        }
        function onCloseClicked() {
            _INTERFACE.closeContent();
        }
        function isActive() {
            return(_isActive);
        }
        function setActive(isActive) {
            _isActive = isActive;
        }
        function getName() {
            return("key");
        }
        var _isActive = false;
    }
