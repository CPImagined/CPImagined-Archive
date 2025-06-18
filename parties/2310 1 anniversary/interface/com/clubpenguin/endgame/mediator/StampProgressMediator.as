//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.endgame.mediator.StampProgressMediator
    {
        var _view, _model;
        function StampProgressMediator (view, model) {
            _view = view;
            _model = model;
        }
        function init() {
            _view.setShell(_model.shell);
            _view.displayProgress(_model.completedPercent);
        }
    }
