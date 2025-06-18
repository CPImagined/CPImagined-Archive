//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.service.webservice
{
    import com.clubpenguin.main.vo.WebServiceDataVO;
    import com.clubpenguin.main.signal.LoadWebServiceFatalErrorSignal;
    import com.clubpenguin.main.model.MainModel;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.playdom.tracker.Tracker;
    import org.osflash.signals.Signal;

    public interface IWebServiceManager 
    {

        function load():void;
        function sendDataAcrossBridge():void;
        function getDataByName(_arg_1:String, _arg_2:Boolean=false):WebServiceDataVO;
        function set fatalError(_arg_1:LoadWebServiceFatalErrorSignal):void;
        function set mainModel(_arg_1:MainModel):void;
        function set localizationManager(_arg_1:ILocalizationManager):void;
        function set bridge(_arg_1:IAVMBridgeService):void;
        function set tracker(_arg_1:Tracker):void;
        function get fatalError():LoadWebServiceFatalErrorSignal;
        function get mainModel():MainModel;
        function get localizationManager():ILocalizationManager;
        function get bridge():IAVMBridgeService;
        function get dataLoaded():Signal;
        function get dataLoadProgress():Signal;
        function get dataSent():Signal;
        function get setLoadMethodAndLoad():Signal;

    }
}//package com.clubpenguin.main.service.webservice
