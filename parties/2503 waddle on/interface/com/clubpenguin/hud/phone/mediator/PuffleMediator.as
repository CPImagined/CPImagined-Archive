//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.hud.phone.mediator.PuffleMediator extends com.clubpenguin.hud.phone.mediator.AppMediator
    {
        var equipmentService, _puffleEquipped, inventory;
        function PuffleMediator (view, context) {
            super(view, context.appClosed, context.languageCode);
            equipmentService = context.equipmentService;
			inventory = _global.getCurrentShell().getMyInventoryArray();
			if (playerHasFlare()) {
				view.flare._visible = true;
				view.flare.enabled = true;
				view.flareIcon._visible = true;
				view.flareTitle._visible = true;
			} else {
				view.flare._visible = false;
				view.flare.enabled = false;
				view.flareIcon._visible = false;
				view.flareTitle._visible = false;
			};
			if (playerHasChirp()) {
				view.chirp._visible = true;
				view.chirp.enabled = true;
				view.chirpIcon._visible = true;
				view.chirpTitle._visible = true;
			} else {
				view.chirp._visible = false;
				view.chirp.enabled = false;
				view.chirpIcon._visible = false;
				view.chirpTitle._visible = false;
			};
			if (playerHasChip()) {
				view.chip._visible = true;
				view.chip.enabled = true;
				view.chipIcon._visible = true;
				view.chipTitle._visible = true;
			} else {
				view.chip._visible = false;
				view.chip.enabled = false;
				view.chipIcon._visible = false;
				view.chipTitle._visible = false;
			};
            _puffleEquipped = new org.osflash.signals.Signal();
            view.flare.onPress = com.clubpenguin.util.Delegate.create(this, equipFlare);
			view.chirp.onPress = com.clubpenguin.util.Delegate.create(this, equipChirp);
			view.chip.onPress = com.clubpenguin.util.Delegate.create(this, equipChip);
        }
        function get puffleEquipped() {
            return(_puffleEquipped);
        }
		function playerHasFlare() {
            var _local_2 = 0;
            while (_local_2 < inventory.length) {
                if (inventory[_local_2].id == FLARE_ID) {
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
		function playerHasChirp() {
            var _local_2 = 0;
            while (_local_2 < inventory.length) {
                if (inventory[_local_2].id == CHIRP_ID) {
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
		function playerHasChip() {
            var _local_2 = 0;
            while (_local_2 < inventory.length) {
                if (inventory[_local_2].id == CHIP_ID) {
                    return(true);
                }
                _local_2++;
            }
            return(false);
        }
        function equipFlare() {
            equipmentService.equipHandItem(FLARE_ID);
            _puffleEquipped.dispatch();
        }
		function equipChirp() {
            equipmentService.equipHandItem(CHIRP_ID);
            _puffleEquipped.dispatch();
        }
		function equipChip() {
            equipmentService.equipHandItem(CHIP_ID);
            _puffleEquipped.dispatch();
        }
        static var FLARE_ID = 5060;
		static var CHIRP_ID = 95061;
		static var CHIP_ID = 95062;
    }
