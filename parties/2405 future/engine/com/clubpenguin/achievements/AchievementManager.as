//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.achievements.AchievementManager
    {
        var _achievementXmls, _shell, _engine, _interface, _achievementChecks, _achievementGroups, _trackerAS2, _currentContext;
        function AchievementManager (shell, engine, interfaceClip) {
            _achievementXmls = [];
            _shell = shell;
            _engine = engine;
            _interface = interfaceClip;
            com.clubpenguin.achievements.AchievementTools.shell = _shell;
            com.clubpenguin.achievements.AchievementTools.engine = _engine;
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
            var _local_3 = _shell.getStampManager().myStamps;
            var _local_4 = _local_3.length;
            var _local_2 = 0;
            while (_local_2 < _local_4) {
                deleteAchievement(String(_local_3[_local_2].getID()));
                _local_2++;
            }
        }
        function deleteAchievement(achievementID) {
            var _local_7 = _achievementGroups.length;
            var _local_3 = 0;
            while (_local_3 < _local_7) {
                var _local_4 = _achievementGroups[_local_3].achievements;
                var _local_8 = _local_4.length;
                var _local_2 = 0;
                while (_local_2 < _local_8) {
                    if (_local_4[_local_2].id == achievementID) {
                        return(undefined);
                    }
                    _local_2++;
                }
                _local_3++;
            }
            var _local_9 = getAchievementIndex(achievementID);
            if (_local_9 >= 0) {
                var _local_6 = _achievementChecks[_local_9].name;
                _achievementChecks[_local_9].destroy();
                _achievementChecks.splice(_local_9, 1);
                var _local_8 = _achievementChecks.length;
                _local_3 = 0;
                while (_local_3 < _local_8) {
                    if (_achievementChecks[_local_3].name == _local_6) {
                        deleteAchievement(_achievementChecks[_local_3].id);
                    }
                    _local_3++;
                }
            }
        }
        function getAchievementIndex(achievementID) {
            var _local_3 = _achievementChecks.length;
            var _local_2 = 0;
            while (_local_2 < _local_3) {
                if (_achievementChecks[_local_2].id == achievementID) {
                    return(_local_2);
                }
                _local_2++;
            }
            return(-1);
        }
        function loadAchievementsXml(path) {
            var _local_2 = new XML();
            _local_2.ignoreWhite = true;
            _local_2.onLoad = com.clubpenguin.util.Delegate.create(this, onAchievementsXmlLoaded, _local_2, path);
            _local_2.load(path);
            _achievementXmls.push(_local_2);
        }
        function onAchievementsXmlLoaded(success, achievementDoc, filePath) {
            if (success) {
                try {
                    var _local_2 = achievementDoc.firstChild;
                    while (_local_2 != null) {
                        if (_local_2.nodeName == XML_NODENAME_ACHIEVEMENT_DOCUMENT) {
                            parseAchievementDocument(_local_2);
                        }
                        _local_2 = _local_2.nextSibling;
                    }
                } catch(ae:com.clubpenguin.achievements.AchievementException) {
                }
            }
        }
        function parseAchievementDocument(node) {
            var _local_6 = [];
            while (node != null) {
                var _local_4 = node.childNodes;
                var _local_3 = 0;
                while (_local_3 < _local_4.length) {
                    var _local_2 = _local_4[_local_3];
                    if (_local_2.nodeName == XML_NODENAME_ACHIEVEMENT) {
                        parseAchievement(_local_2);
                    } else if (_local_2.nodeName == XML_NODENAME_ACHIEVEMENT_GROUP) {
                        _local_6.push(_local_2);
                    }
                    _local_3++;
                }
                node = node.nextSibling;
            }
            var _local_5 = 0;
            while (_local_5 < _local_6.length) {
                parseGroupAchievement(_local_6[_local_5]);
                _local_5++;
            }
        }
        function parseAchievement(node) {
            var _local_3 = new com.clubpenguin.achievements.AchievementCheck(_shell);
            _local_3.name = node.attributes.name;
            _local_3.id = node.attributes.id;
            var _local_2 = node.firstChild;
            while (_local_2 != null) {
                if (_local_2.nodeName == XML_NODENAME_ACHIEVEMENT_EVENT) {
                    _local_3.addEvent(String(_local_2.firstChild));
                } else if (_local_2.nodeName == XML_NODENAME_ACHIEVEMENT_CONDITION) {
                    _local_3.addCondition(String(_local_2.firstChild), false);
                } else if (_local_2.nodeName == XML_NODENAME_ACHIEVEMENT_OPTIONAL_CONDITION) {
                    _local_3.addCondition(String(_local_2.firstChild), true);
                } else if (_local_2.nodeName == XML_NODENAME_ACHIEVEMENT_RESULT) {
                    _local_3.addResult(String(_local_2.firstChild));
                } else if (_local_2.nodeName == XML_NODENAME_DEBUG) {
                    var _local_5 = String(_local_2.firstChild).toLowerCase() == "true";
                    _local_3.debug = _local_5;
                } else if (_local_2.nodeName == XML_NODENAME_EXPIRY_DATE) {
                    var _local_4 = String(_local_2.firstChild);
                    var _local_6 = new Date();
                    if (_local_6.getTime() >= Number(_local_4 * MILLISECONDS)) {
                        _local_3.destroy();
                        return(undefined);
                    }
                } else {
                    throw new com.clubpenguin.achievements.AchievementException(((("AchievementManager::parseAchievement() - There was an error creating achievement \"" + _local_3.name) + "\" - the XML property \"") + _local_2.nodeName) + "\" was not recognised.");
                }
                _local_2 = _local_2.nextSibling;
            }
            _achievementChecks.push(_local_3);
        }
        function parseGroupAchievement(node) {
            var _local_9 = true;
            var _local_4 = new com.clubpenguin.achievements.AchievementGroup(_shell);
            _local_4.name = node.attributes.name;
            _local_4.id = node.attributes.id;
            _local_4.type = node.attributes.type;
            var _local_2 = node.firstChild;
            while (_local_2 != null) {
                if (_local_2.nodeName == XML_NODENAME_ACHIEVEMENT_LINK) {
                    var _local_5 = String(_local_2.attributes.id);
                    var _local_6 = null;
                    debugTrace(((("Group '" + _local_4.name) + "' is trying to find achievement with ID '") + _local_5) + "'");
                    var _local_3 = 0;
                    while (_local_3 < _achievementChecks.length) {
                        if (_achievementChecks[_local_3].id == _local_5) {
                            _local_6 = _achievementChecks[_local_3];
                            break;
                        }
                        _local_3++;
                    }
                    if (_local_6 != null) {
                        _local_4.addAchievement(_local_6);
                    } else {
                        throw new com.clubpenguin.achievements.AchievementException(((("AchievementManager::parseGroupAchievement() - There was an error creating group achievement \"" + _local_4.name) + "\" - the achievement \"") + _local_5) + "\" was not found.");
                    }
                } else if (_local_2.nodeName == XML_NODENAME_ACHIEVEMENT_RESULT) {
                    _local_4.addResult(String(_local_2.firstChild));
                } else if (_local_2.nodeName == XML_NODENAME_DEBUG) {
                    var _local_7 = String(_local_2.firstChild).toLowerCase() == "true";
                    _local_4.debug = _local_7;
                } else {
                    throw new com.clubpenguin.achievements.AchievementException(((("AchievementManager::parseGroupAchievement() - There was an error creating group achievement \"" + _local_4.name) + "\" - the XML property \"") + _local_2.nodeName) + "\" was not recognised.");
                }
                _local_2 = _local_2.nextSibling;
            }
            _local_4.completeInitialization();
            _achievementGroups.push(_local_4);
        }
        function debugDump() {
            var _local_2 = 0;
            while (_local_2 < _achievementChecks.length) {
                var _local_3 = _achievementChecks[_local_2];
                _local_2++;
            }
            _local_2 = 0;
            while (_local_2 < _achievementGroups.length) {
                var _local_4 = _achievementGroups[_local_2];
                _local_2++;
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
