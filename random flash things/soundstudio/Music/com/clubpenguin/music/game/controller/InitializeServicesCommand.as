//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.controller
{
    import org.robotlegs.mvcs.Command;
    import com.clubpenguin.lib.services.socket.IConnection;
    import com.clubpenguin.music.game.service.INameValidationService;

    public class InitializeServicesCommand extends Command 
    {

        [Inject]
        public var connection:IConnection;
        [Inject]
        public var service:INameValidationService;


        override public function execute():void
        {
            if (!this.service.initialized)
            {
                this.service.init(this.connection);
            };
        }


    }
}//package com.clubpenguin.music.game.controller
