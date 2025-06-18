//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.stamps.stampbook.util.StampLookUp extends MovieClip
    {
        static var _instance;
        var _userObject, _masterList, _userStamps, _coverStamps, _stampManager, _userStampsHash, _coverStampsHash, _selectedCategoryHash, _stampsHash, _pageList;
        function StampLookUp () {
            super();
        }
        static function getInstance() {
            if (_instance == null) {
                _instance = new com.clubpenguin.stamps.stampbook.util.StampLookUp();
            }
            return(_instance);
        }
        function initialize(userObject, masterList, userStamps, coverStamps, stampManager) {
            _userObject = userObject;
            _masterList = masterList;
            _userStamps = userStamps;
            _coverStamps = coverStamps;
            _stampManager = stampManager;
            _userStampsHash = {};
            _coverStampsHash = {};
            _selectedCategoryHash = {};
            _stampsHash = {};
            var _local_16 = _userStamps.length;
            var _local_7 = 0;
            while (_local_7 < _local_16) {
                _userStampsHash[_userStamps[_local_7].getID()] = true;
                _local_7++;
            }
            var _local_13 = _coverStamps.getCoverItems();
            var _local_14 = _local_13.length;
            _local_7 = 0;
            while (_local_7 < _local_14) {
                var _local_12 = _local_13[_local_7].getItem();
                _coverStampsHash[_local_12.getID()] = true;
                _local_7++;
            }
            var _local_20;
            var _local_17;
            _pageList = [];
            var _local_15 = _masterList.length;
            _local_7 = 0;
            while (_local_7 < _local_15) {
                var _local_5 = _masterList[_local_7].getSubCategories();
                if ((_local_5 != undefined) && (_local_5.length > 0)) {
                    var _local_10 = _local_5.length;
                    _pageList.push(_masterList[_local_7]);
                    var _local_3 = 0;
                    while (_local_3 < _local_10) {
                        _pageList.push(_local_5[_local_3]);
                        var _local_6 = _local_5[_local_3].getItems();
                        var _local_8 = _local_6.length;
                        var _local_4 = 0;
                        while (_local_4 < _local_8) {
                            var _local_2 = _local_6[_local_4];
                            _stampsHash[_local_2.getID()] = _local_2;
                            _local_4++;
                        }
                        _local_3++;
                    }
                } else {
                    _pageList.push(_masterList[_local_7]);
                    var _local_9 = _masterList[_local_7].getItems();
                    var _local_11 = _local_9.length;
                    var _local_4 = 0;
                    while (_local_4 < _local_11) {
                        var _local_2 = _local_9[_local_4];
                        _stampsHash[_local_2.getID()] = _local_2;
                        _local_4++;
                    }
                }
                _local_7++;
            }
        }
        function isOwned(id) {
            return(_userStampsHash[id]);
        }
        function isCover(id) {
            return(_coverStampsHash[id]);
        }
        function removeStampFromCover(id) {
            _coverStampsHash[id] = false;
        }
        function addStampToCover(id) {
            _coverStampsHash[id] = true;
        }
        function setCategorySelected(categoryID) {
            for (var _local_2 in _selectedCategoryHash) {
                _selectedCategoryHash[_local_2] = false;
            }
            _selectedCategoryHash[categoryID] = true;
        }
        function isCategorySelected(categoryID) {
            if (_selectedCategoryHash[categoryID] != undefined) {
                return(_selectedCategoryHash[categoryID]);
            }
            return(false);
        }
        function getStampByID(stampID) {
            return(_stampsHash[stampID]);
        }
        function addStampsForSection(section, flag) {
            var _local_2;
            var _local_3 = section.length;
            if (_local_3) {
                var _local_4 = Array(section);
                _local_2 = addStamps(_local_4[0], flag);
            } else {
                var _local_5 = [section];
                _local_2 = addStamps(_local_5, flag);
            }
            return(_local_2);
        }
        function addStamps(section, flag) {
            var _local_4 = [];
            var _local_11 = section.length;
            var _local_9 = com.clubpenguin.stamps.StampManager.PIN_CATEGORY_ID;
            var _local_6 = 0;
            for ( ; _local_6 < _local_11 ; _local_6++) {
                var _local_5 = section[_local_6];
                if (_local_5.getID() == _local_9) {
                    if (flag != USER_NONCOVER_STAMPS) {
                        continue;
                    }
                }
                var _local_10 = _local_5.getSubCategories();
                _local_4 = _local_4.concat(addStamps(_local_10, flag));
                var _local_3 = _local_5.getItems();
                var _local_8 = _local_3.length;
                var _local_2 = 0;
                while (_local_2 < _local_8) {
                    switch (flag) {
                        case USER_STAMPS : 
                            if (isOwned(_local_3[_local_2].getID())) {
                                _local_4.push(_local_3[_local_2]);
                            }
                            break;
                        case TOTAL_STAMPS : 
                            _local_4.push(_local_3[_local_2]);
                            break;
                        case USER_NONCOVER_STAMPS : 
                            if (_local_5.getID() == _local_9) {
                                if (!isCover(_local_3[_local_2].getID())) {
                                    _local_4.push(_local_3[_local_2]);
                                }
                            } else if (isOwned(_local_3[_local_2].getID()) && (!isCover(_local_3[_local_2].getID()))) {
                                _local_4.push(_local_3[_local_2]);
                            }
                            break;
                    }
                    _local_2++;
                }
            }
            return(_local_4);
        }
        function getStampsForCategory(section) {
            return(addStampsForSection(section, USER_NONCOVER_STAMPS));
        }
        function getNumberOfTotalStampsForCategory(section) {
            var _local_2 = addStampsForSection(section, TOTAL_STAMPS);
            return(_local_2.length);
        }
        function getNumberOfUserStampsForCategory(section) {
            var _local_2 = addStampsForSection(section, USER_STAMPS);
            return(_local_2.length);
        }
        function getNumberOfUserStamps() {
            return(_userStamps.length);
        }
        function getPageList() {
            return(_pageList);
        }
        function getMasterList() {
            return(_masterList);
        }
        function getPlayerNickname() {
            return(_userObject.nickname);
        }
        static var CLASS_REF = com.clubpenguin.stamps.stampbook.util.StampLookUp;
        static var LINKAGE_ID = "StampLookUp";
        static var USER_STAMPS = "userStamps";
        static var TOTAL_STAMPS = "totalStamps";
        static var USER_NONCOVER_STAMPS = "userNoncoverStamps";
    }
