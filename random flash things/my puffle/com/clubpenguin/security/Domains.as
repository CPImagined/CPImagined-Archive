//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.security.Domains
    {
        static var allowedDomains;
        function Domains () {
        }
        static function getAllowedDomains() {
            if (allowedDomains == undefined) {
                initialiseDomainList();
            }
            return(allowedDomains);
        }
        static function initialiseDomainList() {
            if (com.clubpenguin.util.Reporting.DEBUG_SECURITY) {
                com.clubpenguin.util.Reporting.debugTrace("(Domains) initialising allowed domain list", com.clubpenguin.util.Reporting.DEBUGLEVEL_MESSAGE);
            }
            allowedDomains = new Array();
            allowedDomains.push("play.clubpenguin.com");
            allowedDomains.push("play2.clubpenguin.com");
            allowedDomains.push("media.clubpenguin.com");
            allowedDomains.push("media1.clubpenguin.com");
            allowedDomains.push("media2.clubpenguin.com");
            allowedDomains.push("cdn.clubpenguin.com");
            allowedDomains.push("play.critteroo.com");
            allowedDomains.push("play2.critteroo.com");
            allowedDomains.push("media.critteroo.com");
            allowedDomains.push("media1.critteroo.com");
            allowedDomains.push("media2.critteroo.com");
            allowedDomains.push("cdn.critteroo.com");
            allowedDomains.push("play.clubpenguin.co.uk");
            allowedDomains.push("play2.clubpenguin.co.uk");
            allowedDomains.push("media.clubpenguin.co.uk");
            allowedDomains.push("media1.clubpenguin.co.uk");
            allowedDomains.push("media2.clubpenguin.co.uk");
            allowedDomains.push("cdn.clubpenguin.co.uk");
            allowedDomains.push("play.critteroo.co.uk");
            allowedDomains.push("play2.critteroo.co.uk");
            allowedDomains.push("media.critteroo.co.uk");
            allowedDomains.push("media1.critteroo.co.uk");
            allowedDomains.push("media2.critteroo.co.uk");
            allowedDomains.push("cdn.critteroo.co.uk");
            allowedDomains.push("sandbox01.play.clubpenguin.com");
            allowedDomains.push("sandbox01.play2.clubpenguin.com");
            allowedDomains.push("sandbox01.media.clubpenguin.com");
            allowedDomains.push("sandbox01.media1.clubpenguin.com");
            allowedDomains.push("sandbox01.media2.clubpenguin.com");
            allowedDomains.push("sandbox01.cdn.clubpenguin.com");
            allowedDomains.push("sandbox02.play.clubpenguin.com");
            allowedDomains.push("sandbox02.play2.clubpenguin.com");
            allowedDomains.push("sandbox02.media.clubpenguin.com");
            allowedDomains.push("sandbox02.media1.clubpenguin.com");
            allowedDomains.push("sandbox02.media2.clubpenguin.com");
            allowedDomains.push("sandbox02.cdn.clubpenguin.com");
            allowedDomains.push("sandbox03.play.clubpenguin.com");
            allowedDomains.push("sandbox03.play2.clubpenguin.com");
            allowedDomains.push("sandbox03.media.clubpenguin.com");
            allowedDomains.push("sandbox03.media1.clubpenguin.com");
            allowedDomains.push("sandbox03.media2.clubpenguin.com");
            allowedDomains.push("sandbox03.cdn.clubpenguin.com");
            allowedDomains.push("sandbox04.play.clubpenguin.com");
            allowedDomains.push("sandbox04.play2.clubpenguin.com");
            allowedDomains.push("sandbox04.media.clubpenguin.com");
            allowedDomains.push("sandbox04.media1.clubpenguin.com");
            allowedDomains.push("sandbox04.media2.clubpenguin.com");
            allowedDomains.push("sandbox04.cdn.clubpenguin.com");
            allowedDomains.push("sandbox05.play.clubpenguin.com");
            allowedDomains.push("sandbox05.play2.clubpenguin.com");
            allowedDomains.push("sandbox05.media.clubpenguin.com");
            allowedDomains.push("sandbox05.media1.clubpenguin.com");
            allowedDomains.push("sandbox05.media2.clubpenguin.com");
            allowedDomains.push("sandbox05.cdn.clubpenguin.com");
        }
    }
