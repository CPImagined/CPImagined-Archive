//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.hockey.BallGroup
    {
        var items, container, puck, netLeft_mc, netRight_mc, lines;
        function BallGroup (container_mc) {
            items = [];
            container = container_mc;
            makeLines();
            _global["MovieClip"].addListener(this);
            Mouse.addListener(this);
        }
        function goalScoredTeam1() {
        }
        function goalScoredTeam2() {
        }
        function puckDone() {
        }
        function resetPuck() {
            puck.vel.reset(0, 0);
            puck.pos.reset(0, 0);
        }
        function addNets(netLeft, netRight) {
            netLeft_mc = netLeft;
            netRight_mc = netRight;
            netLeft_mc._visible = false;
            netRight_mc._visible = false;
        }
        function makeLines() {
            lines = [];
            makeLineBetweenMCs(container.p0, container.p1);
            makeLineBetweenMCs(container.p1, container.p2);
            makeLineBetweenMCs(container.p2, container.p3);
            makeLineBetweenMCs(container.p3, container.p4);
            makeLineBetweenMCs(container.p4, container.p5);
            makeLineBetweenMCs(container.p5, container.p6);
            makeLineBetweenMCs(container.p6, container.p7);
            makeLineBetweenMCs(container.p7, container.p8);
            makeLineBetweenMCs(container.p8, container.p9);
            makeLineBetweenMCs(container.p9, container.p10);
            makeLineBetweenMCs(container.p10, container.p11);
            makeLineBetweenMCs(container.p11, container.p0);
        }
        function makeLineBetweenMCs(mc1, mc2) {
            var _local_4 = new com.clubpenguin.util.Line(mc1._x, mc1._y, mc2._x, mc2._y);
            lines.push(_local_4);
            mc1._visible = false;
            mc2._visible = false;
        }
        function onMouseDown() {
        }
        function onMouseUp() {
        }
        function addItem(item) {
            item.ballGroup = this;
            return(items.push(item));
        }
        function draw() {
            var _local_2 = 0;
            while (_local_2 < items.length) {
                var _local_3 = items[_local_2];
                _local_3.draw();
                _local_2++;
            }
        }
        function erase() {
            var _local_2 = 0;
            while (_local_2 < items.length) {
                var _local_3 = items[_local_2];
                _local_3.erase();
                _local_2++;
            }
        }
        function get numPairs() {
            return((items.length * (items.length - 1)) * 0.5);
        }
        static function getPairsInList(list) {
            var _local_7 = [];
            var _local_2 = 0;
            while (_local_2 < (list.length - 1)) {
                var _local_6 = list[_local_2];
                var _local_1 = _local_2 + 1;
                while (_local_1 < list.length) {
                    var _local_3 = list[_local_1];
                    var _local_4 = [_local_6, _local_3];
                    _local_7.push(_local_4);
                    _local_1++;
                }
                _local_2++;
            }
            return(_local_7);
        }
        function getCollidingPairs() {
            var _local_5 = items;
            var _local_8 = [];
            var _local_4 = 0;
            while (_local_4 < (_local_5.length - 1)) {
                var _local_7 = _local_5[_local_4];
                var _local_2 = _local_4 + 1;
                while (_local_2 < _local_5.length) {
                    var _local_3 = _local_5[_local_2];
                    if (areColliding(_local_7, _local_3)) {
                        var _local_6 = [_local_7, _local_3];
                        _local_8.push(_local_6);
                    }
                    _local_2++;
                }
                _local_4++;
            }
            return(_local_8);
        }
        function onEnterFrame() {
            doFriction();
            addVelocity();
            collideWithNets();
            collideWithWalls();
            draw();
        }
        function shootPuckOppositeMouse() {
            var _local_3 = puck.sprite._x - container._xmouse;
            var _local_2 = puck.sprite._y - container._ymouse;
            puck.vel.reset(_local_3 * 0.1, _local_2 * 0.1);
        }
        function hitPuck(startX, startY, speedX, speedY) {
            if (audioEnabled) {
                var _local_2 = new Sound(container);
                _local_2.attachSound("sfx_kick_" + String(Math.floor(Math.random() * 2) + 1));
                _local_2.start();
            }
            puck.pos.reset(startX, startY);
            puck.vel.reset(speedX, speedY);
        }
        function doFriction() {
            var _local_3 = 0;
            while (_local_3 < items.length) {
                var _local_4 = items[_local_3];
                var _local_2 = _local_4.vel.length;
                _local_2 = _local_2 - friction;
                if (_local_2 <= 0) {
                    _local_2 = 0;
                    puckDone();
                    if ((++puckTimeoutCounter) > puckTimeout) {
                        resetPuck();
                    }
                } else {
                    puckTimeoutCounter = 0;
                }
                _local_4.vel.length = _local_2;
                _local_3++;
            }
        }
        function addVelocity() {
            var _local_2 = 0;
            while (_local_2 < items.length) {
                var _local_3 = items[_local_2];
                _local_3.pos.plus(_local_3.vel);
                _local_2++;
            }
        }
        function collideWithNets() {
            var _local_2 = false;
            if (puck.sprite.hitTest(netLeft_mc)) {
                _local_2 = true;
                var _local_6 = puck.pos.y;
                var _local_5 = _local_6 - netLeft_mc._y;
                if (((-maxVerticalFromNetCenter) < _local_5) && (_local_5 < maxVerticalFromNetCenter)) {
                    var _local_3 = puck.vel.angle;
                    if (_local_3 < 0) {
                        _local_3 = _local_3 + 360;
                    }
                    _local_3 = _local_3 - 180;
                    if (((-maxAngleFromHorizontal) < _local_3) && (_local_3 < maxAngleFromHorizontal)) {
                        goalScoredTeam2();
                        resetPuck();
                        return(undefined);
                    }
                }
            } else if (puck.sprite.hitTest(netRight_mc)) {
                _local_2 = true;
                var _local_6 = puck.pos.y;
                var _local_5 = _local_6 - netLeft_mc._y;
                if (((-maxVerticalFromNetCenter) < _local_5) && (_local_5 < maxVerticalFromNetCenter)) {
                    var _local_3 = puck.vel.angle;
                    if (((-maxAngleFromHorizontal) < _local_3) && (_local_3 < maxAngleFromHorizontal)) {
                        goalScoredTeam1();
                        resetPuck();
                        return(undefined);
                    }
                }
            }
            if (_local_2) {
                puck.vel.negate();
                puck.pos.plus(puck.vel);
                puck.pos.plus(puck.vel);
                puck.vel.scale(0.8);
                if (audioEnabled && ((puck.vel.x > 2) || (puck.vel.y > 2))) {
                    var _local_4 = new Sound(container);
                    _local_4.attachSound("sfx_post_" + String(Math.floor(Math.random() * 2) + 1));
                    _local_4.start();
                }
            }
        }
        function collideWithWalls() {
            var _local_7 = 0;
            while (_local_7 < items.length) {
                var _local_8 = false;
                var _local_2 = items[_local_7];
                var _local_4 = 0;
                while (_local_4 < lines.length) {
                    var _local_5 = lines[_local_4];
                    var _local_3 = getBallLineCollisionTime(_local_5, _local_2);
                    if (_local_3 != Infinity) {
                    }
                    if ((0 < _local_3) && (_local_3 <= 1)) {
                        _local_2.vel.reflectOff(_local_5.getVector());
                        _local_2.vel.scale(0.8);
                        _local_2.pos.plus(_local_2.vel);
                        _local_8 = true;
                        if (audioEnabled) {
                            var _local_6 = new Sound(container);
                            _local_6.attachSound("sfx_bounce_" + String(Math.floor(Math.random() * 2) + 1));
                            _local_6.start();
                        }
                        return(undefined);
                    }
                    _local_4++;
                }
                if ((_local_2.pos.x - _local_2.r) < xMin) {
                    resetPuck();
                } else if ((_local_2.pos.x + _local_2.r) > xMax) {
                    resetPuck();
                } else if ((_local_2.pos.y - _local_2.r) < yMin) {
                    resetPuck();
                } else if ((_local_2.pos.y + _local_2.r) > yMax) {
                    resetPuck();
                }
                _local_7++;
            }
        }
        static function getBallLineCollisionTime(theLine, theBall) {
            var _local_3 = theBall.vel.y / theBall.vel.x;
            if (_local_3 == Number.POSITIVE_INFINITY) {
                _local_3 = 1000000 /* 0x0F4240 */;
            } else if (_local_3 == Number.NEGATIVE_INFINITY) {
                _local_3 = -1000000;
            } else if (isNaN(_local_3)) {
                return(Infinity);
            }
            var _local_15 = theBall.pos.y - (_local_3 * theBall.pos.x);
            var _local_5 = (_local_15 - theLine.b) / (theLine.slope - _local_3);
            var _local_7 = (theLine.slope * _local_5) + theLine.b;
            var _local_8 = Math.atan2(theBall.vel.y, theBall.vel.x);
            var _local_16 = _local_8 - theLine.angleRadians;
            var _local_19 = Math.sin(_local_16);
            var _local_10 = theBall.r / _local_19;
            _local_5 = _local_5 - (_local_10 * Math.cos(_local_8));
            _local_7 = _local_7 - (_local_10 * Math.sin(_local_8));
            var _local_12 = _local_5 - theBall.pos.x;
            var _local_11 = _local_7 - theBall.pos.y;
            var _local_17 = Math.sqrt((_local_12 * _local_12) + (_local_11 * _local_11));
            var _local_18 = theBall.vel.length;
            var _local_14 = _local_17 / _local_18;
            var _local_9 = -1 / theLine.slope;
            var _local_13 = _local_7 - (_local_9 * _local_5);
            var _local_4 = (theLine.b - _local_13) / (_local_9 - theLine.slope);
            var _local_6 = (_local_9 * _local_4) + _local_13;
            if ((((_local_4 > theLine.x1) && (_local_4 < theLine.x2)) || ((_local_4 < theLine.x1) && (_local_4 > theLine.x2))) || (((_local_6 > theLine.y1) && (_local_6 < theLine.y2)) || ((_local_6 < theLine.y1) && (_local_6 > theLine.y2)))) {
                return(_local_14);
            }
            return(Infinity);
        }
        function setRandomVelocities() {
            var _local_2 = 0;
            while (_local_2 < items.length) {
                var _local_3 = items[_local_2];
                _local_3.vel.reset((Math.random() - 0.5) * 40, (Math.random() - 0.5) * 40);
                _local_2++;
            }
        }
        static function distanceCenters(a, b) {
            var _local_2 = b.pos.x - a.pos.x;
            var _local_1 = b.pos.y - a.pos.y;
            return(Math.sqrt((_local_2 * _local_2) + (_local_1 * _local_1)));
        }
        static function distanceEdges(a, b) {
            var _local_2 = b.pos.x - a.pos.x;
            var _local_1 = b.pos.y - a.pos.y;
            return(Math.sqrt((_local_2 * _local_2) + (_local_1 * _local_1)) - (a.r + b.r));
        }
        static function areColliding(a, b) {
            var _local_3 = b.pos.x - a.pos.x;
            var _local_2 = b.pos.y - a.pos.y;
            var _local_1 = a.r + b.r;
            return(((_local_3 * _local_3) + (_local_2 * _local_2)) < (_local_1 * _local_1));
        }
        var friction = 0.1;
        var maxAngleFromHorizontal = 50;
        var maxVerticalFromNetCenter = 30;
        var puckTimeout = 1000;
        var puckTimeoutCounter = 0;
        var xMin = -200;
        var yMin = -90;
        var xMax = 240;
        var yMax = 140;
        var audioEnabled = false;
        var isDragging = false;
    }
