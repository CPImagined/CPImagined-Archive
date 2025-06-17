//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.tweener.SpecialPropertyModifier
    {
        var modifyValues, getValue;
        function SpecialPropertyModifier (p_modifyFunction, p_getFunction) {
            modifyValues = p_modifyFunction;
            getValue = p_getFunction;
        }
        function toString() {
            var _local_2 = "";
            _local_2 = _local_2 + "[SpecialPropertyModifier ";
            _local_2 = _local_2 + ("modifyValues:" + modifyValues.toString());
            _local_2 = _local_2 + ", ";
            _local_2 = _local_2 + ("getValue:" + getValue.toString());
            _local_2 = _local_2 + "]";
            return(_local_2);
        }
    }
