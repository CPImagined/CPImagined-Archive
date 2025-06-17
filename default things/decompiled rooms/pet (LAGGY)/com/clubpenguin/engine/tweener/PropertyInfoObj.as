//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.tweener.PropertyInfoObj
    {
        var valueStart, valueComplete, originalValueComplete, arrayIndex, extra, isSpecialProperty, hasModifier, modifierFunction, modifierParameters;
        function PropertyInfoObj (_arg_3, _arg_8, _arg_4, _arg_7, _arg_6, _arg_5, _arg_2, _arg_9) {
            valueStart = _arg_3;
            valueComplete = _arg_8;
            originalValueComplete = _arg_4;
            arrayIndex = _arg_7;
            extra = _arg_6;
            isSpecialProperty = _arg_5;
            hasModifier = _arg_2 != undefined;
            modifierFunction = _arg_2;
            modifierParameters = _arg_9;
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
