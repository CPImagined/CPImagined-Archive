package org.osflash.signals
{
   public interface ISignal
   {
      function add(listener:Function) : Function;
      
      function addOnce(listener:Function) : Function;
      
      function remove(listener:Function) : Function;
      
      function get valueClasses() : Array;
      
      function get numListeners() : uint;
   }
}
