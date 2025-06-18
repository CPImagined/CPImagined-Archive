//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.collection.operators.FilterOperator implements com.clubpenguin.util.collection.operators.IOperator
    {
        var _propertyName, _values;
        function FilterOperator (propertyName) {
            _propertyName = propertyName;
            _values = arguments.slice(1);
        }
        function apply(sourceArray) {
            var _local_5 = [];
            var _local_6 = sourceArray.length;
            var _local_3 = 0;
            while (_local_3 < _local_6) {
                var _local_2 = 0;
                while (_local_2 < _values.length) {
                    if (sourceArray[_local_3][_propertyName] == _values[_local_2]) {
                        _local_5.push(sourceArray[_local_3]);
                        break;
                    }
                    _local_2++;
                }
                _local_3++;
            }
            return(_local_5);
        }
        function toString() {
            return((("[Filter] " + _propertyName) + ":") + _values);
        }
    }
