//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.command
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.managers.LoginFloodManager;

    public class UpdateLoginFloodManagerCommand extends SignalCommand 
    {

        [Inject]
        public var loginFloodManager:LoginFloodManager;


        override public function execute():void
        {
            var result:Boolean = this.loginFloodManager.setLoginAttempt();
        }


    }
}//package com.clubpenguin.main.command
