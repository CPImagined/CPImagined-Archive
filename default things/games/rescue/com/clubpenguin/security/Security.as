//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.security.Security
    {
        function Security () {
        }
        static function doSecurityCheck(_arg_2, _arg_1) {
            allowDomains();
            checkDomain(_arg_2, _arg_1);
        }
        static function checkDomain(_arg_5, _arg_6) {
            if (com.clubpenguin.util.Reporting.DEBUG_SECURITY) {
                com.clubpenguin.util.Reporting.debugTrace("(Security) checking launch from within club penguin:", com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
                com.clubpenguin.util.Reporting.debugTrace((("(Security) stageURL = " + _arg_5) + ", stageParent = ") + _arg_6, com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
            }
            var _local_2 = false;
            if (_arg_5.substr(0, 4) == "http") {
                var _local_4 = new Array();
                _local_4 = _arg_5.split("/");
                var _local_3 = "clubpenguin.com";
                if (_local_4[2].substr(-_local_3.length) == _local_3) {
                    _local_2 = true;
                }
            }
            if (_arg_6 == undefined) {
                _local_2 = false;
            }
            if (!_local_2) {
                _root.loadMovie();
            }
        }
        static function allowDomains() {
            if (com.clubpenguin.util.Reporting.DEBUG_SECURITY) {
                com.clubpenguin.util.Reporting.debugTrace("(Security) allowing all domains", com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
            }
            var _local_2 = com.clubpenguin.security.Domains.getAllowedDomains();
            var _local_1 = 0;
            var _local_3 = _local_2.length;
            while (_local_1 < _local_3) {
                if (com.clubpenguin.util.Reporting.DEBUG_SECURITY) {
                    com.clubpenguin.util.Reporting.debugTrace("(Security) allowing domain " + _local_2[_local_1], com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
                }
                System.security.allowDomain(_local_2[_local_1]);
                _local_1++;
            }
        }
    }
