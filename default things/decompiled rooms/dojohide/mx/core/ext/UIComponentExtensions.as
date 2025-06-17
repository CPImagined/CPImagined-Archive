//Created by Action Script Viewer - https://www.buraks.com/asv
    class mx.core.ext.UIComponentExtensions
    {
        function UIComponentExtensions () {
        }
        static function Extensions() {
            if (bExtended == true) {
                return(true);
            }
            bExtended = true;
            TextField.prototype.setFocus = function () {
                Selection.setFocus(this);
            };
            TextField.prototype.onSetFocus = function (oldFocus) {
                if (this.tabEnabled != false) {
                    if (this.getFocusManager().bDrawFocus) {
                        this.drawFocus(true);
                    }
                }
            };
            TextField.prototype.onKillFocus = function (oldFocus) {
                if (this.tabEnabled != false) {
                    this.drawFocus(false);
                }
            };
            TextField.prototype.drawFocus = mx.core.UIComponent.prototype.drawFocus;
            TextField.prototype.getFocusManager = mx.core.UIComponent.prototype.getFocusManager;
            mx.managers.OverlappedWindows.enableOverlappedWindows();
            mx.styles.CSSSetStyle.enableRunTimeCSS();
            mx.managers.FocusManager.enableFocusManagement();
        }
        static var bExtended = false;
        static var UIComponentExtended = Extensions();
        static var UIComponentDependency = mx.core.UIComponent;
        static var FocusManagerDependency = mx.managers.FocusManager;
        static var OverlappedWindowsDependency = mx.managers.OverlappedWindows;
    }
