package com.clubpenguin.games.gui
{
	import com.clubpenguin.game.ICPGameHost;
	import com.clubpenguin.game.HostAccess;
	import com.disney.lib.IDisposable;
	import com.clubpenguin.lib.util.data.LocalSaveData;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.StageQuality;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class DisplayQuality implements IDisposable
	{
		public static const QUALITY_SETTING:Array = [StageQuality.LOW,StageQuality.MEDIUM,StageQuality.HIGH];
		public static const MEDIUM_QUALITY_SETTING_INDEX:Number = 1;
		public static var QUALITY_SETTING_STRS:Array;
		
		private var __host:ICPGameHost;
		private var __qualityIndex:Number = MEDIUM_QUALITY_SETTING_INDEX;
		private var __qualityBtnHolder:MovieClip;
		private var __toolTipText:TextField;
		private var __saveData:LocalSaveData;

		public function DisplayQuality(qualityBtnHolder:MovieClip,saveDataName:String)
		{
			// We're referencing the host a lot so let's store it.
			this.__host = HostAccess.getHost();
			
			this.__qualityBtnHolder = qualityBtnHolder;
			
			// This will be referenced frequently just like the host.
			this.__toolTipText = this.__qualityBtnHolder.getChildByName('tooltip_display');

			this.__saveData = new LocalSaveData(saveDataName);
			
			// Store these for later use
			if (QUALITY_SETTING_STRS == undefined)
			{
				QUALITY_SETTING_STRS = new Array(this.__host.localizeString('display_quality_low'),this.__host.localizeString('display_quality_medium'),this.__host.localizeString('display_quality_high'));
			}

			this.setupButtons();
			this.setupDisplayQuality();
		}

		public function dispose():void
		{
			var i = 0;
			while (i < QUALITY_SETTING.length)
			{
				var btn = this.findBtnByIndex(i);
				btn.removeEventListener(MouseEvent.MOUSE_UP, this.handleOnRelease);
				btn.removeEventListener(MouseEvent.ROLL_OVER, this.handleOnRollOver);
				btn.removeEventListener(MouseEvent.ROLL_OUT, this.handleOnRollOut);
				i += 1;
			}
			
			this.__host = null;
			this.__toolTipText = null;
			this.__qualityBtnHolder = null;
			this.__saveData = null;
		}

		public function set qualityIndex(val:Number):void
		{
			if (!isNaN(val) && val >= 0 && val <= QUALITY_SETTING.length)
			{
				this.__qualityIndex = val;

				this.__saveData.updateData({qualityIndex:this.__qualityIndex});
				
				this.__qualityBtnHolder.gotoAndStop(this.__qualityIndex + 1);
				
				this.__host.setQuality(QUALITY_SETTING[this.__qualityIndex]);
			}
		}

		public function get qualityIndex():Number
		{
			return this.__qualityIndex;
		}

		private function setupButtons():void
		{
			var i = 0;
			while (i < QUALITY_SETTING.length)
			{
				var btn = this.findBtnByIndex(i);
				btn.addEventListener(MouseEvent.MOUSE_UP, this.handleOnRelease);
				btn.addEventListener(MouseEvent.ROLL_OVER, this.handleOnRollOver);
				btn.addEventListener(MouseEvent.ROLL_OUT, this.handleOnRollOut);
				i += 1;
			}
		}
		
		private function findBtnIndex(btn:InteractiveObject):int
		{
			return QUALITY_SETTING.indexOf(btn.name.toUpperCase());
		}
		
		private function findBtnByIndex(index:int):InteractiveObject
		{
			return this.__qualityBtnHolder.getChildByName(QUALITY_SETTING[index].toLowerCase());
		}

		private function handleOnRelease(evt:MouseEvent):void
		{
			var index = this.findBtnIndex(evt.currentTarget);
			
			if (index != -1)
			{
				this.qualityIndex = index;
			}
		}
		
		// These 2 functions were copied from CJ water and adapted for this AS3 setup.
		private function handleOnRollOver(evt:MouseEvent):void
		{
			var index = this.findBtnIndex(evt.currentTarget);
			
			if (index != -1)
			{
				this.__toolTipText.text = QUALITY_SETTING_STRS[index];
				this.__toolTipText.x = -this.__qualityBtnHolder.width / 2 - this.__qualityBtnHolder.width / 2 + evt.currentTarget.x;
				this.__toolTipText.visible = true;
			}
		}
		
		private function handleOnRollOut(evt:MouseEvent):void
		{
			this.__toolTipText.visible = false;
			this.__toolTipText.text = '';
		}

		private function setupDisplayQuality():void
		{
			var qualityData = this.__saveData.getData();

			if (qualityData && qualityData.qualityIndex != undefined)
			{
				this.qualityIndex = Number(qualityData.qualityIndex);
			}
			else
			{
				this.qualityIndex = MEDIUM_QUALITY_SETTING_INDEX;
			}
		}
	}
}