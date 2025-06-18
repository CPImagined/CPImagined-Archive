    class mx.skins.halo.Defaults
    {
        var beginGradientFill, beginFill, moveTo, lineTo, curveTo, endFill;
        function Defaults () {
        }
        static function setThemeDefaults() {
            var _local_2 = _global.style;
            _local_2.themeColor = 8453965 /* 0x80FF4D */;
            _local_2.disabledColor = 8684164 /* 0x848284 */;
            _local_2.modalTransparency = 0;
            _local_2.filled = true;
            _local_2.stroked = true;
            _local_2.strokeWidth = 1;
            _local_2.strokeColor = 0;
            _local_2.fillColor = 16777215 /* 0xFFFFFF */;
            _local_2.repeatInterval = 35;
            _local_2.repeatDelay = 500;
            _local_2.fontFamily = "_sans";
            _local_2.fontSize = 12;
            _local_2.selectionColor = 13500353 /* 0xCDFFC1 */;
            _local_2.rollOverColor = 14942166 /* 0xE3FFD6 */;
            _local_2.useRollOver = true;
            _local_2.backgroundDisabledColor = 14540253 /* 0xDDDDDD */;
            _local_2.selectionDisabledColor = 14540253 /* 0xDDDDDD */;
            _local_2.selectionDuration = 200;
            _local_2.openDuration = 250;
            _local_2.borderStyle = "inset";
            _local_2["color"] = 734012 /* 0x0B333C */;
            _local_2.textSelectedColor = 24371;
            _local_2.textRollOverColor = 2831164 /* 0x2B333C */;
            _local_2.textDisabledColor = 16777215 /* 0xFFFFFF */;
            _local_2.vGridLines = true;
            _local_2.hGridLines = false;
            _local_2.vGridLineColor = 6710886 /* 0x666666 */;
            _local_2.hGridLineColor = 6710886 /* 0x666666 */;
            _local_2.headerColor = 15395562 /* 0xEAEAEA */;
            _local_2.indentation = 17;
            _local_2.folderOpenIcon = "TreeFolderOpen";
            _local_2.folderClosedIcon = "TreeFolderClosed";
            _local_2.defaultLeafIcon = "TreeNodeIcon";
            _local_2.disclosureOpenIcon = "TreeDisclosureOpen";
            _local_2.disclosureClosedIcon = "TreeDisclosureClosed";
            _local_2.popupDuration = 150;
            _local_2.todayColor = 6710886 /* 0x666666 */;
            _local_2 = (_global.styles.ScrollSelectList = new mx.styles.CSSStyleDeclaration());
            _local_2.backgroundColor = 16777215 /* 0xFFFFFF */;
            _local_2.borderColor = 13290186 /* 0xCACACA */;
            _local_2.borderStyle = "inset";
            _local_2 = (_global.styles.ComboBox = new mx.styles.CSSStyleDeclaration());
            _local_2.borderStyle = "inset";
            _local_2 = (_global.styles.NumericStepper = new mx.styles.CSSStyleDeclaration());
            _local_2.textAlign = "center";
            _local_2 = (_global.styles.RectBorder = new mx.styles.CSSStyleDeclaration());
            _local_2.borderColor = 14015965 /* 0xD5DDDD */;
            _local_2.buttonColor = 7305079 /* 0x6F7777 */;
            _local_2.shadowColor = 15658734 /* 0xEEEEEE */;
            _local_2.highlightColor = 12897484 /* 0xC4CCCC */;
            _local_2.shadowCapColor = 14015965 /* 0xD5DDDD */;
            _local_2.borderCapColor = 9542041 /* 0x919999 */;
            var _local_4 = new Object();
            _local_4.borderColor = 16711680 /* 0xFF0000 */;
            _local_4.buttonColor = 16711680 /* 0xFF0000 */;
            _local_4.shadowColor = 16711680 /* 0xFF0000 */;
            _local_4.highlightColor = 16711680 /* 0xFF0000 */;
            _local_4.shadowCapColor = 16711680 /* 0xFF0000 */;
            _local_4.borderCapColor = 16711680 /* 0xFF0000 */;
            mx.core.UIComponent.prototype.origBorderStyles = _local_4;
            var _local_3;
            _local_3 = (_global.styles.TextInput = new mx.styles.CSSStyleDeclaration());
            _local_3.backgroundColor = 16777215 /* 0xFFFFFF */;
            _local_3.borderStyle = "inset";
            _global.styles.TextArea = _global.styles.TextInput;
            _local_3 = (_global.styles.Window = new mx.styles.CSSStyleDeclaration());
            _local_3.borderStyle = "default";
            _local_3 = (_global.styles.windowStyles = new mx.styles.CSSStyleDeclaration());
            _local_3.fontWeight = "bold";
            _local_3 = (_global.styles.dataGridStyles = new mx.styles.CSSStyleDeclaration());
            _local_3.fontWeight = "bold";
            _local_3 = (_global.styles.Alert = new mx.styles.CSSStyleDeclaration());
            _local_3.borderStyle = "alert";
            _local_3 = (_global.styles.ScrollView = new mx.styles.CSSStyleDeclaration());
            _local_3.borderStyle = "inset";
            _local_3 = (_global.styles.View = new mx.styles.CSSStyleDeclaration());
            _local_3.borderStyle = "none";
            _local_3 = (_global.styles.ProgressBar = new mx.styles.CSSStyleDeclaration());
            _local_3["color"] = 11187123 /* 0xAAB3B3 */;
            _local_3.fontWeight = "bold";
            _local_3 = (_global.styles.AccordionHeader = new mx.styles.CSSStyleDeclaration());
            _local_3.fontWeight = "bold";
            _local_3.fontSize = "11";
            _local_3 = (_global.styles.Accordion = new mx.styles.CSSStyleDeclaration());
            _local_3.borderStyle = "solid";
            _local_3.backgroundColor = 16777215 /* 0xFFFFFF */;
            _local_3.borderColor = 9081738 /* 0x8A938A */;
            _local_3.headerHeight = 22;
            _local_3.marginLeft = (_local_3.marginRight = (_local_3.marginTop = (_local_3.marginBottom = -1)));
            _local_3.verticalGap = -1;
            _local_3 = (_global.styles.DateChooser = new mx.styles.CSSStyleDeclaration());
            _local_3.borderColor = 9542041 /* 0x919999 */;
            _local_3.headerColor = 16777215 /* 0xFFFFFF */;
            _local_3 = (_global.styles.CalendarLayout = new mx.styles.CSSStyleDeclaration());
            _local_3.fontSize = 10;
            _local_3.textAlign = "right";
            _local_3["color"] = 2831164 /* 0x2B333C */;
            _local_3 = (_global.styles.WeekDayStyle = new mx.styles.CSSStyleDeclaration());
            _local_3.fontWeight = "bold";
            _local_3.fontSize = 11;
            _local_3.textAlign = "center";
            _local_3["color"] = 2831164 /* 0x2B333C */;
            _local_3 = (_global.styles.TodayStyle = new mx.styles.CSSStyleDeclaration());
            _local_3["color"] = 16777215 /* 0xFFFFFF */;
            _local_3 = (_global.styles.HeaderDateText = new mx.styles.CSSStyleDeclaration());
            _local_3.fontSize = 12;
            _local_3.fontWeight = "bold";
            _local_3.textAlign = "center";
        }
        function drawRoundRect(x, y, w, h, r, c, alpha, rot, gradient, ratios) {
            if (typeof(r) == "object") {
                var _local_18 = r.br;
                var _local_16 = r.bl;
                var _local_15 = r.tl;
                var _local_10 = r.tr;
            } else {
                var _local_10 = r;
                var _local_15 = _local_10;
                var _local_16 = _local_15;
                var _local_18 = _local_16;
            }
            if (typeof(c) == "object") {
                if (typeof(alpha) != "object") {
                    var _local_9 = [alpha, alpha];
                } else {
                    var _local_9 = alpha;
                }
                if (ratios == undefined) {
                    ratios = [0, 255];
                }
                var _local_14 = h * 0.7;
                if (typeof(rot) != "object") {
                    var _local_11 = {matrixType:"box", x:-_local_14, y:_local_14, w:w * 2, h:h * 4, r:rot * 0.0174532925199433 /* Math.PI/180 */};
                } else {
                    var _local_11 = rot;
                }
                if (gradient == "radial") {
                    this.beginGradientFill("radial", c, _local_9, ratios, _local_11);
                } else {
                    this.beginGradientFill("linear", c, _local_9, ratios, _local_11);
                }
            } else if (c != undefined) {
                this.beginFill(c, alpha);
            }
            r = _local_18;
            var _local_13 = r - (r * 0.707106781186547);
            var _local_12 = r - (r * 0.414213562373095);
            this.moveTo(x + w, (y + h) - r);
            this.lineTo(x + w, (y + h) - r);
            this.curveTo(x + w, (y + h) - _local_12, (x + w) - _local_13, (y + h) - _local_13);
            this.curveTo((x + w) - _local_12, y + h, (x + w) - r, y + h);
            r = _local_16;
            _local_13 = r - (r * 0.707106781186547);
            _local_12 = r - (r * 0.414213562373095);
            this.lineTo(x + r, y + h);
            this.curveTo(x + _local_12, y + h, x + _local_13, (y + h) - _local_13);
            this.curveTo(x, (y + h) - _local_12, x, (y + h) - r);
            r = _local_15;
            _local_13 = r - (r * 0.707106781186547);
            _local_12 = r - (r * 0.414213562373095);
            this.lineTo(x, y + r);
            this.curveTo(x, y + _local_12, x + _local_13, y + _local_13);
            this.curveTo(x + _local_12, y, x + r, y);
            r = _local_10;
            _local_13 = r - (r * 0.707106781186547);
            _local_12 = r - (r * 0.414213562373095);
            this.lineTo((x + w) - r, y);
            this.curveTo((x + w) - _local_12, y, (x + w) - _local_13, y + _local_13);
            this.curveTo(x + w, y + _local_12, x + w, y + r);
            this.lineTo(x + w, (y + h) - r);
            if (c != undefined) {
                this.endFill();
            }
        }
        static function classConstruct() {
            mx.core.ext.UIObjectExtensions.Extensions();
            setThemeDefaults();
            mx.core.UIObject.prototype.drawRoundRect = mx.skins.halo.Defaults.prototype.drawRoundRect;
            return(true);
        }
        static var classConstructed = classConstruct();
        static var CSSStyleDeclarationDependency = mx.styles.CSSStyleDeclaration;
        static var UIObjectExtensionsDependency = mx.core.ext.UIObjectExtensions;
        static var UIObjectDependency = mx.core.UIObject;
    }
