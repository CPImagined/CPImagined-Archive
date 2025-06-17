//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.music.game.view.components.recorder
{
    import flash.events.EventDispatcher;
    import flash.display.MovieClip;
    import flash.text.TextField;
    import com.clubpenguin.music.game.model.enums.MusicStudioRecordingStatusEnum;
    import flash.events.Event;
    import com.clubpenguin.lib.managers.localization.ILocalizationManager;
    import flash.events.MouseEvent;

    public class MusicStudioRecorderBar extends EventDispatcher 
    {

        private static const DEFAULT_TOTAL_TIME:Number = 180;
        private static const MAX_PLAYHEAD_X_COORD_VALUE:Number = 568;

        protected var skin:MovieClip;
        private var recordButton:MovieClip;
        private var progressBar:MovieClip;
        private var playhead:MovieClip;
        private var playheadLabel:TextField;
        private var progressLabel:TextField;
        private var _elapsedTime:Number = 0;
        private var progressBarBarStartX:Number;
        private var playheadStartX:Number;
        private var _stopButtonLocalizedText:String;
        private var _recordButtonLocalizedText:String;
        private var _status:String;
        private var _totalTime:Number = 0;

        public function MusicStudioRecorderBar(skin:MovieClip)
        {
            this.skin = skin;
            this.init();
        }

        public function set status(value:String):void
        {
            this._status = value;
            this.updateAssetsFromStatus();
        }

        private function updateAssetsFromStatus():void
        {
            var stateFrame:int = 1;
            if (this.status != MusicStudioRecordingStatusEnum.OFF)
            {
                if (this.status == MusicStudioRecordingStatusEnum.PREPARING)
                {
                    stateFrame = 2;
                }
                else
                {
                    if (this.status == MusicStudioRecordingStatusEnum.ON)
                    {
                        stateFrame = 3;
                    };
                };
            };
            this.recordButton.gotoAndStop(stateFrame);
            if (this.recordButton.currentFrame != stateFrame)
            {
                this.updateLocalizationAssets();
            }
            else
            {
                this.localizeLabels();
            };
        }

        private function updateLocalizationAssets():void
        {
            var found:Boolean = this.localizeLabels();
            if (!found)
            {
                this.recordButton.addEventListener(Event.REMOVED_FROM_STAGE, this.onRecordButtonRemoved);
                this.recordButton.addEventListener(Event.ENTER_FRAME, this.onRecordButtonEnterFrame);
            };
        }

        protected function onRecordButtonRemoved(event:Event):void
        {
            this.recordButton.removeEventListener(Event.REMOVED_FROM_STAGE, this.onRecordButtonRemoved);
            this.recordButton.removeEventListener(Event.ENTER_FRAME, this.onRecordButtonEnterFrame);
        }

        protected function onRecordButtonEnterFrame(event:Event):void
        {
            var found:Boolean = this.localizeLabels();
            if (found)
            {
                this.onRecordButtonRemoved(event);
            };
        }

        private function localizeLabels():Boolean
        {
            var isFound:Boolean;
            if (((this._recordButtonLocalizedText) && (this.recordButton.recordLabel)))
            {
                this.recordButton.recordLabel.mouseEnabled = false;
                this.recordButton.recordLabel.text = this._recordButtonLocalizedText;
                isFound = true;
            };
            if (((this._stopButtonLocalizedText) && (this.recordButton.stopLabel)))
            {
                this.recordButton.stopLabel.mouseEnabled = false;
                this.recordButton.stopLabel.text = this._stopButtonLocalizedText;
                isFound = true;
            };
            return (isFound);
        }

        public function get status():String
        {
            return (this._status);
        }

        public function set totalTime(value:Number):void
        {
            this._totalTime = value;
            this.updateTimeAssets();
        }

        public function get totalTime():Number
        {
            return (this._totalTime);
        }

        public function set elapsedTime(value:Number):void
        {
            this._elapsedTime = value;
            this.updateTimeAssets();
        }

        private function updateTimeAssets():void
        {
            this.updateCountdown();
            this.updateTimeLabels();
            this.updateProgressBar();
            this.checkForTotalTimeReached();
        }

        private function updateCountdown():void
        {
            var frame:int;
            var COUNTDOWN_NUM_FRAMES:uint = 4;
            if (((this.elapsedTime <= 0) && (this.status == MusicStudioRecordingStatusEnum.PREPARING)))
            {
                if (this.recordButton.hasOwnProperty("countdown"))
                {
                    frame = (this.elapsedTime + COUNTDOWN_NUM_FRAMES);
                    if (frame == 1)
                    {
                        (this.recordButton.countdown as MovieClip).gotoAndStop(frame);
                    }
                    else
                    {
                        if (frame == 2)
                        {
                            (this.recordButton.countdown as MovieClip).gotoAndPlay(1);
                        }
                        else
                        {
                            if (frame == 3)
                            {
                                (this.recordButton.countdown as MovieClip).gotoAndPlay(11);
                            }
                            else
                            {
                                if (frame == 4)
                                {
                                    (this.recordButton.countdown as MovieClip).gotoAndPlay(21);
                                }
                                else
                                {
                                    (this.recordButton.countdown as MovieClip).gotoAndStop(30);
                                };
                            };
                        };
                    };
                };
            };
        }

        private function updateTimeLabels():void
        {
            var remaining:Number = Math.max(0, Math.min(this.totalTime, (this.totalTime - this.elapsedTime)));
            var currentTime:Number = Math.max(0, Math.min(this.totalTime, this.elapsedTime));
            var remaining_str:String = this.getTimeInStringFormat(remaining);
            this.playheadLabel.text = this.getTimeInStringFormat(currentTime);
            this.progressLabel.text = remaining_str;
        }

        private function getTimeInStringFormat(time:Number):String
        {
            var min:uint = uint((time / 60));
            var sec:uint = Math.round((time % 60));
            var min_str:String = min.toString();
            var sec_str:String = ("0" + sec).substr(-2);
            return ((min_str + ":") + sec_str);
        }

        private function updateProgressBar():void
        {
            var progress:Number = (this.elapsedTime / this.totalTime);
            this.progressBar.bar.x = Math.max(this.progressBarBarStartX, (this.progressBarBarStartX + (this.progressBar.bar.width * progress)));
            this.playhead.x = Math.max(this.playheadStartX, (this.playheadStartX + (this.progressBar.bar.width * progress)));
            if (this.playhead.x > MAX_PLAYHEAD_X_COORD_VALUE)
            {
                this.playhead.x = MAX_PLAYHEAD_X_COORD_VALUE;
            };
        }

        private function checkForTotalTimeReached():void
        {
            if (this.elapsedTime >= this.totalTime)
            {
                dispatchEvent(new Event(Event.COMPLETE));
            };
        }

        public function get elapsedTime():Number
        {
            return (this._elapsedTime);
        }

        public function localize(localizationManager:ILocalizationManager):void
        {
            this._recordButtonLocalizedText = localizationManager.getLocalizedString("w.app.music.game.board.record");
            this._stopButtonLocalizedText = localizationManager.getLocalizedString("w.app.music.game.board.stop");
            this.localizeLabels();
        }

        protected function init():void
        {
            this.recordButton = this.skin.recordButton;
            this.recordButton.memberBadge.mouseEnabled = false;
            this.recordButton.buttonMode = true;
            this.recordButton.addEventListener(MouseEvent.CLICK, this.onRecordButtonClicked);
            this.progressBar = this.skin.progressBar;
            this.progressLabel = this.skin.progressBar.progressLabel;
            this.playhead = this.progressBar.playhead;
            this.playheadLabel = this.progressBar.playhead.label;
            this.progressBarBarStartX = this.progressBar.bar.x;
            this.playheadStartX = this.playhead.x;
            this.totalTime = DEFAULT_TOTAL_TIME;
            this.elapsedTime = 0;
            this.status = MusicStudioRecordingStatusEnum.OFF;
        }

        protected function onRecordButtonClicked(event:MouseEvent):void
        {
            dispatchEvent(new MouseEvent(MouseEvent.CLICK));
        }


    }
}//package com.clubpenguin.music.game.view.components.recorder
