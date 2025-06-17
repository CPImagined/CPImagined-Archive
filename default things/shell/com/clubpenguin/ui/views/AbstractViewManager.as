    class com.clubpenguin.ui.views.AbstractViewManager
    {
        var _mc, _views;
        function AbstractViewManager (mc) {
            _mc = mc;
            _views = [];
        }
        function addView(viewClass) {
            var _local_2 = com.clubpenguin.ui.views.IView(_mc.attachMovie(viewClass.LINKAGE_ID, viewClass.LINKAGE_ID, _mc.getNextHighestDepth()));
            _local_2.hide();
            _local_2.setViewManager(this);
            _views.push(_local_2);
            return(_local_2);
        }
        function showView(viewClass) {
            var _local_2 = 0;
            var _local_3 = _views.length;
            while (_local_2 < _local_3) {
                if (_views[_local_2].__constructor__.LINKAGE_ID == viewClass.LINKAGE_ID) {
                    com.clubpenguin.ui.views.IView(_views[_local_2]).show();
                    break;
                }
                _local_2++;
            }
        }
        function hideView(viewClass) {
            var _local_2 = 0;
            var _local_3 = _views.length;
            while (_local_2 < _local_3) {
                if (_views[_local_2].__constructor__.LINKAGE_ID == viewClass.LINKAGE_ID) {
                    com.clubpenguin.ui.views.IView(_views[_local_2]).hide();
                    break;
                }
                _local_2++;
            }
        }
        function hideAllViews() {
            var _local_2 = 0;
            var _local_3 = _views.length;
            while (_local_2 < _local_3) {
                com.clubpenguin.ui.views.IView(_views[_local_2]).hide();
                _local_2++;
            }
        }
        function getView(viewClass) {
            var _local_3 = _views.length;
            var _local_2 = 0;
            while (_local_2 < _local_3) {
                if (_views[_local_2].__constructor__.LINKAGE_ID == viewClass.LINKAGE_ID) {
                    return(com.clubpenguin.ui.views.IView(_views[_local_2]));
                }
                _local_2++;
            }
        }
    }
