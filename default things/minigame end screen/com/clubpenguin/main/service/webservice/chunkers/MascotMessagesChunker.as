//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.service.webservice.chunkers
{
    import com.clubpenguin.main.service.webservice.WebServiceAVMBridge;
    import com.clubpenguin.lib.util.ArrayUtil;
    import com.clubpenguin.lib.services.IAVMBridgeService;
    import com.clubpenguin.main.vo.WebServiceDataVO;

    public class MascotMessagesChunker implements IWebServiceChunker 
    {


        public function sendData(bridge:IAVMBridgeService, wsdVO:WebServiceDataVO, masterChunkMap:Object):Boolean
        {
            var mascotScriptArrays:Object;
            var scriptArrays:Object;
            var iterator:IChunkIterator;
            var firstPassMap:Array;
            var secondPassMap:Array;
            var thirdPassMap:Object;
            var chunkMap:Array;
            var childArray:Array;
            var totalItems:uint;
            var count:uint;
            var lastItem:Boolean;
            var key:String;
            var parentId:String;
            var chunk:Array;
            var isDone:Boolean;
            var dataArray:Array;
            var i:uint;
            var mascot:Object;
            var mascotScript:Array;
            var j:uint;
            try
            {
                if (((!(wsdVO.dataType)) is Array))
                {
                    throw (new Error("Incorrect WebServiceDataVO.dataType in StampsChunker.sendData(). The dataType should be an Array."));
                };
                if (((WebServiceChunkUtils.getItemCount(masterChunkMap[wsdVO.fileName]) == 0) && (WebServiceChunkUtils.getItemCount(wsdVO.data) == 0)))
                {
                    WebServiceAVMBridge.sendData(bridge, wsdVO.name, key, chunk, isDone);
                    return (true);
                };
                firstPassMap = ArrayUtil.clone(masterChunkMap[wsdVO.fileName][0]);
                secondPassMap = ArrayUtil.clone(masterChunkMap[wsdVO.fileName][1]);
                thirdPassMap = ArrayUtil.clone(masterChunkMap[wsdVO.fileName][2]);
                dataArray = ArrayUtil.clone(wsdVO.data);
                if (((dataArray == null) || (dataArray.length == 0)))
                {
                    throw (new Error((wsdVO.name + " JSON data is empty!")));
                };
                i = 0;
                while (i < dataArray.length)
                {
                    mascot = dataArray[i];
                    if ((((!(mascot.mascotScript == undefined)) && (!(mascot.mascotScript == null))) && (mascot.mascotScript is Array)))
                    {
                        mascotScript = mascot.mascotScript;
                        if (mascotScript.length > 0)
                        {
                            j = 0;
                            while (j < mascotScript.length)
                            {
                                if ((((!(mascotScript[j].script == undefined)) && (!(mascotScript[j].script == null))) && (mascotScript[j].script is Array)))
                                {
                                    if (mascotScript[j].script.length > 0)
                                    {
                                        if (scriptArrays == null)
                                        {
                                            scriptArrays = {};
                                        };
                                        key = ((i + ",") + j);
                                        scriptArrays[key] = [];
                                        scriptArrays[key] = scriptArrays[key].concat(ArrayUtil.clone(mascotScript[j].script));
                                        mascotScript[j].script = [];
                                    };
                                };
                                j++;
                            };
                            key = String(i);
                            if (mascotScriptArrays == null)
                            {
                                mascotScriptArrays = {};
                            };
                            mascotScriptArrays[key] = [];
                            mascotScriptArrays[key] = mascotScriptArrays[key].concat(ArrayUtil.clone(mascotScript));
                            mascot.mascotScript = [];
                        };
                    };
                    i++;
                };
                iterator = new ChunkIterator(ArrayUtil.clone(firstPassMap));
                while (iterator.hasNext())
                {
                    chunk = WebServiceChunkUtils.getChunk(dataArray, iterator.next());
                    isDone = ((dataArray.length == 0) && (mascotScriptArrays == null));
                    WebServiceAVMBridge.sendData(bridge, wsdVO.name, "-1", chunk, isDone);
                };
                if (mascotScriptArrays != null)
                {
                    totalItems = WebServiceChunkUtils.getItemCount(mascotScriptArrays);
                    count = 0;
                    for (key in mascotScriptArrays)
                    {
                        chunkMap = ArrayUtil.clone(secondPassMap[key]);
                        childArray = ArrayUtil.clone(mascotScriptArrays[key]);
                        iterator = new ChunkIterator(chunkMap);
                        count++;
                        if (count == totalItems)
                        {
                            lastItem = true;
                        };
                        while (iterator.hasNext())
                        {
                            chunk = WebServiceChunkUtils.getChunk(childArray, iterator.next());
                            isDone = (((lastItem) && (childArray.length == 0)) && (scriptArrays == null));
                            WebServiceAVMBridge.sendData(bridge, wsdVO.name, key, chunk, isDone);
                        };
                    };
                };
                if (scriptArrays != null)
                {
                    totalItems = WebServiceChunkUtils.getItemCount(scriptArrays);
                    count = 0;
                    lastItem = false;
                    for (key in thirdPassMap)
                    {
                        chunkMap = ArrayUtil.clone(thirdPassMap[key]);
                        childArray = ArrayUtil.clone(scriptArrays[key]);
                        iterator = new ChunkIterator(chunkMap);
                        count++;
                        if (count == totalItems)
                        {
                            lastItem = true;
                        };
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
                scriptArrays = null;
                mascotScriptArrays = null;
                dataArray = null;
                firstPassMap = null;
                secondPassMap = null;
                thirdPassMap = null;
            }
            catch(error:Error)
            {
                return (false);
            };
            return (true);
        }


    }
}//package com.clubpenguin.main.service.webservice.chunkers
