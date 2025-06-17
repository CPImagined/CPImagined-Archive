//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.StampNotifier
    {
        var _shell, _queue, _stampEarnedAnimationDone, _pauseNotification, _dlsInitialized, _opcodeJournal, __interface, __get___interface, __get__pauseNotification;
        function StampNotifier (shell) {
            _shell = shell;
            _queue = [];
            _stampEarnedAnimationDone = true;
            _pauseNotification = false;
            _dlsInitialized = false;
            _opcodeJournal = new com.clubpenguin.stamps.StampOpcodeJournal();
            _shell.addListener(_shell.STAMP_EARNED_ANIM_DONE, handleStampEarnedAnimationDone, this);
        }
        function destroy() {
            delete _queue;
            _shell.removeListener(_shell.STAMP_EARNED_ANIM_DONE, handleStampEarnedAnimationDone);
        }
        function set _interface(interfacer) {
            __interface = interfacer;
            //return(__get___interface());
        }
        function add(stamp) {
            _queue.push(stamp);
            showStampEarnedAnimation();
        }
        function set pauseNotification(pause) {
            _pauseNotification = pause;
            if (!_pauseNotification) {
                showStampEarnedAnimation();
            }
            //return(__get__pauseNotification());
        }
        function handleStampEarnedAnimationDone() {
            _stampEarnedAnimationDone = true;
            showStampEarnedAnimation();
        }
        function showStampEarnedAnimation() {
            if (((!_pauseNotification) && (_queue.length > 0)) && (_stampEarnedAnimationDone)) {
                var _local_2 = com.clubpenguin.stamps.IStampItem(_queue.shift());
                _stampEarnedAnimationDone = false;
                if (!_dlsInitialized) {
                    var _local_3 = _shell.getMyPlayerId();
                    _dlsInitialized = true;
                }
                __interface.animateStampEarned(_local_2.getMainCategoryID(), _local_2.getDifficulty(), _local_2.getName());
            }
        }
        function dlsmCallback(retString) {
        }
    }
