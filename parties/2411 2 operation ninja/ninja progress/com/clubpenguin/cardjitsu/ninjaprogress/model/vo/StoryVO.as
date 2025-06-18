//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.cardjitsu.ninjaprogress.model.vo
{
    public class StoryVO 
    {

        public static const HAS_TUSK_CAPE:String = "hasTuskCape";
        public static const HAS_TUSK_CAPE_DEFAULT_VALUE:Boolean = false;
        public static const CINEMATIC_9_STATUS:Object = {"HAS_TUSK_CAPE":HAS_TUSK_CAPE_DEFAULT_VALUE};

        public var storyLevel:Number;
        public var isLocked:Boolean;
        public var videoURL:String;

        public function StoryVO(storyLevel:Number, isLocked:Boolean, videoURL:String)
        {
            this.storyLevel = storyLevel;
            this.isLocked = isLocked;
            this.videoURL = videoURL;
        }

        public function destroy():void
        {
        }


    }
}//package com.clubpenguin.cardjitsu.ninjaprogress.model.vo
