package com.clubpenguin.games.diving
{
	import com.clubpenguin.games.container.Container;
	import com.clubpenguin.games.diving.Bubble;
	import com.clubpenguin.lib.util.xml.XMLUtil;
	import com.clubpenguin.games.diving.DivingEngine;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import flash.utils.Dictionary;

	public class BubbleContainer extends Container
	{
		public function BubbleContainer()
		{
			super();
		}
		
		public function addOrMoveBubbles(parent:DisplayObjectContainer, pos:Point, bubblesName:String):void
		{
			var engine = DivingEngine.instance;
			
			if (Math.abs(pos.y - engine.wallBounds.top) > XMLUtil.getFloatFromConfig(engine.gameConfig, "bubbleHeightCutoff", 0.0))
			{
				var bubbles = this._objects[bubblesName];
			
				if (bubbles == null)
				{
					this.addBubbles(parent, pos, bubblesName);
				}
				else
				{
					bubbles.x = pos.x;
					bubbles.y = pos.y;
					
					bubbles.play();
				}
			}
			else
			{
				trace("Too close to top to spawn bubble: " + bubblesName);
			}
		}
		
		public function addBubbles(parent:DisplayObjectContainer, pos:Point, bubblesName:String):void
		{
			var bubbles = new Bubble();
			
			parent.addChild(bubbles);
			
			bubbles.x = pos.x;
			bubbles.y = pos.y;
			
			this.addObject(bubbles, bubblesName);
		}
		
		public function removeAllBubbles():void
		{
			this.callOnAllObjs("dispose");
			
			this._objects = new Dictionary();
		}
		
		override public function removeObject(objName:String):void
		{
			var bubbles = this._objects[objName];
			
			if (bubbles != null)
			{
				bubbles.dispose();
				
				super.removeObject(objName);
			}
		}
	}
}