//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.model
{
    import com.clubpenguin.lib.model.IABTestModel;
    import org.osflash.signals.Signal;
    import com.playdom.tracker.Tracker;
    import com.clubpenguin.lib.util.Log;

    public class ABTestModel implements IABTestModel 
    {

        private const DEFAULT_CONTROL:Object = {"variant":0};
        private const DEFAULTING_ERROR:String = "abtest_defaulting_error";

        private var _onUpdate:Signal = new Signal(String);
        private var abTestData:Object;
        [Inject]
        public var tracker:Tracker;

        public function ABTestModel()
        {
            this.abTestData = new Object();
        }

        public function get onUpdate():Signal
        {
            return (this._onUpdate);
        }

        public function setAllTestData(data:Object):void
        {
            var test:String;
            var testParam:String;
            Log.debug((("\tABTestModel.setAllTestData(data: " + data) + ")"));
            for (test in data)
            {
                Log.debug(((("\t\t-data[" + test) + "]: ") + data[test]));
                for (testParam in data[test])
                {
                    Log.debug(((((("\t\t\t-data[" + test) + "][") + testParam) + "]: ") + data[test][testParam]));
                };
            };
            this.abTestData = data;
            this._onUpdate.dispatch(null);
        }

        public function getAllTestData():Object
        {
            return (this.abTestData);
        }

        public function setTestDataByName(testName:String, data:Object):void
        {
            Log.debug((((("\tABTestModel.setTestDataByName(testName: " + testName) + ", data: ") + data) + ")"));
            this.abTestData[testName] = data;
            this._onUpdate.dispatch(testName);
        }

        public function getTestDataByName(testName:String):Object
        {
            Log.debug((("\tABTestModel.getTestDataByName(testName: " + testName) + ")"));
            if (this.abTestData[testName])
            {
                return (this.abTestData[testName]);
            };
            Log.error(("\t\t-no test by name: " + testName));
            return (this.DEFAULT_CONTROL);
        }

        public function parameterExists(testName:String, paramName:String):Boolean
        {
            if (this.abTestData[testName][paramName] != undefined)
            {
                return (true);
            };
            return (false);
        }

        public function getParameterByName(testName:String, paramName:String):*
        {
            Log.debug((((("\tABTestModel.getParameterByName(testName: " + testName) + ", paramName: ") + paramName) + ")"));
            if (this.abTestData[testName])
            {
                return (this.abTestData[testName][paramName]);
            };
            Log.error(((("\t\t-no parameter by name: '" + paramName) + "' in test: ") + this.abTestData[testName]));
            return (undefined);
        }


    }
}//package com.clubpenguin.main.model
