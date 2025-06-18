package com.clubpenguin.games.net
{
	import com.gskinner.utils.WeakReference;
	import flash.events.Event;

	public class NetClientEvent extends Event
	{
		// Event types
		public static const NET_REQUEST:String = "netClientRequest";
		public static const NET_RECEIVE:String = "netClientReceive";
		public static const REQ_GAME_CONNECT:String = "ncRequestGameConnect";
		public static const REC_GAME_CONNECT:String = "ncReceiveGameConnect";
		public static const REQ_GAME_JOIN:String = "ncRequestGameJoin";
		public static const REC_GAME_JOIN:String = "ncReceiveGameJoin";
		public static const REQ_GAME_LEAVE:String = "ncRequestGameLeave";
		public static const REC_GAME_LEAVE:String = "ncReceiveGameLeave";
		public static const REQ_GAME_PLAYERS:String = "ncRequestGamePlayers";
		public static const REC_GAME_PLAYERS:String = "ncReceiveGamePlayers";
		public static const REQ_GAME_START:String = "ncRequestGameStart";
		public static const REC_GAME_START:String = "ncReceiveGameStart";
		public static const REQ_GAME_ABORT:String = "ncRequestGameAbort";
		public static const REC_GAME_ABORT:String = "ncReceiveGameAbort";
		public static const REQ_GAME_ACTION:String = "ncRequestGameAction";
		public static const REC_GAME_ACTION:String = "ncReceiveGameAction";
		public static const REQ_GAME_OVER:String = "ncRequestGameOver";
		public static const REC_GAME_OVER:String = "ncReceiveGameOver";
		public static const REQ_GAME_ERROR:String = "ncRequestGameError";
		public static const REC_GAME_ERROR:String = "ncReceiveGameError";
		public static const REC_STAMP_INFORMATION:String = "ncStampInfo";
		
		// The actual message type i.e. "jr"
		private var __netMessage:String;
		
		// The message params (if it requires any)
		private var __msgData:WeakReference;

		public function NetClientEvent(_type:String, _netMessage:String, _msgData:Array=null, _bubbles:Boolean=false, _cancelable:Boolean=false)
		{
			super(_type,_bubbles,_cancelable);
			
			this.__netMessage = _netMessage;
			this.__msgData = new WeakReference(_msgData);
		}

		public override function clone():Event
		{
			return new NetClientEvent(this.type, this.__netMessage, this.__msgData, this.bubbles, this.cancelable);
		}

		public function get netMessage():String
		{
			return this.__netMessage;
		}

		public function get msgData():Array
		{
			return this.__msgData.get() as Array;
		}

		public override function toString():String
		{
			return this.formatToString("NetClientEvent", "type", "__netMessage", "__msgData", "bubbles", "cancelable");
		}
	}
}