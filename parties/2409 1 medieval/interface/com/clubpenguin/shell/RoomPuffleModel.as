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
        function setPosition(xpos, ypos) {
            x = (xpos);
            y = (ypos);
            updateListeners(MOVE, this);
        }
        function set isWalking(isWalking) {
            _isWalking = isWalking;
            updateListeners(WALK, this);
            //return(this.isWalking);
        }
        function get isWalking() {
            return(_isWalking);
        }
        function get x() {
            return(_x);
        }
        function set x(x) {
            _x = x;
            //return(this.x);
        }
        function get y() {
            return(_y);
        }
        function set y(y) {
            _y = y;
            //return(this.y);
        }
        function get isInteracting() {
            return(_isInteracting);
        }
        function set isInteracting(bool) {
            _isInteracting = bool;
            //return(isInteracting);
        }
        function get isWalkable() {
            return(_isWalkable);
        }
        function set isWalkable(bool) {
            _isWalkable = bool;
            //return(isWalkable);
        }
        function set frame(frame) {
            _frame = frame;
            updateListeners(FRAME, this);
            //return(this.frame);
        }
        function get frame() {
            return(_frame);
        }
        function get notifyHunger() {
            return(_notifyHunger);
        }
        function set notifyHunger(bool) {
            _notifyHunger = bool;
            //return(notifyHunger);
        }
        function get notifyAngry() {
            return(_notifyAngry);
        }
        function set notifyAngry(bool) {
            _notifyAngry = bool;
            //return(notifyAngry);
        }
        function get notifyTired() {
            return(_notifyTired);
        }
        function set notifyTired(bool) {
            _notifyTired = bool;
            //return(notifyTired);
        }
        function get lastAction() {
            return(_lastAction);
        }
        function set lastAction(action) {
            _lastAction = action;
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
