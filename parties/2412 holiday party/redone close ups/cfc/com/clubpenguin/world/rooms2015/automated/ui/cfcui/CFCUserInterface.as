//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2015.automated.ui.cfcui.CFCUserInterface
    {
        static var CURRENT_PARTY_DAY, NUM_MILESTONES;
        var _view, _currentParty, _airtower, _interface, _getTotalDelegate, _donationTotalReached, _makeDonationDelegate;
        function CFCUserInterface (view) {
            trace("CFCUserInterface() : ENTERING 2015 ***");
            _view = view;
            _currentParty = _global.getCurrentParty().BaseParty.CURRENT_PARTY;
            _airtower = _global.getCurrentAirtower();
            _interface = _global.getCurrentInterface();
            CURRENT_PARTY_DAY = _currentParty.CONSTANTS.PARTY_DAY;
            NUM_MILESTONES = MILESTONE_FRAMES.length;
            configureMilestoneButtonFunctionality();
            configureDonateButtons();
            updateThermometer();
            displayCorrectCharityInfo();
        }
        function requestDonationTotal() {
            _getTotalDelegate = com.clubpenguin.util.Delegate.create(this, donationTotalReturned);
            _airtower.addListener(com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO.CFC_GLOBAL_TOTAL, _getTotalDelegate);
            _currentParty.partyCookie.sendRequestCFCGlobalTotal();
        }
        function donationTotalReturned(arr) {
            _airtower.removeListener(com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO.CFC_GLOBAL_TOTAL, _getTotalDelegate);
            _getTotalDelegate = null;
            _donationTotalReached = Number(arr[1]);
            _view.goalMC.coinTotal_mc.init(_donationTotalReached);
        }
        function updateThermometer() {
            _view.thermometer.configureThermometer(currentMilestone(), MILESTONE_FRAMES, thermometerFrameNumber());
        }
        function displayCorrectCharityInfo() {
            var _local_2 = 0;
            if (thermometerFrameNumber() >= THERMOMETER_LAST_FRAME) {
                _local_2 = CONGRATS_FRAME_INDEX;
            }
            displayMilestoneInfoArt(_local_2);
        }
        function displayMilestoneInfoArt(descriptionNum) {
            _view.goalMC.gotoAndStop(Number(descriptionNum + 1));
            if (_view.goalMC._currentframe > 1) {
                _view.goalMC.bg_animation.gotoAndStop(2);
                _view.goalMC.back_btn.onRelease = com.clubpenguin.util.Delegate.create(this, goToFirstFrame);
            } else {
                requestDonationTotal();
            }
        }
        function thermometerFrameNumber() {
            trace("!!$$$ CURRENT_PARTY_DAY :  " + CURRENT_PARTY_DAY);
            trace("!!$$$ DAILY_FRAMES[CURRENT_PARTY_DAY] :  " + DAILY_FRAMES[CURRENT_PARTY_DAY]);
            if (CURRENT_PARTY_DAY >= DAILY_FRAMES.length) {
                return(DAILY_FRAMES[DAILY_FRAMES.length - 1]);
            } else {
                return(DAILY_FRAMES[CURRENT_PARTY_DAY]);
            }
        }
        function currentMilestone() {
            var _local_3 = 0;
            var _local_2 = 0;
            while (_local_2 < MILESTONE_FRAMES.length) {
                if (thermometerFrameNumber() >= MILESTONE_FRAMES[_local_2]) {
                    _local_3++;
                }
                _local_2++;
            }
            return(_local_3);
        }
        function configureMilestoneButtonFunctionality() {
            var _local_2 = 0;
            while (_local_2 < NUM_MILESTONES) {
                _view.thermometer["milestone_btn_" + String(_local_2 + 1)].onRelease = com.clubpenguin.util.Delegate.create(this, displayMilestoneInfoArt, Number(_local_2 + 1));
                _local_2++;
            }
        }
        function animateBackground() {
            if (_view.goalMC._currentFrame >= 2) {
                _view.goalMC.bg_animation.gotoAndStop(_view.goalMC._currentFrame + 1);
                if (_view.goalMC.bg_animation._currentFrame >= 12) {
                    _view.goalMC.onEnterFrame = null;
                }
            }
        }
        function goToFirstFrame() {
            _view.goalMC.bg_animation.gotoAndStop(1);
            _view.goalMC.gotoAndStop(1);
            requestDonationTotal();
        }
        function configureDonateButtons() {
            _view.notenoughcoins_mc._visible = false;
            if (thermometerFrameNumber() >= THERMOMETER_LAST_FRAME) {
                disableDonationButtons();
                return(undefined);
            }
            _view.donateText._visible = true;
            _view.coin_100._visible = true;
            _view.coin_1000._visible = true;
            _view.coin_10000._visible = true;
            _view.coin_100.onRelease = com.clubpenguin.util.Delegate.create(this, makeDonation, 100);
            _view.coin_1000.onRelease = com.clubpenguin.util.Delegate.create(this, makeDonation, 1000);
            _view.coin_10000.onRelease = com.clubpenguin.util.Delegate.create(this, makeDonation, 10000);
        }
        function disableDonationButtons() {
            _view.donateText._visible = false;
            _view.coin_100._visible = false;
            _view.coin_1000._visible = false;
            _view.coin_10000._visible = false;
        }
        function makeDonation(coinsDonated) {
            if (_global.getCurrentShell().getMyPlayerTotalCoins() < coinsDonated) {
                trace("MAKE DONATION -- NOT ENOUGH COINS");
                _view.notenoughcoins_mc._visible = true;
            } else {
                trace("MAKE DONATION!!! - coinsDonated : " + coinsDonated);
                _makeDonationDelegate = com.clubpenguin.util.Delegate.create(this, donationComplete);
                _airtower.addListener(com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO.CFC_STATION_DONATE, _makeDonationDelegate);
                _currentParty.partyCookie.sendCFCDonation(coinsDonated);
                fakeUpdatedTotal(coinsDonated);
            }
            disableDonationButtons();
            setTimeout(com.clubpenguin.util.Delegate.create(this, configureDonateButtons), FLOOD_TIMER);
        }
        function fakeUpdatedTotal(donation) {
            _donationTotalReached = _donationTotalReached + donation;
            if (_view.goalMC._currentFrame >= 2) {
                _view.goalMC.gotoAndStop(1);
            }
            _view.goalMC.coinTotal_mc.init(_donationTotalReached);
            setTimeout(com.clubpenguin.util.Delegate.create(this, showDonationFeedbackAnimation), 600);
        }
        function showDonationFeedbackAnimation() {
            _view.goalMC.feedback_mc.gotoAndPlay(2);
        }
        function donationComplete(numCoins) {
            trace("PLAYER HAS DONATED COINS - numCoins : " + numCoins);
            _airtower.removeListener(com.clubpenguin.world.rooms2015.automated.vo.TemplatePartyCookieVO.CFC_STATION_DONATE, _makeDonationDelegate);
            _makeDonationDelegate = null;
            _global.getCurrentShell().setMyPlayerTotalCoins(numCoins);
        }
        static var DAILY_FRAMES = [0, 0, 0, 9, 9, 19, 19, 29, 29, 29, 34, 34, 39, 39, 39, 39, 49, 49, 61, 61, 69, 69, 80, 80, 80, 89, 89, 89, 100];
        static var MILESTONE_FRAMES = [34, 61, 80, 100];
        static var FIRST_PARTY_DAY = 0;
        static var MERRY_WALRUS_DAY = 37;
        static var CONGRATS_FRAME_INDEX = 5;
        static var THERMOMETER_LAST_FRAME = 100;
        static var FLOOD_TIMER = 3500;
    }
