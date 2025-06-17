//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.igloo.vo.items.IglooItemVO implements com.clubpenguin.util.IVO
    {
        var _id, interactiveType, assetURL, iconURL, type, cost, label, prompt, name;
        function IglooItemVO (id) {
            _id = id;
            interactiveType = com.clubpenguin.igloo.enum.IglooItemInteractiveTypeEnum.NONE;
        }
        function destroy() {
        }
        function getID() {
            return(_id);
        }
        function update(vo) {
            var _local_2 = com.clubpenguin.igloo.vo.items.IglooItemVO(vo);
            assetURL = _local_2.assetURL;
            iconURL = _local_2.iconURL;
            type = _local_2.type;
            cost = _local_2.cost;
            label = _local_2.label;
            prompt = _local_2.prompt;
            name = _local_2.name;
            interactiveType = _local_2.interactiveType;
            isMemberOnly = _local_2.isMemberOnly;
        }
        function equals(vo) {
            return(vo.getID() == getID());
        }
        function toString() {
            return((((((((("[IglooItemVO] " + name) + "\n\tid = ") + _id) + "\n\ttype = ") + type) + "\n\tasset URL = ") + assetURL) + "\n\tcost = ") + cost);
        }
        var isMemberOnly = true;
    }
