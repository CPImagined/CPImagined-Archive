//Created by Action Script Viewer - https://www.buraks.com/asv
package com.playdom.baseactors
{
    public class BaseMoney 
    {

        private static var _instance:BaseMoney;

        public var amount:Number;
        public var currency:String;
        public var item:String;

        public function BaseMoney(currency:String, amount:Number, item:String=null):void
        {
            this.amount = amount;
            this.currency = currency;
            this.item = item;
        }

        public static function getInstance(currency:String, amount:Number, item:String=null):BaseMoney
        {
            if (_instance)
            {
                _instance.amount = amount;
                _instance.currency = currency;
            }
            else
            {
                _instance = new BaseMoney(currency, amount, item);
            };
            return (_instance);
        }


    }
}//package com.playdom.baseactors
