//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.module
{
    import org.robotlegs.core.IInjector;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import com.clubpenguin.lib.managers.resource.IResourceManager;
    import com.clubpenguin.lib.services.socket.IConnection;
    import org.robotlegs.core.ISignalCommandMap;
    import com.clubpenguin.game.ICPGame;

    public interface IAppContext 
    {

        function getInjector():IInjector;
        function getSignalBus():IAppSignalBus;
        function getModel():IAppModel;
        function getLocalizationManager():ILocalizationManager;
        function getResourceManager():IResourceManager;
        function getSocketConnection():IConnection;
        function getSignalCommandMap():ISignalCommandMap;
        function setActiveGame(_arg_1:ICPGame):void;

    }
}//package com.clubpenguin.lib.module
