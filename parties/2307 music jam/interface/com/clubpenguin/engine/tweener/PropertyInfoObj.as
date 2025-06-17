//Created by Action Script Viewer - https://www.buraks.com/asv
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
            var _local_2 = new com.clubpenguin.engine.tweener.PropertyInfoObj(valueStart, valueComplete, originalValueComplete, arrayIndex, extra, isSpecialProperty, modifierFunction, modifierParameters);
            return(_local_2);
        }
        function toString() {
            var _local_2 = "\n[PropertyInfoObj ";
            _local_2 = _local_2 + ("valueStart:" + String(valueStart));
            _local_2 = _local_2 + ", ";
            _local_2 = _local_2 + ("valueComplete:" + String(valueComplete));
            _local_2 = _local_2 + ", ";
            _local_2 = _local_2 + ("originalValueComplete:" + String(originalValueComplete));
            _local_2 = _local_2 + ", ";
            _local_2 = _local_2 + ("arrayIndex:" + String(arrayIndex));
            _local_2 = _local_2 + ", ";
            _local_2 = _local_2 + ("extra:" + String(extra));
            _local_2 = _local_2 + ", ";
            _local_2 = _local_2 + ("isSpecialProperty:" + String(isSpecialProperty));
            _local_2 = _local_2 + ", ";
            _local_2 = _local_2 + ("hasModifier:" + String(hasModifier));
            _local_2 = _local_2 + ", ";
            _local_2 = _local_2 + ("modifierFunction:" + String(modifierFunction));
            _local_2 = _local_2 + ", ";
            _local_2 = _local_2 + ("modifierParameters:" + String(modifierParameters));
            _local_2 = _local_2 + "]\n";
            return(_local_2);
        }
    }
