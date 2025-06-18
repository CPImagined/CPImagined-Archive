//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2014.future.ui.components.AsteroidPointsDisplay
    {
        var _pointsDisplayMC, _airtower, _handleUpdateAsteroidPointsDelegate;
        function AsteroidPointsDisplay (mc) {
            _pointsDisplayMC = mc;
            _airtower = _global.getCurrentAirtower();
            _handleUpdateAsteroidPointsDelegate = com.clubpenguin.util.Delegate.create(this, handleUpdateAsteroidPoints);
            _airtower.addListener(com.clubpenguin.world.rooms2014.future.vo.FuturePartyCookieVO.FUTURE_RECEIVE_COMMAND_NAME, _handleUpdateAsteroidPointsDelegate);
            com.clubpenguin.world.rooms2014.future.FutureParty.partyCookie.asteroidPointsChanged.add(_handleUpdateAsteroidPointsDelegate, this);
            com.clubpenguin.world.rooms2014.future.FutureParty.sendRequestPartyCookie();
            _asteroidPoints = Number(com.clubpenguin.world.rooms2014.future.FutureParty.partyCookie.asteroidPoints);
            handleUpdateAsteroidPoints();
        }
        function handleUpdateAsteroidPoints(data, updatedPoints) {
            updatedPoints = ((updatedPoints == undefined) ? (Number(com.clubpenguin.world.rooms2014.future.FutureParty.partyCookie.asteroidPoints)) : (updatedPoints));
            _pointsDisplayMC[POINTS_TEXTFIELD_LABEL].text = updatedPoints.toString();
            var _local_4 = updatedPoints - _asteroidPoints;
            if ((_asteroidPoints != undefined) && (_local_4 > 0)) {
                var _local_5 = _global.getCurrentEngine().getRoomMovieClip().room.currentWaveType;
                com.clubpenguin.world.rooms2014.future.FutureParty.sendSpaceBattlePayoutBI(_local_5, _local_4);
                _asteroidPoints = updatedPoints;
            }
        }
        function clean() {
            trace("AsteroidPointsDisplay.clean()");
            _airtower.removeListener(com.clubpenguin.world.rooms2014.future.vo.FuturePartyCookieVO.FUTURE_RECEIVE_COMMAND_NAME, _handleUpdateAsteroidPointsDelegate);
        }
        static var POINTS_TEXTFIELD_LABEL = "asteroidPoints";
        static var _asteroidPoints = 0;
    }
