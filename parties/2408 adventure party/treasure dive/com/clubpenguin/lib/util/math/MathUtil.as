package com.clubpenguin.lib.util.math
{
	import flash.geom.Point;

	public class MathUtil
	{
		public static function findAngle(fromX:Number, fromY:Number, toX:Number, toY:Number):Number
		{
			var xDist = toX - fromX;
			var yDist = toY - fromY;
			var angle = Math.atan2(yDist,xDist);
			return Math.round(MathUtil.rad2Deg(angle));
		}
		
		public static function findAngle2(angle:Number):Number
		{
			var angle = Math.atan2(Math.sin(angle),Math.cos(angle));
			return Math.round(MathUtil.rad2Deg(angle));
		}
		
		public static function findDistanceCoordinate(from:Number, to:Number):Number
		{
			return Math.round(Math.abs(from - to));
		}
		
		public static function findDistance(fromX:Number, fromY:Number, toX:Number, toY:Number):Number
		{
			var xDist = Math.round(toX - fromX);
			var yDist = Math.round(toY - fromY);
			return Math.round(Math.sqrt(xDist * xDist + yDist * yDist));
		}
		
		public static function findMotionFromAngle(angle:Number, strength:Number):Point
		{
			return new Point(Math.cos(MathUtil.deg2Rad(angle)) * strength, Math.sin(MathUtil.deg2Rad(angle)) * strength);
		}
		
		public static function findAngleFromMotion(motionX:Number, motionY:Number):Number
		{
			var angle = Math.atan2(motionY,motionX);
			return Math.round(MathUtil.rad2Deg(angle));
		}
		
		public static function findPositionAfterParentRotation(pointX:Number, pointY:Number, parentX:Number, parentY:Number, parentAngle:Number):Point
		{
			var angle = MathUtil.findAngle(0,0,pointX,pointY);
			var dist = MathUtil.findDistance(0,0,pointX,pointY);
			
			angle += parentAngle;
			
			var offset = MathUtil.findMotionFromAngle(angle,dist);
			
			return new Point(parentX, parentY).add(offset);
		}
		
		public static function rad2Deg(angle:Number):Number
		{
			return angle * 180 / Math.PI;
		}
		
		public static function deg2Rad(angle:Number):Number
		{
			return angle * Math.PI / 180;
		}
		
		public static function invertAngleDeg(angle:Number):Number
		{
			return angle - 180;
		}
		
		public static function invertAngleRad(angle:Number):Number
		{
			return angle - Math.PI;
		}
		
		public static function randomRange(min:Number, max:Number):Number
		{
			var minCeiled = Math.ceil(min);
		  	return Math.floor(Math.random() * (Math.floor(max) - minCeiled) + minCeiled);
		}
		
		public static function linearInterpolate(v0:Number, v1:Number, t:Number):Number
		{
			/*
			Returns a value interpolated between v0 and v1, according to t.
			t == 0 maps to v0 and t == 1 maps to v1.
			*/
			return v0 + ((v1 - v0) * t);
		}
	}
}