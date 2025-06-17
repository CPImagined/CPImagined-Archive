//Created by Action Script Viewer - https://www.buraks.com/asv
package it.gotoandplay.smartfoxserver.data
{
    public class Room 
    {

        private var maxUsers:int;
        private var userList:Array;
        private var name:String;
        private var userCount:int;
        private var specCount:int;
        private var id:int;
        private var myPlayerIndex:int;
        private var priv:Boolean;
        private var temp:Boolean;
        private var limbo:Boolean;
        private var maxSpectators:int;
        private var game:Boolean;
        private var variables:Array;

        public function Room(id:int, name:String, maxUsers:int, maxSpectators:int, isTemp:Boolean, isGame:Boolean, isPrivate:Boolean, isLimbo:Boolean, userCount:int=0, specCount:int=0)
        {
            this.id = id;
            this.name = name;
            this.maxSpectators = maxSpectators;
            this.maxUsers = maxUsers;
            this.temp = isTemp;
            this.game = isGame;
            this.priv = isPrivate;
            this.limbo = isLimbo;
            this.userCount = userCount;
            this.specCount = specCount;
            this.userList = [];
            this.variables = [];
        }

        public function getVariable(varName:String):Object
        {
            return (variables[varName]);
        }

        public function addUser(u:User, id:int):void
        {
            userList[id] = u;
            userCount++;
        }

        public function getName():String
        {
            return (this.name);
        }

        public function getId():int
        {
            return (this.id);
        }

        public function setIsLimbo(b:Boolean):*
        {
            this.limbo = b;
        }

        public function clearVariables():void
        {
            this.variables = [];
        }

        public function isTemp():Boolean
        {
            return (this.temp);
        }

        public function getMaxSpectators():int
        {
            return (this.maxSpectators);
        }

        public function setVariables(vars:Array):void
        {
            this.variables = vars;
        }

        public function isGame():Boolean
        {
            return (this.game);
        }

        public function getUser(userId:*):User
        {
            var user:User;
            var i:String;
            var u:User;
            user = null;
            if (typeof(userId) == "number")
            {
                user = userList[userId];
            }
            else
            {
                if (typeof(userId) == "string")
                {
                    for (i in userList)
                    {
                        u = this.userList[i];
                        if (u.getName() == userId)
                        {
                            user = u;
                            break;
                        };
                    };
                };
            };
            return (user);
        }

        public function setUserCount(n:int):void
        {
            this.userCount = n;
        }

        public function getVariables():Array
        {
            return (variables);
        }

        public function getUserCount():int
        {
            return (this.userCount);
        }

        public function isLimbo():Boolean
        {
            return (this.limbo);
        }

        public function getSpectatorCount():int
        {
            return (this.specCount);
        }

        public function setSpectatorCount(n:int):void
        {
            this.specCount = n;
        }

        public function setMyPlayerIndex(id:int):void
        {
            this.myPlayerIndex = id;
        }

        public function removeUser(id:int):void
        {
            delete userList[id];
            userCount--;
        }

        public function getMyPlayerIndex():int
        {
            return (this.myPlayerIndex);
        }

        public function isPrivate():Boolean
        {
            return (this.priv);
        }

        public function getMaxUsers():int
        {
            return (this.maxUsers);
        }

        public function getUserList():Array
        {
            return (this.userList);
        }


    }
}//package it.gotoandplay.smartfoxserver.data
