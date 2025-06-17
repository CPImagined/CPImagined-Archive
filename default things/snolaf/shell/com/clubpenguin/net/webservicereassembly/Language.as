//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.net.webservicereassembly.Language extends com.clubpenguin.net.webservicereassembly.WebServiceReassembler implements com.clubpenguin.net.webservicereassembly.IWebServiceReassembler
    {
        var serviceData;
        function Language () {
            super();
            serviceData = [];
        }
        function addData(key, data) {
            if (serviceData[key] == null) {
                serviceData[key] = [];
            }
            serviceData[key] = serviceData[key].concat(data);
        }
        function retreiveData() {
            var _local_3 = {};
            _local_3.lang = {};
            _local_3.error_lang = {};
            for (var _local_4 in serviceData.lang) {
                var _local_2 = serviceData.lang[_local_4];
                _local_3.lang[_local_2[0]] = _local_2[1];
            }
            for (var _local_4 in serviceData.error_lang) {
                var _local_2 = serviceData.error_lang[_local_4];
                _local_3.error_lang[_local_2[0]] = _local_2[1];
            }
            return(_local_3);
        }
    }
