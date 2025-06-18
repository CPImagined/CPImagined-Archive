package com.clubpenguin.games.chase.movies
{
   import flash.display.MovieClip;
   
   public class PopupMC extends MovieClip
   {
      public var art:MovieClip;
      
      public function PopupMC()
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

