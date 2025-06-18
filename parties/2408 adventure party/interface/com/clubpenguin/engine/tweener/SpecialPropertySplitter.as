//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.engine.tweener.SpecialPropertySplitter
    {
        var parameters;
        function SpecialPropertySplitter (p_splitFunction, p_parameters) {
            splitValues = p_splitFunction;
            parameters = p_parameters;
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
