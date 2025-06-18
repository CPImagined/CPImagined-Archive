package com.clubpenguin.games.chase.movies
{
   import flash.display.MovieClip;
   
   public class PuffleMC extends MovieClip
   {
      public var art:MovieClip;
      
      public function PuffleMC()
      {
         super();
      }
      
      public function setArtMain(param1:String) : void
      {
         this.art.gotoAndStop(param1);
      }
      
      public function setArtSub(param1:String) : void
      {
         this.art.art.gotoAndStop(param1);
      }
   }
}

