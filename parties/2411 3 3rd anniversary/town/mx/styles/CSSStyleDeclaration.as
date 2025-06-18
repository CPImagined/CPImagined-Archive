    class mx.styles.CSSStyleDeclaration
    {
        var _tf;
        function CSSStyleDeclaration () {
        }
        function __getTextFormat(tf, bAll) {
            var _local_5 = false;
            if (_tf != undefined) {
                var _local_2;
                for (_local_2 in mx.styles.StyleManager.TextFormatStyleProps) {
                    if (bAll || (mx.styles.StyleManager.TextFormatStyleProps[_local_2])) {
                        if (tf[_local_2] == undefined) {
                            var _local_3 = _tf[_local_2];
                            if (_local_3 != undefined) {
                                tf[_local_2] = _local_3;
                            } else {
                                _local_5 = true;
                            }
                        }
                    }
                }
            } else {
                _local_5 = true;
            }
            return(_local_5);
        }
        function getStyle(styleProp) {
            var _local_2 = this[styleProp];
            var _local_3 = mx.styles.StyleManager.getColorName(_local_2);
            return(((_local_3 == undefined) ? (_local_2) : (_local_3)));
        }
        static function classConstruct() {
            mx.styles.CSSTextStyles.addTextStyles(mx.styles.CSSStyleDeclaration.prototype, true);
            return(true);
        }
        static var classConstructed = classConstruct();
        static var CSSTextStylesDependency = mx.styles.CSSTextStyles;
    }
