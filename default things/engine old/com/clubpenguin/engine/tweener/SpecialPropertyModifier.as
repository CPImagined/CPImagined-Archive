
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.engine.tweener.SpecialPropertyModifier
    {
        var modifyValues, getValue;
        function SpecialPropertyModifier (p_modifyFunction, p_getFunction) {
            modifyValues = p_modifyFunction;
            getValue = p_getFunction;
        }
        function toString() {
            var _local2 = "";
            _local2 = _local2 + "[SpecialPropertyModifier ";
            _local2 = _local2 + ("modifyValues:" + modifyValues.toString());
            _local2 = _local2 + ", ";
            _local2 = _local2 + ("getValue:" + getValue.toString());
            _local2 = _local2 + "]";
            return(_local2);
        }
    }
