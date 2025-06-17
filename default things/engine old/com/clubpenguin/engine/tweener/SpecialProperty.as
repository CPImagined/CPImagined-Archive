
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.engine.tweener.SpecialProperty
    {
        var getValue, setValue, parameters, preProcess;
        function SpecialProperty (p_getFunction, p_setFunction, p_parameters, p_preProcessFunction) {
            getValue = p_getFunction;
            setValue = p_setFunction;
            parameters = p_parameters;
            preProcess = p_preProcessFunction;
        }
        function toString() {
            var _local2 = "";
            _local2 = _local2 + "[SpecialProperty ";
            _local2 = _local2 + ("getValue:" + getValue.toString());
            _local2 = _local2 + ", ";
            _local2 = _local2 + ("setValue:" + setValue.toString());
            _local2 = _local2 + ", ";
            _local2 = _local2 + ("parameters:" + parameters.toString());
            _local2 = _local2 + ", ";
            _local2 = _local2 + ("preProcess:" + preProcess.toString());
            _local2 = _local2 + "]";
            return(_local2);
        }
    }
