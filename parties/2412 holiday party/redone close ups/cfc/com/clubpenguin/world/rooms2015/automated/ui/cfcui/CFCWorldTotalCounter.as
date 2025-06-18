//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.automated.ui.cfcui.CFCWorldTotalCounter extends MovieClip
    {
        var _donationTotal, _currentParty;
        function CFCWorldTotalCounter () {
            super();
            trace("CFCWorldTotalCounter()  : LOAD CLASS");
        }
        function init(donationTotal) {
            _donationTotal = donationTotal;
            _currentParty = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
            trace("CFCWorldTotalCounter -- GRAND TOTAL IS : " + _donationTotal);
            if (_donationTotal >= 99999999999) {
                _donationTotal = 99999999999;
            }
            updateCounter();
        }
        function updateCounter() {
            _currentParty.pebug("updateCounter " + _donationTotal);
            var _local_8 = _donationTotal.toString();
            var _local_7 = _currentParty.previousWorldCoinTotal.toString();
            var _local_6 = _local_8.split("");
            var _local_9 = _local_7.split("");
            var _local_3 = 0;
            while (_local_3 < NUM_DIGITS) {
                var _local_5 = _local_6[_local_6.length - (1 + _local_3)];
                var _local_2 = this["digit" + Number(_local_3 + 1)];
                if (_local_5 == undefined) {
                    _local_2.gotoAndStop("blank");
                } else {
                    var _local_4 = String("d_" + _local_5);
                    if ((_currentParty.previousWorldCoinTotal != null) && (_local_2._currentLabel != _local_4)) {
                        _local_2.play();
                        _local_2.onEnterFrame = com.clubpenguin.util.Delegate.create(this, trackDigitAnim, _local_2, _local_4);
                    } else {
                        _local_2.gotoAndStop(_local_4);
                    }
                }
                _local_3++;
            }
            _currentParty.previousWorldCoinTotal = _donationTotal;
        }
        function trackDigitAnim(mc, targetFrame) {
            if ((targetFrame == "d_0") && (_donationTotal == 0)) {
                mc.gotoAndStop("d_0");
                delete mc.onEnterFrame;
            }
            if (mc._currentLabel == targetFrame) {
                delete mc.onEnterFrame;
                mc.stop();
            }
        }
        static var NUM_DIGITS = 11;
    }
