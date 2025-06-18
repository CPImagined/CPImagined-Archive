//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.hollywood.ui.ActorScavengerHunt
    {
        var _INTERFACE, _SHELL, _progressLookup, _progressJustCompleted, _completedTimeout;
        function ActorScavengerHunt () {
            _INTERFACE = _global.getCurrentInterface();
            _SHELL = _global.getCurrentShell();
            _progressLookup = {};
            _progressJustCompleted = [];
            _SHELL.addListener(_SHELL.PARTY_COOKIE_UPDATED, readPartyCookie, this);
        }
        function readPartyCookie() {
            var _local_4 = _global.getCurrentParty().partyCookie;
            var _local_6 = _local_4.StarPower.SchoolSet.Cameras;
            var _local_5 = _local_4.StarPower.ActionSet.Stunts;
            var _local_3 = _local_4.StarPower.SciFiSet.Locations;
            _progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_A_ACT1] = _local_6[0];
            _progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_A_ACT2] = _local_6[1];
            _progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_A_ACT3] = _local_6[2];
            _progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_B_ACT1] = _local_5[0];
            _progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_B_ACT2] = _local_5[1];
            _progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_B_ACT3] = _local_5[2];
            _progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_C_ACT1] = _local_3[0];
            _progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_C_ACT2] = _local_3[1];
            _progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_C_ACT3] = _local_3[2];
        }
        function writePartyCookie() {
            var _local_4 = _global.getCurrentParty();
            var _local_5 = _local_4.partyCookie;
            var _local_7 = _local_5.StarPower.SchoolSet.Cameras;
            var _local_6 = _local_5.StarPower.ActionSet.Stunts;
            var _local_3 = _local_5.StarPower.SciFiSet.Locations;
            _local_7[0] = _progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_A_ACT1];
            _local_7[1] = _progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_A_ACT2];
            _local_7[2] = _progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_A_ACT3];
            _local_6[0] = _progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_B_ACT1];
            _local_6[1] = _progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_B_ACT2];
            _local_6[2] = _progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_B_ACT3];
            _local_3[0] = _progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_C_ACT1];
            _local_3[1] = _progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_C_ACT2];
            _local_3[2] = _progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_C_ACT3];
            _local_4.sendSavePartyCookieJson(com.clubpenguin.world.rooms2013.hollywood.Hollywood.PARTY_COOKIE_ID, _local_4.partyCookie);
        }
        function onActingDone(stageActingID) {
            if (_progressLookup[stageActingID] == true) {
                return(undefined);
            }
            _progressLookup[stageActingID] = true;
            _progressJustCompleted.push(stageActingID);
            writePartyCookie();
            clearInterval(_completedTimeout);
            _completedTimeout = setInterval(this, "onCompletedTimeout", 2200, stageActingID);
        }
        function isStageAComplete() {
            return((((_progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_A_ACT1] && (_progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_A_ACT2])) && (_progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_A_ACT3])) ? true : false));
        }
        function isStageBComplete() {
            return((((_progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_B_ACT1] && (_progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_B_ACT2])) && (_progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_B_ACT3])) ? true : false));
        }
        function isStageCComplete() {
            return((((_progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_C_ACT1] && (_progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_C_ACT2])) && (_progressLookup[com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_C_ACT3])) ? true : false));
        }
        function onCompletedTimeout(stageActingID) {
            clearInterval(_completedTimeout);
            switch (stageActingID) {
                case com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_A_ACT1 : 
                case com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_A_ACT2 : 
                case com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_A_ACT3 : 
                    if (isStageAComplete()) {
                        _INTERFACE.showContent(com.clubpenguin.world.rooms2013.hollywood.Hollywood.QUEST_UI_STAGE_A);
                    }
                    break;
                case com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_B_ACT1 : 
                case com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_B_ACT2 : 
                case com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_B_ACT3 : 
                    if (isStageBComplete()) {
                        _INTERFACE.showContent(com.clubpenguin.world.rooms2013.hollywood.Hollywood.QUEST_UI_STAGE_B);
                    }
                    break;
                case com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_C_ACT1 : 
                case com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_C_ACT2 : 
                case com.clubpenguin.world.rooms2013.hollywood.Hollywood.STAGE_C_ACT3 : 
                    if (isStageCComplete()) {
                        _INTERFACE.showContent(com.clubpenguin.world.rooms2013.hollywood.Hollywood.QUEST_UI_STAGE_C);
                    }
                    break;
            }
        }
        function hasCompleted(stageActingID) {
            return(_progressLookup[stageActingID] == true);
        }
        function getRecentActingProgress() {
            return(_progressJustCompleted);
        }
        function clearRecentActingProgress() {
            _progressJustCompleted = [];
        }
    }
