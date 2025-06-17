//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.net.webservicereassembly.MascotMessages extends com.clubpenguin.net.webservicereassembly.WebServiceReassembler implements com.clubpenguin.net.webservicereassembly.IWebServiceReassembler
    {
        var serviceData;
        function MascotMessages () {
            super();
            serviceData = [];
        }
        function addData(key, data) {
            var _local_2 = key.split(",");
            if (_local_2.length == 1) {
                if (Number(key) < 0) {
                    serviceData = serviceData.concat(data);
                } else {
                    if (serviceData[Number(key)] == null) {
                        serviceData[Number(key)].mascotScript = [];
                    }
                    serviceData[Number(key)].mascotScript = serviceData[Number(key)].mascotScript.concat(data);
                }
            } else {
                if (serviceData[_local_2[0]][_local_2[1]] == null) {
                    serviceData[_local_2[0]].mascotScript[_local_2[1]].script = [];
                }
                serviceData[_local_2[0]].mascotScript[_local_2[1]].script = serviceData[_local_2[0]].mascotScript[_local_2[1]].script.concat(data);
            }
        }
        function retreiveData() {
            return(serviceData);
        }
    }
