
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.clubpenguin.achievements.AchievementManager
    {
        var _achievementXmls, _shell, _engine, _interface, _achievementChecks, _achievementGroups, _trackerAS2, _currentContext;
        function AchievementManager (shell, engine, interfaceClip) {
            _achievementXmls = [];
            _shell = shell;
            _engine = engine;
            _interface = interfaceClip;
            com.clubpenguin.achievements.AchievementTools.__set__shell(_shell);
            com.clubpenguin.achievements.AchievementTools.__set__engine(_engine);
            _achievementChecks = [];
            _achievementGroups = [];
            _trackerAS2 = com.clubpenguin.util.TrackerAS2.getInstance();
            _shell.addListener(_shell.ACHIEVEMENT_DONE, deleteAchievement, this);
            _currentContext = "load.world";
            try {
                loadAchievementsXml(_shell.getBaseConfigPath() + ACHIEVEMENT_XML_URL);
            } catch(ae:com.clubpenguin.achievements.AchievementException) {
            }
        }
        function deleteAllEarnedAchievements() {
            var _local3 = _shell.getStampManager().myStamps;
            var _local4 = _local3.length;
            var _local2 = 0;
            while (_local2 < _local4) {
                deleteAchievement(String(_local3[_local2].getID()));
                _local2++;
            }
        }
        function deleteAchievement(achievementID) {
            var _local7 = _achievementGroups.length;
            var _local3 = 0;
            while (_local3 < _local7) {
                var _local4 = _achievementGroups[_local3].achievements;
                var _local8 = _local4.length;
                var _local2 = 0;
                while (_local2 < _local8) {
                    if (_local4[_local2].id == achievementID) {
                        return(undefined);
                    }
                    _local2++;
                }
                _local3++;
            }
            var _local9 = getAchievementIndex(achievementID);
            if (_local9 >= 0) {
                var _local6 = _achievementChecks[_local9].name;
                _achievementChecks[_local9].destroy();
                _achievementChecks.splice(_local9, 1);
                var _local8 = _achievementChecks.length;
                _local3 = 0;
                while (_local3 < _local8) {
                    if (_achievementChecks[_local3].name == _local6) {
                        deleteAchievement(_achievementChecks[_local3].id);
                    }
                    _local3++;
                }
            }
        }
        function getAchievementIndex(achievementID) {
            var _local3 = _achievementChecks.length;
            var _local2 = 0;
            while (_local2 < _local3) {
                if (_achievementChecks[_local2].id == achievementID) {
                    return(_local2);
                }
                _local2++;
            }
            return(-1);
        }
        function loadAchievementsXml(path) {
            var _local2 = new XML();
            _local2.ignoreWhite = true;
            _local2.onLoad = com.clubpenguin.util.Delegate.create(this, onAchievementsXmlLoaded, _local2, path);
            _local2.load(path);
            _achievementXmls.push(_local2);
        }
        function onAchievementsXmlLoaded(success, achievementDoc, filePath) {
            if (success) {
                try {
                    var _local2 = achievementDoc.firstChild;
                    while (_local2 != null) {
                        if (_local2.nodeName == XML_NODENAME_ACHIEVEMENT_DOCUMENT) {
                            parseAchievementDocument(_local2);
                        }
                        _local2 = _local2.nextSibling;
                    }
                } catch(ae:com.clubpenguin.achievements.AchievementException) {
                }
            }
        }
        function parseAchievementDocument(node) {
            var _local6 = [];
            while (node != null) {
                var _local4 = node.childNodes;
                var _local3 = 0;
                while (_local3 < _local4.length) {
                    var _local2 = _local4[_local3];
                    if (_local2.nodeName == XML_NODENAME_ACHIEVEMENT) {
                        parseAchievement(_local2);
                    } else if (_local2.nodeName == XML_NODENAME_ACHIEVEMENT_GROUP) {
                        _local6.push(_local2);
                    }
                    _local3++;
                }
                node = node.nextSibling;
            }
            var _local5 = 0;
            while (_local5 < _local6.length) {
                parseGroupAchievement(_local6[_local5]);
                _local5++;
            }
        }
        function parseAchievement(node) {
            var _local3 = new com.clubpenguin.achievements.AchievementCheck(_shell);
            _local3.__set__name(node.attributes.name);
            _local3.__set__id(node.attributes.id);
            var _local2 = node.firstChild;
            while (_local2 != null) {
                if (_local2.nodeName == XML_NODENAME_ACHIEVEMENT_EVENT) {
                    _local3.addEvent(String(_local2.firstChild));
                } else if (_local2.nodeName == XML_NODENAME_ACHIEVEMENT_CONDITION) {
                    _local3.addCondition(String(_local2.firstChild), false);
                } else if (_local2.nodeName == XML_NODENAME_ACHIEVEMENT_OPTIONAL_CONDITION) {
                    _local3.addCondition(String(_local2.firstChild), true);
                } else if (_local2.nodeName == XML_NODENAME_ACHIEVEMENT_RESULT) {
                    _local3.addResult(String(_local2.firstChild));
                } else if (_local2.nodeName == XML_NODENAME_DEBUG) {
                    var _local5 = String(_local2.firstChild).toLowerCase() == "true";
                    _local3.__set__debug(_local5);
                } else if (_local2.nodeName == XML_NODENAME_EXPIRY_DATE) {
                    var _local4 = String(_local2.firstChild);
                    var _local6 = new Date();
                    if (_local6.getTime() >= Number(_local4 * MILLISECONDS)) {
                        _local3.destroy();
                        return(undefined);
                    }
                } else {
                    throw new com.clubpenguin.achievements.AchievementException(((("AchievementManager::parseAchievement() - There was an error creating achievement \"" + _local3.__get__name()) + "\" - the XML property \"") + _local2.nodeName) + "\" was not recognised.");
                }
                _local2 = _local2.nextSibling;
            }
            _achievementChecks.push(_local3);
        }
        function parseGroupAchievement(node) {
            var _local9 = true;
            var _local4 = new com.clubpenguin.achievements.AchievementGroup(_shell);
            _local4.__set__name(node.attributes.name);
            _local4.__set__id(node.attributes.id);
            _local4.__set__type(node.attributes.type);
            var _local2 = node.firstChild;
            while (_local2 != null) {
                if (_local2.nodeName == XML_NODENAME_ACHIEVEMENT_LINK) {
                    var _local5 = String(_local2.attributes.id);
                    var _local6 = null;
                    debugTrace(((("Group '" + _local4.__get__name()) + "' is trying to find achievement with ID '") + _local5) + "'");
                    var _local3 = 0;
                    while (_local3 < _achievementChecks.length) {
                        if (_achievementChecks[_local3].id == _local5) {
                            _local6 = _achievementChecks[_local3];
                            break;
                        }
                        _local3++;
                    }
                    if (_local6 != null) {
                        _local4.addAchievement(_local6);
                    } else {
                        throw new com.clubpenguin.achievements.AchievementException(((("AchievementManager::parseGroupAchievement() - There was an error creating group achievement \"" + _local4.__get__name()) + "\" - the achievement \"") + _local5) + "\" was not found.");
                    }
                } else if (_local2.nodeName == XML_NODENAME_ACHIEVEMENT_RESULT) {
                    _local4.addResult(String(_local2.firstChild));
                } else if (_local2.nodeName == XML_NODENAME_DEBUG) {
                    var _local7 = String(_local2.firstChild).toLowerCase() == "true";
                    _local4.__set__debug(_local7);
                } else {
                    throw new com.clubpenguin.achievements.AchievementException(((("AchievementManager::parseGroupAchievement() - There was an error creating group achievement \"" + _local4.__get__name()) + "\" - the XML property \"") + _local2.nodeName) + "\" was not recognised.");
                }
                _local2 = _local2.nextSibling;
            }
            _local4.completeInitialization();
            _achievementGroups.push(_local4);
        }
        function debugDump() {
            var _local2 = 0;
            while (_local2 < _achievementChecks.length) {
                var _local3 = _achievementChecks[_local2];
                _local2++;
            }
            _local2 = 0;
            while (_local2 < _achievementGroups.length) {
                var _local4 = _achievementGroups[_local2];
                _local2++;
            }
        }
        function debugTrace(msg) {
            if (_debug) {
            }
        }
        static var ACHIEVEMENT_XML_URL = "v2/content/global/stampbook/world_stamps.xml";
        static var XML_NODENAME_ACHIEVEMENT_DOCUMENT = "achievementDocument";
        static var XML_NODENAME_ACHIEVEMENT_GROUP = "achievementGroup";
        static var XML_NODENAME_ACHIEVEMENT = "achievement";
        static var XML_NODENAME_ACHIEVEMENT_EVENT = "event";
        static var XML_NODENAME_ACHIEVEMENT_CONDITION = "condition";
        static var XML_NODENAME_ACHIEVEMENT_OPTIONAL_CONDITION = "optionalCondition";
        static var XML_NODENAME_ACHIEVEMENT_RESULT = "result";
        static var XML_NODENAME_ACHIEVEMENT_LINK = "achievementLink";
        static var XML_NODENAME_DEBUG = "debug";
        static var XML_NODENAME_EXPIRY_DATE = "expiryDate";
        static var MILLISECONDS = 1000;
        var _debug = true;
    }
