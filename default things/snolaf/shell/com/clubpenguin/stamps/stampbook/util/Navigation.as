//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.util.Navigation extends com.clubpenguin.util.EventDispatcher
    {
        var _shell, structure, indexList, currentSection, dispatchEvent;
        function Navigation (structure) {
            super();
            _shell = com.clubpenguin.stamps.stampbook.util.ShellLookUp.shell;
            this.structure = structure;
            indexList = [];
            update();
        }
        function get title() {
            if (currentSection == structure) {
                return(_shell.getLocalizedString("contents_category_title"));
            } else {
                return(currentSection.getName());
            }
        }
        function get parentTitle() {
            var _local_3 = indexList.length;
            var _local_2 = lookUp(_local_3 - 1);
            if (_local_2 == structure) {
                return(currentSection.getName());
            }
            return(_local_2.getName());
        }
        function get children() {
            if (currentSection == structure) {
                return(Array(currentSection));
            } else {
                return(currentSection.getSubCategories());
            }
        }
        function get type() {
            return(null);
        }
        function reset() {
            indexList = [];
            update();
        }
		function next()
   		{
      		var _loc9_ = this.indexList.slice(0);
      		var _loc6_ = false;
      		while(true)
      	{
         	if(this.indexList.length == 0)
         	{
            	this.indexList.push(0);
            	this.update();
            	return undefined;
         	}
         	var _loc2_ = this.indexList.length;
         	var _loc8_ = this.lookUp(_loc2_);
         	var _loc4_ = _loc8_.getSubCategories();
         	if(!_loc6_ && _loc4_ != undefined && _loc4_.length > 0)
         	{
            	this.indexList.push(0);
            	this.update();
            	return undefined;
         	}
         	_loc6_ = false;
         	var _loc7_ = this.indexList[_loc2_ - 1];
         	var _loc5_ = this.lookUp(_loc2_ - 1);
         	var _loc3_ = undefined;
         	if(_loc5_ == this.structure)
         	{
         	   _loc3_ = this.structure;
         	}
         	else
         	{
         	   _loc3_ = _loc5_.getSubCategories();
         	}
         	if(_loc7_ != _loc3_.length - 1)
         	{
         	   this.indexList[_loc2_ - 1]++;
          	  this.update();
          	  break;
         	}
        	this.indexList.pop();
         	_loc6_ = true;
         	if(this.indexList.length == 0)
         	{
            	this.indexList = _loc9_;
            	return undefined;
         	}
      		}
   		}
        function previous() {
            var _local_7 = indexList.slice(0);
            var _local_8 = false;
            if (indexList.length == 0) {
                return(undefined);
            }
            var _local_4 = indexList.length;
            var _local_5 = indexList[_local_4 - 1];
            if (_local_5 == 0) {
                indexList.pop();
            } else {
                indexList[_local_4 - 1]--;
                var _local_6 = lookUp(_local_4);
                var _local_3 = _local_6;
                while ((_local_3.getSubCategories() != undefined) && (_local_3.getSubCategories().length > 0)) {
                    var _local_2 = _local_3.getSubCategories();
                    indexList.push(_local_2.length - 1);
                    _local_3 = _local_2[_local_2.length - 1];
                }
            }
            update();
            return(undefined);
        }
        function update() {
            currentSection = lookUp();
            dispatchEvent({type:"change"});
        }
        function lookUp(depth) {
            if (depth < 0) {
                return(null);
            }
            if (depth == null) {
                depth = indexList.length;
            }
            var _local_3 = structure;
            var _local_2 = 0;
            while (_local_2 < depth) {
                if (_local_3 == structure) {
                    _local_3 = _local_3[indexList[_local_2]];
                } else {
                    _local_3 = _local_3.getSubCategories()[indexList[_local_2]];
                }
                _local_2++;
            }
            return(_local_3);
        }
        function addSection(id) {
            indexList.push(id);
            update();
        }
        function removeSection() {
            indexList.pop();
            update();
        }
        function goToSection(id) {
            indexList = [];
            indexList.push(id);
            update();
        }
    }
