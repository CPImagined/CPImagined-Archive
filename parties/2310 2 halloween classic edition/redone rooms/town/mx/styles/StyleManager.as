﻿//Created by Action Script Viewer - https://www.buraks.com/asv
    class mx.styles.StyleManager
    {
        function StyleManager () {
        }
        static function registerInheritingStyle(styleName) {
            inheritingStyles[styleName] = true;
        }
        static function isInheritingStyle(styleName) {
            return(inheritingStyles[styleName] == true);
        }
        static function registerColorStyle(styleName) {
            colorStyles[styleName] = true;
        }
        static function isColorStyle(styleName) {
            return(colorStyles[styleName] == true);
        }
        static function registerColorName(colorName, colorValue) {
            colorNames[colorName] = colorValue;
        }
        static function isColorName(colorName) {
            return(colorNames[colorName] != undefined);
        }
        static function getColorName(colorName) {
            return(colorNames[colorName]);
        }
        static var inheritingStyles = {color:true, direction:true, fontFamily:true, fontSize:true, fontStyle:true, fontWeight:true, textAlign:true, textIndent:true};
        static var colorStyles = {barColor:true, trackColor:true, borderColor:true, buttonColor:true, color:true, dateHeaderColor:true, dateRollOverColor:true, disabledColor:true, fillColor:true, highlightColor:true, scrollTrackColor:true, selectedDateColor:true, shadowColor:true, strokeColor:true, symbolBackgroundColor:true, symbolBackgroundDisabledColor:true, symbolBackgroundPressedColor:true, symbolColor:true, symbolDisabledColor:true, themeColor:true, todayIndicatorColor:true, shadowCapColor:true, borderCapColor:true, focusColor:true};
        static var colorNames = {black:0, white:16777215, red:16711680, green:65280, blue:255, magenta:16711935, yellow:16776960, cyan:65535, haloGreen:8453965, haloBlue:2881013, haloOrange:16761344};
        static var TextFormatStyleProps = {font:true, size:true, color:true, leftMargin:false, rightMargin:false, italic:true, bold:true, align:true, indent:true, underline:false, embedFonts:false};
        static var TextStyleMap = {textAlign:true, fontWeight:true, color:true, fontFamily:true, textIndent:true, fontStyle:true, lineHeight:true, marginLeft:true, marginRight:true, fontSize:true, textDecoration:true, embedFonts:true};
    }
