//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.login.views.ServerSelectionView extends com.clubpenguin.ui.views.AbstractView
    {
        var _shell;
        function ServerSelectionView () {
            super();
        }
        function setShell(target) {
            _shell = target;
            _shell.ROSTER.updated.add(onRosterUpdated, this);
        }
        function onRosterUpdated(numBuddies) {
            throw new Error("Must override ServerSelectionView.onRosterupdated");
        }
    }
