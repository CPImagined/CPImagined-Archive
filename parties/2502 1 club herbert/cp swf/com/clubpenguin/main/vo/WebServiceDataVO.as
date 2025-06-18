//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.vo
{
    import com.clubpenguin.lib.enums.errors.ErrorCodeEnum;
    import flash.utils.getQualifiedClassName;
    import flash.utils.getDefinitionByName;

    public class WebServiceDataVO 
    {

        public var name:String;
        public var fileName:String;
        public var data:*;
        public var priority:int;
        public var requiresChunking:Boolean;
        public var isCritical:Boolean;
        public var loadError:ErrorCodeEnum;
        public var sendError:ErrorCodeEnum;


        public function get dataType():Class
        {
            var className:String = getQualifiedClassName(this.data);
            if (className == null)
            {
                return (null);
            };
            return (Class(getDefinitionByName(className)));
        }


    }
}//package com.clubpenguin.main.vo
