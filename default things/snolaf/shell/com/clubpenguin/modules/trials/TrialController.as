//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.modules.trials.TrialController
    {
        var _shell, _airtower, membershipTrial;
        function TrialController () {
        }
        function init(shell, airtower) {
            _shell = shell;
            _airtower = airtower;
        }
        function setupTrials() {
            membershipTrial = new com.clubpenguin.modules.trials.membershiptrial.MembershipTrial(_shell, _airtower);
        }
    }
