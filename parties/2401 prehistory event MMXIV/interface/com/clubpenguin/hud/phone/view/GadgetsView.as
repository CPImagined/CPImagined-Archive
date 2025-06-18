//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.view.GadgetsView extends com.clubpenguin.hud.phone.view.AppView
    {
        var localizedAssets, title, stateAddEvidence, stateCalibrating, stateOn, stateOff, onOffSlider, opened, _visible, evidenceSpout;
        function GadgetsView () {
            super();
            localizedAssets = [title, stateAddEvidence.insert, stateCalibrating, stateOn.title, stateOn.description, stateOn.badge.member, stateOff.title, stateOff.description, stateOff.badge.member, onOffSlider.txtOff, onOffSlider.txtOn];
            opened = new org.osflash.signals.Signal();
        }
        function open() {
            _visible = true;
            opened.dispatch();
        }
        function hideAllViews() {
            stateOff._visible = false;
            stateAddEvidence._visible = false;
            evidenceSpout._visible = false;
            stateCalibrating._visible = false;
            stateOn._visible = false;
        }
        function close() {
            _visible = false;
        }
        var _traceTrackerOn = false;
    }
