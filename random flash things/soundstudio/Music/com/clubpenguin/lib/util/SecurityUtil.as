//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.util
{
    import flash.system.Security;

    public class SecurityUtil 
    {


        public static function getAllowedDomains():Array
        {
            var num:String;
            var allowedDomainArray:Array = new Array();
            allowedDomainArray.push("clubpenguin.miniclip.com");
            allowedDomainArray.push("clubpenguin.jeu.fr");
            allowedDomainArray.push("clubpenguin.ojogos.com.br");
            allowedDomainArray.push("clubpenguin.ojogos.pt");
            allowedDomainArray.push("clubpenguin.agame.com");
            allowedDomainArray.push("clubpenguin.juegos.com");
            allowedDomainArray.push("clubpenguin.spel.se");
            allowedDomainArray.push("clubpenguin.spela.se");
            allowedDomainArray.push("clubpenguin.wildtangent.com");
            allowedDomainArray.push("clubpenguin.atrativa.com.br");
            allowedDomainArray.push("clubpenguin-globo.atrativa.com.br");
            allowedDomainArray.push("clubpenguin-click21.atrativa.com.br");
            allowedDomainArray.push("clubpenguin-yahoo.atrativa.com.br");
            allowedDomainArray.push("clubpenguin-ig.atrativa.com.br");
            allowedDomainArray.push("clubpenguin.tfou.fr");
            allowedDomainArray.push("clubpenguin.vtr.com");
            allowedDomainArray.push("clubpenguin.disney.in");
            allowedDomainArray.push("clubpenguin.viwawa.com");
            allowedDomainArray.push("*.play.clubpenguin.com");
            allowedDomainArray.push("*.media1.clubpenguin.com");
            allowedDomainArray.push("stage.secured.clubpenguin.com");
            allowedDomainArray.push("media2.clubpenguin.com");
            allowedDomainArray.push("secured.clubpenguin.com");
            allowedDomainArray.push("stage.play.clubpenguin.com");
            allowedDomainArray.push("stage2.play.clubpenguin.com");
            allowedDomainArray.push("stage.media1.clubpenguin.com");
            allowedDomainArray.push("stage.media2.clubpenguin.com");
            allowedDomainArray.push("stage2.media1.clubpenguin.com");
            allowedDomainArray.push("stage2.media2.clubpenguin.com");
            allowedDomainArray.push("mg01.sandbox.play.clubpenguin.com");
            allowedDomainArray.push("mg01.sandbox.media1.clubpenguin.com");
            allowedDomainArray.push("mg01.sandbox.media2.clubpenguin.com");
            allowedDomainArray.push("mg02.sandbox.play.clubpenguin.com");
            allowedDomainArray.push("mg02.sandbox.media1.clubpenguin.com");
            allowedDomainArray.push("mg02.sandbox.media2.clubpenguin.com");
            allowedDomainArray.push("mg03.sandbox.play.clubpenguin.com");
            allowedDomainArray.push("mg03.sandbox.media1.clubpenguin.com");
            allowedDomainArray.push("mg03.sandbox.media2.clubpenguin.com");
            var i:int = 1;
            while (i < 100)
            {
                num = ((i < 10) ? ("0" + i) : String(i));
                allowedDomainArray.push((("qa" + num) + ".sandbox.play.clubpenguin.com"));
                allowedDomainArray.push((("qa" + num) + ".sandbox.media1.clubpenguin.com"));
                allowedDomainArray.push((("qa" + num) + ".sandbox.media2.clubpenguin.com"));
                allowedDomainArray.push((("pimint" + num) + ".sandbox.play.clubpenguin.com"));
                allowedDomainArray.push((("pimint" + num) + ".sandbox.media1.clubpenguin.com"));
                allowedDomainArray.push((("pimint" + num) + ".sandbox.media2.clubpenguin.com"));
                i++;
            };
            allowedDomainArray.push("bttfdev01.sandbox.play.clubpenguin.com");
            allowedDomainArray.push("cjsnowdev01.sandbox.play.clubpenguin.com");
            allowedDomainArray.push("cjsnowdev02.sandbox.play.clubpenguin.com");
            allowedDomainArray.push("kel-dev-clp-ib03.sandbox.play.clubpenguin.com");
            allowedDomainArray.push("kel-dev-clp-ib03.sandbox.media1.clubpenguin.com");
            allowedDomainArray.push("gameint1-play.clubpenguin.com");
            allowedDomainArray.push("gameint1-play.clubpenguin.com");
            allowedDomainArray.push("gameint1-media1.clubpenguin.com");
            allowedDomainArray.push("gameqa2-play.clubpenguin.com");
            allowedDomainArray.push("gameqa2-media1.clubpenguin.com");
            allowedDomainArray.push("sandbox01.play.clubpenguin.com");
            allowedDomainArray.push("sandbox01.media1.clubpenguin.com");
            allowedDomainArray.push("sandbox01.media2.clubpenguin.com");
            allowedDomainArray.push("sandbox02.play.clubpenguin.com");
            allowedDomainArray.push("sandbox02.media1.clubpenguin.com");
            allowedDomainArray.push("sandbox02.media2.clubpenguin.com");
            allowedDomainArray.push("sandbox03.play.clubpenguin.com");
            allowedDomainArray.push("sandbox03.media1.clubpenguin.com");
            allowedDomainArray.push("sandbox03.media2.clubpenguin.com");
            allowedDomainArray.push("sandbox04.play.clubpenguin.com");
            allowedDomainArray.push("sandbox04.media1.clubpenguin.com");
            allowedDomainArray.push("sandbox04.media2.clubpenguin.com");
            allowedDomainArray.push("sandbox05.play.clubpenguin.com");
            allowedDomainArray.push("sandbox05.media1.clubpenguin.com");
            allowedDomainArray.push("sandbox05.media2.clubpenguin.com");
            return (allowedDomainArray);
        }

        public static function ALLOW_DOMAINS():void
        {
            var domain:String;
            for each (domain in SecurityUtil.getAllowedDomains())
            {
                Security.allowDomain(domain);
            };
        }


    }
}//package com.clubpenguin.lib.util
