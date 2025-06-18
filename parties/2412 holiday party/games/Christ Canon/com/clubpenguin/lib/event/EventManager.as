class com.clubpenguin.lib.event.EventManager implements com.clubpenguin.lib.event.IEventDispatcher
{
   var __uid;
   var __listenerObjects;
   static var $_instance;
   static var $_instanceCount = 0;
   function EventManager()
   {
      this.__uid = com.clubpenguin.lib.event.EventManager.$_instanceCount++;
      this.__listenerObjects = new Array();
   }
   static function get instance()
   {
      if(com.clubpenguin.lib.event.EventManager.$_instance == null)
      {
         com.clubpenguin.lib.event.EventManager.$_instance = new com.clubpenguin.lib.event.EventManager();
      }
      return com.clubpenguin.lib.event.EventManager.$_instance;
   }
   static function addEventListener(_eventType, _handler, _scope, _context)
   {
      var _loc1_ = undefined;
      _loc1_ = com.clubpenguin.lib.event.EventManager.instance.addInternalEventListener(_eventType,_handler,_scope,_context);
      return _loc1_;
   }
   function addInternalEventListener(_eventType, _handler, _scope, _context)
   {
      var _loc4_ = undefined;
      _loc4_ = false;
      if(!_eventType.length)
      {
         trace("## ERROR ## EventManager.addEventListener(): eventType missing. eventType: " + _eventType);
      }
      if(!(_handler instanceof Function))
      {
         trace("## ERROR ## EventManager.addEventListener(): handler missing. eventType: " + _eventType + ", handler: " + _handler);
      }
      var _loc3_ = undefined;
      var _loc6_ = undefined;
      var _loc2_ = undefined;
      if(_context == null)
      {
         _loc2_ = this;
      }
      else
      {
         _loc2_ = _context;
      }
      _loc3_ = com.clubpenguin.lib.event.EventManager.getListenersArray(_loc2_,_eventType);
      _loc6_ = com.clubpenguin.lib.event.EventManager.getListenerIndex(_loc3_,_handler,_scope);
      if(_loc6_ == -1)
      {
         _loc3_.push(new com.clubpenguin.lib.event.EventListener(_handler,_scope));
         _loc4_ = true;
      }
      return _loc4_;
   }
   static function removeEventListener(_eventType, _handler, _scope)
   {
      var _loc1_ = undefined;
      _loc1_ = com.clubpenguin.lib.event.EventManager.instance.removeInternalEventListener(_eventType,_handler,_scope);
      return _loc1_;
   }
   function removeInternalEventListener(_eventType, _handler, _scope)
   {
      var _loc4_ = undefined;
      _loc4_ = false;
      if(!_eventType.length)
      {
         trace("## ERROR ## EventManager.removeEventListener(): eventType missing. eventType: " + _eventType);
      }
      if(!(_handler instanceof Function))
      {
         trace("## ERROR ## EventManager.removeEventListener(): handler missing. eventType: " + _eventType + ", handler: " + _handler);
      }
      var _loc3_ = undefined;
      var _loc2_ = undefined;
      _loc3_ = com.clubpenguin.lib.event.EventManager.getListenersArray(this,_eventType);
      _loc2_ = com.clubpenguin.lib.event.EventManager.getListenerIndex(_loc3_,_handler,_scope);
      if(_loc2_ != -1)
      {
         _loc3_.splice(_loc2_,1);
         _loc4_ = true;
      }
      return _loc4_;
   }
   static function dispatchEvent(_event)
   {
      var _loc1_ = undefined;
      _loc1_ = com.clubpenguin.lib.event.EventManager.instance.dispatchInternalEvent(_event);
      return _loc1_;
   }
   function dispatchInternalEvent(_event)
   {
      var _loc7_ = undefined;
      var _loc8_ = undefined;
      _loc7_ = false;
      if(!_event.type.length)
      {
         trace("## ERROR ## EventManager.dispatchEvent(): event.type missing. event.type: " + _event.type);
      }
      _loc8_ = _event.target.getUniqueName();
      if(_loc8_ == undefined || _loc8_ == "")
      {
         _event.target = this;
      }
      var _loc6_ = undefined;
      var _loc5_ = undefined;
      var _loc9_ = undefined;
      var _loc3_ = undefined;
      var _loc2_ = undefined;
      _loc6_ = com.clubpenguin.lib.event.EventManager.getListenersArray(this,_event.type).concat();
      if(_event.target.getUniqueName() == this.getUniqueName())
      {
         _loc5_ = new Array();
      }
      else
      {
         _loc5_ = com.clubpenguin.lib.event.EventManager.getListenersArray(_event.target,_event.type).concat();
      }
      _loc9_ = _loc6_.length + _loc5_.length;
      if(_loc9_ > 0)
      {
         _loc7_ = true;
         _loc3_ = 0;
         while(_loc3_ < _loc6_.length)
         {
            _loc2_ = _loc6_[_loc3_];
            !!_loc2_.scope ? _loc2_.handler.call(_loc2_.scope,_event) : _loc2_.handler(_event);
            _loc3_ += 1;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc5_.length)
         {
            _loc2_ = _loc5_[_loc3_];
            !!_loc2_.scope ? _loc2_.handler.call(_loc2_.scope,_event) : _loc2_.handler(_event);
            _loc3_ += 1;
         }
      }
      return _loc7_;
   }
   static function getListenerIndex(_listeners, _handler, _scope)
   {
      var _loc5_ = _listeners.length;
      var _loc1_ = 0;
      var _loc2_ = undefined;
      var _loc4_ = undefined;
      _loc4_ = -1;
      _loc1_ = 0;
      while(_loc1_ < _loc5_)
      {
         _loc2_ = _listeners[_loc1_];
         if(_loc2_.handler == _handler && (_scope == undefined || _loc2_.scope == _scope))
         {
            _loc4_ = _loc1_;
         }
         _loc1_ += 1;
      }
      return _loc4_;
   }
   static function getListenersArray(_eventSource, _eventType)
   {
      var _loc1_ = undefined;
      _loc1_ = com.clubpenguin.lib.event.EventManager.instance.listenerObject(_eventSource.getUniqueName());
      if(!_loc1_[_eventType])
      {
         _loc1_[_eventType] = new Array();
      }
      return _loc1_[_eventType];
   }
   function listenerObject(_context)
   {
      if(this.__listenerObjects[_context] == null)
      {
         this.__listenerObjects[_context] = new Array();
      }
      return this.__listenerObjects[_context];
   }
   function getUniqueName()
   {
      return "[EventManager<" + this.__uid + ">]";
   }
   static function dispose()
   {
      com.clubpenguin.lib.event.EventManager.instance.__listenerObjects = new Array();
      com.clubpenguin.lib.event.EventManager.instance.dispatchInternalEvent(new com.clubpenguin.game.net.event.NetClientEvent(new com.clubpenguin.lib.event.IEventDispatcher(),com.clubpenguin.game.net.event.NetClientEvent.NET_REQUEST));
   }
}
