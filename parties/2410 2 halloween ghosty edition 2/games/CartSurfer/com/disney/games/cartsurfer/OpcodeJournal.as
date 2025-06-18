class com.disney.games.cartsurfer.OpcodeJournal
{
   static var CP_CART_SURFER = "9C34F886-0912-FA63-97CA-DFECE917FE8E";
   static var CS_JUMP = "1A83739B-8929-218A-ACCF-A363B6C6B8F3";
   static var CS_LEAN_LEFT = "B6EDE331-286D-4A26-E41D-963A96F9254B";
   static var CS_LEAN_RIGHT = "E53E5BCB-3738-9630-CF84-AFE000322B39";
   static var CS_JUMP_360_SPIN_LEFT = "3FEE839F-950A-C176-706E-2DCDA43E580F";
   static var CS_JUMP_360_SPIN_RIGHT = "06F9646C-F4B5-7ACE-8596-7DCB41F6390C";
   static var CS_CART_SLAM = "A156A367-01FD-D3DA-341A-F7E4943F0B6E";
   static var CS_FLAP_WINGS = "C23E5855-40D7-CF2E-E106-54EB29C9D84E";
   static var CS_SURF_OLLIE = "9388C6BD-CC88-DCF8-7837-6BA813521F2E";
   static var CS_SURF_RAIL_SLIDE_LEFT = "C7C6BEB1-CE42-6824-9D49-90980FFFE737";
   static var CS_SURF_RAIL_SLIDE_RIGHT = "C1B1E6A6-7782-7860-857D-9AF2704CBB5A";
   static var CS_SURF_HANDSTAND = "AADBCFD2-D4A0-FE4F-C299-A8E80E2D8873";
   static var CS_WHEELIE_BACKFLIP = "2E87A919-D874-7AD7-BCA9-95983520861A";
   static var CS_WHEELIE_GRIND_LEFT = "40456893-6C21-DB83-3CE4-16A26E755EF4";
   static var CS_WHEELIE_GRIND_RIGHT = "EC061A35-4E86-C17C-CC09-97AAA3BC69F5";
   static var CS_WHEELIE_RUN_WITH_CART = "AB2FC670-9EF5-5616-564A-E844229E33A3";
   static var CS_BLACK_PUFFLE_IN_GAME = "5AF7A0C7-A73E-55B8-29C3-41EEEEB8B520";
   static var CS_INSTRUCTIONS = "85F9136B-E212-7230-CE79-B68BB4DCCA55";
   static var ST_CART_PRO = "DFB1D6A1-566A-8996-46F6-06371CBBB105";
   static var ST_CART_EXPERT = "CBDE7A0E-D51C-AB64-5D20-392E21F322CE";
   static var ST_CART_MASTER = "C104E1AD-5A85-FB34-74AD-5FAD84F5907E";
   static var ST_GREAT_BALANCE = "1B331C09-F91D-05DB-0C5E-AB8307315B21";
   static var ST_MINE_MARVEL = "7D825A71-9CFE-71BF-C2B7-A15B876E8EC9";
   static var ST_MINE_MISSION = "744D6F6F-E780-87C7-C05A-9F126E2865FC";
   static var ST_TRICK_MASTER = "5A21FBBA-7CCD-5B40-BCE5-47DDF0D5F2AF";
   static var ST_MINE_GRIND = "35CDDE88-190E-90B9-A9FE-8C2AAB8B4B19";
   static var ST_SURFS_UP = "6CC6125E-DEF3-EE3B-C35D-AF3E6A0B4EE4";
   static var ST_FLIP_MANIA = "F135120D-8465-FDA3-FE30-333FA0F1EE2A";
   static var ST_ULTIMATE_DUO = "C1031B61-9025-162C-84DD-48A6D4E58BD2";
   static var ST_PUFFLE_POWER = "AB793606-BA4C-0F9F-05C0-DEFB0F046F83";
   var arrStampsSent = new Array();
   var trickArray = new Array();
   var CART_SURFER_OPCODES = [com.disney.games.cartsurfer.OpcodeJournal.CP_CART_SURFER,com.disney.games.cartsurfer.OpcodeJournal.CS_JUMP,com.disney.games.cartsurfer.OpcodeJournal.CS_LEAN_LEFT,com.disney.games.cartsurfer.OpcodeJournal.CS_LEAN_RIGHT,com.disney.games.cartsurfer.OpcodeJournal.CS_JUMP_360_SPIN_LEFT,com.disney.games.cartsurfer.OpcodeJournal.CS_JUMP_360_SPIN_RIGHT,com.disney.games.cartsurfer.OpcodeJournal.CS_CART_SLAM,com.disney.games.cartsurfer.OpcodeJournal.CS_FLAP_WINGS,com.disney.games.cartsurfer.OpcodeJournal.CS_SURF_OLLIE,com.disney.games.cartsurfer.OpcodeJournal.CS_SURF_RAIL_SLIDE_LEFT,com.disney.games.cartsurfer.OpcodeJournal.CS_SURF_RAIL_SLIDE_RIGHT,com.disney.games.cartsurfer.OpcodeJournal.CS_SURF_HANDSTAND,com.disney.games.cartsurfer.OpcodeJournal.CS_WHEELIE_BACKFLIP,com.disney.games.cartsurfer.OpcodeJournal.CS_WHEELIE_GRIND_LEFT,com.disney.games.cartsurfer.OpcodeJournal.CS_WHEELIE_GRIND_RIGHT,com.disney.games.cartsurfer.OpcodeJournal.CS_WHEELIE_RUN_WITH_CART,com.disney.games.cartsurfer.OpcodeJournal.CS_BLACK_PUFFLE_IN_GAME,com.disney.games.cartsurfer.OpcodeJournal.CS_INSTRUCTIONS];
   var CART_SURFER_STAMPS = [com.disney.games.cartsurfer.OpcodeJournal.ST_CART_PRO,com.disney.games.cartsurfer.OpcodeJournal.ST_CART_EXPERT,com.disney.games.cartsurfer.OpcodeJournal.ST_CART_MASTER,com.disney.games.cartsurfer.OpcodeJournal.ST_GREAT_BALANCE,com.disney.games.cartsurfer.OpcodeJournal.ST_MINE_MARVEL,com.disney.games.cartsurfer.OpcodeJournal.ST_MINE_MISSION,com.disney.games.cartsurfer.OpcodeJournal.ST_TRICK_MASTER,com.disney.games.cartsurfer.OpcodeJournal.ST_MINE_GRIND,com.disney.games.cartsurfer.OpcodeJournal.ST_SURFS_UP,com.disney.games.cartsurfer.OpcodeJournal.ST_FLIP_MANIA,com.disney.games.cartsurfer.OpcodeJournal.ST_ULTIMATE_DUO,com.disney.games.cartsurfer.OpcodeJournal.ST_PUFFLE_POWER];
   function OpcodeJournal()
   {
   }
   function checkForTrick(trick)
   {
      var _loc3_ = false;
      if(this.trickArray.length > 0)
      {
         var _loc2_ = 0;
         while(_loc2_ < this.trickArray.length)
         {
            if(String(this.trickArray[_loc2_]) == trick)
            {
               _loc3_ = true;
               return true;
            }
            _loc2_ = _loc2_ + 1;
         }
      }
      if(_loc3_ == false)
      {
         this.trickArray.push(trick);
         return false;
      }
   }
   function checkOpcodeActivity(stamp)
   {
      var _loc3_ = false;
      if(this.arrStampsSent.length > 0)
      {
         var _loc2_ = 0;
         while(_loc2_ < this.arrStampsSent.length)
         {
            if(Number(this.arrStampsSent[_loc2_]) == stamp)
            {
               _loc3_ == true;
               return true;
            }
            _loc2_ = _loc2_ + 1;
         }
      }
      if(_loc3_ == false)
      {
         this.arrStampsSent.push(stamp);
         return false;
      }
   }
   function sendStampOpcodes(stamp)
   {
      var _loc2_ = -1;
      if(this.checkOpcodeActivity(stamp) == false)
      {
         switch(stamp)
         {
            case 206:
               _loc2_ = 0;
               break;
            case 208:
               _loc2_ = 1;
               break;
            case 210:
               _loc2_ = 2;
               break;
            case 212:
               _loc2_ = 3;
               break;
            case 214:
               _loc2_ = 4;
               break;
            case 216:
               _loc2_ = 5;
               break;
            case 218:
               _loc2_ = 6;
               break;
            case 220:
               _loc2_ = 7;
               break;
            case 222:
               _loc2_ = 8;
               break;
            case 224:
               _loc2_ = 9;
               break;
            case 226:
               _loc2_ = 10;
               break;
            case 226:
               _loc2_ = 11;
         }
         this.sendStampAction(_loc2_);
      }
   }
   function sendFeatureOpcodes(feature)
   {
      var _loc2_ = -1;
      if(this.checkForTrick(feature) == false)
      {
         switch(feature)
         {
            case "jump":
               _loc2_ = 1;
               break;
            case "lean_left":
               _loc2_ = 2;
               break;
            case "lean_right":
               _loc2_ = 3;
               break;
            case "360_left":
               _loc2_ = 4;
               break;
            case "360_right":
               _loc2_ = 5;
               break;
            case "slam":
               _loc2_ = 6;
               break;
            case "flap_wings":
               _loc2_ = 7;
               break;
            case "olie":
               _loc2_ = 8;
               break;
            case "slide_left":
               _loc2_ = 9;
               break;
            case "slide_right":
               _loc2_ = 10;
               break;
            case "handstand":
               _loc2_ = 11;
               break;
            case "backflip":
               _loc2_ = 12;
               break;
            case "grind_left":
               _loc2_ = 13;
               break;
            case "grind_right":
               _loc2_ = 14;
               break;
            case "run_with_cart":
               _loc2_ = 15;
               break;
            case "black_puffle":
               _loc2_ = 16;
               break;
            case "instructions":
               _loc2_ = 17;
               break;
            default:
               _loc2_ = -1;
         }
         this.sendActionCode(_loc2_);
      }
   }
   function init(playerID)
   {
      com.disney.dlearning.managers.DLSManager.init(String(playerID),"cs.k.api.dlsnetwork.com");
   }
   function startGame()
   {
      com.disney.dlearning.managers.DLSManager.instance.pushOpcode("start",this.CART_SURFER_OPCODES[0],this.dlsmCallback,"0");
   }
   function stopGame()
   {
      com.disney.dlearning.managers.DLSManager.instance.pushOpcode("stop",this.CART_SURFER_OPCODES[0],this.dlsmCallback,"0");
   }
   function sendGameScore(status, score, coins)
   {
      com.disney.dlearning.managers.DLSManager.instance.pushOpcode("gamescore",this.CART_SURFER_OPCODES[0],this.dlsmCallback,String(score),status,String(coins));
   }
   function sendActionCode(type)
   {
      com.disney.dlearning.managers.DLSManager.instance.pushOpcode("selected",this.CART_SURFER_OPCODES[type],this.dlsmCallback,"0","0","0");
   }
   function sendStampAction(type)
   {
      com.disney.dlearning.managers.DLSManager.instance.pushOpcode("selected",this.CART_SURFER_STAMPS[type],this.dlsmCallback,"0","0","0");
   }
   function dlsmCallback(stringArg)
   {
   }
}
