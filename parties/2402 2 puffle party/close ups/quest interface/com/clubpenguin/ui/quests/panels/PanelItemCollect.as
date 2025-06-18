//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.ui.quests.panels.PanelItemCollect extends com.clubpenguin.ui.quests.panels.PanelBase implements com.clubpenguin.ui.quests.panels.IPanel
    {
        var _currentParty, _questVO, _view;
        function PanelItemCollect (view, vo) {
            super(view, vo);
            configureItemCollection();
        }
        function checkVars() {
        }
        function configureItemCollection() {
            if (_questVO.unlockDay > _currentParty.CONSTANTS.PARTY_DAY) {
                return(undefined);
            }
            var _local_6 = _questVO.taskLockNumber;
            if ((_local_6 >= 0) && (!_currentParty.partyCookie.hasPlayerCompletedTask(_local_6))) {
                return(undefined);
            }
            var _local_5 = new com.clubpenguin.ui.itemcollection.ItemCollectionBase();
            var _local_4 = _questVO.memberItemVOs;
            var _local_2 = 0;
            while (_local_2 < _local_4.length) {
                _view.questdisplay["member_" + String(_local_2)].gotoAndStop(2);
                _local_5.createBuyButton(_local_4[_local_2], _view.questdisplay["member_" + String(_local_2)].collect_btn);
                _local_2++;
            }
            var _local_3 = _questVO.nonMemberItemVOs;
            _local_2 = 0;
            while (_local_2 < _local_3.length) {
                _view.questdisplay["non_member_" + String(_local_2)].gotoAndStop(2);
                _local_5.createBuyButton(_local_3[_local_2], _view.questdisplay["non_member_" + String(_local_2)].collect_btn);
                _local_2++;
            }
        }
        function getVO() {
            return(_questVO);
        }
        static var CLASS_NAME = "PanelItemCollect";
    }
