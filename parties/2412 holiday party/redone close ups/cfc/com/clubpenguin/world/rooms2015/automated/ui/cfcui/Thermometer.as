//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.automated.ui.cfcui.Thermometer
    {
        var _shell, _currentParty, actionSound, thermometerMC, _currentMilestone, _milestoneFrames, milestone_btn_1;
        function Thermometer () {
            _shell = _global.getCurrentShell();
            _currentParty = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
            actionSound = new Sound(this);
            actionSound.attachSound("sfx_meter");
        }
        function configureThermometer(milestone, milestoneFrames, frameEnd) {
            thermometerMC.gotoAndStop(1);
            _currentMilestone = milestone;
            _milestoneFrames = milestoneFrames;
            var _local_2 = frameEnd;
            trace("configureThermometer() -  finishFrame : " + _local_2);
            actionSound.start(0, 99);
            thermometerMC.gotoAndPlay(2);
            thermometerMC.onEnterFrame = com.clubpenguin.util.Delegate.create(this, playThermometerAnim, _local_2);
        }
        function playThermometerAnim(endFrame) {
            var _local_3 = thermometerMC._currentframe;
            if (((endFrame == 0) || (_local_3 >= endFrame)) || (_local_3 >= thermometerMC._totalframes)) {
                delete thermometerMC.onEnterFrame;
                thermometerMC.stop();
                actionSound.stop();
            }
            milestone_btn_1.gotoAndStop("unlocked");
            var _local_2 = 0;
            while (_local_2 < _milestoneFrames.length) {
                if (_local_3 >= _milestoneFrames[_local_2]) {
                    this["milestone_btn_" + Number(_local_2 + 2)].gotoAndStop("unlocked");
                    this["milestone_btn_" + Number(_local_2 + 1)].gotoAndStop("achieved");
                }
                _local_2++;
            }
        }
    }
