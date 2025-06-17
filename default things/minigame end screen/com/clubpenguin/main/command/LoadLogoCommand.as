//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.vo.EnvironmentDataVO;
    import com.clubpenguin.lib.vo.PathsVO;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.lib.services.http.LoadSWFService;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.display.MovieClip;
    import flash.display.Loader;
    import com.clubpenguin.lib.services.http.LoadSWFResponse;
    import com.clubpenguin.main.view.LogoView;

    public class LoadLogoCommand extends SignalCommand 
    {

        private static const LOGO_PATH_TOKEN:String = "w.app.logo.logo";

        [Inject]
        public var environmentData:EnvironmentDataVO;
        [Inject]
        public var pathsVO:PathsVO;
        [Inject]
        public var appModel:IAppModel;


        override public function execute():void
        {
            Log.debug("\tLoadLogoCommand.execute()");
            var pathToFile:String = this.pathsVO.getGlobalPath(LOGO_PATH_TOKEN);
            this.loadFile(pathToFile);
        }

        private function loadFile(pathToFile:String):void
        {
            var loadSWFService:LoadSWFService;
            Log.debug((("\tLoadLogoCommand.loadFile(pathToFile: " + pathToFile) + ")"));
            loadSWFService = new LoadSWFService(pathToFile);
            loadSWFService.applicationDomain = ApplicationDomain.currentDomain;
            loadSWFService.context = new LoaderContext(false, loadSWFService.applicationDomain);
            loadSWFService.responseReceived.addOnce(this.onLogoLoadComplete);
            loadSWFService.requestFailed.addOnce(this.onLogoLoadIOError);
            loadSWFService.send();
        }

        private function onLogoLoadComplete(response:LoadSWFResponse):void
        {
            var logoClip:MovieClip;
            var i:String;
            Log.debug("\tLoadLogoCommand.onLogoLoadComplete()");
            try
            {
                logoClip = ((response.data as Loader).content as MovieClip);
                this.setupLogo(logoClip);
            }
            catch(error:Error)
            {
                Log.error("\t\t-Unable to fetch movieclip from response.data:");
                for (i in response)
                {
                    Log.debug(((("\t\t\t-response[" + i) + "]") + response[i]));
                };
            };
        }

        private function onLogoLoadIOError(response:LoadSWFResponse):void
        {
            Log.error("\tLoadLogoCommand.onLogoLoadIOError()");
        }

        private function setupLogo(logoClip:MovieClip):void
        {
            Log.debug("\tLoadLogoCommand.setupLogo()");
            var logoView:LogoView = new LogoView(logoClip, this.appModel.getLanguage());
            injector.mapValue(LogoView, logoView);
        }


    }
}//package com.clubpenguin.main.command
