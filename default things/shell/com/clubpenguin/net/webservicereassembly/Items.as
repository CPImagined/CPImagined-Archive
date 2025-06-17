//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.net.webservicereassembly.Items extends com.clubpenguin.net.webservicereassembly.WebServiceReassembler implements com.clubpenguin.net.webservicereassembly.IWebServiceReassembler
    {
        var serviceData, reformatArrayToObjectIndexedBy;
        function Items () {
            super();
            serviceData = [];
        }
        function retreiveData() {
            return(reformatArrayToObjectIndexedBy(INDEX_KEY, serviceData));
        }
        static var INDEX_KEY = "paper_item_id";
    }
