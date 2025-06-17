//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.services.socket.abtest
{
    import com.clubpenguin.lib.services.socket.IConnection;
    import com.clubpenguin.lib.model.IABTestModel;
    import com.adobe.serialization.json.JSON;

    public class ABTestService 
    {

        private static const GET_AB_TEST_DATA:String = "gabcms";

        private var connection:IConnection;
        private var abTestModel:IABTestModel;


        public function init(connection:IConnection, abTestModel:IABTestModel):void
        {
            this.connection = connection;
            this.abTestModel = abTestModel;
            this.connection.getResponded().add(this.onResponded);
        }

        private function onResponded(messageType:String, responseData:Array):void
        {
            var dataString:String;
            var abTestData:Object;
            if (messageType == GET_AB_TEST_DATA)
            {
                dataString = responseData[1];
                abTestData = com.adobe.serialization.json.JSON.decode(dataString);
                this.abTestModel.setAllTestData(abTestData);
            };
        }


    }
}//package com.clubpenguin.services.socket.abtest
