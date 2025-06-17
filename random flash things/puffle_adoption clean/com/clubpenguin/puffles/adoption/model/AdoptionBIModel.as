//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.model
{
    import flash.utils.getTimer;

    public class AdoptionBIModel 
    {

        public var adoptedByQuiz:uint = 0;
        public var adoptedWithoutQuiz:uint = 0;
        public var sessionDuration:uint = 0;
        private var sessionStartTime:uint;


        public function startTrackingDuration():void
        {
            this.sessionStartTime = getTimer();
        }

        public function endTrackingDuration():void
        {
            this.sessionDuration = (getTimer() - this.sessionStartTime);
        }

        public function getBIDataString():String
        {
            var biDataString:* = (((((this.sessionDuration.toString() + "|") + this.adoptedByQuiz.toString()) + "|") + this.adoptedWithoutQuiz.toString()) + "|");
            return (biDataString);
        }


    }
}//package com.clubpenguin.puffles.adoption.model
