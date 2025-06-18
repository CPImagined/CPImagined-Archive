//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.StampDefinitionsService
    {
        var stampManager, numStamps, stampDefinitionsParsed, stampDefinitions, polaroidDefinitions;
        function StampDefinitionsService (stampManager, stampDefinitionsParsed, webServiceManager) {
            this.stampManager = stampManager;
            numStamps = 0;
            this.stampDefinitionsParsed = stampDefinitionsParsed;
            stampDefinitions = webServiceManager.getCachedServiceData(com.clubpenguin.net.WebServiceType.STAMPS);
            polaroidDefinitions = webServiceManager.getCachedServiceData(com.clubpenguin.net.WebServiceType.POLAROIDS);
            var _local_2 = parsePolaroidDefinitions();
            var _local_3 = parseStampDefinitions(_local_2);
            stampDefinitionsParsed.dispatch(_local_3, numStamps);
        }
        function parsePolaroidDefinitions() {
            var _local_11 = {};
            if (polaroidDefinitions != undefined) {
                for (var _local_12 in polaroidDefinitions) {
                    var _local_6 = polaroidDefinitions[_local_12].polaroids;
                    var _local_10 = ((_local_6 == undefined) ? 0 : (_local_6.length));
                    _local_11[_local_12] = [];
                    var _local_3 = 0;
                    while (_local_3 < _local_10) {
                        var _local_2 = _local_6[_local_3];
                        var _local_5 = Number(_local_2.polaroid_id);
                        var _local_9 = Number(_local_2.stamp_count);
                        var _local_4 = "";
                        var _local_8 = String(_local_2.description);
                        var _local_7 = new com.clubpenguin.stamps.PolaroidItem(_local_5, _local_9, _local_4, _local_8);
                        _local_11[_local_12].push(_local_7);
                        _local_3++;
                    }
                }
            }
            return(_local_11);
        }
        function parseStampDefinitions(categoryIDsToPolariodItems) {
            var _local_27 = [];
            if (stampDefinitions != undefined) {
                var _local_20 = {};
                var _local_17 = {};
                for (var _local_29 in stampDefinitions) {
                    var _local_22;
                    var _local_9 = stampDefinitions[_local_29];
                    var _local_23 = Number(_local_9.parent_group_id);
                    var _local_15;
                    var _local_19 = INVALID_CATEGORY_ID;
                    var _local_7 = Number(_local_29);
                    var _local_24 = String(_local_9.name);
                    var _local_11 = [];
                    var _local_25 = categoryIDsToPolariodItems[_local_29];
                    if (_local_23 == NO_PARENT_GROUP_ID) {
                        _local_15 = _local_7;
                    } else {
                        _local_15 = _local_23;
                        _local_19 = _local_7;
                    }
                    for (var _local_26 in _local_9.stamps) {
                        var _local_2 = _local_9.stamps[_local_26];
                        var _local_8 = Number(_local_26);
                        var _local_13 = _local_15;
                        var _local_14 = Number(_local_2.rank);
                        var _local_5 = String(_local_2.name);
                        var _local_10 = String(_local_2.description);
                        var _local_4 = Boolean(_local_2.is_member);
                        var _local_6;
                        if (_local_7 == com.clubpenguin.stamps.StampManager.AWARD_CATEGORY_ID) {
                            _local_6 = new com.clubpenguin.stamps.AwardItem(_local_8, _local_5, _local_10, _local_4);
                        } else {
                            _local_6 = new com.clubpenguin.stamps.StampItem(_local_8, _local_13, _local_14, _local_5, _local_10, _local_4);
                        }
                        _local_11.push(_local_6);
                        numStamps++;
                    }
                    if (_local_7 == com.clubpenguin.stamps.StampManager.AWARD_CATEGORY_ID) {
                        _local_11.sort(stampManager.stampBookItemComparisonByID);
                    } else {
                        _local_11.sort(stampManager.stampItemComparisonByDifficultyThenID);
                    }
                    _local_22 = new com.clubpenguin.stamps.StampBookCategory(_local_7, _local_24, null, _local_11, _local_25);
                    _local_20[_local_29] = _local_22;
                    if (_local_19 != INVALID_CATEGORY_ID) {
                        var _local_30 = String(_local_15);
                        if (_local_17[_local_30] == undefined) {
                            _local_17[_local_30] = [];
                        }
                        _local_17[_local_30].push(_local_19);
                    } else {
                        _local_27.push(_local_22);
                    }
                }
                for (var _local_30 in _local_17) {
                    var _local_12 = _local_20[_local_30];
                    var _local_18 = _local_17[_local_30];
                    var _local_21 = _local_18.length;
                    var _local_3 = 0;
                    while (_local_3 < _local_21) {
                        var _local_16 = _local_20[String(_local_18[_local_3])];
                        _local_12.addSubCategory(_local_16);
                        _local_3++;
                    }
                    if (_local_12.getID() == com.clubpenguin.stamps.StampManager.GAMES_CATEGORY_ID) {
                        _local_12.getSubCategories().sortOn(NAME_FIELD, Array.CASEINSENSITIVE);
                    } else {
                        _local_12.getSubCategories().sort(stampManager.stampBookCategoryComparisonByID);
                    }
                }
            }
            _local_27.sort(stampManager.stampBookCategoryComparisonByID);
            return(_local_27);
        }
        static var NO_PARENT_GROUP_ID = 0;
        static var INVALID_CATEGORY_ID = -1;
        static var NAME_FIELD = "name";
    }
