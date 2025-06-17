
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.security.Security
    {
        function Security () {
        }
        static function doSecurityCheck($stageURL, $stageParent) {
            allowDomains();
            checkDomain($stageURL, $stageParent);
        }
        static function checkDomain($stageURL, $stageParent) {
            if (com.clubpenguin.util.Reporting.DEBUG_SECURITY) {
                com.clubpenguin.util.Reporting.debugTrace("(Security) checking launch from within club penguin:", com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
                com.clubpenguin.util.Reporting.debugTrace((("(Security) stageURL = " + $stageURL) + ", stageParent = ") + $stageParent, com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
            }
            var _local2 = false;
            if ($stageURL.substr(0, 4) == "http") {
                var _local4 = new Array();
                _local4 = $stageURL.split("/");
                var _local3 = "clubpenguin.com";
                if (_local4[2].substr(-_local3.length) == _local3) {
                    _local2 = true;
                }
            }
            if ($stageParent == undefined) {
                _local2 = false;
            }
            if (!_local2) {
                _root.loadMovie();
            }
        }
        static function allowDomains() {
            if (com.clubpenguin.util.Reporting.DEBUG_SECURITY) {
                com.clubpenguin.util.Reporting.debugTrace("(Security) allowing all domains", com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
            }
            var _local2 = com.clubpenguin.security.Domains.getAllowedDomains();
            var _local1 = 0;
            var _local3 = _local2.length;
            while (_local1 < _local3) {
                if (com.clubpenguin.util.Reporting.DEBUG_SECURITY) {
                    com.clubpenguin.util.Reporting.debugTrace("(Security) allowing domain " + _local2[_local1], com.clubpenguin.util.Reporting.DEBUGLEVEL_VERBOSE);
                }
                System.security.allowDomain(_local2[_local1]);
                _local1++;
            }
        }
    }
