//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.mediator.AppMediator
    {
        var view, appClosed;
        function AppMediator (view, appClosed, languageCode) {
            this.view = view;
            view.close();
            view.closed.add(onClosed, this);
            this.appClosed = appClosed;
            setLanguageCode(languageCode);
        }
        function setLanguageCode(code) {
            var _local_2 = 0;
            while (_local_2 < view.localizedAssets.length) {
                MovieClip(view.localizedAssets[_local_2]).gotoAndStop(code);
                _local_2++;
            }
        }
        function onClosed() {
            appClosed.dispatch(view._name);
        }
        static var DELAY_AMOUNT = 500;
    }
