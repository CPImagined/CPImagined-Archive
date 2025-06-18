//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.holiday.HolidayRoom extends com.clubpenguin.world.rooms.BaseRoom
    {
        var _airtower, _destroyDelegate, _SHELL, _crystalMovieClip, _stage;
        function HolidayRoom (stageReference) {
            super(stageReference);
            com.clubpenguin.util.Log.debug(CLASS_NAME + "()");
            _airtower = _global.getCurrentAirtower();
            com.clubpenguin.util.Log.debug("HOlidayRoom - _airtower : " + _airtower);
            _destroyDelegate = com.clubpenguin.util.Delegate.create(this, destroy);
            _SHELL.addListener(_global.getCurrentShell().ROOM_DESTROYED, _destroyDelegate);
        }
        function configureHolidayRoomElements() {
            _crystalMovieClip = MovieClip(_stage.crystal);
            configureCrystal();
        }
        function configureCrystal() {
            _crystalMovieClip.onRelease = com.clubpenguin.util.Delegate.create(this, crystalClick);
            _crystalMovieClip._visible = false;
            if (com.clubpenguin.world.rooms2014.holiday.party.HolidayParty.partyCookie.questItems) {
                updateCrystal();
            }
        }
        function initializePartyCookieDependentAssets() {
            updateCrystal();
        }
        function updateCrystal() {
            var partyQuestTaskVO = com.clubpenguin.world.rooms2014.holiday.party.HolidayParty.getQuestVOByRoomID(0);
            if (partyQuestTaskVO != undefined) {
                if ((com.clubpenguin.world.rooms2014.holiday.party.HolidayPartyConstants.PARTY_DAY >= partyQuestTaskVO.unlockDay) && (!isCrystalCollected())) {
                    _crystalMovieClip._visible = true;
                }
            }
        }
        function isCrystalCollected() {
            var currentRoomId = _SHELL.getCurrentRoomId();
            var questTaskStatus = com.clubpenguin.world.rooms2014.holiday.party.HolidayParty.partyCookie.questItems;
            var crystalQuestTaskStatusIndex = com.clubpenguin.world.rooms2014.holiday.party.HolidayParty.partyCookie.crystalQuestTaskStatusIndexForRoom(currentRoomId);
            return((crystalQuestTaskStatusIndex >= 0) && (questTaskStatus[crystalQuestTaskStatusIndex] == 1));
        }
        function crystalClick() {
            com.clubpenguin.util.Log.debug("HolidayRoom.crystalClick() !!!");
            var currentRoomId = _SHELL.getCurrentRoomId();
            com.clubpenguin.world.rooms2014.holiday.party.HolidayParty.sendCrystalCollected(currentRoomId);
            _crystalMovieClip.gotoAndPlay(2);
            com.clubpenguin.world.rooms2014.holiday.party.HolidayPartySounds.playCollectCrystal();
            var scope = this;
            _crystalMovieClip.onEnterFrame = function () {
                if (scope._crystalMovieClip._currentframe >= scope._crystalMovieClip._totalframes) {
                    scope._crystalMovieClip.onEnterFrame = null;
                    scope._crystalMovieClip._visible = false;
                }
            };
        }
        function destroy() {
        }
        static var CLASS_NAME = "HolidayRoom";
    }
