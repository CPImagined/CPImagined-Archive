//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.tweener.SpecialPropertySplitter
    {
        var parameters;
        function SpecialPropertySplitter (_arg_3, _arg_2) {
            splitValues = _arg_3;
            parameters = _arg_2;
        }
        function splitValues(p_value, p_parameters) {
            return([]);
        }
        function toString() {
            var _local_2 = "";
            _local_2 = _local_2 + "[SpecialPropertySplitter ";
            _local_2 = _local_2 + ("splitValues:" + splitValues.toString());
            _local_2 = _local_2 + ", ";
            _local_2 = _local_2 + ("parameters:" + parameters.toString());
            _local_2 = _local_2 + "]";
            return(_local_2);
        }
    }
