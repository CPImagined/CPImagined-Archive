import com.clubpenguin.ui.views.AbstractViewManager;
    class com.clubpenguin.ui.views.AbstractView extends MovieClip implements com.clubpenguin.ui.views.IView
    {
        var _shell, viewManager, _visible;
        function AbstractView () {
            super();
            com.clubpenguin.util.EventDispatcher.initialize(this);
        }
        function addEventListener(type, func, scope) {
            return(false);
        }
        function removeEventListener(type, func, scope) {
            return(false);
        }
        function updateListeners(type, event) {
            return(false);
        }
        function dispatchEvent(event) {
            return(false);
        }
        function setLanguageAbbr(abbr: String): Void {
        }
        function setShell(target: MovieClip): Void {
            _shell = target;
        }
        function setViewManager(manager: AbstractViewManager): Void {
            viewManager = manager;
        }
        function getViewManager(): AbstractViewManager {
            return(viewManager);
        }
        function hide(): Void {
            _visible = false;
        }
        function show(): Void {
            _visible = true;
        }
    }
