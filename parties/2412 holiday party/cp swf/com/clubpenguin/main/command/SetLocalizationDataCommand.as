//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import org.osflash.signals.Signal;
    import com.clubpenguin.lib.module.IAppModel;
    import com.clubpenguin.tools.localtext.core.ILocalText;
    import com.clubpenguin.tools.localtext.core.ILocalizedText;

    public class SetLocalizationDataCommand extends SignalCommand 
    {

        [Inject]
        public var localizationManager:ILocalizationManager;
        [Inject]
        public var _onLoaded:Signal;
        [Inject]
        public var mainModel:IAppModel;
        [Inject]
        public var localText:ILocalText;


        override public function execute():void
        {
            var localizedText:ILocalizedText = this.localizationManager.getGameStrings();
            this.localText.setLocalizedText(localizedText);
            this._onLoaded.dispatch();
        }


    }
}//package com.clubpenguin.main.command
