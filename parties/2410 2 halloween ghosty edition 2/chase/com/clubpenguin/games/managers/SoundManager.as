package com.clubpenguin.games.managers
{
	import com.clubpenguin.games.container.Container;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	import mx.utils.DelegateAS3;
	import org.osmf.logging.Log;

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

		public function play(sndName:String, loop:Boolean = false, startTime:Number = 0):void
		{
			Log.getLogger(this.getUniqueName()).debug("Trying to play sound: " + sndName + " looping: " + loop);
			
			var snd = this._objects[sndName];

			if (snd != null)
			{
				// Stop so an outstanding loop doesn't keep going.
				this.stop(sndName);
				
				var sndChannel = snd.play(startTime, 0, this.__transforms[sndName]);
				
				/*
				This is null if there is either no sound driver
				or we run out of channels (32 according to the docs).
				*/
				if (sndChannel != null)
				{
					sndChannel.addEventListener(Event.SOUND_COMPLETE, DelegateAS3.globalDelegate.create(sndChannelDoneCallback, [sndName, loop, startTime]));
					
					this.__playingTracks[sndName] = sndChannel;
               		this.__transforms[sndName] = sndChannel.soundTransform;
				}
				else
				{
					Log.getLogger(this.getUniqueName()).warn("Failed to play sound: " + sndName);
				}
			}
			else
			{
				Log.getLogger(this.getUniqueName()).warn("Unknown sound: " + sndName);
			}
		}
		
		private function sndChannelDoneCallback(sndName:String, loop:Boolean, startTime:Number):void
		{
			this.stop(sndName);
			
			if (loop)
			{
				// Loop infinitely until we stop.
				this.play(sndName, true, startTime);
			}
		}
		
		public function playIfNotPlaying(sndName:String, loop:Boolean = false, startTime:Number = 0):void
		{
			if (!this.isTrackPlaying(sndName))
			{
				this.play(sndName, loop, startTime);
			}
			else
			{
				Log.getLogger(this.getUniqueName()).warn("Sound " + sndName + " is already playing.");
			}
		}
		
		public function stop(sndName:String):void
		{
			var sndChannel = this.__playingTracks[sndName];

			if (sndChannel != null)
			{
				Log.getLogger(this.getUniqueName()).debug("Stopping channel for: " + sndName);
				
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
					
					this.__transforms[sndName] = sndTransform;
				}
				
				Log.getLogger(this.getUniqueName()).debug("Sound " + sndName + " had its volume changed to " + newVol);
				
				sndTransform.volume = newVol;
				
				return true;
			}
			
			Log.getLogger(this.getUniqueName()).warn("Volume not changed. Volume must be 0 to 1.");
			
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
					
					this.__transforms[sndName] = sndTransform;
				}
				
				Log.getLogger(this.getUniqueName()).debug("Sound " + sndName + " had its panning changed to " + newPan);
				
				sndTransform.pan = newPan;
				
				return true;
			}
			
			Log.getLogger(this.getUniqueName()).warn("Panning not changed. Pan must be -1 to 1.");
			
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
			
			this.__playingTracks = null;
			
			this.__transforms = null;

			super.dispose();
		}

		public function stopAll():void
		{
			for each(var sndChannel in this.__playingTracks)
			{
				sndChannel.stop();
			}

			this.__playingTracks = new Dictionary();
		}
		
		override public function getUniqueName():String
		{
			return "SoundManager" + this._uid;
		}
	}
}