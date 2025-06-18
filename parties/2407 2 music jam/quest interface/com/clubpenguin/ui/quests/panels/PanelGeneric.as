//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.ui.quests.panels.PanelGeneric extends com.clubpenguin.ui.quests.panels.PanelBase implements com.clubpenguin.ui.quests.panels.IPanel
    {
        var _shell, _view, _questVO;
        function PanelGeneric (view, vo) {
            super(view, vo);
            localize();
        }
        function checkVars() {
        }
        function localize() {
            _view.questdisplay.gothere_text.text = _shell.getLocalizedString("w.generic.button.goto");
        }
        function getVO() {
            return(_questVO);
        }
        static var CLASS = "PanelGeneric";
    }
