//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.friends.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.disney.friends.FriendsService;
    import com.clubpenguin.lib.vo.PlayerVO;
    import flash.external.ExternalInterface;

    public class ConnectToFriendsCommand extends SignalCommand 
    {

        private static const FLASH_CRASH_SWID_UPDATE_CALL:String = "Disney.Error.setUserId";

        [Inject]
        public var loginInfo:Object;
        [Inject]
        public var friendsService:FriendsService;
        [Inject]
        public var playerVO:PlayerVO;


        override public function execute():void
        {
            this.playerVO.player_swid = this.loginInfo.swid;
            if (ExternalInterface.available)
            {
                ExternalInterface.call(FLASH_CRASH_SWID_UPDATE_CALL, this.playerVO.player_swid);
            }
            else
            {
                throw (new Error("Trying to call External Interface in ConnectToFriendsCommand - must be run within a web browser."));
            };
            if (!this.loginInfo.isMascot)
            {
                this.friendsService.connectAndLogin(this.loginInfo.swid, ((this.loginInfo.loginDataRaw + "#") + this.loginInfo.confirmationHash));
            };
        }


    }
}//package com.clubpenguin.lib.friends.commands
