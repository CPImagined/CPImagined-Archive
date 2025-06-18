package com.clubpenguin.games.managers
{
	import com.clubpenguin.games.container.Container;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	import mx.utils.DelegateAS3;

	public class SoundManager extends Container
	{
		private var __playingTracks:Dictionary;
		private var __transforms:Dictionary;

		public function SoundManager()
		{
			super();

			this.__playingTracks = new Dictionary();
			this.__transforms = new Dictionary();
		}

		public function play(sndName:String, loop:Boolean = false):void
		{
			trace(this.getUniqueName() + " Trying to play sound: " + sndName + " looping: " + loop);
			
			var snd = this._objects[sndName];

			if (snd != null)
			{
				var sndChannel = snd.play(0, loop ? 9999 : 0, this.__transforms[sndName]);
				
				/*
				This is null if there is either no sound driver
				or we run out of channels (32 according to the docs).
				*/
				if (sndChannel != null)
				{
					sndChannel.addEventListener(Event.SOUND_COMPLETE, DelegateAS3.globalDelegate.create(sndChannelDoneCallback, [sndName, loop]));
		
					this.__playingTracks[sndName] = sndChannel;
					
					this.__transforms[sndName] = sndChannel.soundTransform;
				}
				else
				{
					trace(this.getUniqueName() + " Failed to play sound: " + sndName);
				}
			}
			else
			{
				trace(this.getUniqueName() + " Unknown sound: " + sndName);
			}
		}
		
		private function sndChannelDoneCallback(sndName:String, loop:Boolean):void
		{
			this.stop(sndName);
			
			if (loop)
			{
				// Loop infinitely until we stop.
				this.play(sndName, true);
			}
		}
		
		public function playIfNotPlaying(sndName:String, loop:Boolean = false):void
		{
			if (!this.isTrackPlaying(sndName))
			{
				this.play(sndName,loop);
			}
			else
			{
				trace(this.getUniqueName() + " sound " + sndName + " is already playing.");
			}
		}
		
		public function stop(sndName:String):void
		{
			var sndChannel = this.__playingTracks[sndName];

			if (sndChannel != null)
			{
				trace(this.getUniqueName() + " Stopping channel for " + sndName + ".");
				
				sndChannel.stop();
				delete this.__playingTracks[sndName];
			}
		}

		public function isTrackPlaying(sndName:String):Boolean
		{
			var sndChannel:SoundChannel = this.__playingTracks[sndName];
			return sndChannel != null;
		}

		public function changeVolume(sndName:String, newVol:Number):Boolean
		{
			if (newVol >= 0 && newVol <= 1)
			{
				var sndTransform = this.__transforms[sndName];
				
				if (sndTransform == null)
				{
					sndTransform = new SoundTransform();
				}
				
				trace(this.getUniqueName() + " Sound " + sndName + " had its volume changed to " + newVol);
				
				sndTransform.volume = newVol;
				
				this.__transforms[sndName] = sndTransform;
				
				return true;
			}
			
			trace(this.getUniqueName() + " Volume not changed. Volume must be 0 to 1.");
			
			return false;
		}
		
		public function changePan(sndName:String, newPan:Number):Boolean
		{
			if (newPan >= -1 && newPan <= 1)
			{
				var sndTransform = this.__transforms[sndName];
				
				if (sndTransform == null)
				{
					sndTransform = new SoundTransform();
				}
				
				trace(this.getUniqueName() + " Sound " + sndName + " had its panning changed to " + newPan);
				
				sndTransform.pan = newPan;
				
				this.__transforms[sndName] = sndTransform;
				
				return true;
			}
			
			trace(this.getUniqueName() + " Panning not changed. Volume must be -1 to 1.");
			
			return false;
		}

		override public function removeObject(sndName:String):void
		{
			this.stop(sndName);

			super.removeObject(sndName);
		}

		override public function dispose():void
		{
			this.stopAll();
			
			this.__transforms = null;

			super.dispose();
		}

		public function stopAll():void
		{
			for each (var sndChannel in this.__playingTracks)
			{
				sndChannel.stop();
			}

			this.__playingTracks = null;
		}
		
		override public function getUniqueName():String
		{
			return "[SoundManager" + this._uid + "]";
		}
	}
}