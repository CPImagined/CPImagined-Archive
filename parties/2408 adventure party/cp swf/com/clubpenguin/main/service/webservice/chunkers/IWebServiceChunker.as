//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.service.webservice.chunkers
{
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.main.vo.WebServiceDataVO;

    public interface IWebServiceChunker 
    {

        function sendData(_arg_1:IAVMBridgeService, _arg_2:WebServiceDataVO, _arg_3:Object):Boolean;

    }
}//package com.clubpenguin.main.service.webservice.chunkers
