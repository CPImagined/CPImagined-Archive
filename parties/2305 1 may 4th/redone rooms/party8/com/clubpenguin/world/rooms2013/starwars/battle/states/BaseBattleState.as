//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms2013.starwars.battle.states.BaseBattleState extends com.clubpenguin.util.state.BaseState
    {
        var _stateName, _controller, _battle, _shell, _engine, _interface;
        function BaseBattleState (stateName, manager, controller, battle) {
            super(manager);
            _stateName = stateName;
            _controller = controller;
            _battle = battle;
            _shell = _global.getCurrentShell();
            _engine = _global.getCurrentEngine();
            _interface = _global.getCurrentInterface();
        }
        function toString() {
            return("BaseBattleState:" + _stateName);
        }
    }
