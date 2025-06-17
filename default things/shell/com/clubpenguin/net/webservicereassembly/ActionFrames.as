//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.net.webservicereassembly.ActionFrames extends com.clubpenguin.net.webservicereassembly.WebServiceReassembler implements com.clubpenguin.net.webservicereassembly.IWebServiceReassembler
    {
        var serviceData;
        function ActionFrames () {
            super();
            serviceData = [];
        }
        function addData(key, data) {
            if (serviceData[key] == null) {
                serviceData[key] = [];
            }
            serviceData[key] = serviceData[key].concat(data);
        }
    }
