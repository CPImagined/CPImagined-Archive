package com.clubpenguin.lib.vo{
    public class MPGameVO {

        public var name:String;
        public var mpProduct:String;
        public var worldNamePrefix:String;

        public function MPGameVO(_arg_1:XML){
            trace((("\tMPGameVO(" + _arg_1.descendants()) + ")"));
            if (!_arg_1.hasOwnProperty("game")){
                trace("\t-ERROR: configXML missing game");
            };
            if (_arg_1.game.attribute("gameName")){
                this.name = _arg_1.game.attribute("gameName");
            } else {
                trace("\t-ERROR: configXML.game missing gameName");
            };
            if (_arg_1.game.attribute("mpProduct")){
                this.mpProduct = _arg_1.game.attribute("mpProduct");
            } else {
                trace("\t-ERROR: configXML.game missing mpProduct");
            };
            if (_arg_1.game.attribute("worldNamePrefix")){
                this.worldNamePrefix = _arg_1.game.attribute("worldNamePrefix");
            } else {
                trace("\t-ERROR: configXML.game missing worldNamePrefix");
            };
        }

    }
}//package com.clubpenguin.lib.vo
