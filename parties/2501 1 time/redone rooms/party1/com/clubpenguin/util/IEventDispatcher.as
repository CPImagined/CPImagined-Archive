//Created by Action Script Viewer - https://www.buraks.com/asv
interface com.clubpenguin.util.IEventDispatcher {
	function addEventListener(type, func, scope);
	function removeEventListener(type, func, scope);
	function updateListeners(type, event);
	function dispatchEvent(event);
}