﻿var doc=fl.getDocumentDOM();
var tl=doc.getTimeline();
var lib=doc.library;
var newSel=new Array();
var si,li,ci,pi,tx,r0,nr,cx,cy,el,sm;

//linkage
li=lib.items[lib.findItemIndex("Symbol_1")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="sound_truckReverse";
li=lib.items[lib.findItemIndex("Symbol_2")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="sound_truck";
li=lib.items[lib.findItemIndex("Symbol_3")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="sound_toonhit";
li=lib.items[lib.findItemIndex("Symbol_4")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="sound_switch";
li=lib.items[lib.findItemIndex("Symbol_5")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="sound_fish";
li=lib.items[lib.findItemIndex("Symbol_6")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="sound_splop";
li=lib.items[lib.findItemIndex("Symbol_7")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="sound_powerUpPickUp";
li=lib.items[lib.findItemIndex("Symbol_8")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="sound_poof";
li=lib.items[lib.findItemIndex("Symbol_9")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="backgroundLoop";
li=lib.items[lib.findItemIndex("Symbol_10")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="sound_vase";
li=lib.items[lib.findItemIndex("Symbol_11")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="sound_anvil";
li=lib.items[lib.findItemIndex("Symbol_12")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="sound_boing";
li=lib.items[lib.findItemIndex("Symbol_13")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="sound_beanbagPlace";
li=lib.items[lib.findItemIndex("Symbol_14")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="sound_beanbagLand";
li=lib.items[lib.findItemIndex("Symbol_16")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="unloaded_btn";
li=lib.items[lib.findItemIndex("Symbol_19")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="FloatingScore";
li=lib.items[lib.findItemIndex("Symbol_25")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="back_into_truck";
li=lib.items[lib.findItemIndex("Symbol_31")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="TryAgain";
li=lib.items[lib.findItemIndex("Symbol_43")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="CandyBackIntoTruckHolder";
li=lib.items[lib.findItemIndex("Symbol_50")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="CandyAirBag3Holder";
li=lib.items[lib.findItemIndex("Symbol_52")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="CandyAirBag2Holder";
li=lib.items[lib.findItemIndex("Symbol_54")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="CandyAirBag1Holder";
li=lib.items[lib.findItemIndex("Symbol_56")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="CandyAirbag0Holder";
li=lib.items[lib.findItemIndex("Symbol_60")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="AirBag3Holder";
li=lib.items[lib.findItemIndex("Symbol_62")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="AirBag2Holder";
li=lib.items[lib.findItemIndex("Symbol_64")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="AirBag1Holder";
li=lib.items[lib.findItemIndex("Symbol_66")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="Airbag0Holder";
li=lib.items[lib.findItemIndex("Symbol_170")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="CandyPenguinSprite";
li=lib.items[lib.findItemIndex("Symbol_173")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="BeanTimeHolder";
li=lib.items[lib.findItemIndex("Symbol_180")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="CandyFlowersHazard";
li=lib.items[lib.findItemIndex("Symbol_185")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="CandyFishHazard";
li=lib.items[lib.findItemIndex("Symbol_190")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="CandyAnvilHazard";
li=lib.items[lib.findItemIndex("Symbol_197")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="FlowersHazard";
li=lib.items[lib.findItemIndex("Symbol_203")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="AnvilHazard";
li=lib.items[lib.findItemIndex("Symbol_210")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="FishHazard";
li=lib.items[lib.findItemIndex("Symbol_213")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="1UpHolder";
li=lib.items[lib.findItemIndex("Symbol_214")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="StackBag";
li=lib.items[lib.findItemIndex("Symbol_238")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="CandyTruck";
li=lib.items[lib.findItemIndex("Symbol_298")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="ColorSign";
li=lib.items[lib.findItemIndex("Symbol_300")];
li.linkageExportForRS=true;
li.linkageExportInFirstFrame=true;
li.linkageIdentifier="CandyBagThread";

