//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.resources.song
{
    import flash.events.EventDispatcher;
    import __AS3__.vec.Vector;
    import flash.utils.Timer;
    import flash.system.ApplicationDomain;
    import flash.media.SoundTransform;
    import com.clubpenguin.lib.util.Log;
    import flash.media.Sound;
    import flash.media.SoundMixer;
    import flash.events.TimerEvent;
    import flash.media.SoundChannel;
    import flash.utils.getTimer;
    import flash.events.Event;
    import com.clubpenguin.music.player.MusicPlayer;
    import __AS3__.vec.*;

    public class SongRecorded extends EventDispatcher 
    {

        private const TIMER_INTERVAL:uint = 50;
        private const END_OF_FILE:String = "1111111111111111";
        private const NUM_SOUNDS_LOOPS:uint = 25;
        private const NUM_SOUNDS:uint = 40;
        private const GRID_STATUS_DEFAULT:Array = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

        private var _songID:int;
        private var _playerID:int;
        private var _autoPlay:Boolean;
        private var _fade:Boolean;
        private var _loop:Boolean;
        private var _rawData:String;
        private var _media:Vector.<RecordData>;
        private var _channel:Array;
        private var _albumID:int;
        private var _playbackTimer:Timer;
        private var _currentMediaIndex:Number;
        private var _genreAsset:ApplicationDomain;
        private var _muted:Boolean = false;
        private var muteTransform:SoundTransform = new SoundTransform(0);
        private var playTransform:SoundTransform = new SoundTransform(1);
        private var startTime:int;

        public function SongRecorded(songID:int, playerID:int, autoPlay:Boolean=true, fade:Boolean=true, loop:Boolean=false, rawData:String=null)
        {
            Log.debug(((songID + " ") + playerID));
            this._songID = songID;
            this._playerID = playerID;
            this._autoPlay = autoPlay;
            this._fade = fade;
            this._loop = loop;
            this._rawData = rawData;
            this._channel = new Array();
        }

        public function get songID():int
        {
            return (this._songID);
        }

        public function get playerID():int
        {
            return (this._playerID);
        }

        public function get autoPlay():Boolean
        {
            return (this._autoPlay);
        }

        public function get fade():Boolean
        {
            return (this._fade);
        }

        public function get genreID():int
        {
            return (this._albumID);
        }

        public function get rawData():String
        {
            return (this._rawData);
        }

        public function set loop(value:Boolean):void
        {
            this._loop = value;
        }

        public function play(albumAsset:ApplicationDomain):void
        {
            var soundDefinition:Class;
            var tempSound:Sound;
            Log.debug("");
            SoundMixer.stopAll();
            if (((this._media == null) || (albumAsset == null)))
            {
                return;
            };
            this._genreAsset = albumAsset;
            this._playbackTimer = new Timer(this.TIMER_INTERVAL, 0);
            this._playbackTimer.addEventListener(TimerEvent.TIMER, this.timer_Tick_Handler);
            this._currentMediaIndex = 0;
            var i:uint;
            while (i < this.NUM_SOUNDS_LOOPS)
            {
                if (!this._genreAsset.hasDefinition(("music_clip_" + i.toString())))
                {
                }
                else
                {
                    soundDefinition = (this._genreAsset.getDefinition(("music_clip_" + i.toString())) as Class);
                    tempSound = (new (soundDefinition)() as Sound);
                    this._channel[i] = tempSound.play(0, 999);
                    Log.debug((SoundChannel(this._channel[i]) + ""));
                    SoundChannel(this._channel[i]).soundTransform = this.muteTransform;
                };
                i++;
            };
            this.startTime = getTimer();
            this._playbackTimer.start();
        }

        public function set volume(volume:Number):void
        {
            var soundChannel:SoundChannel;
            this.playTransform.volume = volume;
            for each (soundChannel in this._channel)
            {
                if (this._muted == true)
                {
                    soundChannel.soundTransform = this.muteTransform;
                }
                else
                {
                    if (soundChannel.soundTransform.volume > 0)
                    {
                        soundChannel.soundTransform = this.playTransform;
                    };
                };
            };
        }

        public function get volume():Number
        {
            return (this.playTransform.volume);
        }

        public function stop():void
        {
            if (this._playbackTimer != null)
            {
                this._playbackTimer.reset();
                this._playbackTimer.removeEventListener(TimerEvent.TIMER, this.timer_Tick_Handler);
            };
            this._currentMediaIndex = 0;
            if (this._loop == true)
            {
                this.play(this._genreAsset);
            }
            else
            {
                this.stopAllSounds();
            };
        }

        public function mute():void
        {
            this._muted = true;
            this.volume = this.playTransform.volume;
        }

        public function unmute():void
        {
            this._muted = false;
            if (this._media.length == 0)
            {
                return;
            };
            var gridStatus:Array = this._media[(this._currentMediaIndex - 1)].recordGridStatus.split("");
            var i:uint;
            while (i < this.NUM_SOUNDS_LOOPS)
            {
                if (gridStatus[i] == 1)
                {
                    SoundChannel(this._channel[i]).soundTransform = this.playTransform;
                };
                i++;
            };
        }

        public function resetLoops():void
        {
            var soundDefinition:Class;
            var tempSound:Sound;
            Log.debug("Entering");
            if (this._currentMediaIndex <= 0)
            {
                return;
            };
            var gridStatus:Array = this._media[(this._currentMediaIndex - 1)].recordGridStatus.split("");
            var i:uint;
            while (i < this.NUM_SOUNDS_LOOPS)
            {
                Log.debug(("Stopping Loop with channel id: " + i));
                SoundChannel(this._channel[i]).stop();
                soundDefinition = (this._genreAsset.getDefinition(("music_clip_" + i.toString())) as Class);
                tempSound = (new (soundDefinition)() as Sound);
                this._channel[i] = tempSound.play(0, 999);
                if (gridStatus[i] == 1)
                {
                    SoundChannel(this._channel[i]).soundTransform = this.playTransform;
                }
                else
                {
                    SoundChannel(this._channel[i]).soundTransform = this.muteTransform;
                };
                i++;
            };
        }

        public function appendStatus(status:String):void
        {
            var timestamp:Number = (((this._playbackTimer.currentCount + 0) * this._playbackTimer.delay) + 100);
            this._media.push(new RecordData(status, timestamp));
        }

        public function convertRawData(rawData:String):void
        {
            var recordString:String;
            var recordGridStatus:String;
            var recordTimeStamp:Number;
            Log.debug(("" + rawData));
            var dataCollection:Vector.<RecordData> = new Vector.<RecordData>();
            var songData:Array = rawData.split(",");
            this._albumID = int(songData.splice(0, 1));
            for each (recordString in songData)
            {
                recordGridStatus = this.hexToBinary(recordString.split("|")[0]);
                recordTimeStamp = this.hexToDecimal(recordString.split("|")[1]);
                dataCollection.push(new RecordData(recordGridStatus, recordTimeStamp));
            };
            this._media = dataCollection;
        }

        private function stopAllSounds():void
        {
            var channel:SoundChannel;
            Log.debug("");
            for each (channel in this._channel)
            {
                if (channel != null)
                {
                    channel.stop();
                };
            };
        }

        private function timer_Tick_Handler(e:TimerEvent):void
        {
            var currentTime:Number = (getTimer() - this.startTime);
            var i:Number = this._currentMediaIndex;
            while (i < this._media.length)
            {
                if (((currentTime > this._media[this._currentMediaIndex].recordTimeStamp) || (Math.abs((currentTime - this._media[this._currentMediaIndex].recordTimeStamp)) < 10)))
                {
                    this.evaluateGridStatus(this._media[this._currentMediaIndex].recordGridStatus);
                    this._currentMediaIndex++;
                }
                else
                {
                    break;
                };
                i++;
            };
        }

        private function evaluateGridStatus(gridStatus:String):void
        {
            if (gridStatus.indexOf(this.END_OF_FILE) != -1)
            {
                this.stop();
                this.songCompleted();
                return;
            };
            var currentGridStatus:Array = gridStatus.split("");
            var prevGridStatus:Array = this.GRID_STATUS_DEFAULT;
            if (this._currentMediaIndex > 0)
            {
                prevGridStatus = this._media[(this._currentMediaIndex - 1)].recordGridStatus.split("");
            };
            var i:Number = 0;
            while (i < this.NUM_SOUNDS)
            {
                if (((!(currentGridStatus[i] == prevGridStatus[i])) || ((i >= this.NUM_SOUNDS_LOOPS) && (currentGridStatus[i] == 1))))
                {
                    this.evaluateGridChange(parseInt(currentGridStatus[i]), i);
                };
                i++;
            };
        }

        private function evaluateGridChange(currentValue:int, gridID:int):void
        {
            if (((currentValue == 0) && (!(this._channel[gridID] == null))))
            {
                this.stopSoundChannel(gridID);
            }
            else
            {
                if (currentValue == 1)
                {
                    this.startSoundChannel(gridID);
                };
            };
        }

        private function startSoundChannel(id:Number):void
        {
            var soundDefinition:Class;
            var tempSound:Sound;
            if ((((!(this._muted)) && (id < this.NUM_SOUNDS_LOOPS)) && (!(this._channel[id] == null))))
            {
                SoundChannel(this._channel[id]).soundTransform = this.playTransform;
            }
            else
            {
                if (id >= this.NUM_SOUNDS_LOOPS)
                {
                    this.stopOnOffSound(id);
                    soundDefinition = (this._genreAsset.getDefinition(("music_clip_" + id.toString())) as Class);
                    tempSound = (new (soundDefinition)() as Sound);
                    this._channel[id] = tempSound.play(0);
                    if (this._channel[id] == null)
                    {
                        return;
                    };
                    if (this._muted)
                    {
                        SoundChannel(this._channel[id]).soundTransform = this.muteTransform;
                    }
                    else
                    {
                        SoundChannel(this._channel[id]).soundTransform = this.playTransform;
                    };
                };
            };
        }

        private function stopOnOffSound(id:Number, stopOtherOneOffs:Boolean=true):void
        {
            if (!stopOtherOneOffs)
            {
                if ((this._channel[id] is SoundChannel))
                {
                    (this._channel[id] as SoundChannel).stop();
                };
                return;
            };
            var i:int = this.NUM_SOUNDS_LOOPS;
            while (i < this.NUM_SOUNDS)
            {
                if ((this._channel[i] is SoundChannel))
                {
                    (this._channel[i] as SoundChannel).stop();
                };
                i++;
            };
        }

        private function stopSoundChannel(id:Number):void
        {
            if (id < this.NUM_SOUNDS_LOOPS)
            {
                SoundChannel(this._channel[id]).soundTransform = this.muteTransform;
            };
        }

        private function songCompleted():void
        {
            if (this._loop == false)
            {
                dispatchEvent(new Event(MusicPlayer.EVENT_SONG_COMPLETE, false, true));
            };
        }

        private function binaryToHex(binary:String):String
        {
            var decimal:Number = parseInt(binary, 2);
            var hex:String = decimal.toString(16);
            return (hex);
        }

        private function hexToDecimal(hex:String):Number
        {
            return (parseInt(hex, 16));
        }

        private function hexToBinary(hex:String):String
        {
            var decimal:Number = parseInt(hex, 16);
            var binary:String = decimal.toString(2);
            while (binary.length < this.NUM_SOUNDS)
            {
                binary = ("0" + binary);
            };
            Log.debug(binary);
            return (binary);
        }


    }
}//package com.clubpenguin.music.resources.song
