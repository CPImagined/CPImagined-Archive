//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.model.ABTestModel
    {
        var _onUpdate, abTestData, DEFAULT_CONTROL;
        function ABTestModel () {
            _onUpdate = new org.osflash.signals.Signal(String);
            abTestData = new Object();
            DEFAULT_CONTROL = {variant:0};
        }
        function get onUpdate() {
            return(_onUpdate);
        }
        function setAllTestData(data) {
            abTestData = data;
            _onUpdate.dispatch(null);
        }
        function getAllTestData() {
            return(abTestData);
        }
        function setTestDataByName(testName, data) {
            abTestData[testName] = data;
            _onUpdate.dispatch(testName);
        }
        function getTestDataByName(testName) {
            if (abTestData[testName]) {
                return(abTestData[testName]);
            } else {
                return(DEFAULT_CONTROL);
            }
        }
        function parameterExists(testName, paramName) {
            if (abTestData[testName][paramName] != undefined) {
                return(true);
            }
            return(false);
        }
        var ABTESTMODEL_CONTEXT = "abtestmodel";
        var DEFAULTING_ERROR = "defaulting_error";
    }
