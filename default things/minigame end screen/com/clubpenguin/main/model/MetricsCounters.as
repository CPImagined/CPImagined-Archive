//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.model
{
    import com.clubpenguin.lib.model.ICounters;

    public class MetricsCounters implements ICounters 
    {

        private var _counters:Object;

        public function MetricsCounters()
        {
            this._counters = new Object();
        }

        public function registerCounter(counter:String):void
        {
            this._counters[counter] = 0;
        }

        public function getCount(counter:String):int
        {
            return ((this._counters[counter] != undefined) ? this._counters[counter] : -1);
        }

        public function incrementCounter(counter:String):void
        {
            if (this._counters[counter] != undefined)
            {
                this._counters[counter]++;
            };
        }

        public function resetCounter(counter:String):void
        {
            if (this._counters[counter] != undefined)
            {
                this._counters[counter] = 0;
            };
        }

        public function resetAllCounters():void
        {
            var counter:String;
            for (counter in this._counters)
            {
                this._counters[counter] = 0;
            };
        }

        public function removeCounter(counter:String):void
        {
            if (this._counters[counter] != undefined)
            {
                delete this._counters[counter];
            };
        }

        public function removeAllCounters():void
        {
            this._counters = new Object();
        }


    }
}//package com.clubpenguin.main.model
