//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.StampManager
    {
        static var MONTH_STRING, AWARD_STAMP_IDS_TO_DB_IDS, EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID;
        var shell, _numClubPenguinStamps, clubPenguinStampCategories, _myStamps, pinCategoryName, stampDefinitionsParsed, stampDefinitionsService, _stampBookCoverCrumbs, pinsService, awardsService, epfService, stampsService, _usersStampCategories, _activeUsersStampList, _hasModifiedStampCover;
        function StampManager (shell, connection) {
            this.shell = shell;
            if (MONTH_STRING == undefined) {
                MONTH_STRING = [];
                MONTH_STRING.push(shell.getLocalizedString("January"));
                MONTH_STRING.push(shell.getLocalizedString("February"));
                MONTH_STRING.push(shell.getLocalizedString("March"));
                MONTH_STRING.push(shell.getLocalizedString("April"));
                MONTH_STRING.push(shell.getLocalizedString("May"));
                MONTH_STRING.push(shell.getLocalizedString("June"));
                MONTH_STRING.push(shell.getLocalizedString("July"));
                MONTH_STRING.push(shell.getLocalizedString("August"));
                MONTH_STRING.push(shell.getLocalizedString("September"));
                MONTH_STRING.push(shell.getLocalizedString("October"));
                MONTH_STRING.push(shell.getLocalizedString("November"));
                MONTH_STRING.push(shell.getLocalizedString("December"));
            }
            if (AWARD_STAMP_IDS_TO_DB_IDS == undefined) {
                AWARD_STAMP_IDS_TO_DB_IDS = [];
                AWARD_STAMP_IDS_TO_DB_IDS[159] = 801;
                AWARD_STAMP_IDS_TO_DB_IDS[160] = 802;
                AWARD_STAMP_IDS_TO_DB_IDS[161] = 803;
                AWARD_STAMP_IDS_TO_DB_IDS[162] = 804;
                AWARD_STAMP_IDS_TO_DB_IDS[163] = 805;
                AWARD_STAMP_IDS_TO_DB_IDS[164] = 806;
                AWARD_STAMP_IDS_TO_DB_IDS[165] = 808;
                AWARD_STAMP_IDS_TO_DB_IDS[166] = 809;
                AWARD_STAMP_IDS_TO_DB_IDS[167] = 810;
                AWARD_STAMP_IDS_TO_DB_IDS[168] = 811;
                AWARD_STAMP_IDS_TO_DB_IDS[169] = 813;
                AWARD_STAMP_IDS_TO_DB_IDS[170] = 814;
                AWARD_STAMP_IDS_TO_DB_IDS[171] = 815;
                AWARD_STAMP_IDS_TO_DB_IDS[172] = 816;
                AWARD_STAMP_IDS_TO_DB_IDS[173] = 817;
                AWARD_STAMP_IDS_TO_DB_IDS[174] = 818;
                AWARD_STAMP_IDS_TO_DB_IDS[175] = 819;
                AWARD_STAMP_IDS_TO_DB_IDS[176] = 820;
                AWARD_STAMP_IDS_TO_DB_IDS[177] = 822;
                AWARD_STAMP_IDS_TO_DB_IDS[178] = 823;
                AWARD_STAMP_IDS_TO_DB_IDS[179] = 8007;
                AWARD_STAMP_IDS_TO_DB_IDS[180] = 8008;
            }
            if (EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID == undefined) {
                EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID = [];
                EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID[1] = 197;
                EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID[5] = 198;
                EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID[10] = 199;
                EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID[25] = 200;
                EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID[50] = 201;
            }
            _numClubPenguinStamps = 0;
            clubPenguinStampCategories = [];
            _myStamps = [];
            pinCategoryName = shell.getLocalizedString("pins_category_title");
            stampDefinitionsParsed = new org.osflash.signals.Signal(Array, Number);
            stampDefinitionsParsed.addOnce(handleStampDefinitionsParsed, this);
            stampDefinitionsService = new com.clubpenguin.stamps.StampDefinitionsService(this, stampDefinitionsParsed, shell.getWebServiceManager());
            _stampBookCoverCrumbs = new com.clubpenguin.stamps.StampBookCoverCrumbs(shell.getWebServiceManager());
            pinsService = new com.clubpenguin.services.PinsService(connection);
            pinsService.pinsListReceived.add(handleQueryPlayersPins, this);
            awardsService = new com.clubpenguin.services.AwardsService(connection);
            awardsService.awardsListReceived.add(handleQueryPlayersAwards, this);
            epfService = new com.clubpenguin.services.EPFService(connection);
            epfService.pointsReceived.add(handleEPFPoints, this);
            stampsService = new com.clubpenguin.services.StampsService(connection);
            stampsService.playersStampsReceived.add(handleGetPlayersStamps, this);
            stampsService.recentlyEarnedStampsReceived.add(handleGetMyRecentlyEarnedStamps, this);
            stampsService.playersStampBookCoverDetailsReceived.add(handleGetStampBookCoverDetails, this);
            stampsService.playerEarnedStampReceived.add(handlePlayerEarnedStampReceived, this);
        }
        function destroy() {
            var _local_3 = clubPenguinStampCategories.length;
            var _local_2 = 0;
            while (_local_2 < _local_3) {
                clubPenguinStampCategories[_local_2].destroy();
                _local_2++;
            }
            delete clubPenguinStampCategories;
            delete _myStamps;
            pinsService.pinsListReceived.remove(handleQueryPlayersPins, this);
            awardsService.awardsListReceived.remove(handleQueryPlayersAwards, this);
            epfService.pointsReceived.remove(handleEPFPoints, this);
            stampsService.playersStampsReceived.remove(handleGetPlayersStamps, this);
            stampsService.recentlyEarnedStampsReceived.remove(handleGetMyRecentlyEarnedStamps, this);
            stampsService.playersStampBookCoverDetailsReceived.remove(handleGetStampBookCoverDetails, this);
            stampsService.playerEarnedStampReceived.remove(handlePlayerEarnedStampReceived, this);
        }
        function stampItemComparisonByDifficultyThenID(stampBookItemA, stampBookItemB) {
            if ((stampBookItemA.getType() != com.clubpenguin.stamps.StampBookItemType.STAMP) || (stampBookItemB.getType() != com.clubpenguin.stamps.StampBookItemType.STAMP)) {
                return(0);
            }
            var _local_5 = com.clubpenguin.stamps.IStampItem(stampBookItemA);
            var _local_6 = com.clubpenguin.stamps.IStampItem(stampBookItemB);
            var _local_4 = _local_5.getDifficulty();
            var _local_3 = _local_6.getDifficulty();
            var _local_2 = _local_5.getID();
            var _local_1 = _local_6.getID();
            if (_local_4 < _local_3) {
                return(-1);
            } else if (_local_4 > _local_3) {
                return(1);
            } else if (_local_2 < _local_1) {
                return(-1);
            } else if (_local_2 > _local_1) {
                return(1);
            } else {
                return(0);
            }
        }
        function stampBookItemComparisonByID(stampBookItemA, stampBookItemB) {
            var _local_2 = stampBookItemA.getID();
            var _local_1 = stampBookItemB.getID();
            if (_local_2 < _local_1) {
                return(-1);
            } else if (_local_2 > _local_1) {
                return(1);
            } else {
                return(0);
            }
        }
        function stampBookCategoryComparisonByID(stampBookCategoryA, stampBookCategoryB) {
            var _local_2 = stampBookCategoryA.getID();
            var _local_1 = stampBookCategoryB.getID();
            if (_local_2 < _local_1) {
                return(-1);
            } else if (_local_2 > _local_1) {
                return(1);
            } else {
                return(0);
            }
        }
        function checkForEPFFieldOpsMedalStamps(totalPoints) {
            if ((totalPoints == undefined) || (totalPoints == null)) {
                epfService.getPoints();
            } else {
                var _local_3 = [];
                for (var _local_2 in EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID) {
                    if (Number(_local_2) <= totalPoints) {
                        _local_3.push(EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID[Number(_local_2)]);
                    }
                }
                var _local_4 = _local_3.length;
                var _local_2 = 0;
                while (_local_2 < _local_4) {
                    shell.stampEarned(_local_3[_local_2]);
                    _local_2++;
                }
            }
        }
        function getAwardStampID(dbAwardID) {
            for (var _local_3 in AWARD_STAMP_IDS_TO_DB_IDS) {
                var _local_1 = Number(_local_3);
                if (AWARD_STAMP_IDS_TO_DB_IDS[_local_1] == dbAwardID) {
                    return(_local_1);
                }
            }
            return(-1);
        }
        function setRecentlyEarnedStamp(stampID, isServerSide) {
            if (!isServerSide) {
                stampsService.sendStampEarned(stampID);
            }
            var _local_2 = getStampBookItem(stampID, com.clubpenguin.stamps.StampBookItemType.STAMP.value);
            if (_local_2 != undefined) {
                _myStamps.push(_local_2);
            }
        }
        function get stampBookCoverCrumbs() {
            return(_stampBookCoverCrumbs);
        }
        function get myStamps() {
            return(_myStamps);
        }
        function get myStampsByIds() {
            var _local_3 = [];
            if (_myStamps != undefined) {
                var _local_4 = _myStamps.length;
                var _local_2 = 0;
                while (_local_2 < _local_4) {
                    _local_3.push(_myStamps[_local_2].getID());
                    _local_2++;
                }
            }
            return(_local_3);
        }
        function get numClubPenguinStamps() {
            return(_numClubPenguinStamps);
        }
        function getStampBookItem(id, typeValue) {
            var _local_9 = _usersStampCategories.length;
            var _local_5 = 0;
            while (_local_5 < _local_9) {
                var _local_2 = findStampBookItemInItemsList(id, _usersStampCategories[_local_5].getItems(), typeValue);
                if (_local_2 != undefined) {
                    return(_local_2);
                } else {
                    var _local_4 = _usersStampCategories[_local_5].getSubCategories();
                    if (_local_4 != undefined) {
                        var _local_6 = _local_4.length;
                        var _local_3 = 0;
                        while (_local_3 < _local_6) {
                            _local_2 = findStampBookItemInItemsList(id, _local_4[_local_3].getItems(), typeValue);
                            if (_local_2 != undefined) {
                                return(_local_2);
                            }
                            _local_3++;
                        }
                    }
                }
                _local_5++;
            }
            return(undefined);
        }
        function stampIsOwnedByMe(stampID) {
            if (_myStamps != undefined) {
                var _local_3 = _myStamps.length;
                var _local_2 = 0;
                while (_local_2 < _local_3) {
                    if (_myStamps[_local_2].getID() == stampID) {
                        return(true);
                    }
                    _local_2++;
                }
            }
            return(false);
        }
        function getPlayersStampBookCategories(playerID) {
            pinsService.queryPlayersPins(playerID);
        }
        function getPlayersStamps(playerID) {
            stampsService.getPlayersStamps(playerID);
        }
        function getMyRecentlyEarnedStamps() {
            stampsService.getMyRecentlyEarnedStamps();
        }
        function getStampBookCoverDetails(playerID) {
            stampsService.getStampBookCoverDetails(playerID);
        }
        function saveMyStampBookCover(stampBookCover) {
            var _local_15 = stampBookCover.getColourID();
            var _local_14 = stampBookCover.getHighlightID();
            var _local_16 = stampBookCover.getPatternID();
            var _local_17 = stampBookCover.getClaspIconArtID();
            var _local_11 = [];
            var _local_10 = stampBookCover.getCoverItems();
            var _local_12 = _local_10.length;
            var _local_4 = 0;
            while (_local_4 < _local_12) {
                var _local_2 = _local_10[_local_4];
                var _local_6 = _local_2.getItem();
                var _local_7 = _local_6.getType().value;
                var _local_3 = _local_6.getID();
                var _local_5 = _local_2.getItemPosition();
                var _local_9 = _local_2.getItemRotation();
                var _local_8 = _local_2.getItemDepth();
                if (_local_7 == com.clubpenguin.stamps.StampBookItemType.AWARD.value) {
                    _local_3 = AWARD_STAMP_IDS_TO_DB_IDS[_local_3];
                }
                _local_11.push((((((((((_local_7 + SOCKET_SERVER_DATA_DELIMITER) + _local_3) + SOCKET_SERVER_DATA_DELIMITER) + _local_5.x) + SOCKET_SERVER_DATA_DELIMITER) + _local_5.y) + SOCKET_SERVER_DATA_DELIMITER) + _local_9) + SOCKET_SERVER_DATA_DELIMITER) + _local_8);
                _local_4++;
            }
            stampsService.setStampBookCoverDetails(_local_15, _local_14, _local_16, _local_17, _local_11);
        }
        function handleEPFPoints(unusedPoints, totalPoints) {
            checkForEPFFieldOpsMedalStamps(totalPoints);
        }
        function handleQueryPlayersPins(serverEventData) {
            _usersStampCategories = [];
            var _local_15 = Number(serverEventData.shift());
            var _local_11 = [];
            var _local_12 = serverEventData.length;
            var _local_5 = 0;
            while (_local_5 < _local_12) {
                var _local_3 = serverEventData[_local_5].split(SOCKET_SERVER_DATA_DELIMITER);
                var _local_7 = Number(_local_3[0]);
                var _local_4 = shell.getInventoryObjectById(_local_7);
                if (_local_4 != undefined) {
                    var _local_9 = _local_4.name;
                    var _local_6 = new Date(Number(_local_3[1]) * MILLISECONDS);
                    var _local_2 = shell.getLocalizedString("pin_release_date");
                    var _local_8 = ((Number(_local_3[2]) == 1) ? true : false);
                    _local_2 = com.clubpenguin.util.StringUtils.replaceString("%month%", MONTH_STRING[_local_6.getMonth()], _local_2);
                    _local_2 = com.clubpenguin.util.StringUtils.replaceString("%day%", String(_local_6.getDate()), _local_2);
                    _local_2 = com.clubpenguin.util.StringUtils.replaceString("%year%", String(_local_6.getFullYear()), _local_2);
                    _local_11.push(new com.clubpenguin.stamps.PinItem(_local_7, _local_9, _local_2, _local_8));
                }
                _local_5++;
            }
            var _local_13 = new com.clubpenguin.stamps.StampBookCategory(PIN_CATEGORY_ID, pinCategoryName, [], _local_11, []);
            _usersStampCategories = clubPenguinStampCategories.concat(_local_13);
            var _local_14 = new com.clubpenguin.stamps.StampBookCategory(MYSTERY_CATEGORY_ID, MYSTERY_PAGE_TITLE, [], [], []);
            _usersStampCategories.push(_local_14);
            shell.updateListeners(shell.PLAYERS_STAMP_BOOK_CATEGORIES, _usersStampCategories);
        }
        function handleGetPlayersStamps(serverEventData) {
            var _local_4 = Number(serverEventData.shift());
            var _local_2 = Number(serverEventData.shift());
            _activeUsersStampList = createStampBookItemListFromServerData(serverEventData, com.clubpenguin.stamps.StampBookItemType.STAMP.value);
            if (shell.isMyPlayer(_local_2)) {
                _myStamps = _activeUsersStampList;
            }
            awardsService.queryPlayersAwards(_local_2);
        }
        function handleQueryPlayersAwards(serverEventData) {
            var _local_8 = Number(serverEventData.shift());
            var _local_6 = Number(serverEventData.shift());
            var _local_5 = serverEventData[0].split(SOCKET_SERVER_DATA_DELIMITER);
            var _local_4 = _local_5.length;
            var _local_7;
            serverEventData[0] = "";
            var _local_2 = 0;
            while (_local_2 < _local_4) {
                serverEventData[0] = serverEventData[0] + getAwardStampID(_local_5[_local_2]);
                if (_local_2 < (_local_4 - 1)) {
                    serverEventData[0] = serverEventData[0] + SOCKET_SERVER_DATA_DELIMITER;
                }
                _local_2++;
            }
            _local_7 = createStampBookItemListFromServerData(serverEventData, com.clubpenguin.stamps.StampBookItemType.AWARD.value);
            _activeUsersStampList = _activeUsersStampList.concat(_local_7);
            if (shell.isMyPlayer(_local_6)) {
                _myStamps = _activeUsersStampList;
            }
            shell.updateListeners(shell.PLAYERS_STAMPS, _activeUsersStampList);
        }
        function handleGetMyRecentlyEarnedStamps(serverEventData) {
            var _local_3 = Number(serverEventData.shift());
            shell.updateListeners(shell.MY_RECENTLY_EARNED_STAMPS, createStampBookItemListFromServerData(serverEventData, com.clubpenguin.stamps.StampBookItemType.STAMP.value));
        }
        function handleGetStampBookCoverDetails(serverEventData) {
            var _local_14 = Number(serverEventData.shift());
            var _local_10 = Number(serverEventData.shift());
            var _local_9 = Number(serverEventData.shift());
            var _local_11 = Number(serverEventData.shift());
            var _local_13 = Number(serverEventData.shift());
            var _local_12;
            var _local_7 = [];
            var _local_8 = serverEventData.length;
            var _local_3 = 0;
            while (_local_3 < _local_8) {
                var _local_2 = serverEventData[_local_3].split(SOCKET_SERVER_DATA_DELIMITER);
                var _local_4;
                if (_local_2[0] == com.clubpenguin.stamps.StampBookItemType.AWARD.value) {
                    _local_2[1] = getAwardStampID(_local_2[1]);
                }
                _local_4 = getStampBookItem(_local_2[1], _local_2[0]);
                if (_local_4 != undefined) {
                    var _local_5 = new com.clubpenguin.stamps.StampBookCoverItem(_local_4, new flash.geom.Point(_local_2[2], _local_2[3]), _local_2[4], _local_2[5]);
                    _local_7.push(_local_5);
                }
                _local_3++;
            }
            _local_12 = new com.clubpenguin.stamps.StampBookCover(_local_7, _local_10, _local_9, _local_11, _local_13);
            shell.updateListeners(shell.STAMP_BOOK_COVER_DETAILS, _local_12);
        }
        function handlePlayerEarnedStampReceived(serverEventData) {
            var _local_4 = Number(serverEventData[0]);
            var _local_2 = Number(serverEventData[1]);
            shell.stampEarned(_local_2, true);
        }
        function handleStampDefinitionsParsed(clubPenguinStampCategories, numClubPenguinStamps) {
            if (clubPenguinStampCategories != undefined) {
                this.clubPenguinStampCategories = clubPenguinStampCategories;
                _usersStampCategories = clubPenguinStampCategories;
                _numClubPenguinStamps = numClubPenguinStamps;
            }
        }
        function findStampBookItemInItemsList(id, items, typeValue) {
            if (items != undefined) {
                var _local_3 = items.length;
                var _local_1 = 0;
                while (_local_1 < _local_3) {
                    if ((items[_local_1].getType().value == typeValue) && (items[_local_1].getID() == id)) {
                        return(items[_local_1]);
                    }
                    _local_1++;
                }
            }
            return(undefined);
        }
        function createStampBookItemListFromServerData(serverEventData, typeValue) {
            var _local_4 = [];
            var _local_5 = serverEventData[0].split(SOCKET_SERVER_DATA_DELIMITER);
            var _local_6 = _local_5.length;
            var _local_2 = 0;
            while (_local_2 < _local_6) {
                var _local_3 = getStampBookItem(_local_5[_local_2], typeValue);
                if (_local_3 != undefined) {
                    _local_4.push(_local_3);
                }
                _local_2++;
            }
            return(_local_4);
        }
        function getHasModifiedStampCover() {
            return(_hasModifiedStampCover);
        }
        function setHasModifiedStampCover(hasModifiedStampCover) {
            _hasModifiedStampCover = hasModifiedStampCover;
        }
        static var ALL_CATEGORY_ID = 9000;
        static var AWARD_CATEGORY_ID = 22;
        static var GAMES_CATEGORY_ID = 8;
        static var PIN_CATEGORY_ID = 9001;
        static var MYSTERY_CATEGORY_ID = 10000;
        static var MYSTERY_PAGE_TITLE = "Mystery Page";
        static var MAX_STAMPBOOK_COVER_ITEMS = 6;
        static var STAMP_ICON_BOX_WIDTH = 80;
        static var STAMP_ICON_BOX_HEIGHT = 70;
        static var STAMPBOOK_SWF_FILENAME = "stampbook.swf";
        static var COVER_PATTERN_NONE_ID = -1;
        static var SOCKET_SERVER_DATA_DELIMITER = "|";
        static var MILLISECONDS = 1000;
    }
