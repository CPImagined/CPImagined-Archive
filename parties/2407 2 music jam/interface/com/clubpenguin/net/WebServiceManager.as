//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.net.WebServiceManager extends com.clubpenguin.util.EventDispatcher
    {
        var _servicesData, _shell, _isLoading;
        function WebServiceManager () {
            super();
            _servicesData = {};
            _shell = _global.getCurrentShell();
            _isLoading = false;
        }
        function getCachedServiceData(serviceType) {
            if (_servicesData[serviceType.name] == null) {
            }
            return(_servicesData[serviceType.name]);
        }
        function cacheServiceData(serviceName, serviceData) {
            if (serviceData == null) {
                return(undefined);
            }
            _servicesData[serviceName] = serviceData;
        }
        static var EVENT_CACHING_COMPLETE = "initComplete";
        static var EVENT_CACHING_PROGRESS = "cachingProgress";
        var eventCachingComplete = false;
        static var MAX_CONCURRENT_LOADERS = 4;
    }
