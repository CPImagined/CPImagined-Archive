//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.service.webservice.chunkers
{
    import com.clubpenguin.lib.util.ArrayUtil;
    import com.clubpenguin.main.service.webservice.WebServiceAVMBridge;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.main.vo.WebServiceDataVO;

    public class SimpleChunker implements IWebServiceChunker 
    {


        public function sendData(bridge:IAVMBridgeService, wsdVO:WebServiceDataVO, masterChunkMap:Object):Boolean
        {
            var dataArray:Array;
            var chunkMap:Array;
            var iterator:IChunkIterator;
            var chunk:Array;
            var isDone:Boolean;
            try
            {
                if (((!(wsdVO.dataType)) is Array))
                {
                    throw (new Error("Incorrect WebServiceDataVO.dataType in StampsChunker.sendData(). The dataType should be an Array."));
                };
                if (WebServiceChunkUtils.getItemCount(masterChunkMap) == 0)
                {
                    throw (new Error("Chunking Map JSON data is empty!"));
                };
                if (((wsdVO.data == null) || (wsdVO.data.length == 0)))
                {
                    throw (new Error((wsdVO.name + " JSON data is empty!")));
                };
                dataArray = ArrayUtil.clone(wsdVO.data);
                chunkMap = ArrayUtil.clone(masterChunkMap[wsdVO.fileName]);
                if (((dataArray == null) || (dataArray.length == 0)))
                {
                    throw (new Error((wsdVO.name + " JSON data is empty!")));
                };
                iterator = new ChunkIterator(chunkMap);
                while (iterator.hasNext())
                {
                    chunk = WebServiceChunkUtils.getChunk(dataArray, iterator.next());
                    isDone = (dataArray.length == 0);
                    WebServiceAVMBridge.sendData(bridge, wsdVO.name, wsdVO.name, chunk, isDone);
                };
            }
            catch(error:Error)
            {
                return (false);
            };
            return (true);
        }


    }
}//package com.clubpenguin.main.service.webservice.chunkers
