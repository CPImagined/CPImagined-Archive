//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.service.webservice.chunkers
{
    import com.clubpenguin.lib.vo.AVMBridgeMessage;
    import com.clubpenguin.lib.util.ArrayUtil;
    import com.clubpenguin.main.service.webservice.WebServiceAVMBridge;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.main.vo.WebServiceDataVO;

    public class StampsChunker implements IWebServiceChunker 
    {

        public static const MAX_ELEMENTS:int = 100;


        public function sendData(bridge:IAVMBridgeService, wsdVO:WebServiceDataVO, masterChunkMap:Object):Boolean
        {
            var stampsChildArrays:Object;
            var endIndex:int;
            var chunk:Array;
            var isDone:Boolean;
            var message:AVMBridgeMessage;
            var dataArray:Array;
            var wsdVOData:Array;
            var i:uint;
            var firstPassMap:Array;
            var secondPassMap:Array;
            var iterator:IChunkIterator;
            var stamps:Object;
            var totalItems:uint;
            var count:uint;
            var lastItem:Boolean;
            var key:String;
            var chunkMap:Array;
            var childArray:Array;
            try
            {
                if (((!(wsdVO.dataType)) is Array))
                {
                    throw (new Error("Incorrect WebServiceDataVO.dataType in StampsChunker.sendData(). The dataType should be an Array."));
                };
                dataArray = ArrayUtil.clone(wsdVO.data);
                if (((dataArray == null) || (dataArray.length == 0)))
                {
                    throw (new Error((wsdVO.name + " JSON data is empty!")));
                };
                wsdVOData = (wsdVO.data as Array);
                i = 0;
                while (i < dataArray.length)
                {
                    stamps = dataArray[i];
                    if ((((!(stamps.stamps == undefined)) && (!(stamps.stamps == null))) && (stamps.stamps is Array)))
                    {
                        if (stampsChildArrays == null)
                        {
                            stampsChildArrays = {};
                        };
                        if (stamps.stamps.length > 0)
                        {
                            stampsChildArrays[i] = [];
                            stampsChildArrays[i] = stampsChildArrays[i].concat(stamps.stamps);
                            stamps.stamps = [];
                        };
                    };
                    i++;
                };
                firstPassMap = ArrayUtil.clone(masterChunkMap[wsdVO.fileName][0]);
                secondPassMap = ArrayUtil.clone(masterChunkMap[wsdVO.fileName][1]);
                iterator = new ChunkIterator(firstPassMap);
                while (iterator.hasNext())
                {
                    chunk = WebServiceChunkUtils.getChunk(dataArray, iterator.next());
                    isDone = ((dataArray.length == 0) && (stampsChildArrays == null));
                    WebServiceAVMBridge.sendData(bridge, wsdVO.name, "-1", chunk, isDone);
                };
                if (stampsChildArrays != null)
                {
                    totalItems = WebServiceChunkUtils.getItemCount(stampsChildArrays);
                    count = 0;
                    for (key in stampsChildArrays)
                    {
                        chunkMap = ArrayUtil.clone(secondPassMap[key]);
                        childArray = ArrayUtil.clone(stampsChildArrays[key]);
                        count++;
                        if (count == totalItems)
                        {
                            lastItem = true;
                        };
                        iterator = new ChunkIterator(ArrayUtil.clone(chunkMap));
                        while (iterator.hasNext())
                        {
                            chunk = WebServiceChunkUtils.getChunk(childArray, iterator.next());
                            isDone = ((lastItem) && (childArray.length == 0));
                            WebServiceAVMBridge.sendData(bridge, wsdVO.name, key, chunk, isDone);
                        };
                    };
                };
                iterator = null;
                childArray = null;
                stampsChildArrays = null;
                dataArray = null;
                firstPassMap = null;
                secondPassMap = null;
            }
            catch(error:Error)
            {
                return (false);
            };
            return (true);
        }


    }
}//package com.clubpenguin.main.service.webservice.chunkers
