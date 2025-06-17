//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.net.WebServiceReceiver extends com.clubpenguin.util.EventDispatcher
    {
        var _SHELL, _webServiceManager, _itemsReassembler, _languageReassembler, _furnitureReassembler, _stampsReassembler, _actionFramesReassembler, _mascotMessagesReassembler, _puffleItemsReassembler, dispatchEvent;
        function WebServiceReceiver () {
            super();
            _SHELL = _global.getCurrentShell();
            _webServiceManager = _SHELL.getWebServiceManager();
            var _local_5 = com.clubpenguin.net.WebServiceType.getServiceTypes();
            var _local_4 = _local_5.length - 1;
            while (_local_4 > 0) {
                if (!_local_5[_local_4].isCritical) {
                    _local_5.splice(_local_4, 1);
                }
                _local_4--;
            }
            _criticalServicesToLoad = _local_5.length;
            _itemsReassembler = new com.clubpenguin.net.webservicereassembly.Items();
            _languageReassembler = new com.clubpenguin.net.webservicereassembly.Language();
            _furnitureReassembler = new com.clubpenguin.net.webservicereassembly.Furniture();
            _stampsReassembler = new com.clubpenguin.net.webservicereassembly.Stamps();
            _actionFramesReassembler = new com.clubpenguin.net.webservicereassembly.ActionFrames();
            _mascotMessagesReassembler = new com.clubpenguin.net.webservicereassembly.MascotMessages();
            _puffleItemsReassembler = new com.clubpenguin.net.webservicereassembly.PuffleItemsReassembler();
        }
        function receiveWebServiceData(serviceData) {
            switch (serviceData.name) {
                case com.clubpenguin.net.WebServiceType.ITEMS.name : 
                    _itemsReassembler.addData(serviceData["key"], serviceData.value);
                    if (serviceData.isDone) {
                        var _local_5 = _itemsReassembler.retreiveData();
                        _SHELL.setInventoryCrumbsObject(_local_5);
                        incrementLoadCount(com.clubpenguin.net.WebServiceType.ITEMS);
                        _itemsReassembler.destroy();
                    }
                    break;
                case com.clubpenguin.net.WebServiceType.LANGUAGE.name : 
                    _languageReassembler.addData(serviceData["key"], serviceData.value);
                    if (serviceData.isDone) {
                        var _local_3 = _languageReassembler.retreiveData();
                        _SHELL.setLanguageObject(_local_3.lang);
                        _SHELL.setLocalizedErrorObject(_local_3.error_lang);
                        incrementLoadCount(com.clubpenguin.net.WebServiceType.LANGUAGE);
                        _languageReassembler.destroy();
                    }
                    break;
                case com.clubpenguin.net.WebServiceType.FURNITURE.name : 
                    _furnitureReassembler.addData(serviceData["key"], serviceData.value);
                    if (serviceData.isDone) {
                        var _local_5 = _furnitureReassembler.retreiveData();
                        _SHELL.setFurnitureCrumbsObject(_local_5);
                        incrementLoadCount(com.clubpenguin.net.WebServiceType.FURNITURE);
                        _furnitureReassembler.destroy();
                    }
                    break;
                case com.clubpenguin.net.WebServiceType.STAMPS.name : 
                    _stampsReassembler.addData(serviceData["key"], serviceData.value);
                    if (serviceData.isDone) {
                        var _local_5 = _stampsReassembler.retreiveData();
                        sendServiceData(serviceData.name, _local_5);
                        incrementLoadCount(com.clubpenguin.net.WebServiceType.STAMPS);
                        sendServiceData(serviceData.name, _local_5, com.clubpenguin.net.WebServiceType.STAMPS.isCritical);
                        _stampsReassembler.destroy();
                    }
                    break;
                case com.clubpenguin.net.WebServiceType.PENGUIN_ACTION_FRAMES.name : 
                    _actionFramesReassembler.addData(serviceData["key"], serviceData.value);
                    if (serviceData.isDone) {
                        var _local_5 = _actionFramesReassembler.retreiveData();
                        _SHELL.setFrameHackCrumbs(_local_5);
                        incrementLoadCount(com.clubpenguin.net.WebServiceType.PENGUIN_ACTION_FRAMES);
                        _actionFramesReassembler.destroy();
                    }
                    break;
                case com.clubpenguin.net.WebServiceType.MASCOT_MESSAGES.name : 
                    if (serviceData.value == null) {
                        _SHELL.setMascotMessageArray([]);
                        incrementLoadCount(com.clubpenguin.net.WebServiceType.MASCOT_MESSAGES);
                    } else {
                        _mascotMessagesReassembler.addData(serviceData["key"], serviceData.value);
                        if (serviceData.isDone) {
                            var _local_5 = _mascotMessagesReassembler.retreiveData();
                            _SHELL.setMascotMessageArray(convertObjectToArray(_local_5));
                            incrementLoadCount(com.clubpenguin.net.WebServiceType.MASCOT_MESSAGES);
                            _mascotMessagesReassembler.destroy();
                        }
                    }
                    break;
                case com.clubpenguin.net.WebServiceType.GAMES.name : 
                    _SHELL.setGameCrumbs(serviceData.value);
                    incrementLoadCount(com.clubpenguin.net.WebServiceType.GAMES);
                    break;
                case com.clubpenguin.net.WebServiceType.POLAROIDS.name : 
                    sendServiceData(serviceData.name, serviceData.value);
                    incrementLoadCount(com.clubpenguin.net.WebServiceType.POLAROIDS);
                    break;
                case com.clubpenguin.net.WebServiceType.STAMPBOOK_COVER.name : 
                    sendServiceData(serviceData.name, serviceData.value);
                    incrementLoadCount(com.clubpenguin.net.WebServiceType.STAMPBOOK_COVER);
                    break;
                case com.clubpenguin.net.WebServiceType.ANALYTICS.name : 
                    sendServiceData(serviceData.name, serviceData.value);
                    incrementLoadCount(com.clubpenguin.net.WebServiceType.ANALYTICS);
                    break;
                case com.clubpenguin.net.WebServiceType.PATHS.name : 
                    _SHELL.setGlobalPathsObject(serviceData.value.global);
                    _SHELL.setLocalPathsObject(serviceData.value.local);
                    _SHELL.setLinkPathsObject(serviceData.value.link);
                    incrementLoadCount(com.clubpenguin.net.WebServiceType.PATHS);
                    break;
                case com.clubpenguin.net.WebServiceType.IGLOOS.name : 
                    _SHELL.setIglooCrumbs(serviceData.value);
                    incrementLoadCount(com.clubpenguin.net.WebServiceType.IGLOOS);
                    break;
                case com.clubpenguin.net.WebServiceType.PUFFLES.name : 
                    _SHELL.setPuffleCrumbs(serviceData.value);
                    incrementLoadCount(com.clubpenguin.net.WebServiceType.PUFFLES);
                    break;
                case com.clubpenguin.net.WebServiceType.PUFFLE_ITEMS.name : 
                    _puffleItemsReassembler.addData(serviceData["key"], serviceData.value);
                    if (serviceData.isDone) {
                        var _local_5 = _puffleItemsReassembler.retreiveData();
                        _SHELL.setPuffleHatCollection(_local_5);
                        incrementLoadCount(com.clubpenguin.net.WebServiceType.ITEMS);
                        _puffleItemsReassembler.destroy();
                    }
                    break;
                case com.clubpenguin.net.WebServiceType.ROOMS.name : 
                    _SHELL.setRoomCrumbs(serviceData.value);
                    incrementLoadCount(com.clubpenguin.net.WebServiceType.ROOMS);
                    break;
                case com.clubpenguin.net.WebServiceType.MASCOTS.name : 
                    var _local_4 = processMascotCrumbs(serviceData.value);
                    _SHELL.setMascotCrumbs(_local_4);
                    incrementLoadCount(com.clubpenguin.net.WebServiceType.MASCOTS);
                    break;
                case com.clubpenguin.net.WebServiceType.TOUR_GUIDE_MESSAGES.name : 
                    _SHELL.setTourGuideMessageArray(convertObjectToArray(serviceData.value));
                    incrementLoadCount(com.clubpenguin.net.WebServiceType.TOUR_GUIDE_MESSAGES);
                    break;
                case com.clubpenguin.net.WebServiceType.SCRIPT_MESSAGES.name : 
                    _SHELL.setLineMessageArray(convertObjectToArray(serviceData.value));
                    incrementLoadCount(com.clubpenguin.net.WebServiceType.SCRIPT_MESSAGES);
                    break;
                case com.clubpenguin.net.WebServiceType.SAFE_CHAT_MESSAGES.name : 
                    _SHELL.setSafeMessageArray(convertObjectToArray(serviceData.value));
                    _SHELL.setTreveresdSafeMessageObject(traverseMessages(serviceData.value));
                    incrementLoadCount(com.clubpenguin.net.WebServiceType.SAFE_CHAT_MESSAGES);
                    break;
                case com.clubpenguin.net.WebServiceType.JOKES.name : 
                    _SHELL.setJokeArray(convertObjectToArray(serviceData.value));
                    incrementLoadCount(com.clubpenguin.net.WebServiceType.JOKES);
                    break;
                case com.clubpenguin.net.WebServiceType.FLOORS.name : 
                    _SHELL.setFloorCrumbs(serviceData.value);
                    incrementLoadCount(com.clubpenguin.net.WebServiceType.FLOORS);
                    break;
                case com.clubpenguin.net.WebServiceType.PLAYER_COLORS.name : 
                    _SHELL.setPlayerColoursObject(serviceData.value);
                    incrementLoadCount(com.clubpenguin.net.WebServiceType.PLAYER_COLORS);
                    break;
                case com.clubpenguin.net.WebServiceType.NEWSPAPERS.name : 
                    _SHELL.setNewspaperCrumbs(serviceData.value);
                    incrementLoadCount(com.clubpenguin.net.WebServiceType.NEWSPAPERS);
                    break;
                case com.clubpenguin.net.WebServiceType.POSTCARDS.name : 
                    _SHELL.setPostcardCrumbs(serviceData.value);
                    incrementLoadCount(com.clubpenguin.net.WebServiceType.POSTCARDS);
                    break;
                case com.clubpenguin.net.WebServiceType.GENERAL.name : 
                    _SHELL.setIglooOptions(serviceData.value.igloo_options);
                    _SHELL.setPartyOptions(serviceData.value.party_options);
                    _SHELL.setMascotOptions(serviceData.value.mascot_options);
                    _SHELL.setIslandOptions(serviceData.value.island_options);
                    incrementLoadCount(com.clubpenguin.net.WebServiceType.GENERAL);
                    break;
                case com.clubpenguin.net.WebServiceType.LOCATIONS.name : 
                    _SHELL.setLocationObject(serviceData.value);
                    incrementLoadCount(com.clubpenguin.net.WebServiceType.LOCATIONS);
                    break;
                default : 
                    break;
            }
        }
        function sendServiceData(serviceName, serviceValue) {
            if (serviceValue == null) {
            }
            _webServiceManager.cacheServiceData(serviceName, serviceValue);
        }
        function incrementLoadCount(loadedServiceType) {
            if (loadedServiceType.isCritical) {
                _criticalLoadedServices++;
                _SHELL.updateLoadingScreen(_criticalLoadedServices / _criticalServicesToLoad);
                if (_criticalLoadedServices >= _criticalServicesToLoad) {
                    dispatchEvent({type:EVENT_RECEIVING_COMPLETE, target:this});
                }
            }
        }
        function convertObjectToArray(obj) {
            var _local_2 = [];
            for (var _local_3 in obj) {
                _local_2[_local_3] = obj[_local_3];
            }
            return(_local_2);
        }
        function traverseMessages(node, traveresed_safe_message_obj) {
            if (traveresed_safe_message_obj == undefined) {
                traveresed_safe_message_obj = new Object();
            }
            for (var _local_5 in node) {
                var _local_3 = node[_local_5].id;
                traveresed_safe_message_obj[_local_3] = node[_local_5];
                if (node[_local_5].menu.length > 0) {
                    traverseMessages(node[_local_5].menu, traveresed_safe_message_obj);
                }
            }
            return(traveresed_safe_message_obj);
        }
        function processMascotCrumbs(webServiceData) {
            var _local_3 = {};
            _local_3.mascots = {};
            for (var _local_5 in webServiceData) {
                var _local_1 = webServiceData[_local_5];
                _local_3.mascots[_local_1.mascot_id] = _local_1;
                var _local_2 = 0;
                while (_local_2 < _local_1.ids.length) {
                    _local_3[_local_1.ids[_local_2]] = _local_1;
                    _local_2++;
                }
            }
            return(_local_3);
        }
        static var EVENT_RECEIVING_COMPLETE = "initComplete";
        var _criticalLoadedServices = 0;
        var _criticalServicesToLoad = 0;
    }
