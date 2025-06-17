//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.service
{
    import org.robotlegs.mvcs.Actor;
    import com.clubpenguin.lib.services.socket.IConnection;
    import org.osflash.signals.Signal;
    import com.clubpenguin.music.game.model.vo.SongNameValidationVO;
    import com.clubpenguin.lib.util.Log;
    import com.clubpenguin.lib.services.socket.ConnectionConstants;

    public class SongNameValidationService extends Actor implements INameValidationService 
    {

        private static const MESSAGE_TYPE_INVALID_NAME:String = "441";
        private static const MESSAGE_TYPE_CHECK_NAME_WITH_RESPONSE:String = "checkpufflename";

        private var _connection:IConnection;
        private var _validationResult:Signal;
        private var _initialized:Boolean;


        public function get initialized():Boolean
        {
            return (this._initialized);
        }

        public function init(connection:IConnection):void
        {
            this._initialized = true;
            this._validationResult = new Signal(SongNameValidationVO);
            this._connection = connection;
            (this._connection.getResponded() as Signal).add(this.onResponded);
        }

        public function destroy():void
        {
            (this._connection.getResponded() as Signal).remove(this.onResponded);
        }

        public function onResponded(messageType:String, responseData:Array):void
        {
            var name:String;
            var isValid:Boolean;
            var vo:SongNameValidationVO;
            Log.debug(("messageType: " + messageType));
            Log.debug(("responseData: " + responseData));
            switch (messageType)
            {
                case MESSAGE_TYPE_CHECK_NAME_WITH_RESPONSE:
                    name = (responseData[1] as String);
                    isValid = (responseData[2] == "1");
                    vo = new SongNameValidationVO(name, isValid);
                    this._validationResult.dispatch(vo);
                    break;
            };
        }

        public function get nameValidationResult():Signal
        {
            return (this._validationResult);
        }

        public function checkName(name:String):void
        {
            this._connection.sendMessage(ConnectionConstants.MESSAGE_CATEGORY_PUFFLES, MESSAGE_TYPE_CHECK_NAME_WITH_RESPONSE, [name]);
        }


    }
}//package com.clubpenguin.music.game.service
