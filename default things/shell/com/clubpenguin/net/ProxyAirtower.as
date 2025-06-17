//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.net.ProxyAirtower extends com.clubpenguin.net.Airtower
    {
        var _airtower;
        function ProxyAirtower (shell) {
            super(shell);
        }
        function getServer() {
            return(_airtower.getServer());
        }
        function setAirtower(airtower) {
            _airtower = airtower;
        }
        function setIsJumpToNewServerInProgress(isJumping) {
            _airtower.setIsJumpToNewServerInProgress(isJumping);
        }
        function init() {
            _airtower.init();
        }
        function cloneListeners(cloneTo) {
            _airtower.cloneListeners(cloneTo);
        }
        function addListener(type, func, scope) {
            return(_airtower.addListener(type, func, scope));
        }
        function removeListener(type, func) {
            return(_airtower.removeListener(type, func));
        }
        function getListenerIndex(array, func) {
            return(_airtower.getListenerIndex(array, func));
        }
        function updateListeners(type, obj) {
            return(_airtower.updateListeners(type, obj));
        }
        function getListenersArray(type) {
            return(_airtower.getListenersArray(type));
        }
        function onAirtowerResponse(eventData, type, overrideBlock) {
            _airtower.onAirtowerResponse(eventData, type, overrideBlock);
        }
        function setUsername(in_username) {
            _airtower.setUsername(in_username);
        }
        function setPlayerId(in_playerId) {
            _airtower.setPlayerId(in_playerId);
        }
        function connectToLogin(in_username, in_pass, login_response, doAutoLogin) {
            _airtower.connectToLogin(in_username, in_pass, login_response, doAutoLogin);
        }
        function handleLostConnection() {
            _airtower.handleLostConnection();
        }
        function handleLoginConnection(success) {
            _airtower.handleLoginConnection(success);
        }
        function handleLoginRandomKey(key) {
            _airtower.handleLoginRandomKey(key);
        }
        function login() {
            _airtower.login();
        }
        function handleOnLogin(obj) {
            _airtower.handleOnLogin(obj);
        }
        function connectToRedemption(server_ip, server_port, connect_to_world_response) {
            _airtower.connectToRedemption(server_ip, server_port, connect_to_world_response);
        }
        function connectToWorld(server_ip, server_port, connect_to_world_response, loginKey) {
            _airtower.connectToWorld(server_ip, server_port, connect_to_world_response, loginKey);
        }
        function handleWorldConnection(success) {
            _airtower.handleWorldConnection(success);
        }
        function handleWorldRandomKey(key) {
            _airtower.handleWorldRandomKey(key);
        }
        function worldLogin() {
            _airtower.worldLogin();
        }
        function joinWorld() {
            _airtower.joinWorld();
        }
        function handleJoinRedemption(obj) {
            _airtower.handleJoinRedemption(obj);
        }
        function handleJoinWorld(obj) {
            _airtower.handleJoinWorld(obj);
        }
        function send(extension, command, arr, type, room_id) {
            _airtower.send(extension, command, arr, type, room_id);
        }
        function disconnect(disconnectFriends) {
            _airtower.disconnect(disconnectFriends);
        }
        function getLoginHash() {
            return(_airtower.getLoginHash());
        }
        function hex_md5(s) {
            return(_airtower.hex_md5(s));
        }
        function encryptPassword(pass) {
            return(_airtower.encryptPassword(pass));
        }
        function isBlocked() {
            return(_airtower.isBlocked());
        }
        function block() {
            _airtower.block();
        }
        function unblock() {
            _airtower.unblock();
        }
        function toString() {
            return(("ProxyAirtower[" + _airtower.debugName) + "]");
        }
    }
