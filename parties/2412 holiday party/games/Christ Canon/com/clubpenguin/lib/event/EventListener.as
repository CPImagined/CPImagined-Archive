class com.clubpenguin.lib.event.EventListener
{
   var handler;
   var scope;
   function EventListener(_handler, _scope)
   {
      this.handler = _handler;
      this.scope = _scope;
   }
   function toString()
   {
      return "EventListener with scope (" + this.scope + ")";
   }
}
