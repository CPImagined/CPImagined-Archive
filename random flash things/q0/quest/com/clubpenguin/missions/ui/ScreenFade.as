//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.missions.ui.ScreenFade
    {
        var _modal, dispatchEvent, _onComplete, _onCompleteScope, __get__color, __get__alpha, __get__fadeDuration, __get__onComplete, __get__onCompleteScope;
        function ScreenFade ($scope) {
            if ($scope) {
                setupModal($scope);
                mx.events.EventDispatcher.initialize(this);
            }
        }
        function setupModal($scope) {
            if ($scope.modalClip) {
                $scope.modalClip.removeMovieClip();
            }
            _modal = $scope.createEmptyMovieClip("modalClip", $scope.getNextHighestDepth());
            _modal._visible = false;
            _modal.onPress = null;
            _modal.useHandCursor = false;
            drawModal();
        }
        function drawModal() {
            _modal.clear();
            _modal.beginFill(_color, _alpha);
            _modal.moveTo(0, 0);
            _modal.lineTo(Stage.width, 0);
            _modal.lineTo(Stage.width, Stage.height);
            _modal.lineTo(0, Stage.height);
            _modal.lineTo(0, 0);
            _modal.endFill();
        }
        function onFadingModalIn() {
            dispatchEvent(new com.clubpenguin.missions.ui.ScreenFadeEvent(com.clubpenguin.missions.ui.ScreenFadeEvent.FADE_IN, this));
            dispatchEvent(new com.clubpenguin.missions.ui.ScreenFadeEvent(com.clubpenguin.missions.ui.ScreenFadeEvent.FADE, this));
        }
        function onFadeModalInComplete() {
            fadeComplete();
            dispatchEvent(new com.clubpenguin.missions.ui.ScreenFadeEvent(com.clubpenguin.missions.ui.ScreenFadeEvent.FADE_IN_COMPLETE, this));
        }
        function onFadingModalOut() {
            dispatchEvent(new com.clubpenguin.missions.ui.ScreenFadeEvent(com.clubpenguin.missions.ui.ScreenFadeEvent.FADE_OUT, this));
            dispatchEvent(new com.clubpenguin.missions.ui.ScreenFadeEvent(com.clubpenguin.missions.ui.ScreenFadeEvent.FADE, this));
        }
        function onFadeModalOutComplete() {
            _modal._visible = false;
            fadeComplete();
            dispatchEvent(new com.clubpenguin.missions.ui.ScreenFadeEvent(com.clubpenguin.missions.ui.ScreenFadeEvent.FADE_OUT_COMPLETE, this));
        }
        function fadeComplete() {
            if (_onComplete) {
                var _local_2;
                if (_onCompleteScope) {
                    _local_2 = com.clubpenguin.util.Delegate.create(_onCompleteScope, _onComplete);
                } else {
                    _local_2 = _onComplete;
                }
                _local_2();
            }
            dispatchEvent(new com.clubpenguin.missions.ui.ScreenFadeEvent(com.clubpenguin.missions.ui.ScreenFadeEvent.FADE_COMPLETE, this));
        }
        function fadeIn() {
            _modal._alpha = 0;
            _modal._visible = true;
            gs.TweenLite.to(_modal, _fadeDuration, {_alpha:100, onUpdate:com.clubpenguin.util.Delegate.create(this, onFadingModalIn), onComplete:com.clubpenguin.util.Delegate.create(this, onFadeModalInComplete)});
        }
        function fadeOut() {
            _modal._visible = true;
            _modal._alpha = 100;
            gs.TweenLite.to(_modal, _fadeDuration, {_alpha:0, onUpdate:com.clubpenguin.util.Delegate.create(this, onFadingModalOut), onComplete:com.clubpenguin.util.Delegate.create(this, onFadeModalOutComplete)});
        }
        function set color($color) {
            _color = $color;
            drawModal();
            //return(__get__color());
        }
        function set alpha($alpha) {
            _alpha = $alpha;
            drawModal();
            //return(__get__alpha());
        }
        function showModal() {
            if (_modal) {
                _modal._visible = true;
                _modal._alpha = 100;
            }
        }
        function hideModal() {
            if (_modal) {
                _modal._visible = false;
                _modal._alpha = 0;
            }
        }
        function set fadeDuration($duration) {
            _fadeDuration = $duration;
            //return(__get__fadeDuration());
        }
        function set onComplete($function) {
            _onComplete = $function;
            //return(__get__onComplete());
        }
        function set onCompleteScope($scope) {
            _onCompleteScope = $scope;
            //return(__get__onCompleteScope());
        }
        var _color = 0;
        var _alpha = 100;
        var _fadeDuration = 1;
    }
