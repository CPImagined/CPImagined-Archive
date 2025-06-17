//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.lib.managers.resource
{
    import com.clubpenguin.lib.enums.resource.ResourceTypeEnum;
    import com.clubpenguin.lib.vo.resource.ResourceVO;

    public interface IResourceManager 
    {

        function getResourceVO(_arg_1:ResourceTypeEnum, _arg_2:int):ResourceVO;

    }
}//package com.clubpenguin.lib.managers.resource
