//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.net.webservicereassembly.Stamps extends com.clubpenguin.net.webservicereassembly.WebServiceReassembler implements com.clubpenguin.net.webservicereassembly.IWebServiceReassembler
    {
        var serviceData, reformatArrayToObjectIndexedBy;
        function Stamps () {
            super();
            serviceData = [];
        }
        function addData(key, data) {
            if (Number(key) < 0) {
                serviceData = serviceData.concat(data);
            } else {
                if (serviceData[Number(key)].stamps == null) {
                    serviceData[Number(key)].stamps = [];
                }
                serviceData[Number(key)].stamps = serviceData[Number(key)].stamps.concat(data);
            }
        }
        function retreiveData() {
            var _local_2 = restructure(serviceData);
            return(reformatArrayToObjectIndexedBy(INDEX_KEY, _local_2));
        }
        function restructure(stampsData) {
            for (var _local_6 in stampsData) {
                var _local_4 = [];
                for (var _local_5 in stampsData[_local_6].stamps) {
                    var _local_1 = stampsData[_local_6].stamps[_local_5];
                    var _local_3 = _local_1.stamp_id;
                    _local_4[_local_3] = _local_1;
                }
                stampsData[_local_6].stamps = _local_4;
            }
            return(stampsData);
        }
        static var INDEX_KEY = "group_id";
    }
