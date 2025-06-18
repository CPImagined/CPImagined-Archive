package com.clubpenguin.games.managers
{
	import com.clubpenguin.games.engine.GameEngine;
	import com.disney.lib.IDisposable;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	public class InputMgr implements IDisposable
	{
		private var __gameEngine:GameEngine;

		private var keyDownBits:Array;
		private var keyPressedBits:Array;

		private var mouseDownBit:Boolean;
		private var mousePressedBit:Boolean;

		public function InputMgr(engine:GameEngine)
		{
			super();
		
			this.keyDownBits = new Array(256);
			this.keyPressedBits = new Array(256);
			
			this.mouseDownBit = false;
			this.mousePressedBit = false;

			this.__gameEngine = engine;
			
			this.init();
		}

		public function init():void
		{
			this.__gameEngine.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
			this.__gameEngine.stage.addEventListener(KeyboardEvent.KEY_UP,this.keyUpHandler);

			this.__gameEngine.stage.addEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
			this.__gameEngine.stage.addEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
			
			this.__gameEngine.stage.addEventListener(Event.DEACTIVATE,this.deactivateHandler);
		}

		public function isKeyDown(key:uint):Boolean
		{
			// Check if a key is currently being held down.
			return Boolean(this.keyDownBits[key]);
		}
		
		public function isKeyPressed(key:uint):Boolean
		{
			// Check if a key was pressed this game tick.
			return Boolean(this.keyPressedBits[key]);
		}

		private function keyDownHandler(evt:KeyboardEvent):void
		{
			this.keyDownBits[evt.keyCode] = true;
			this.keyPressedBits[evt.keyCode] = true;
		}

		private function keyUpHandler(evt:KeyboardEvent):void
		{
			this.keyDownBits[evt.keyCode] = false;
		}
		
		private function mouseDownHandler(evt:MouseEvent):void
		{
			this.mouseDownBit = true;
			this.mousePressedBit = true;
		}
		
		private function mouseUpHandler(evt:MouseEvent):void
		{
			this.mouseDownBit = false;
		}
		
		public function releasePressedKeys():void
		{
			// Called in the main loop to release everything pressed down last game tick.
			
			// Easier to just re-initialize it to clear the state out.
			this.keyPressedBits = new Array(256);
			
			this.mousePressedBit = false;
		}
		
		public function isMouseDown():Boolean
		{
			// Check if the mouse button is currently being held down.
			return this.mouseDownBit;
		}
		
		public function isMousePressed():Boolean
		{
			// Check if the mouse button was pressed this game tick.
			return this.mousePressedBit;
		}

		private function deactivateHandler(evt: Event):void
		{
			this.keyDownBits = new Array(256);
			this.keyPressedBits = new Array(256);
			
			this.mouseDownBit = false;
			this.mousePressedBit = false;
		}

		public function dispose():void
		{
			this.__gameEngine.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
			this.__gameEngine.stage.removeEventListener(KeyboardEvent.KEY_UP,this.keyUpHandler);
			
			this.__gameEngine.stage.removeEventListener(MouseEvent.MOUSE_DOWN,this.mouseDownHandler);
			this.__gameEngine.stage.removeEventListener(MouseEvent.MOUSE_UP,this.mouseUpHandler);
			
			this.__gameEngine.stage.removeEventListener(Event.DEACTIVATE,this.deactivateHandler);
			
			this.keyDownBits = null;
			this.keyPressedBits = null;
			
			this.mouseDownBit = false;
			this.mousePressedBit = false;

			this.__gameEngine = null;
		}
	}
}