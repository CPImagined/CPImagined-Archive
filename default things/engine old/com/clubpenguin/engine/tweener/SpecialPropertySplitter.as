
//Created by Action Script Viewer - http://www.buraks.com/asv
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
            var _local2 = "";
            _local2 = _local2 + "[SpecialPropertySplitter ";
            _local2 = _local2 + ("splitValues:" + splitValues.toString());
            _local2 = _local2 + ", ";
            _local2 = _local2 + ("parameters:" + parameters.toString());
            _local2 = _local2 + "]";
            return(_local2);
        }
    }
