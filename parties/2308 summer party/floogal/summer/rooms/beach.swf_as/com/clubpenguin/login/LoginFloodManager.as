dynamic class com.clubpenguin.login.LoginFloodManager
{
    static var SHARED_OBJECT_NAME: String = "floodControl";
    static var NEXT_LOGIN_TIME: String = "nlt";
    static var LOGIN_ATTEMPTS: String = "att";
    static var LOGIN_DELAYS = [0, 20, 40];
    static var RANDOM_RANGE: Number = 20;
    static var MIN_DELAY: Number = 10;
    static var ONE_SECOND: Number = 1000;

    function LoginFloodManager()
    {
    }

    static function clearFloodControl()
    {
        var __reg1 = SharedObject.getLocal(com.clubpenguin.login.LoginFloodManager.SHARED_OBJECT_NAME, "/");
        __reg1.clear();
        __reg1 = null;
        return;
    }

    static function setLoginAttempt()
    {
        var __reg2 = SharedObject.getLocal(com.clubpenguin.login.LoginFloodManager.SHARED_OBJECT_NAME, "/");
        var __reg4 = undefined;
        var __reg5 = new Date();
        var __reg1 = 0;
        var __reg3 = 0;
        if (__reg2.data[com.clubpenguin.login.LoginFloodManager.LOGIN_ATTEMPTS] != undefined) 
        {
            __reg1 = __reg2.data[com.clubpenguin.login.LoginFloodManager.LOGIN_ATTEMPTS];
        }
        ++__reg1;
        if (__reg1 > com.clubpenguin.login.LoginFloodManager.LOGIN_DELAYS.length - 1) 
        {
            __reg1 = 0;
        }
        if (__reg1 == 0) 
        {
            __reg3 = com.clubpenguin.login.LoginFloodManager.MIN_DELAY;
        }
        __reg2.data[com.clubpenguin.login.LoginFloodManager.LOGIN_ATTEMPTS] = __reg1;
        __reg2.data[com.clubpenguin.login.LoginFloodManager.NEXT_LOGIN_TIME] = Number(__reg5.getTime() + (com.clubpenguin.login.LoginFloodManager.LOGIN_DELAYS[__reg1] + com.clubpenguin.math.MathHelper.getRandomNumberInRange(__reg3, com.clubpenguin.login.LoginFloodManager.RANDOM_RANGE)) * com.clubpenguin.login.LoginFloodManager.ONE_SECOND);
        __reg4 = __reg2.flush();
        return true;
    }

}
