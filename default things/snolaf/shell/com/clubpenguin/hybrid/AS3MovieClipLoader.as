//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hybrid.AS3MovieClipLoader
    {
        function AS3MovieClipLoader (host, load_clip, path, init_function, start_function, progress_function, error_function, options) {
            __host = host;
            __loadClip = load_clip;
            __path = path;
            __options = options;
            __useIterations = ((__options.useIterations != undefined) ? (__options.useIterations) : false);
            __skipLoadChecking = ((__options.skipLoadChecking != undefined) ? (__options.skipLoadChecking) : false);
            __initFunction = init_function;
            __startFunction = ((start_function != undefined) ? (start_function) : null);
            __progressFunction = ((progress_function != undefined) ? (progress_function) : null);
            __errorFunction = ((error_function != undefined) ? (error_function) : null);
            init();
        }
        function init() {
            __trace = com.clubpenguin.hybrid.TraceOutput.getInstance();
            __iterations = 0;
            __instance = this;
            __loadClip.unloadMovie();
            __loadClip.loadMovie(__path);
            if (!__skipLoadChecking) {
                __loadInterval = setInterval(__instance, "checkLoadProgress", INTERVAL_RATE);
            }
            if (__startFunction != null) {
                __startFunction(__loadClip);
            }
        }
        function checkLoadProgress() {
            __iterations++;
            var _local_4 = __loadClip.getBytesLoaded();
            var _local_2 = __loadClip.getBytesTotal();
            var _local_3 = false;
            if (__useIterations) {
                _local_3 = (((_local_4 == _local_2) && ((_local_2 > MIN_BYTES) || (__iterations > MIN_ITERATIONS))) ? true : false);
            } else {
                _local_3 = (((_local_4 == _local_2) && (_local_2 > 4)) ? true : false);
            }
            if (__progressFunction != null) {
                __progressFunction(__loadClip, _local_4, _local_2);
            }
            if (_local_3) {
                stopLoadListening();
            }
            if ((!__useIterations) && (__iterations >= TIME_OUT_THRESHOLD)) {
                clearInterval(__loadInterval);
                var _local_5 = "Could not load: " + __path;
                if (__errorFunction != null) {
                    __errorFunction(__loadClip);
                }
                throw new Error("Time out error, AS3MovieClipLodaer exceeded its iteration limit checking for: " + __path);
            }
        }
        function stopLoadListening() {
            clearInterval(__loadInterval);
            __initFunction(__loadClip);
        }
        static var INTERVAL_RATE = 10;
        static var TIME_OUT_THRESHOLD = 200;
        static var MIN_ITERATIONS = 20;
        static var MIN_BYTES = 4;
        static var AS3_ERROR = "AS3_error";
        var __instance = null;
        var __loadInterval = null;
        var __initFunction = null;
        var __loadClip = null;
        var __path = null;
        var __host = null;
        var __iterations = null;
        var __trace = null;
        var __options = null;
        var __useIterations = null;
        var __skipLoadChecking = null;
        var __startFunction = null;
        var __progressFunction = null;
        var __errorFunction = null;
    }
