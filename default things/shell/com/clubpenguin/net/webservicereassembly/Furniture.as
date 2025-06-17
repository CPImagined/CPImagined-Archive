//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.net.webservicereassembly.Furniture extends com.clubpenguin.net.webservicereassembly.WebServiceReassembler implements com.clubpenguin.net.webservicereassembly.IWebServiceReassembler
    {
        var serviceData, reformatArrayToObjectIndexedBy;
        function Furniture () {
            super();
            serviceData = [];
        }
        function retreiveData() {
            return(reformatArrayToObjectIndexedBy(INDEX_KEY, serviceData));
        }
        static var INDEX_KEY = "furniture_item_id";
    }
