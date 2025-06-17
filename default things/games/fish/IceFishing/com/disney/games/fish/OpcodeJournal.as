//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.disney.games.fish.OpcodeJournal
    {
        function OpcodeJournal () {
        }
        function checkOpcodeActivity(stamp) {
            var _local_3 = false;
            if (arrStampsSent.length > 0) {
                var _local_2 = 0;
                while (_local_2 < arrStampsSent.length) {
                    if (String(arrStampsSent[_local_2]) == stamp) {
                        _local_3 == true;
                        return(true);
                    }
                    _local_2++;
                }
            }
            if (_local_3 == false) {
                arrStampsSent.push(stamp);
                return(false);
            }
        }
        function sendStampOpcodes(stampOpcode) {
            if (checkOpcodeActivity(stampOpcode) == false) {
                sendStampAction(stampOpcode);
            }
        }
        function init(playerID) {
            com.disney.dlearning.managers.DLSManager.init(String(playerID), "icefishing.k.api.dlsnetwork.com");
        }
        function startGame() {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("start", OPCODEGUID_ICEFISHING, dlsmCallback, "0");
        }
        function stopGame() {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("stop", OPCODEGUID_ICEFISHING, dlsmCallback, "0");
        }
        function sendGameScore(status, score, coins) {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("gamescore", OPCODEGUID_ICEFISHING, dlsmCallback, String(score), status, String(coins));
        }
        function sendStampAction(stampOpcode) {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("selected", stampOpcode, dlsmCallback, "0", "0", "0");
        }
        function sendEventAction(eventOpcode) {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("selected", eventOpcode, dlsmCallback, "0", "0", "0");
        }
        function dlsmCallback(stringArg) {
        }
        var OPCODEGUID_ICEFISHING = "B1D55EB3-4A5E-42A6-2BEC-7E9C81FBEDDB";
        var OPCODEGUID_INSTRUCTIONS = "29E4AAA9-5F68-D4A2-BE6E-5D37EB48379D";
        var OPCODEGUID_USEFLASHINGLUREFISHINGROD = "D60CFB38-D8CA-99D6-F73A-EE29EACDD7BE";
        var OPCODEGUID_KICKEDBYBOOT = "A977A3E0-140D-BD7F-7845-58CBDBA18D4E";
        var OPCODEGUID_HITBYBARREL = "3A92F819-8B38-71A6-94B3-53FEF07DF3AF";
        var OPCODEGUID_ATEBYSHARK = "A19706A6-DCD7-9FDE-9FD4-A654B328250D";
        var OPCODEGUID_STUNGBYJELLYFISH = "125916F2-220D-E710-2ED9-63CBAA911853";
        var OPCODEGUID_CLIPPEDBYCRAB = "A7EBB56C-BACA-DD50-671B-69D0DEB5227E";
        var OPCODEGUID_CATCHCANOFWORMS = "D7A41046-A73B-2252-71A7-002D7A870C63";
        var OPCODEGUID_CATCHMULLET = "9293FE9D-542D-9320-B915-BEE3205422F3";
        var OPCODEGUID_DIDNTCATCHMULLET = "CB835886-28B0-289C-3DE5-43AD1CB76746";
        var OPCODEGUID_STAMPS372_SNACKATTACK = "8D8C507D-0591-9DEA-90E6-0D429E02E76C";
        var OPCODEGUID_STAMPS374_SHOCKKING = "039656EB-0B90-BE74-5455-C3623AA5C3FB";
        var OPCODEGUID_STAMPS376_FISHTASTIC = "F58542F8-F941-EDF3-EF06-B84D5988C4BA";
        var OPCODEGUID_STAMPS378_WORMWIN = "485E7332-CD38-EC98-6FD5-B95AAA1535C6";
        var OPCODEGUID_STAMPS380_CRABCUTS = "FF7FC751-F0A9-199D-F6CD-5FD5DE6E7DAE";
        var OPCODEGUID_STAMPS382_AFISHIONADO = "723A203D-E114-D0C6-AC18-E41E3F0AD513";
        var OPCODEGUID_STAMPS384_GRAYGOODIES = "1A3CCF32-D016-A0CE-8EE0-31BBD134E364";
        var OPCODEGUID_STAMPS386_PRIZEMULLET = "F64B11D2-5FE7-2AB2-55D9-F364C0F2FEAC";
        var OPCODEGUID_STAMPS388_FLYFISHER = "C525A69D-514B-84BE-8935-29E6CC8D116B";
        var OPCODEGUID_STAMPS390_ACEANGLER = "FDCEE7B2-B9CC-E06C-0130-3B44FB6B7FCB";
        var arrStampsSent = new Array();
    }
