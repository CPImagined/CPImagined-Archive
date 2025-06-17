import com.clubpenguin.ui.views.AbstractViewManager;
interface com.clubpenguin.ui.views.IView extends com.clubpenguin.util.IEventDispatcher
{
	function setLanguageAbbr(abbr: String): Void
	function setShell(target: MovieClip): Void
    function setViewManager(manager: AbstractViewManager) : Void
    function getViewManager(): AbstractViewManager
	function hide(): Void
	function show(): Void
}
