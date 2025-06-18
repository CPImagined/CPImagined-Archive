//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.service
{
    import com.disney.disneylearning.managers.DLSManager;

    public class DLearningService 
    {

        private var PUFFLE_ITEM_BOUGHT_PUFFLE_O:String = "52001E94-B94F-D2AF-5EC0-EF8957DA96DA";
        private var PUFFLE_ITEM_BOUGHT_COOKIE:String = "B325C4F0-1CC8-3E7B-E06A-59E52F7364B3";
        private var PUFFLE_ITEM_BOUGHT_BUBBLE_GUM:String = "DB168C37-E1FC-289D-D0CE-AC92E096B377";
        private var PUFFLE_ITEM_BOUGHT_PIZZA:String = "9AC4CFAF-84FF-3140-33B8-12DD0645106F";
        private var PUFFLE_ITEM_BOUGHT_CARROT:String = "FDCFE36C-2B58-AA45-D86E-DF1E476BB2F2";
        private var PUFFLE_ITEM_BOUGHT:String = "4EF1A957-28FC-F74B-8D65-2C0D68533C44";
        private var INSUFFICIENT_FUNDS:String = "DF2A58E5-3544-3BCE-6252-5583C4A0BB2E";
        private var PUFFLE_FURNITURE_TOYS:String = "7BCF899D-7DB5-6309-50F0-AF9C79835010";
        private var PUFFLE_FURNITURE_HOUSES:String = "8BD8565C-A3C7-D786-2E19-E289A4A79A68";
        private var PUFFLE_FURNITURE_BEDS:String = "07B08383-8414-82B2-067A-E25DC528404F";
        private var PUFFLE_FURNITURE_GOURMET:String = "33BCAF44-1C47-1381-63FB-8A3C1E303CBE";
        private var _isInitialized:Boolean = false;


        public function init(learnerId:String):void
        {
            this._isInitialized = true;
            DLSManager.init(learnerId, "k.api.dlsnetwork.com");
        }

        public function isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        private function setHost():void
        {
            DLSManager.host = "puffle.care.k.api.dlsnetwork.com";
        }

        public function buyItemPuffleO(amount:int=1):void
        {
            this.setHost();
            DLSManager.instance.pushOpcode("Selected", this.PUFFLE_ITEM_BOUGHT_PUFFLE_O, this.callBackFunc, "0", "0", "0");
            DLSManager.instance.pushOpcode("Notify", this.PUFFLE_ITEM_BOUGHT, this.callBackFunc, "PuffleO", String(amount), "0");
        }

        public function buyItemCookie(amount:int=1):void
        {
            this.setHost();
            DLSManager.instance.pushOpcode("Selected", this.PUFFLE_ITEM_BOUGHT_COOKIE, this.callBackFunc, "0", "0", "0");
            DLSManager.instance.pushOpcode("Notify", this.PUFFLE_ITEM_BOUGHT, this.callBackFunc, "Cookie", String(amount), "0");
        }

        public function buyItemBubbleGum(amount:int=1):void
        {
            this.setHost();
            DLSManager.instance.pushOpcode("Selected", this.PUFFLE_ITEM_BOUGHT_BUBBLE_GUM, this.callBackFunc, "0", "0", "0");
            DLSManager.instance.pushOpcode("Notify", this.PUFFLE_ITEM_BOUGHT, this.callBackFunc, "BubbleGum", String(amount), "0");
        }

        public function buyItemPizza(amount:int=1):void
        {
            this.setHost();
            DLSManager.instance.pushOpcode("Selected", this.PUFFLE_ITEM_BOUGHT_PIZZA, this.callBackFunc, "0", "0", "0");
            DLSManager.instance.pushOpcode("Notify", this.PUFFLE_ITEM_BOUGHT, this.callBackFunc, "Pizza", String(amount), "0");
        }

        public function buyItemCarrot(amount:int=1):void
        {
            this.setHost();
            DLSManager.instance.pushOpcode("Selected", this.PUFFLE_ITEM_BOUGHT_CARROT, this.callBackFunc, "0", "0", "0");
            DLSManager.instance.pushOpcode("Notify", this.PUFFLE_ITEM_BOUGHT, this.callBackFunc, "Carrot", String(amount), "0");
        }

        public function insufficientFunds():void
        {
            this.setHost();
            DLSManager.instance.pushOpcode("Selected", this.INSUFFICIENT_FUNDS, this.callBackFunc, "0", "0", "0");
        }

        public function buyFurnitureToys(amount:int=1):void
        {
            this.setHost();
            DLSManager.instance.pushOpcode("Selected", this.PUFFLE_FURNITURE_TOYS, this.callBackFunc, "0", "0", "0");
            DLSManager.instance.pushOpcode("Notify", this.PUFFLE_ITEM_BOUGHT, this.callBackFunc, "Toys", String(amount), "0");
        }

        public function buyFurnitureHouses(amount:int=1):void
        {
            this.setHost();
            DLSManager.instance.pushOpcode("Selected", this.PUFFLE_FURNITURE_HOUSES, this.callBackFunc, "0", "0", "0");
            DLSManager.instance.pushOpcode("Notify", this.PUFFLE_ITEM_BOUGHT, this.callBackFunc, "Houses", String(amount), "0");
        }

        public function buyFurnitureGourmet(amount:int=1):void
        {
            this.setHost();
            DLSManager.instance.pushOpcode("Selected", this.PUFFLE_FURNITURE_GOURMET, this.callBackFunc, "0", "0", "0");
            DLSManager.instance.pushOpcode("Notify", this.PUFFLE_ITEM_BOUGHT, this.callBackFunc, "Gourmet", String(amount), "0");
        }

        public function buyFurnitureBeds(amount:int=1):void
        {
            this.setHost();
            DLSManager.instance.pushOpcode("Selected", this.PUFFLE_FURNITURE_BEDS, this.callBackFunc, "0", "0", "0");
            DLSManager.instance.pushOpcode("Notify", this.PUFFLE_ITEM_BOUGHT, this.callBackFunc, "Beds", String(amount), "0");
        }

        private function callBackFunc(retString:String):void
        {
        }


    }
}//package com.clubpenguin.main.service
