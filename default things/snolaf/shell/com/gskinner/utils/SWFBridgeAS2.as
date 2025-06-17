//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.gskinner.utils.SWFBridgeAS2
    {
        var bridgeDisconnect, baseID, lc, clientObj, host, myID, extID, dispatchEvent;
        function SWFBridgeAS2 (p_id, p_clientObj) {
            mx.events.EventDispatcher.initialize(this);
            bridgeDisconnect = new org.osflash.signals.Signal();
            baseID = p_id.split(":").join("");
            lc = new LocalConnection();
            var _this = this;
            lc.com_gskinner_utils_SWFBridge_init = function () {
                _this.com_gskinner_utils_SWFBridge_init();
            };
            lc.com_gskinner_utils_SWFBridge_receive = function () {
                _this.com_gskinner_utils_SWFBridge_receive.apply(_this, arguments);
            };
            lc.onStatus = function (infoObject) {
                switch (infoObject.level) {
                    case "status" : 
                        break;
                    case "error" : 
                        break;
                }
            };
            clientObj = p_clientObj;
            host = lc.connect(baseID + "_host");
            myID = baseID + (host ? "_host" : "_guest");
            extID = baseID + (host ? "_guest" : "_host");
            if (!host) {
                lc.connect(myID);
                lc.send(extID, "com_gskinner_utils_SWFBridge_init");
            }
        }
        function onStatus(event) {
            switch (event.level) {
                case "status" : 
                    break;
                case "error" : 
                    break;
            }
        }
        function close() {
            lc.close();
            delete clientObj;
            delete lc;
            _connected = false;
        }
        function send() {
            if (!_connected) {
                bridgeDisconnect.dispatch();
                return(undefined);
            }
            var _local_3 = arguments.slice(0);
            _local_3.unshift("com_gskinner_utils_SWFBridge_receive");
            _local_3.unshift(extID);
            for (var _local_4 in _local_3[3]) {
            }
            lc.send.apply(lc, _local_3);
        }
        function get id() {
            return(baseID);
        }
        function get connected() {
            return(_connected);
        }
        function com_gskinner_utils_SWFBridge_receive() {
            var _local_3 = arguments.slice(0);
            var _local_4 = String(_local_3.shift());
            clientObj[_local_4].apply(clientObj, _local_3);
        }
        function com_gskinner_utils_SWFBridge_init() {
            if (host) {
                lc.send(extID, "com_gskinner_utils_SWFBridge_init");
            }
            _connected = true;
            dispatchEvent({type:"connect"});
        }
        var _connected = false;
    }
