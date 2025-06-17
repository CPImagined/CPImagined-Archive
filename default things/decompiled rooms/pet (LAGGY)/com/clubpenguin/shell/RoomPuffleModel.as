//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.shell.RoomPuffleModel extends com.clubpenguin.shell.PuffleModel
    {
        var _x, _y, _notifyHunger, _notifyAngry, _notifyTired, _isWalking, _isInteracting, _isWalkable, updateListeners, _frame, _lastAction, stats;
        function RoomPuffleModel () {
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
        }
        function setPosition(_arg_3, _arg_2) {
            x = (_arg_3);
            y = (_arg_2);
            updateListeners(MOVE, this);
        }
        function set isWalking(_arg_2) {
            _isWalking = _arg_2;
            updateListeners(WALK, this);
            //return(isWalking);
        }
        function get isWalking() {
            return(_isWalking);
        }
        function get x() {
            return(_x);
        }
        function set x(_arg_2) {
            _x = _arg_2;
            //return(x);
        }
        function get y() {
            return(_y);
        }
        function set y(_arg_2) {
            _y = _arg_2;
            //return(y);
        }
        function get isInteracting() {
            return(_isInteracting);
        }
        function set isInteracting(_arg_2) {
            _isInteracting = _arg_2;
            //return(isInteracting);
        }
        function get isWalkable() {
            return(_isWalkable);
        }
        function set isWalkable(_arg_2) {
            _isWalkable = _arg_2;
            //return(isWalkable);
        }
        function set frame(_arg_2) {
            _frame = _arg_2;
            updateListeners(FRAME, this);
            //return(frame);
        }
        function get frame() {
            return(_frame);
        }
        function get notifyHunger() {
            return(_notifyHunger);
        }
        function set notifyHunger(_arg_2) {
            _notifyHunger = _arg_2;
            //return(notifyHunger);
        }
        function get notifyAngry() {
            return(_notifyAngry);
        }
        function set notifyAngry(_arg_2) {
            _notifyAngry = _arg_2;
            //return(notifyAngry);
        }
        function get notifyTired() {
            return(_notifyTired);
        }
        function set notifyTired(_arg_2) {
            _notifyTired = _arg_2;
            //return(notifyTired);
        }
        function get lastAction() {
            return(_lastAction);
        }
        function set lastAction(_arg_2) {
            _lastAction = _arg_2;
            //return(lastAction);
        }
        function cleanUp() {
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
        }
        static var WALK = "walk";
        static var MOVE = "move";
        static var FRAME = "frame";
    }
