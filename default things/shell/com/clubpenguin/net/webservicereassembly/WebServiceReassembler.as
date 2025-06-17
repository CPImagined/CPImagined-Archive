//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.net.webservicereassembly.WebServiceReassembler implements com.clubpenguin.net.webservicereassembly.IWebServiceReassembler
    {
        var serviceData;
        function WebServiceReassembler () {
            serviceData = [];
        }
        function addData(key, data) {
            serviceData = serviceData.concat(data);
        }
        function retreiveData() {
            return(serviceData);
        }
        function destroy() {
            for (var _local_2 in this) {
                this[_local_2] = null;
            }
        }
        function reformatArrayToObjectIndexedBy(indexKey, inputData) {
            var _local_3 = {};
            for (var _local_5 in inputData) {
                var _local_1 = inputData[_local_5][indexKey];
                _local_3[_local_1] = inputData[_local_5];
            }
            return(_local_3);
        }
    }
