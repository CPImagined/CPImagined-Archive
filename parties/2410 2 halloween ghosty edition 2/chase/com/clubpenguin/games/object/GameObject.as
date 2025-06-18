package com.clubpenguin.games.object
{
	import com.clubpenguin.games.engine.GameEngine;
	import com.disney.lib.*;
	import com.clubpenguin.lib.util.xml.XMLUtil;
	import flash.display.MovieClip;
	import flash.display.BlendMode;

	public class GameObject extends MovieClip implements IDisposable,IUniquelyNamable
	{
		protected var _engine;
		
		public function GameObject()
		{
			super();
			
			this._engine = GameEngine.instance;
			
			if (this.hasCollTestObj())
			{
				if (this._engine.isDebugMode() && XMLUtil.getStringFromConfig(this._engine.gameConfig, "showBounds-" + this.getUniqueName(), "").length != 0)
				{
					// Make it look slightly transparent so it doesn't obscure gameplay.
					this["collBox"].blendMode = BlendMode.LIGHTEN;
				}
				else
				{
					// Players don't need to see these.
					this["collBox"].visible = false;
				}
			}
		}
		
		public function update():void
		{
			// Override me to do something more interesting.
		}
		
		public function getUniqueName():String
		{
			return "GameObject";
		}
		
		public function hasCollTestObj():Boolean
		{
			return this.hasOwnProperty("collBox") && this["collBox"] != null;
		}
		
		public function get collTestObj():MovieClip
		{
			if (this.hasCollTestObj())
			{
				return this["collBox"];
			}
			return this;
		}

		public function dispose():void
		{
			this._engine = null;
		}
	}
}