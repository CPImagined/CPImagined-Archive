//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.PhoneView extends MovieClip
    {
        var attachMovie, getNextHighestDepth, gameHolder;
        function PhoneView () {
            super();
            var _local_3 = _global.getCurrentShell().getMyPlayerId();
        }
        function get agentStatus() {
            showAgentStatus();
            return(_agentStatus);
        }
        function hideAgentStatus() {
            _agentStatus.removeMovieClip();
            if (_agentStatus != null) {
                _agentStatus = null;
            }
        }
        function showAgentStatus() {
            if (_agentStatus == null) {
                _agentStatus = com.clubpenguin.hud.phone.view.AgentStatusView(this.attachMovie("com.clubpenguin.hud.phone.view.AgentStatusView", "agentStatus", getNextHighestDepth()));
                _agentStatus._xscale = (_agentStatus._yscale = 70.6);
                _agentStatus._rotation = -90;
                _agentStatus._y = 480;
            }
        }
        function get distortion() {
            showDistortion();
            return(_distortion);
        }
        function hideDistortion() {
            _distortion.removeMovieClip();
            if (_distortion != null) {
                _distortion = null;
            }
        }
        function showDistortion() {
            if (_distortion == null) {
                _distortion = this.attachMovie("Distortion", "distortion", getNextHighestDepth());
            }
        }
        function get appMenu() {
            showAppMenu();
            return(_appMenu);
        }
        function hideAppMenu() {
            _appMenu.removeMovieClip();
            if (_appMenu != null) {
                _appMenu = null;
            }
        }
        function showAppMenu() {
            if (_appMenu == null) {
                _appMenu = com.clubpenguin.hud.phone.view.AppMenuView(this.attachMovie("com.clubpenguin.hud.phone.view.AppMenuView", "appView", TOOLTIP_CLIP_DEPTH - 1));
            }
        }
        function deleteObjectiveMovie() {
            if (gameHolder) {
                MovieClip(gameHolder).destroy();
                MovieClip(gameHolder).removeMovieClip();
            }
        }
        function hideAllViews() {
            hideAppMenu();
            deleteObjectiveMovie();
            hideAgentStatus();
            hideDistortion();
        }
        static var TOOLTIP_CLIP_DEPTH = 800000;
        var _appMenu = null;
        var _distortion = null;
        var _agentStatus = null;
    }
