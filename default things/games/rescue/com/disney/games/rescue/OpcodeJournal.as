//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.disney.games.rescue.OpcodeJournal
    {
        function OpcodeJournal () {
        }
        function init(_arg_1) {
            com.disney.dlearning.managers.DLSManager.init(String(_arg_1), "puffle.rescue.k.api.dlsnetwork.com");
        }
        function sendStartOpcode() {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("START", CP_PUFFLE_RESCUE, dlsmCallback);
        }
        function sendStopOpcode() {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("STOP", CP_PUFFLE_RESCUE, dlsmCallback);
        }
        function sendInstructionsOpcode() {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", PR_INSTRUCTIONS, dlsmCallback);
        }
        function sendOopsOpcode() {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("PRESENTED", PR_OOPS_MESSAGE, dlsmCallback);
        }
        function sendSnowStartOpcode() {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("START", PR_SNOW_AREA, dlsmCallback);
        }
        function sendSnowSelectedOpcode() {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", PR_SNOW_AREA, dlsmCallback);
        }
        function sendSnowStopOpcode() {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("STOP", PR_SNOW_AREA, dlsmCallback);
        }
        function sendSnowGamescoreOpcode(_arg_2, _arg_4, _arg_5, _arg_3) {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("GAMESCORE", PR_SNOW_AREA, dlsmCallback, "" + _arg_2, "" + _arg_4, "" + _arg_5, "" + _arg_3);
            if ((_arg_2 >= 1) & (_arg_2 < 5)) {
                com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", PR_SNOW_SAVE_PUFFLE_01, dlsmCallback);
            } else if ((_arg_2 >= 5) && (_arg_2 < 15)) {
                com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", PR_SNOW_SAVE_PUFFLE_05, dlsmCallback);
            } else if ((_arg_2 >= 15) && (_arg_2 < 20)) {
                com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", PR_SNOW_SAVE_PUFFLE_15, dlsmCallback);
            } else if ((_arg_2 >= 20) && (_arg_2 < 50)) {
                com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", PR_SNOW_SAVE_PUFFLE_20, dlsmCallback);
            } else if (_arg_2 >= 50) {
                com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", PR_SNOW_SAVE_PUFFLE_50, dlsmCallback);
            }
        }
        function sendTempleStartOpcode() {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("START", PR_TEMPLE_AREA, dlsmCallback);
        }
        function sendTempleSelectedOpcode() {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", PR_TEMPLE_AREA, dlsmCallback);
        }
        function sendTempleStopOpcode() {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("STOP", PR_TEMPLE_AREA, dlsmCallback);
        }
        function sendTempleGamescoreOpcode(_arg_2, _arg_4, _arg_5, _arg_3) {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("GAMESCORE", PR_TEMPLE_AREA, dlsmCallback, "" + _arg_2, "" + _arg_4, "" + _arg_5, "" + _arg_3);
            if ((_arg_2 >= 1) & (_arg_2 < 5)) {
                com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", PR_TEMPLE_SAVE_PUFFLE_01, dlsmCallback);
            } else if ((_arg_2 >= 5) && (_arg_2 < 15)) {
                com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", PR_TEMPLE_SAVE_PUFFLE_05, dlsmCallback);
            } else if ((_arg_2 >= 15) && (_arg_2 < 20)) {
                com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", PR_TEMPLE_SAVE_PUFFLE_15, dlsmCallback);
            } else if ((_arg_2 >= 20) && (_arg_2 < 50)) {
                com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", PR_TEMPLE_SAVE_PUFFLE_20, dlsmCallback);
            } else if (_arg_2 >= 50) {
                com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", PR_TEMPLE_SAVE_PUFFLE_50, dlsmCallback);
            }
        }
        function sendVolcanoStartOpcode() {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("START", PR_VOLCANO_AREA, dlsmCallback);
        }
        function sendVolcanoSelectedOpcode() {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", PR_VOLCANO_AREA, dlsmCallback);
        }
        function sendVolcanoStopOpcode() {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("STOP", PR_VOLCANO_AREA, dlsmCallback);
        }
        function sendVolcanoGamescoreOpcode(_arg_2, _arg_4, _arg_5, _arg_3) {
            com.disney.dlearning.managers.DLSManager.instance.pushOpcode("GAMESCORE", PR_VOLCANO_AREA, dlsmCallback, "" + _arg_2, "" + _arg_4, "" + _arg_5, "" + _arg_3);
            if ((_arg_2 >= 1) & (_arg_2 < 5)) {
                com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", PR_VOLCANO_SAVE_PUFFLE_01, dlsmCallback);
            } else if ((_arg_2 >= 5) && (_arg_2 < 15)) {
                com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", PR_VOLCANO_SAVE_PUFFLE_05, dlsmCallback);
            } else if ((_arg_2 >= 15) && (_arg_2 < 20)) {
                com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", PR_VOLCANO_SAVE_PUFFLE_15, dlsmCallback);
            } else if ((_arg_2 >= 20) && (_arg_2 < 50)) {
                com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", PR_VOLCANO_SAVE_PUFFLE_20, dlsmCallback);
            } else if (_arg_2 >= 50) {
                com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", PR_VOLCANO_SAVE_PUFFLE_50, dlsmCallback);
            }
        }
        function sendVolcanoSquidOpcode(_arg_2) {
            if (_arg_2) {
                com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", PR_SEE_SQUID_WITH_MOSSKEY, dlsmCallback);
            } else {
                com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", PR_SEE_SQUID_WITHOUT_MOSSKEY, dlsmCallback);
            }
        }
        function sendStampOpcode(_arg_3) {
            var _local_2 = null;
            switch (_arg_3) {
                case 130 : 
                    _local_2 = ST_PR_130;
                    break;
                case 131 : 
                    _local_2 = ST_PR_131;
                    break;
                case 132 : 
                    _local_2 = ST_PR_132;
                    break;
                case 133 : 
                    _local_2 = ST_PR_133;
                    break;
                case 134 : 
                    _local_2 = ST_PR_134;
                    break;
                case 135 : 
                    _local_2 = ST_PR_135;
                    break;
                case 136 : 
                    _local_2 = ST_PR_136;
                    break;
                case 137 : 
                    _local_2 = ST_PR_137;
                    break;
                case 138 : 
                    _local_2 = ST_PR_138;
                    break;
                case 139 : 
                    _local_2 = ST_PR_139;
                    break;
                case 140 : 
                    _local_2 = ST_PR_140;
                    break;
                case 141 : 
                    _local_2 = ST_PR_141;
                    break;
                case 142 : 
                    _local_2 = ST_PR_142;
                    break;
                case 144 : 
                    _local_2 = ST_PR_144;
                    break;
                case 145 : 
                    _local_2 = ST_PR_145;
                    break;
                case 146 : 
                    _local_2 = ST_PR_146;
                    break;
                case 147 : 
                    _local_2 = ST_PR_147;
                    break;
                case 148 : 
                    _local_2 = ST_PR_148;
                    break;
                case 149 : 
                    _local_2 = ST_PR_149;
                    break;
                case 150 : 
                    _local_2 = ST_PR_150;
                    break;
                case 151 : 
                    _local_2 = ST_PR_151;
                    break;
                case 152 : 
                    _local_2 = ST_PR_152;
                    break;
                case 153 : 
                    _local_2 = ST_PR_153;
                    break;
                case 154 : 
                    _local_2 = ST_PR_154;
                    break;
                case 155 : 
                    _local_2 = ST_PR_155;
                    break;
                case 156 : 
                    _local_2 = ST_PR_156;
                    break;
                case 157 : 
                    _local_2 = ST_PR_157;
                    break;
                case 158 : 
                    _local_2 = ST_PR_158;
            }
            if (_local_2) {
                com.disney.dlearning.managers.DLSManager.instance.pushOpcode("SELECTED", _local_2, dlsmCallback);
            }
        }
        function dlsmCallback(_arg_1) {
        }
        static var CP_PUFFLE_RESCUE = "5D178674-9072-42BD-A412-959A6A5A6812";
        static var PR_INSTRUCTIONS = "D6881EA3-B0EB-2FDF-E77D-E51B38D480A1";
        static var PR_SNOW_AREA = "87FB21A5-F330-0ECF-ECD5-0DFE9DC0F329";
        static var PR_TEMPLE_AREA = "E199C2A0-5AB4-E6AC-1599-00478D7C3B46";
        static var PR_VOLCANO_AREA = "9EF642E3-25EE-3FCC-F1DF-833B96942727";
        static var PR_OOPS_MESSAGE = "F617F561-1FAE-CB8E-8E75-CC952216890A";
        static var PR_SEE_SQUID_WITHOUT_MOSSKEY = "55FD573B-2BD9-F476-93B6-BABF3CD57D9E";
        static var PR_SEE_SQUID_WITH_MOSSKEY = "30685DFC-E9C9-9ACF-862B-0F45532D8C19";
        static var PR_SNOW_SAVE_PUFFLE_01 = "EB8FC3B3-FEAC-D5DC-0F19-497EB19070F1";
        static var PR_SNOW_SAVE_PUFFLE_05 = "39AADD0B-DF71-94A3-6955-CB38E00A5FE4";
        static var PR_SNOW_SAVE_PUFFLE_15 = "12B9A90C-03CE-06D0-996D-B0DB710AC357";
        static var PR_SNOW_SAVE_PUFFLE_20 = "4CDB1B99-5428-E6BD-BD16-0F7175DC7283";
        static var PR_SNOW_SAVE_PUFFLE_50 = "D9806A58-C827-3A1C-9517-85E873DDAF0E";
        static var PR_TEMPLE_SAVE_PUFFLE_01 = "DF51291D-F14B-D2A9-7EE9-80BCAA3FDEAB";
        static var PR_TEMPLE_SAVE_PUFFLE_05 = "415A8203-7BA0-97EB-F319-107C1B565906";
        static var PR_TEMPLE_SAVE_PUFFLE_15 = "423540A8-BF73-0D9A-7723-300D93F5EDF6";
        static var PR_TEMPLE_SAVE_PUFFLE_20 = "2D85E4FD-DF57-FC02-1EE6-F13CEC4D93DE";
        static var PR_TEMPLE_SAVE_PUFFLE_50 = "416897E4-06D7-6CFB-EC91-26686211F2E0";
        static var PR_VOLCANO_SAVE_PUFFLE_01 = "33F16D96-A0BB-EE4B-65FF-E511C389B686";
        static var PR_VOLCANO_SAVE_PUFFLE_05 = "AAC505A1-D6EE-C7A9-5FC4-CFC396F3A8A5";
        static var PR_VOLCANO_SAVE_PUFFLE_15 = "E999F8AB-D2EF-3562-F16C-0AE243641445";
        static var PR_VOLCANO_SAVE_PUFFLE_20 = "E634DBB5-3348-E970-8933-E21BA9A504F3";
        static var PR_VOLCANO_SAVE_PUFFLE_50 = "56381E31-A2FE-EDB4-F941-7671F6262EDB";
        static var ST_PR_130 = "C572797D-687E-66A9-60A4-386DF7934723";
        static var ST_PR_131 = "43D4186A-BC94-E1C4-1513-7B7BC68C03E9";
        static var ST_PR_132 = "4EA4A4A6-ACC1-CEDF-C219-62612A76E509";
        static var ST_PR_133 = "EDA6D5D0-1431-80B9-932D-89530A29DE1E";
        static var ST_PR_134 = "F464B112-AB4D-305B-0FD0-7B6F4236C882";
        static var ST_PR_135 = "13BDD93B-1FA6-3CA9-4FD9-A569203533C3";
        static var ST_PR_136 = "33D573A0-0D54-1884-2EA8-5E0341B0CC1A";
        static var ST_PR_137 = "9F55C76C-B089-9BBA-8842-2D50C5CD43F6";
        static var ST_PR_138 = "16B9FA6D-C2C1-2598-DD31-D7F760356832";
        static var ST_PR_139 = "B7A8DE73-1304-A1DF-CD4F-605478AED163";
        static var ST_PR_140 = "2E470021-B8C7-52CD-0E0D-CB859FB0C64D";
        static var ST_PR_141 = "5570E0E2-54A8-FBC9-6C16-6669C03443D6";
        static var ST_PR_142 = "2E6EA473-008A-76AA-CFF6-510FAE159F85";
        static var ST_PR_144 = "A8D31862-9DDD-C359-34CA-E2E8420F0F8F";
        static var ST_PR_145 = "64DF0210-DD77-3054-599C-1CB64BC49271";
        static var ST_PR_146 = "3E4EF833-D9F2-9B32-C08B-4229C3E37772";
        static var ST_PR_147 = "9F4CCD5A-B36D-2518-5E80-CB036838B9B3";
        static var ST_PR_148 = "C5796241-F810-19DF-2E09-E1FCE32C0D41";
        static var ST_PR_149 = "B2333980-757B-013B-4603-C8F2D849D67A";
        static var ST_PR_150 = "0422FC5A-039D-7043-E07D-9FE7F8D9B294";
        static var ST_PR_151 = "B0A4FC7E-DC35-D262-85F1-95FEB214DF79";
        static var ST_PR_152 = "1FB7A6B6-8F9F-01AA-98FA-4C7C6C95D35F";
        static var ST_PR_153 = "BD72A74D-CDA8-E7E7-2479-0EA1C87A1C6F";
        static var ST_PR_154 = "BC01142A-11F9-B8D4-6384-93815D1E17E2";
        static var ST_PR_155 = "BAC9BBD3-E557-94AF-EC0B-D48BF2B8E5A0";
        static var ST_PR_156 = "9668E7E6-DEC1-757C-C78C-6E95B2C1424A";
        static var ST_PR_157 = "E804F584-63AE-D356-34D7-62D7D668630B";
        static var ST_PR_158 = "63B5A7DF-64A1-9311-4A2A-E242C0F6C912";
    }
