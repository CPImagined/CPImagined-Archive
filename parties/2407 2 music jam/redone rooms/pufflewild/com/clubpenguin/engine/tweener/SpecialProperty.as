//Created by Action Script Viewer - https://www.buraks.com/asv
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
            var _local_2 = "";
            _local_2 = _local_2 + "[SpecialProperty ";
            _local_2 = _local_2 + ("getValue:" + getValue.toString());
            _local_2 = _local_2 + ", ";
            _local_2 = _local_2 + ("setValue:" + setValue.toString());
            _local_2 = _local_2 + ", ";
            _local_2 = _local_2 + ("parameters:" + parameters.toString());
            _local_2 = _local_2 + ", ";
            _local_2 = _local_2 + ("preProcess:" + preProcess.toString());
            _local_2 = _local_2 + "]";
            return(_local_2);
        }
    }
