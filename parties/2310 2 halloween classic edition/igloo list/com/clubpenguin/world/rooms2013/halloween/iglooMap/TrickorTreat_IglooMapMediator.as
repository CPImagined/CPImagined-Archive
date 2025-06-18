//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.halloween.iglooMap.TrickorTreat_IglooMapMediator
    {
        var _context, _view, _model, _iglooMapListMediator;
        function TrickorTreat_IglooMapMediator (context, iglooMapView, iglooMapModel) {
            _context = context;
            _view = iglooMapView;
            _model = iglooMapModel;
            _iglooMapListMediator = new com.clubpenguin.world.rooms2013.halloween.iglooMap.mediator.IglooMapListMediator(_context, _view.list, _model);
            _view.background.onRelease = function () {
            };
            _view.background.useHandCursor = false;
            _view.close_button.onRelease = com.clubpenguin.util.Delegate.create(this, onCloseButtonClick);
        }
        function destroy() {
        }
        function onCloseButtonClick() {
            trace(this + " close button clicked");
            _context.closeMap(false);
        }
        function toString() {
            return("[IglooMapMediator]");
        }
    }
