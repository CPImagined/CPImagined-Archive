//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.endgame.mediator.StampListMediator
    {
        var _view, _model;
        function StampListMediator (view, model) {
            _view = view;
            _model = model;
        }
        function init() {
            _view.setShell(_model.shell);
            _view.displayStamps(_model.getStamps(), _model.stampIds);
        }
        function get stampIconRolledOver() {
            return(_view.stampIconRolledOver);
        }
        function get stampIconRolledOut() {
            return(_view.stampIconRolledOut);
        }
    }
