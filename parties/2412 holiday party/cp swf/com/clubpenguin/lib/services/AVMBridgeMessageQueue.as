//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.services
{
    import com.clubpenguin.lib.vo.AVMBridgeMessage;

    public class AVMBridgeMessageQueue 
    {

        private var messageQueue:Array;

        public function AVMBridgeMessageQueue()
        {
            this.messageQueue = [];
        }

        public function addItem(item:AVMBridgeMessage, atHeadOfQueue:Boolean=false):void
        {
            if (atHeadOfQueue)
            {
                this.messageQueue.unshift(item);
            }
            else
            {
                this.messageQueue.push(item);
            };
        }

        public function get hasNext():Boolean
        {
            return (this.messageQueue.length > 0);
        }

        public function next():AVMBridgeMessage
        {
            if (this.hasNext)
            {
                return (this.messageQueue.shift());
            };
            return (null);
        }


    }
}//package com.clubpenguin.lib.services
