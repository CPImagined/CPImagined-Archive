//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.tweener.SpecialProperty
    {
        var getValue, setValue, parameters, preProcess;
        function SpecialProperty (_arg_3, _arg_2, _arg_4, _arg_5) {
            getValue = _arg_3;
            setValue = _arg_2;
            parameters = _arg_4;
            preProcess = _arg_5;
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
