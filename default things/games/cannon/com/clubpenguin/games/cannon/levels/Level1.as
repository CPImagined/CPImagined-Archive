//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.games.cannon.levels.Level1 extends com.clubpenguin.games.cannon.CannonLevel
    {
        var sky, ground, startIconX, startIconY, endIconX, endIconY, level1bgArtArraySaved, level1cannonArraySaved, level1obstacleArraySaved, level1puffleOArraySaved;
        function Level1 () {
            super();
            sky = 1;
            ground = 850;
            startIconX = 70;
            startIconY = 320;
            endIconX = 100;
            endIconY = -810;
            buildArrays();
        }
        function buildArrays() {
            level1bgArtArraySaved = [[14, 424, 422], [6, 410, -80], [5, 750, -280], [4, 460, -470], [3, 770, -670], [2, 175, -617.9], [1, 70, -230], [6, 471.65, -796.65], [3, -60, -770], [12, 1330, 650], [11, 740, 790], [10, 1280, 300], [9, 700, 540], [12, -260, 640], [8, -220, 310], [5, -100, -500], [2, 720, 50], [2, 205.6, 197.25], [7, 240, -950]];
            level1cannonArraySaved = [[1, 80, 440, -38], [2, 340, 270, 0], [1, 600, 270, -90], [1, 600, 20, 178], [7, 337, 39, 0], [1, 80, 40, 91], [1, 340, -180, -90], [1, 600, -190, 90], [1, 600, -400, 91], [7, 352.1, -410.45, 0], [1, 360, -660, 0], [1, 600, -650, 91], [6, 96, -414, 90]];
            level1obstacleArraySaved = [];
            level1puffleOArraySaved = [[1, 143, 391], [1, 204, 346], [1, 263, 307], [1, 79, 120], [1, 77, 200], [1, 420, 270], [1, 498, 273], [1, 600, 190], [1, 600, 115], [1, 520, 23], [1, 442, 28], [1, 600, -110], [1, 600, -54], [1, 599, -320], [1, 600.1, -269.55], [1, 599, -570], [1, 597, -489], [1, 340, -260], [1, 340, -335], [1, 440, -660], [1, 518, -657], [1, 349, -590], [1, 347, -509], [1, 96, -658], [1, 95, -576], [1, 93, -494], [1, 339, -110], [1, 337, -29], [1, 260, 39], [1, 182, 40], [1, 260, -414], [1, 183, -415], [1, 330, 188], [1, 331, 116]];
        }
    }
