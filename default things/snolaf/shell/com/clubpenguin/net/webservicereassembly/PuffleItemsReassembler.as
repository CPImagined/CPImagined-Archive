//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.net.webservicereassembly.PuffleItemsReassembler extends com.clubpenguin.net.webservicereassembly.WebServiceReassembler implements com.clubpenguin.net.webservicereassembly.IWebServiceReassembler
    {
        var serviceData, reformatArrayToObjectIndexedBy;
        function PuffleItemsReassembler () {
            super();
        }
        function Items() {
            serviceData = [];
        }
        function retreiveData() {
            return(reformatArrayToObjectIndexedBy(INDEX_KEY, serviceData));
        }
        static var INDEX_KEY = "puffle_item_id";
    }
