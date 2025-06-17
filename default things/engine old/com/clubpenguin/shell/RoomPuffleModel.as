class com.clubpenguin.shell.RoomPuffleModel extends com.clubpenguin.shell.PuffleModel
{
    var _x, _y, _notifyHunger, _notifyAngry, _notifyTired, _isWalking, _isInteracting, _isWalkable, __set__x, __set__y, updateListeners, __get__isWalking, __get__x, __get__y, __get__isInteracting, __get__isWalkable, _frame, __get__frame, __get__notifyHunger, __get__notifyAngry, __get__notifyTired, _lastAction, __get__lastAction, stats, __set__frame, __set__isInteracting, __set__isWalkable, __set__isWalking, __set__lastAction, __set__notifyAngry, __set__notifyHunger, __set__notifyTired;
    function RoomPuffleModel()
    {
        super();
        _x = 0;
        _y = 0;
        _notifyHunger = true;
        _notifyAngry = true;
        _notifyTired = true;
        _isWalking = false;
        _isInteracting = false;
        _isWalkable = true;
        com.clubpenguin.util.EventDispatcher.initialize(this);
    } // End of the function
    function setPosition(xpos, ypos)
    {
        this.__set__x(xpos);
        this.__set__y(ypos);
        this.updateListeners(com.clubpenguin.shell.RoomPuffleModel.MOVE, this);
    } // End of the function
    function set isWalking(isWalking)
    {
        _isWalking = isWalking;
        this.updateListeners(com.clubpenguin.shell.RoomPuffleModel.WALK, this);
        //return (this.isWalking());
        null;
    } // End of the function
    function get isWalking()
    {
        return (_isWalking);
    } // End of the function
    function get x()
    {
        return (_x);
    } // End of the function
    function set x(x)
    {
        _x = x;
        //return (this.x());
        null;
    } // End of the function
    function get y()
    {
        return (_y);
    } // End of the function
    function set y(y)
    {
        _y = y;
        //return (this.y());
        null;
    } // End of the function
    function get isInteracting()
    {
        return (_isInteracting);
    } // End of the function
    function set isInteracting(bool)
    {
        _isInteracting = bool;
        //return (this.isInteracting());
        null;
    } // End of the function
    function get isWalkable()
    {
        return (_isWalkable);
    } // End of the function
    function set isWalkable(bool)
    {
        _isWalkable = bool;
        //return (this.isWalkable());
        null;
    } // End of the function
    function set frame(frame)
    {
        _frame = frame;
        this.updateListeners(com.clubpenguin.shell.RoomPuffleModel.FRAME, this);
        //return (this.frame());
        null;
    } // End of the function
    function get frame()
    {
        return (_frame);
    } // End of the function
    function get notifyHunger()
    {
        return (_notifyHunger);
    } // End of the function
    function set notifyHunger(bool)
    {
        _notifyHunger = bool;
        //return (this.notifyHunger());
        null;
    } // End of the function
    function get notifyAngry()
    {
        return (_notifyAngry);
    } // End of the function
    function set notifyAngry(bool)
    {
        _notifyAngry = bool;
        //return (this.notifyAngry());
        null;
    } // End of the function
    function get notifyTired()
    {
        return (_notifyTired);
    } // End of the function
    function set notifyTired(bool)
    {
        _notifyTired = bool;
        //return (this.notifyTired());
        null;
    } // End of the function
    function get lastAction()
    {
        return (_lastAction);
    } // End of the function
    function set lastAction(action)
    {
        _lastAction = action;
        //return (this.lastAction());
        null;
    } // End of the function
    function cleanUp()
    {
        _x = null;
        _y = null;
        _isWalking = null;
        _lastAction = null;
        _notifyHunger = null;
        _notifyAngry = null;
        _notifyTired = null;
        _frame = null;
        stats = null;
        _isWalkable = null;
    } // End of the function
    static var WALK = "walk";
    static var MOVE = "move";
    static var FRAME = "frame";
} // End of Class
