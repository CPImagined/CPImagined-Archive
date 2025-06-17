//Created by Action Script Viewer - https://www.buraks.com/asv
package it.gotoandplay.smartfoxserver.data
{
    public class User 
    {

        private var isSpec:Boolean;
        private var name:String;
        private var id:int;
        private var pId:int;
        private var variables:Array;
        private var isMod:Boolean;

        public function User(id:int, name:String)
        {
            this.id = id;
            this.name = name;
            this.variables = [];
            this.isSpec = false;
            this.isMod = false;
        }

        public function setModerator(b:Boolean):void
        {
            this.isMod = b;
        }

        public function getName():String
        {
            return (this.name);
        }

        public function getVariables():Array
        {
            return (this.variables);
        }

        public function getId():int
        {
            return (this.id);
        }

        public function getPlayerId():int
        {
            return (this.pId);
        }

        public function setPlayerId(pid:int):void
        {
            this.pId = pid;
        }

        public function setIsSpectator(b:Boolean):void
        {
            this.isSpec = b;
        }

        public function isSpectator():Boolean
        {
            return (this.isSpec);
        }

        public function clearVariables():void
        {
            this.variables = [];
        }

        public function getVariable(varName:String):Object
        {
            return (this.variables[varName]);
        }

        public function setVariables(vars:Array):void
        {
            this.variables = vars;
        }

        public function isModerator():Boolean
        {
            return (this.isMod);
        }


    }
}//package it.gotoandplay.smartfoxserver.data
