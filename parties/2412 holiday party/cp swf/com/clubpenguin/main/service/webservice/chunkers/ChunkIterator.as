//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.service.webservice.chunkers
{
    public class ChunkIterator implements IChunkIterator 
    {

        private var map:Array;

        public function ChunkIterator(map:Array)
        {
            this.map = map;
        }

        public function hasNext():Boolean
        {
            return (this.map.length > 0);
        }

        public function next():int
        {
            if (this.hasNext())
            {
                return (this.map.shift());
            };
            return (-1);
        }


    }
}//package com.clubpenguin.main.service.webservice.chunkers
