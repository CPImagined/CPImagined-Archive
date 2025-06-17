//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.service.webservice.chunkers
{
    import com.clubpenguin.lib.util.ArrayUtil;
    import com.clubpenguin.main.service.webservice.WebServiceAVMBridge;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.main.vo.WebServiceDataVO;

    public class KeyedArrayChunker implements IWebServiceChunker 
    {


        public function sendData(bridge:IAVMBridgeService, wsdVO:WebServiceDataVO, masterChunkMap:Object):Boolean
        {
            var totalItems:uint;
            var count:uint;
            var lastItem:Boolean;
            var key:String;
            var chunkMap:Array;
            var dataArray:Array;
            var iterator:IChunkIterator;
            var chunk:Array;
            var isDone:Boolean;
            try
            {
                if (!(wsdVO.dataType is Object))
                {
                    throw (new Error("Incorrect WebServiceDataVO.dataType in LanguageChunker.sendData(). The dataType should be an Object."));
                };
                totalItems = WebServiceChunkUtils.getItemCount(wsdVO.data);
                count = 0;
                if (WebServiceChunkUtils.getItemCount(masterChunkMap) == 0)
                {
                    throw (new Error("Chunking Map JSON data is empty!"));
                };
                if (((wsdVO.data == null) || (totalItems == 0)))
                {
                    throw (new Error((wsdVO.name + " JSON data is empty!")));
                };
                for (key in wsdVO.data)
                {
                    chunkMap = ArrayUtil.clone(masterChunkMap[wsdVO.fileName][key]);
                    dataArray = (ArrayUtil.clone(wsdVO.data[key]) as Array);
                    iterator = new ChunkIterator(ArrayUtil.clone(chunkMap));
                    count++;
                    if (count == totalItems)
                    {
                        lastItem = true;
                    };
                    while (iterator.hasNext())
                    {
                        chunk = WebServiceChunkUtils.getChunk(dataArray, iterator.next());
                        isDone = ((lastItem) && (dataArray.length == 0));
                        WebServiceAVMBridge.sendData(bridge, wsdVO.name, key, chunk, isDone);
                    };
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
