//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.util.collection.operators.SortOperator implements com.clubpenguin.util.collection.operators.IOperator
    {
        var _propertyNames, _sortOptions;
        function SortOperator (propertyNames, sortOptions) {
            _propertyNames = propertyNames;
            _sortOptions = sortOptions;
        }
        function apply(arrayToSort) {
            arrayToSort.sortOn(_propertyNames, _sortOptions);
            return(arrayToSort);
        }
        function toString() {
            return("[SortOperator] " + _propertyNames);
        }
    }
