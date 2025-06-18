package com.clubpenguin.games.diving.obstacles
{
	import com.clubpenguin.games.diving.DivingEngine;
	import com.clubpenguin.games.diving.Environment;
	import com.clubpenguin.games.diving.obstacles.DivingObstacleSpawner;
	import com.clubpenguin.games.container.Container;
	import flash.geom.Point;

	public class DivingObstacleMgr extends Container
	{
		private static var $__spawnerInstanceCount:int = -1;
		
		private var __environment:Environment;
		
		public function DivingObstacleMgr()
		{
			super();
			
			this.__environment = DivingEngine.instance.objManager.getObj("environment");
		}
		
		private function formatSpawnerName(obstacleType:uint, $spawnerNum:uint=10000):String
		{
			var spawnerNum:uint;
			
			// Just some arbitrarily high number we'll never use
			if ($spawnerNum == 10000)
			{
				spawnerNum = ++$__spawnerInstanceCount;
			}
			else
			{
				spawnerNum = $spawnerNum;
			}
			
			return "DivingObstacleSpawner-type" + obstacleType + "-" + spawnerNum;
		}
		
		public function addSpawner(pos:Point, obstacleType:uint, maxObstacles:uint, cooldown:Number, dir:int, initCooldown:Number):void
		{
			var spawner = new DivingObstacleSpawner(obstacleType, maxObstacles, cooldown, dir, initCooldown);
			
			this.__environment.addChild(spawner);
			
			spawner.x = pos.x;
			spawner.y = pos.y;
			
			this.addObject(spawner, this.formatSpawnerName(obstacleType));
		}
		
		public function resetSpawners():void
		{
			this.callOnAllObjs("reset");
		}
		
		public function startSpawners():void
		{
			this.callOnAllObjs("startTimer");
		}
		
		public function removeObstacles():void
		{
			this.callOnAllObjs("removeObstacles");
		}
		
		public function removeSpawner(obstacleType:uint, spawnerNum:uint):void
		{
			var spawnerName = this.formatSpawnerName(obstacleType, spawnerNum);
			
			var spawner = this.getObj(spawnerName);
			
			if (spawner)
			{
				this.__environment.removeChild(spawner);
				
				this.removeObject(spawnerName);
			}
		}
		
		override public function dispose():void
		{
			this.__environment = null;
			
			super.dispose();
		}
		
		override public function getUniqueName():String
		{
			return "[DivingObstacleMgr" + this._uid + "]";
		}
	}
}