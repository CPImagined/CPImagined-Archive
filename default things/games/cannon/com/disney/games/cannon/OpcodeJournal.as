//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.disney.games.cannon.OpcodeJournal
    {
        var currentLevel;
        function OpcodeJournal () {
        }
        function getStartOpcode(_arg_1) {
            trace("inside getStartOpcode with level: " + _arg_1);
            if ((_arg_1 > 0) && (_arg_1 <= 12)) {
                return(PUFFLE_LAUNCH_BLUE_SKY_START);
            }
            if ((_arg_1 > 12) && (_arg_1 <= 24)) {
                return(PUFFLE_LAUNCH_SODA_SUNSET_START);
            }
            if ((_arg_1 > 24) && (_arg_1 <= 36)) {
                return(PUFFLE_LAUNCH_STARRY_START);
            }
            if (_arg_1 == 0) {
                return(PUFFLE_LAUNCH);
            }
            if (((_arg_1 > 36) || (_arg_1 == undefined)) || (_arg_1 == null)) {
                return(null);
            }
        }
        function getLevelOpcode(_arg_2) {
            if (_arg_2 <= 12) {
                return(BlueSkyLevels[_arg_2 - 1]);
            }
            if ((_arg_2 > 12) && (_arg_2 <= 24)) {
                var _local_3 = _arg_2 - 12;
                return(SodaSunsetLevels[_local_3 - 1]);
            }
            if ((_arg_2 > 24) && (_arg_2 <= 36)) {
                var _local_3 = _arg_2 - 24;
                return(StarryLevels[_local_3 - 1]);
            }
            if (_arg_2 > 36) {
                trace("More levels have been added and we need more code");
                return(null);
            }
        }
        function getNotifyOpcode(_arg_2) {
            if (_arg_2 <= 12) {
                return(BlueSkyNotify[_arg_2 - 1]);
            }
            if ((_arg_2 > 12) && (_arg_2 <= 24)) {
                var _local_3 = _arg_2 - 12;
                return(SodaSunsetNotify[_local_3 - 1]);
            }
            if ((_arg_2 > 24) && (_arg_2 <= 36)) {
                var _local_3 = _arg_2 - 24;
                return(StarryNotify[_local_3 - 1]);
            }
            if (_arg_2 > 36) {
                trace("More levels have been added and we need more code");
                return(null);
            }
        }
        function init(_arg_1) {
            trace("playerID in init: " + _arg_1);
            com.disney.dlearning.managers.DLSManager.init(String(_arg_1), "puffle.launch.k.api.dlsnetwork.com");
            trace("DLSManager loaded and initialised");
        }
        function startLevel(_arg_2) {
            currentLevel = String(_arg_2);
            trace("inside startLevel with level: " + _arg_2);
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("start", getStartOpcode(Number(_arg_2)), dlsmCallback, "0");
        }
        function stopGame() {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("stop", PUFFLE_LAUNCH, dlsmCallback, "0");
        }
        function sendGameScore(_arg_3, _arg_4, _arg_2) {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("gamescore", PUFFLE_LAUNCH, dlsmCallback, String(_arg_4), _arg_3, String(_arg_2), currentLevel);
            trace((((("sent game score of: " + _arg_4) + " and player endgame status: ") + _arg_3) + " coins: ") + _arg_2);
        }
        function sendLearnerOpcode(_arg_3, _arg_2, _arg_4) {
            trace((((("Checking params for learnerscore: (level, totPuffles, userPuffles): " + _arg_3) + " ") + _arg_2) + " ") + _arg_4);
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("learnerscore", getLevelOpcode(_arg_3), dlsmCallback, String(Math.round((_arg_4 / _arg_2) * 100)));
        }
        function sendNotifyOpcode(_arg_2, _arg_3) {
            trace((("Checking params for notify: (level, userPuffles): " + _arg_2) + " ") + _arg_3);
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("notify", getNotifyOpcode(_arg_2), dlsmCallback, String(_arg_3));
        }
        function checkOpcodeActivity(_arg_4) {
            var _local_3 = false;
            if (arrStampsSent.length > 0) {
                var _local_2 = 0;
                while (_local_2 < arrStampsSent.length) {
                    if (Number(arrStampsSent[_local_2]) == _arg_4) {
                        _local_3 == true;
                        return(true);
                    }
                    _local_2++;
                }
            }
            if (_local_3 == false) {
                arrStampsSent.push(_arg_4);
                return(false);
            }
        }
        function sendStampOpcodes(_arg_3) {
            var _local_2 = -1;
            if (checkOpcodeActivity(_arg_3) == false) {
                trace("checkOpcodeActivity(stamp) = false");
                switch (_arg_3) {
                    case 340 : 
                        _local_2 = 0;
                        break;
                    case 342 : 
                        _local_2 = 1;
                        break;
                    case 344 : 
                        _local_2 = 2;
                        break;
                    case 346 : 
                        _local_2 = 3;
                        break;
                    case 348 : 
                        _local_2 = 4;
                        break;
                    case 350 : 
                        _local_2 = 5;
                        break;
                    case 352 : 
                        _local_2 = 6;
                        break;
                    case 354 : 
                        _local_2 = 7;
                        break;
                    case 356 : 
                        _local_2 = 8;
                        break;
                    case 1 : 
                        _local_2 = 9;
                        break;
                    case 2 : 
                        _local_2 = 10;
                        break;
                    case 3 : 
                        _local_2 = 11;
                        break;
                    default : 
                        trace("no stamp found, must be a new stamp");
                }
                trace("Stamp: " + _arg_3);
                sendStampAction(_local_2);
            }
        }
        function sendStampAction(_arg_2) {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("selected", Puffle_Launch_Stamps[_arg_2], dlsmCallback, "0", "0", "0");
        }
        function dlsmCallback(_arg_1) {
            trace("dlsm callback :" + _arg_1);
        }
        static var PUFFLE_LAUNCH = "60C36682-96DC-CC2A-A8A7-0318CFC69AE4";
        static var PUFFLE_LAUNCH_BLUE_SKY_START = "3EE515D0-5EA9-F677-4B8E-AA97E6D68FBD";
        static var PUFFLE_LAUNCH_SODA_SUNSET_START = "D4FBD15D-9807-FFE7-1E4F-C6818D3D4489";
        static var PUFFLE_LAUNCH_STARRY_START = "1E190FD6-C065-ED4E-69B2-F268A6C20000";
        static var BLUE_SKY_LEVEL_1 = "BD9FD68B-819A-1B0B-9DE3-AED05CADF46D";
        static var BLUE_SKY_LEVEL_2 = "A3B06726-EB7C-725B-EDAC-D494BC2E8A8E";
        static var BLUE_SKY_LEVEL_3 = "79D7C112-D7D2-D82A-89C5-90BFA7F7487F";
        static var BLUE_SKY_LEVEL_4 = "8FC59D88-857F-DCA4-09F3-DA37B582ED6C";
        static var BLUE_SKY_LEVEL_5 = "F8A2D928-AF29-42DE-2A14-2EB4007146AE";
        static var BLUE_SKY_LEVEL_6 = "08AE3DB7-145E-24F1-F436-8D130BAF92E2";
        static var BLUE_SKY_LEVEL_7 = "05C6AFFE-FE58-7574-376F-A338A0030259";
        static var BLUE_SKY_LEVEL_8 = "5F0BAC87-74CF-6656-C1CE-B00D68AEEE95";
        static var BLUE_SKY_LEVEL_9 = "2FF15571-048A-DF12-707D-6342324F3C12";
        static var BLUE_SKY_LEVEL_10 = "3458FB04-9823-F409-10B3-2E1FFF12309F";
        static var BLUE_SKY_LEVEL_11 = "D4D5DEAD-3750-6D79-2A05-AC5E184055B0";
        static var BLUE_SKY_LEVEL_12 = "A0CA4086-1F16-4640-7432-0CB43E612AA4";
        static var SODA_SUNSET_LEVEL_1 = "01ACAFA0-0BC4-66FE-11E3-768589156802";
        static var SODA_SUNSET_LEVEL_2 = "E82B6BAA-DEF4-B2C8-94D2-F63959589658";
        static var SODA_SUNSET_LEVEL_3 = "0712358B-971C-5A09-E8BD-C9AAF3E821D1";
        static var SODA_SUNSET_LEVEL_4 = "F16DDC85-E6A1-BAC2-2F05-AE0B0F14CD03";
        static var SODA_SUNSET_LEVEL_5 = "459B206A-F15C-6254-489E-573525C206F9";
        static var SODA_SUNSET_LEVEL_6 = "3C899DDB-D418-BAFA-0DD2-BC7074E2A69A";
        static var SODA_SUNSET_LEVEL_7 = "2C6E166A-BDCC-62B5-6C1B-851E66F3BF5E";
        static var SODA_SUNSET_LEVEL_8 = "CC5F340C-560B-D8B6-0787-D585C1C76FD7";
        static var SODA_SUNSET_LEVEL_9 = "52E5E6A0-142B-3796-4C4B-0C3508E714BD";
        static var SODA_SUNSET_LEVEL_10 = "14E1FBFB-3108-FE25-5D3E-51F852C22FA5";
        static var SODA_SUNSET_LEVEL_11 = "29B619DD-8CF2-8070-E1AD-E4DAD75573EE";
        static var SODA_SUNSET_LEVEL_12 = "81DA1EC1-0414-E5DE-0684-95BB8E89F00A";
        static var STARRY_LEVEL_1 = "F5136312-B728-B10B-5E00-D94F82E7FB3A";
        static var STARRY_LEVEL_2 = "51F08EA8-03F2-F10F-E36F-03064FBE3257";
        static var STARRY_LEVEL_3 = "F2C0BD04-58E1-15B2-098A-98BBAA454889";
        static var STARRY_LEVEL_4 = "D3F72CA4-8D20-CD37-D5C3-D5B44877A21B";
        static var STARRY_LEVEL_5 = "CB33800A-83C5-17F5-1102-14E7CA877248";
        static var STARRY_LEVEL_6 = "C5D193DA-7288-F28D-0894-63F7F2EA0841";
        static var STARRY_LEVEL_7 = "892A60BE-38CC-A342-7E28-9E0AD5630706";
        static var STARRY_LEVEL_8 = "21C1DA6B-A151-EF5F-656D-3D30C6293188";
        static var STARRY_LEVEL_9 = "33F95504-D920-2F39-498D-C9B03D3A21B1";
        static var STARRY_LEVEL_10 = "C95E8E93-E76D-9DD2-74D6-DC67BAF0B740";
        static var STARRY_LEVEL_11 = "C2885235-CD84-66A6-E992-9FE8BF720916";
        static var STARRY_LEVEL_12 = "B1C4C706-9F02-8BCB-CB9C-6F31A9A3E576";
        static var NOTIFY_BUILD_CANNON_P1 = "406B13FF-2E9F-F61D-8004-406E216AEE17";
        static var NOTIFY_BUILD_CANNON_P2 = "81464531-2A4D-319C-B9E0-4DDAC285316D";
        static var NOTIFY_BUILD_CANNON_P3 = "FE2867EC-E350-E6B0-5597-0F55124E80BB";
        static var NOTIFY_BLUE_SKY_LEVEL_1 = "072B8F8C-8243-46B2-18A8-397A1FCCFBE1";
        static var NOTIFY_BLUE_SKY_LEVEL_2 = "95D514B4-A857-4AA5-C576-998C4D5785F2";
        static var NOTIFY_BLUE_SKY_LEVEL_3 = "9D621D3D-E5F5-E4FA-D281-F4C996345CA2";
        static var NOTIFY_BLUE_SKY_LEVEL_4 = "6345485D-DCCE-C4BB-4B84-8DDEC78E3E9C";
        static var NOTIFY_BLUE_SKY_LEVEL_5 = "D4CC0AFF-65E2-445B-8DE1-E46E8BF8F3ED";
        static var NOTIFY_BLUE_SKY_LEVEL_6 = "46D08059-6022-53A2-6F81-DA3CCEDB6D1E";
        static var NOTIFY_BLUE_SKY_LEVEL_7 = "D1CEDF2C-C400-DCDB-E416-DAEE37D7AA2F";
        static var NOTIFY_BLUE_SKY_LEVEL_8 = "212F4933-E0EB-37B5-0919-E0CC7D8C0F60";
        static var NOTIFY_BLUE_SKY_LEVEL_9 = "C2B5887F-0C8D-A4EC-1B85-D18F01DB1EAA";
        static var NOTIFY_BLUE_SKY_LEVEL_10 = "29984FFB-6C36-5FEB-85DB-1B2E4C58E0B8";
        static var NOTIFY_BLUE_SKY_LEVEL_11 = "9C623800-6FA0-B9DF-FAB3-D70FAF7B6E2F";
        static var NOTIFY_BLUE_SKY_LEVEL_12 = "BC077312-DBE7-0AAA-CFBC-D614E4193A68";
        static var NOTIFY_SODA_SUNSET_LEVEL_1 = "E49AA48C-435E-7EE3-B329-B1446E44A5EB";
        static var NOTIFY_SODA_SUNSET_LEVEL_2 = "6CEE8C34-5A0A-5431-ACDD-FD7C6B76A4A6";
        static var NOTIFY_SODA_SUNSET_LEVEL_3 = "7CDD147D-9887-2232-B2B5-051D75BB13E0";
        static var NOTIFY_SODA_SUNSET_LEVEL_4 = "FC7CD58C-2427-8431-6885-F083D732B38E";
        static var NOTIFY_SODA_SUNSET_LEVEL_5 = "A7FDA610-0665-9551-EE89-534A73E3282F";
        static var NOTIFY_SODA_SUNSET_LEVEL_6 = "9164C887-2FA3-9C37-D40A-DD7DE8584C1E";
        static var NOTIFY_SODA_SUNSET_LEVEL_7 = "F65B0A2A-0111-159D-1107-1B13D03872FC";
        static var NOTIFY_SODA_SUNSET_LEVEL_8 = "97DD92AE-2D6C-0081-20BA-C1F69C424513";
        static var NOTIFY_SODA_SUNSET_LEVEL_9 = "3521625C-32C7-337D-3D6A-88C340F7F997";
        static var NOTIFY_SODA_SUNSET_LEVEL_10 = "DB52D34B-9FF9-61D4-1404-C7D902C934D4";
        static var NOTIFY_SODA_SUNSET_LEVEL_11 = "DB5CEC6D-A0CD-4A3F-7D55-4155C925300B";
        static var NOTIFY_SODA_SUNSET_LEVEL_12 = "BB4363AB-15AA-EC3B-09DB-49145F7DF4F7";
        static var NOTIFY_STARRY_LEVEL_1 = "8DFF80E5-3464-2E56-B70D-B0531A11793A";
        static var NOTIFY_STARRY_LEVEL_2 = "EFD06CB8-DC70-89AB-D1D7-A326E22F1D1A";
        static var NOTIFY_STARRY_LEVEL_3 = "023E4C91-7EDE-7846-7FF3-E9FC011AE4F8";
        static var NOTIFY_STARRY_LEVEL_4 = "2DD4809F-17DB-D060-37DD-50D33C5862D9";
        static var NOTIFY_STARRY_LEVEL_5 = "A623773D-DA4A-FA0E-AF68-6D833260C1FD";
        static var NOTIFY_STARRY_LEVEL_6 = "9911A51D-86EE-6E71-AB19-0C62D07601CD";
        static var NOTIFY_STARRY_LEVEL_7 = "E3463894-A5BE-1CBE-58D5-83AB25C2BD9F";
        static var NOTIFY_STARRY_LEVEL_8 = "C56C2181-A47D-3AD1-36F7-C3C7B6A08412";
        static var NOTIFY_STARRY_LEVEL_9 = "04F5414C-D3BB-BE13-A4E8-E9F87C4D36FF";
        static var NOTIFY_STARRY_LEVEL_10 = "ED517E0A-72D5-B2E9-61DD-92D940888317";
        static var NOTIFY_STARRY_LEVEL_11 = "A1B8103C-7907-8723-4B62-9DFA206CE710";
        static var NOTIFY_STARRY_LEVEL_12 = "3ED88D1E-BAB5-A649-E32B-58C8047E5C91";
        static var GOOD_BYE = "1404615F-1809-C558-6DD6-6E89A4E3F56B";
        static var CRAB_CRASH = "960B3994-23C0-09FD-3BF0-DD108BDA6BAF";
        static var CRAB_BATTLE = "960B3994-23C0-09FD-3BF0-DD108BDA6BAF";
        static var IN_A_FLASH = "343B57E3-2429-DF45-61AD-9F3760ABD4B1";
        static var LIGHT_SPEED = "41AF7C04-4740-DBA8-AB19-05C7E7704429";
        static var SUPER_SONIC = "A6540D6E-AAF6-FD26-99FE-33F62E8E72A2";
        static var TURBO_TIME = "2C5159E2-4A7C-B6BF-4389-C3CFFBB34E81";
        static var TURBO_CRAB = "D2B66447-7642-032D-94BC-198378DA227B";
        static var MACH = "1FFF5C20-7F99-83E5-59E2-138880932102";
        var BlueSkyLevels = [BLUE_SKY_LEVEL_1, BLUE_SKY_LEVEL_2, BLUE_SKY_LEVEL_3, BLUE_SKY_LEVEL_4, BLUE_SKY_LEVEL_5, BLUE_SKY_LEVEL_6, BLUE_SKY_LEVEL_7, BLUE_SKY_LEVEL_8, BLUE_SKY_LEVEL_9, BLUE_SKY_LEVEL_10, BLUE_SKY_LEVEL_11, BLUE_SKY_LEVEL_12];
        var BlueSkyNotify = [NOTIFY_BLUE_SKY_LEVEL_1, NOTIFY_BLUE_SKY_LEVEL_2, NOTIFY_BLUE_SKY_LEVEL_3, NOTIFY_BLUE_SKY_LEVEL_4, NOTIFY_BLUE_SKY_LEVEL_5, NOTIFY_BLUE_SKY_LEVEL_6, NOTIFY_BLUE_SKY_LEVEL_7, NOTIFY_BLUE_SKY_LEVEL_8, NOTIFY_BLUE_SKY_LEVEL_9, NOTIFY_BLUE_SKY_LEVEL_10, NOTIFY_BLUE_SKY_LEVEL_11, NOTIFY_BLUE_SKY_LEVEL_12];
        var SodaSunsetLevels = [SODA_SUNSET_LEVEL_1, SODA_SUNSET_LEVEL_2, SODA_SUNSET_LEVEL_3, SODA_SUNSET_LEVEL_4, SODA_SUNSET_LEVEL_5, SODA_SUNSET_LEVEL_6, SODA_SUNSET_LEVEL_7, SODA_SUNSET_LEVEL_8, SODA_SUNSET_LEVEL_9, SODA_SUNSET_LEVEL_10, SODA_SUNSET_LEVEL_11, SODA_SUNSET_LEVEL_12];
        var SodaSunsetNotify = [NOTIFY_SODA_SUNSET_LEVEL_1, NOTIFY_SODA_SUNSET_LEVEL_2, NOTIFY_SODA_SUNSET_LEVEL_3, NOTIFY_SODA_SUNSET_LEVEL_4, NOTIFY_SODA_SUNSET_LEVEL_5, NOTIFY_SODA_SUNSET_LEVEL_6, NOTIFY_SODA_SUNSET_LEVEL_7, NOTIFY_SODA_SUNSET_LEVEL_8, NOTIFY_SODA_SUNSET_LEVEL_9, NOTIFY_SODA_SUNSET_LEVEL_10, NOTIFY_SODA_SUNSET_LEVEL_11, NOTIFY_SODA_SUNSET_LEVEL_12];
        var StarryLevels = [STARRY_LEVEL_1, STARRY_LEVEL_2, STARRY_LEVEL_3, STARRY_LEVEL_4, STARRY_LEVEL_5, STARRY_LEVEL_6, STARRY_LEVEL_7, STARRY_LEVEL_8, STARRY_LEVEL_9, STARRY_LEVEL_10, STARRY_LEVEL_11, STARRY_LEVEL_12];
        var StarryNotify = [NOTIFY_STARRY_LEVEL_1, NOTIFY_STARRY_LEVEL_2, NOTIFY_STARRY_LEVEL_3, NOTIFY_STARRY_LEVEL_4, NOTIFY_STARRY_LEVEL_5, NOTIFY_STARRY_LEVEL_6, NOTIFY_STARRY_LEVEL_7, NOTIFY_STARRY_LEVEL_8, NOTIFY_STARRY_LEVEL_9, NOTIFY_STARRY_LEVEL_10, NOTIFY_STARRY_LEVEL_11, NOTIFY_STARRY_LEVEL_12];
        var Puffle_Launch_Stamps = [GOOD_BYE, CRAB_CRASH, CRAB_BATTLE, IN_A_FLASH, LIGHT_SPEED, SUPER_SONIC, TURBO_TIME, TURBO_CRAB, MACH, NOTIFY_BUILD_CANNON_P1, NOTIFY_BUILD_CANNON_P2, NOTIFY_BUILD_CANNON_P3];
        var arrStampsSent = new Array();
    }
