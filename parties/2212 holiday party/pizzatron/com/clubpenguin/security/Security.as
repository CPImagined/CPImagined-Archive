//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.security.Security
    {
        function Security () {
        }
        static function doSecurityCheck($stageURL, $stageParent) {
            if (!checkDomain($stageURL, $stageParent)) {
                return(false);
            }
            allowDomains();
            return(true);
        }
        static function checkDomain($stageURL, $stageParent) {
            if (com.clubpenguin.util.Reporting.DEBUG_SECURITY) {
                com.clubpenguin.util.Reporting.debugTrace("(Security) checking launch from within club penguin:", com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
                com.clubpenguin.util.Reporting.debugTrace((("(Security) stageURL = " + $stageURL) + ", stageParent = ") + $stageParent, com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
            }
            var _local_2 = false;
            if ($stageURL.substr(0, 4) == "http") {
                var _local_4 = new Array();
                _local_4 = $stageURL.split("/");
                var _local_3 = "clubpenguin.com";
                if (_local_4[2].substr(-_local_3.length) == _local_3) {
                    _local_2 = true;
                }
            }
            if ($stageParent == undefined) {
                _local_2 = false;
            }
            if (!_local_2) {
                _root.loadMovie();
            }
            return(_local_2);
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
