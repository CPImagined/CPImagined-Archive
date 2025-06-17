//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.shell.DependencyLoader extends com.clubpenguin.util.EventDispatcher
    {
        var container, _trackerAS2, dependencies, _currentContext, updateListeners;
        function DependencyLoader (baseURL, container) {
            super();
            if (baseURL == undefined) {
                throw new Error("DependencyLoader -> baseURL is undefined! baseURL:" + baseURL);
            }
            if (!container) {
                throw new Error("DependencyLoader -> container is not set! container:" + container);
            }
            this.baseURL = baseURL;
            this.container = container;
            _trackerAS2 = com.clubpenguin.util.TrackerAS2.getInstance();
        }
        function load(dependencies) {
            if (!dependencies.length) {
                throw new Error("DependencyLoader.load -> dependencies array is not defined! dependencies: " + dependencies);
            }
            this.dependencies = dependencies.concat();
            _currentContext = _trackerAS2.currentContext;
            _trackerAS2.sendToAS3StartSubContextAssetLoad(_currentContext, "dependencies");
            currentIndex = 0;
            loadDependency(dependencies[currentIndex]);
        }
        function loadDependency(dependency) {
            currentID = dependency.id;
            _trackerAS2.sendToAS3StartSubContextAssetLoad(_currentContext, "dep." + currentID);
            if (container[currentID] != undefined) {
                container[currentID].removeMovieClip();
            }
            var _local_5 = container.createEmptyMovieClip(currentID, container.getNextHighestDepth());
            var _local_3 = dependency.folder || "";
            var _local_4 = dependency.baseURL || (baseURL);
            var _local_6 = com.clubpenguin.util.URLUtils.getCacheResetURL(((_local_4 + _local_3) + currentID) + DEPENDENCY_FILE_EXTENSTION);
            var _local_2 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            _local_2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onLoadInit));
            _local_2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_PROGRESS, com.clubpenguin.util.Delegate.create(this, onLoadProgress));
            _local_2.loadClip(_local_6, _local_5);
        }
        function onLoadInit(event) {
            _trackerAS2.sendToAS3EndSubContextAssetLoad("dep." + currentID);
            if (currentIndex >= (dependencies.length - 1)) {
                _trackerAS2.sendToAS3EndSubContextAssetLoad("dependencies");
                updateListeners(COMPLETE);
                return(undefined);
            }
            currentIndex++;
            loadDependency(dependencies[currentIndex]);
        }
        function onLoadProgress(event) {
            event.dependencyTitle = dependencies[currentIndex].title;
            updateListeners(PROGRESS, event);
        }
        static var COMPLETE = "complete";
        static var PROGRESS = "progress";
        static var DEPENDENCY_FILE_EXTENSTION = ".swf";
        var currentID = "";
        var currentIndex = -1;
        var baseURL = "";
    }
