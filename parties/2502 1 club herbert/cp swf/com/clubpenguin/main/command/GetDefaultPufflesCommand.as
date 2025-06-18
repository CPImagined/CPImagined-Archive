//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import org.osflash.signals.Signal;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.main.service.webservice.WebServiceManagerProxy;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.lib.enums.puffle.PuffleTypeEnum;
    import com.clubpenguin.lib.enums.puffle.PuffleSubTypeEnum;
    import com.clubpenguin.main.service.webservice.WebServiceType;
    import com.clubpenguin.main.vo.WebServiceDataVO;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.lib.enums.Enum;

    public class GetDefaultPufflesCommand extends SignalCommand 
    {

        [Inject]
        public var _onComplete:Signal;
        [Inject]
        public var mainModel:MainModel;
        [Inject]
        public var webServiceManager:WebServiceManagerProxy;
        [Inject]
        public var localizationManager:ILocalizationManager;


        override public function execute():void
        {
            var puffle:Object;
            var i:int;
            var puffleTypeEnum:PuffleTypeEnum;
            var msg:String;
            var puffleSubTypeEnum:PuffleSubTypeEnum;
            var errorMsg:String;
            var pufflesData:WebServiceDataVO = this.webServiceManager.getDataByName(WebServiceType.PUFFLES.name);
            var errorMessages:Array = new Array();
            for each (puffle in pufflesData.data)
            {
                if (((!(puffle.parent_puffle_id == undefined)) && (!(int(puffle.parent_puffle_id) == int(puffle.puffle_id)))))
                {
                    Log.info((("[GetDefaultPufflesCommand] Found a puffle creature with id " + puffle.puffle_id) + ". Ignoring this entry."));
                }
                else
                {
                    puffleTypeEnum = (Enum.getEnum(PuffleTypeEnum.PUFFLE_TYPE_ENUM_LIST, int(puffle.puffle_id)) as PuffleTypeEnum);
                    if (puffleTypeEnum == null)
                    {
                        msg = (((("GetDefaultPufflesCommand failed to parse PuffleTypeEnum for puffle '" + puffle.description) + "' (id=") + puffle.puffle_id) + ")");
                        Log.error(msg);
                        errorMessages.push(msg);
                    }
                    else
                    {
                        puffleTypeEnum.description = puffle.description;
                        puffleTypeEnum.hexColor = int(puffle.color);
                        if (puffleTypeEnum.id == -1)
                        {
                            puffleTypeEnum.id = int(puffle.puffle_id);
                        };
                    };
                };
            };
            i = 0;
            while (i < PuffleSubTypeEnum.PUFFLE_SUB_TYPE_ENUM_LIST.length)
            {
                puffleSubTypeEnum = PuffleSubTypeEnum.PUFFLE_SUB_TYPE_ENUM_LIST[i];
                puffleSubTypeEnum.description = this.localizationManager.getLocalizedString((("w.puffles.wildpuffle." + puffleSubTypeEnum.name) + ".name"));
                i++;
            };
            this._onComplete.dispatch();
            if (errorMessages.length > 0)
            {
                errorMsg = "GetDefaultPufflesCommand failed to parse puffles webservice. ";
                errorMsg = (errorMsg + "Execution will continue but puffles or other functionality may not work as expected.\n\n");
                errorMsg = (errorMsg + (("Errors:\n" + errorMessages) + "\n"));
                throw (new Error(errorMsg));
            };
        }


    }
}//package com.clubpenguin.main.command
