//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.SimonPatternVO
    {
        var firstPattern, firstPatternLength, secondPattern, secondPatternLength, thirdPattern, thirdPatternLength, patterns, lengths;
        function SimonPatternVO (firstPattern, secondPattern, thirdPattern) {
            this.firstPattern = firstPattern;
            firstPatternLength = firstPattern.length;
            this.secondPattern = secondPattern;
            secondPatternLength = secondPattern.length;
            this.thirdPattern = thirdPattern;
            thirdPatternLength = thirdPattern.length;
            patterns = [firstPattern, secondPattern, thirdPattern];
            lengths = [firstPatternLength, secondPatternLength, thirdPatternLength];
        }
        static var CLASS_NAME = "SimonPattern";
    }
