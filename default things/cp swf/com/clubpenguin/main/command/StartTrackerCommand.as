//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.lib.vo.PlayerVO;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;

    public class StartTrackerCommand extends SignalCommand 
    {

        private static const DEFAULT_URL_STRING:String = "http://log.data.disney.com/flash_log?";

        [Inject]
        public var tracker:Tracker;
        [Inject]
        public var mainModel:MainModel;
        [Inject]
        public var player:PlayerVO;
        [Inject]
        public var environmentData:EnvironmentDataVO;
        private var __app:String;
        private var __view:String = "cp";
        private var __network:String = "c";


        override public function execute():void
        {
            var lang:String = this.getLocale();
            this.__app = ((this.environmentData.environment == "live") ? "clubpenguin" : "qa_clubpenguin");
        }

        private function getLocale():String
        {
            var lang:String = this.mainModel.getEnvironmentData().language;
            switch (lang)
            {
                case "en":
                    return ("en_US");
                case "fr":
                    return ("fr_FR");
                case "pt":
                    return ("pt_BR");
                case "es":
                    return ("es_ES");
                case "de":
                    return ("de_DE");
                case "ru":
                    return ("ru_RU");
            };
            throw (new Error((("StartTrackerCommand could not determine the locale for the specified langauge. Make sure that '" + lang) + "' has been added to the switch.")));
        }


    }
}//package com.clubpenguin.main.command
