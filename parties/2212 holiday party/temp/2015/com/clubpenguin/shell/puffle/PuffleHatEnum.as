class com.clubpenguin.shell.puffle.PuffleHatEnum extends com.clubpenguin.util.Enumeration
{
   static var EMPTY_HAT = new com.clubpenguin.shell.puffle.PuffleHatEnum("empty hat");
   static var ACTUAL_HAT = new com.clubpenguin.shell.puffle.PuffleHatEnum("actual hat");
   function PuffleHatEnum(name)
   {
      super();
      this._name = name;
   }
   function get name()
   {
      return this._name;
   }
   function toString()
   {
      return "[PuffleHatEnum name=\"" + this._name + "\"]";
   }
}
