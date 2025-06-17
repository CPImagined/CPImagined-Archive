
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.engine.tweener.PropertyInfoObj
    {
        var valueStart, valueComplete, originalValueComplete, arrayIndex, extra, isSpecialProperty, hasModifier, modifierFunction, modifierParameters;
        function PropertyInfoObj (p_valueStart, p_valueComplete, p_originalValueComplete, p_arrayIndex, p_extra, p_isSpecialProperty, p_modifierFunction, p_modifierParameters) {
            valueStart = p_valueStart;
            valueComplete = p_valueComplete;
            originalValueComplete = p_originalValueComplete;
            arrayIndex = p_arrayIndex;
            extra = p_extra;
            isSpecialProperty = p_isSpecialProperty;
            hasModifier = p_modifierFunction != undefined;
            modifierFunction = p_modifierFunction;
            modifierParameters = p_modifierParameters;
        }
        function clone() {
            var _local2 = new com.clubpenguin.engine.tweener.PropertyInfoObj(valueStart, valueComplete, originalValueComplete, arrayIndex, extra, isSpecialProperty, modifierFunction, modifierParameters);
            return(_local2);
        }
        function toString() {
            var _local2 = "\n[PropertyInfoObj ";
            _local2 = _local2 + ("valueStart:" + String(valueStart));
            _local2 = _local2 + ", ";
            _local2 = _local2 + ("valueComplete:" + String(valueComplete));
            _local2 = _local2 + ", ";
            _local2 = _local2 + ("originalValueComplete:" + String(originalValueComplete));
            _local2 = _local2 + ", ";
            _local2 = _local2 + ("arrayIndex:" + String(arrayIndex));
            _local2 = _local2 + ", ";
            _local2 = _local2 + ("extra:" + String(extra));
            _local2 = _local2 + ", ";
            _local2 = _local2 + ("isSpecialProperty:" + String(isSpecialProperty));
            _local2 = _local2 + ", ";
            _local2 = _local2 + ("hasModifier:" + String(hasModifier));
            _local2 = _local2 + ", ";
            _local2 = _local2 + ("modifierFunction:" + String(modifierFunction));
            _local2 = _local2 + ", ";
            _local2 = _local2 + ("modifierParameters:" + String(modifierParameters));
            _local2 = _local2 + "]\n";
            return(_local2);
        }
    }
