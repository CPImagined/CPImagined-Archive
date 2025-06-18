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
            var _local_2 = com.clubpenguin.world.rooms2014.holiday.party.HolidayParty.getQuestVOByRoomID(0);
            if (_local_2 != undefined) {
                if ((com.clubpenguin.world.rooms2014.holiday.party.HolidayPartyConstants.PARTY_DAY >= _local_2.unlockDay) && (!isCrystalCollected())) {
                    _crystalMovieClip._visible = true;
                }
            }
        }
        function isCrystalCollected() {
            var _local_4 = _SHELL.getCurrentRoomId();
            var _local_3 = com.clubpenguin.world.rooms2014.holiday.party.HolidayParty.partyCookie.questItems;
            var _local_2 = com.clubpenguin.world.rooms2014.holiday.party.HolidayParty.partyCookie.crystalQuestTaskStatusIndexForRoom(_local_4);
            return((_local_2 >= 0) && (_local_3[_local_2] == 1));
        }
        function crystalClick() {
            com.clubpenguin.util.Log.debug("HolidayRoom.crystalClick() !!!");
            var _local_2 = _SHELL.getCurrentRoomId();
            com.clubpenguin.world.rooms2014.holiday.party.HolidayParty.sendCrystalCollected(_local_2);
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
