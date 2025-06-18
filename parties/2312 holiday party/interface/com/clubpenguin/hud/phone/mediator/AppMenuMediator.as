//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.mediator.AppMenuMediator
    {
        var context, languageCrumbs, iconPressed, view;
        function AppMenuMediator (context, view, player, languageCrumbs) {
            this.context = context;
            this.languageCrumbs = languageCrumbs;
            initView(view);
            iconPressed = new org.osflash.signals.Signal(String);
        }
        function initView(view) {
            this.view = view;
            setupIcons();
        }
        function delaySetupIcons() {
            clearInterval(delayInterval);
            setupIcons();
        }
        function setupIcons() {
            icons = [view.agentStatus, view.teleport, view.recruit, view.communication, view.gadgets, view.mission];
            if (context.playerHasElitePuffleWhistle()) {
                icons.push(view.puffle);
            } else {
                view.puffle.active = false;
                view.puffle._visible = false;
                view.txtMenuPuffle._visible = false;
                view.puffle.enabled = false;
            }
            var _local_3 = 0;
            while (_local_3 < icons.length) {
                var _local_4 = com.clubpenguin.util.Delegate.create(this, timeoutFunction);
                var _local_5 = _global.setTimeout(_local_4, 250, [_local_3]);
                _local_3++;
            }
        }
        function timeoutFunction(iterator) {
            var _local_2 = icons[iterator];
            if (_local_2.active) {
                _local_2.pressSignal.add(onIconPress, this);
                _local_2.title = languageCrumbs[_local_2._name];
            } else {
                _local_2.title = languageCrumbs["Coming Soon"];
            }
        }
        function onIconPress(icon) {
            icon.gotoAndPlay(2);
            iconPressed.dispatch(icon._name);
        }
        var icons = new Array();
        var delayInterval = null;
    }
