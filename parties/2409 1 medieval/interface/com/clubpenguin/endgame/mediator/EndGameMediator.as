//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.endgame.mediator.EndGameMediator
    {
        var _view, _model, _endGameClosed;
        function EndGameMediator (view, model) {
            _view = view;
            _model = model;
            _view.setModel(_model);
            _view.setShell(_model.shell);
            _view.endGameClosed.addOnce(onClose, this);
            _view.initialize(_model.endGameParams);
            _endGameClosed = new org.osflash.signals.Signal();
        }
        function get endGameClosed() {
            return(_endGameClosed);
        }
        function onClose() {
            _endGameClosed.dispatch();
        }
    }
