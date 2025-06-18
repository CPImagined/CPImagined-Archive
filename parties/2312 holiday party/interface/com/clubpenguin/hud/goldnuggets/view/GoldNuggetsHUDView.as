//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.goldnuggets.view.GoldNuggetsHUDView
    {
        var _parentClip, _totalGoldNuggetsToCollect, HUDClicked, HUDAnimationCompleted, _goldNuggetsHUDClip, _numGoldNuggetsCollected;
        function GoldNuggetsHUDView (parentClip, totalGoldNuggetsToCollect) {
            _parentClip = parentClip;
            _totalGoldNuggetsToCollect = totalGoldNuggetsToCollect;
            HUDClicked = new org.osflash.signals.Signal();
            HUDAnimationCompleted = new org.osflash.signals.Signal();
        }
        function destroy() {
            _goldNuggetsHUDClip.onRelease = null;
            _goldNuggetsHUDClip.onRollOver = null;
            _goldNuggetsHUDClip.onRollOut = null;
        }
        function show(animate) {
            if (_goldNuggetsHUDClip._visible) {
                return(undefined);
            }
            _goldNuggetsHUDClip._visible = true;
            if (animate) {
                _goldNuggetsHUDClip.goldNuggetsIcon.gotoAndPlay("appearAnim");
                var scope = this;
                _goldNuggetsHUDClip.goldNuggetsIcon.onEnterFrame = function () {
                    if (this._currentframe >= this._totalframes) {
                        scope.HUDAnimationCompleted.dispatch();
                        this.onEnterFrame = null;
                    }
                };
            } else {
                _goldNuggetsHUDClip.goldNuggetsIcon.gotoAndStop("appear");
            }
        }
        function hide() {
            _goldNuggetsHUDClip._visible = false;
        }
        function isVisible() {
            return(_goldNuggetsHUDClip._visible);
        }
        function setNumGoldNuggetsCollected(numGoldNuggets) {
            if (_numGoldNuggetsCollected != numGoldNuggets) {
                _numGoldNuggetsCollected = numGoldNuggets;
                setNumGoldNuggetsCollectedText();
            }
        }
        function loadGoldNuggetsHUD(assetURL) {
            var _local_2 = new com.clubpenguin.hybrid.HybridMovieClipLoader();
            _goldNuggetsHUDClip = _parentClip.createEmptyMovieClip("goldNuggetsHUD", _parentClip.getNextHighestDepth());
            _local_2.addEventListener(com.clubpenguin.hybrid.HybridMovieClipLoader.EVENT_ON_LOAD_INIT, com.clubpenguin.util.Delegate.create(this, onGoldNuggetsHUDLoaded));
            _local_2.loadClip(assetURL, _goldNuggetsHUDClip, "GoldNuggetsHUDView.as loadGoldNuggetsHUD()");
        }
        function setNumGoldNuggetsCollectedText() {
            _goldNuggetsHUDClip.goldNuggetsIcon.numGoldNuggetsCollected.valueText.text = (_numGoldNuggetsCollected + "/") + _totalGoldNuggetsToCollect;
        }
        function onGoldNuggetsHUDLoaded(event) {
            _goldNuggetsHUDClip.onRelease = com.clubpenguin.util.Delegate.create(HUDClicked, HUDClicked.dispatch);
            _goldNuggetsHUDClip.onRollOver = com.clubpenguin.util.Delegate.create(this, onHUDMouseOver);
            _goldNuggetsHUDClip.onRollOut = com.clubpenguin.util.Delegate.create(this, onHUDMouseOut);
        }
        function onHUDMouseOver() {
            _goldNuggetsHUDClip.goldNuggetsIcon.gotoAndStop("over");
        }
        function onHUDMouseOut() {
            _goldNuggetsHUDClip.goldNuggetsIcon.gotoAndStop("appear");
        }
    }
