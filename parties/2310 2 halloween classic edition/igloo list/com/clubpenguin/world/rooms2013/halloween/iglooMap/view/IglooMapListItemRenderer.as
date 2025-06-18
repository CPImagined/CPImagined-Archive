//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.halloween.iglooMap.view.IglooMapListItemRenderer extends MovieClip implements com.clubpenguin.igloo.component.renderer.IItemRenderer
    {
        var _clickSignal, background, _itemVO, best_friends_icon, friends_icon, everyone_icon, star_icon, lock_icon, penguin_icon, nameTxt, likesLabelTxt, likesValueTxt, populationValueTxt;
        function IglooMapListItemRenderer () {
            super();
            _clickSignal = new org.osflash.signals.Signal(com.clubpenguin.world.rooms2013.halloween.iglooMap.vo.IglooMapPlayerVO);
            background.onRelease = com.clubpenguin.util.Delegate.create(this, onClick);
        }
        function getVO() {
            return(_itemVO);
        }
        function setVO(newVO, loadQueue) {
            trace(this + " setVO");
            _itemVO = com.clubpenguin.world.rooms2013.halloween.iglooMap.vo.IglooMapPlayerVO(newVO);
            best_friends_icon._visible = false;
            friends_icon._visible = false;
            everyone_icon._visible = false;
            star_icon._visible = false;
            lock_icon._visible = false;
            penguin_icon._visible = false;
            trace("_itemVO.isLocalPlayer " + _itemVO.isLocalPlayer);
            if (_itemVO.isLocalPlayer) {
                star_icon._visible = true;
            } else if (_itemVO.isBestFriend) {
                best_friends_icon._visible = true;
                friends_icon._visible = true;
            } else if (_itemVO.isFriend || (_itemVO.isOpenListFriend)) {
                friends_icon._visible = true;
            } else {
                everyone_icon._visible = true;
            }
            trace("_itemVO.name " + _itemVO.name);
            nameTxt.text = _itemVO.name;
            likesLabelTxt.text = _global.getCurrentShell().getLocalizedString("w.igloo.likes.label");
            likesValueTxt._x = (likesLabelTxt._x + likesLabelTxt.textWidth) + 5;
            likesValueTxt.text = String(_itemVO.totalLikes);
            if (_global.getCurrentShell().playerModel.isPlayerModerator()) {
                if (_itemVO.isIglooLocked) {
                    lock_icon._visible = true;
                    penguin_icon._visible = false;
                } else {
                    lock_icon._visible = false;
                    penguin_icon._visible = true;
                }
                populationValueTxt.text = String(_itemVO.population);
            }
        }
        function getItemClickedSignal() {
            return(_clickSignal);
        }
        function onClick() {
            trace((this + " onClick: ") + _itemVO);
            _clickSignal.dispatch(_itemVO);
        }
        function getWidth() {
            return(WIDTH);
        }
        function getHeight() {
            return(HEIGHT);
        }
        static var LINKAGE_ID = "IglooMapListItemRenderer";
        static var WIDTH = 170;
        static var HEIGHT = 40;
    }
