var doc=fl.getDocumentDOM();
var tl=doc.getTimeline();
var lib=doc.library;
var newSel=new Array();
var si,li,ci,pi,tx,r0,nr,cx,cy,el,sm;

//create library
//sound_1.mp3 saved. character ID:1
si=lib.findItemIndex("sound_1.mp3");
if (si=='') {si=lib.findItemIndex("sound_1");}
lib.items[si].name="Symbol_1";
si=lib.findItemIndex("Symbol_1");
//sound_2.mp3 saved. character ID:2
si=lib.findItemIndex("sound_2.mp3");
if (si=='') {si=lib.findItemIndex("sound_2");}
lib.items[si].name="Symbol_2";
si=lib.findItemIndex("Symbol_2");
//sound_3.mp3 saved. character ID:3
si=lib.findItemIndex("sound_3.mp3");
if (si=='') {si=lib.findItemIndex("sound_3");}
lib.items[si].name="Symbol_3";
si=lib.findItemIndex("Symbol_3");
//sound_4.mp3 saved. character ID:4
si=lib.findItemIndex("sound_4.mp3");
if (si=='') {si=lib.findItemIndex("sound_4");}
lib.items[si].name="Symbol_4";
si=lib.findItemIndex("Symbol_4");
//sound_5.mp3 saved. character ID:5
si=lib.findItemIndex("sound_5.mp3");
if (si=='') {si=lib.findItemIndex("sound_5");}
lib.items[si].name="Symbol_5";
si=lib.findItemIndex("Symbol_5");
//sound_6.mp3 saved. character ID:6
si=lib.findItemIndex("sound_6.mp3");
if (si=='') {si=lib.findItemIndex("sound_6");}
lib.items[si].name="Symbol_6";
si=lib.findItemIndex("Symbol_6");
//sound_7.mp3 saved. character ID:7
si=lib.findItemIndex("sound_7.mp3");
if (si=='') {si=lib.findItemIndex("sound_7");}
lib.items[si].name="Symbol_7";
si=lib.findItemIndex("Symbol_7");
//sound_8.mp3 saved. character ID:8
si=lib.findItemIndex("sound_8.mp3");
if (si=='') {si=lib.findItemIndex("sound_8");}
lib.items[si].name="Symbol_8";
si=lib.findItemIndex("Symbol_8");
//sound_9.mp3 saved. character ID:9
si=lib.findItemIndex("sound_9.mp3");
if (si=='') {si=lib.findItemIndex("sound_9");}
lib.items[si].name="Symbol_9";
si=lib.findItemIndex("Symbol_9");
//sound_10.mp3 saved. character ID:10
si=lib.findItemIndex("sound_10.mp3");
if (si=='') {si=lib.findItemIndex("sound_10");}
lib.items[si].name="Symbol_10";
si=lib.findItemIndex("Symbol_10");
//sound_11.mp3 saved. character ID:11
si=lib.findItemIndex("sound_11.mp3");
if (si=='') {si=lib.findItemIndex("sound_11");}
lib.items[si].name="Symbol_11";
si=lib.findItemIndex("Symbol_11");
//sound_12.mp3 saved. character ID:12
si=lib.findItemIndex("sound_12.mp3");
if (si=='') {si=lib.findItemIndex("sound_12");}
lib.items[si].name="Symbol_12";
si=lib.findItemIndex("Symbol_12");
//sound_13.mp3 saved. character ID:13
si=lib.findItemIndex("sound_13.mp3");
if (si=='') {si=lib.findItemIndex("sound_13");}
lib.items[si].name="Symbol_13";
si=lib.findItemIndex("Symbol_13");
//sound_14.mp3 saved. character ID:14
si=lib.findItemIndex("sound_14.mp3");
if (si=='') {si=lib.findItemIndex("sound_14");}
lib.items[si].name="Symbol_14";
si=lib.findItemIndex("Symbol_14");
//symbol_15.swf saved. character ID:15
si=lib.findItemIndex("symbol_15.swf");
if (si=='') {si=lib.findItemIndex("symbol_15");}
lib.items[si].name="Symbol_15";
si=lib.findItemIndex("Symbol_15");
//symbol_20.swf saved. character ID:20
si=lib.findItemIndex("symbol_20.swf");
if (si=='') {si=lib.findItemIndex("symbol_20");}
lib.items[si].name="Symbol_20";
si=lib.findItemIndex("Symbol_20");
//symbol_21.swf saved. character ID:21
si=lib.findItemIndex("symbol_21.swf");
if (si=='') {si=lib.findItemIndex("symbol_21");}
lib.items[si].name="Symbol_21";
si=lib.findItemIndex("Symbol_21");
//symbol_22.swf saved. character ID:22
si=lib.findItemIndex("symbol_22.swf");
if (si=='') {si=lib.findItemIndex("symbol_22");}
lib.items[si].name="Symbol_22";
si=lib.findItemIndex("Symbol_22");
//symbol_28.swf saved. character ID:28
si=lib.findItemIndex("symbol_28.swf");
if (si=='') {si=lib.findItemIndex("symbol_28");}
lib.items[si].name="Symbol_28";
si=lib.findItemIndex("Symbol_28");
li=lib.items[lib.findItemIndex("Symbol_28")];
li.symbolType="movie clip";
lib.editItem("Symbol_28");
tl=doc.getTimeline();
doc.selectAll();
doc.breakApart();
el=tl.layers[0].frames[0].elements;
if (el.length==1){
el[0].setTextAttr("bold", false);
el[0].setTextAttr("italic", false);
el[0].setTextAttr("face", el[0].getTextAttr("face"));
}
el=tl.layers[0].frames[0].elements;
for(var n=0;n<el.length;n++){
tx=el[n];
tx.fontRenderingMode="standard";
}
if (el.length==1){
el[0].setTextAttr("alignment", "left");
el[0].setTextAttr("letterSpacing", -0.1);
el[0].setTextAttr("autoKern", true);
}
doc.exitEditMode();
tl=doc.getTimeline();
//symbol_29.swf saved. character ID:29
si=lib.findItemIndex("symbol_29.swf");
if (si=='') {si=lib.findItemIndex("symbol_29");}
lib.items[si].name="Symbol_29";
si=lib.findItemIndex("Symbol_29");
li=lib.items[lib.findItemIndex("Symbol_29")];
li.symbolType="movie clip";
lib.editItem("Symbol_29");
tl=doc.getTimeline();
doc.selectAll();
doc.breakApart();
el=tl.layers[0].frames[0].elements;
if (el.length==1){
el[0].setTextAttr("bold", false);
el[0].setTextAttr("italic", false);
el[0].setTextAttr("face", el[0].getTextAttr("face"));
}
el=tl.layers[0].frames[0].elements;
for(var n=0;n<el.length;n++){
tx=el[n];
tx.fontRenderingMode="standard";
}
if (el.length==1){
el[0].setTextAttr("alignment", "left");
el[0].setTextAttr("letterSpacing", 0);
el[0].setTextAttr("autoKern", false);
}
doc.exitEditMode();
tl=doc.getTimeline();
//symbol_30.swf saved. character ID:30
si=lib.findItemIndex("symbol_30.swf");
if (si=='') {si=lib.findItemIndex("symbol_30");}
lib.items[si].name="Symbol_30";
si=lib.findItemIndex("Symbol_30");
li=lib.items[lib.findItemIndex("Symbol_30")];
li.symbolType="movie clip";
lib.editItem("Symbol_30");
tl=doc.getTimeline();
doc.selectAll();
doc.breakApart();
el=tl.layers[0].frames[0].elements;
if (el.length==1){
el[0].setTextAttr("bold", false);
el[0].setTextAttr("italic", false);
el[0].setTextAttr("face", el[0].getTextAttr("face"));
}
el=tl.layers[0].frames[0].elements;
for(var n=0;n<el.length;n++){
tx=el[n];
tx.fontRenderingMode="standard";
}
if (el.length==1){
el[0].setTextAttr("alignment", "left");
el[0].setTextAttr("letterSpacing", -0.1);
el[0].setTextAttr("autoKern", true);
}
doc.exitEditMode();
tl=doc.getTimeline();
//symbol_32.swf saved. character ID:32
si=lib.findItemIndex("symbol_32.swf");
if (si=='') {si=lib.findItemIndex("symbol_32");}
lib.items[si].name="Symbol_32";
si=lib.findItemIndex("Symbol_32");
//symbol_34.swf saved. character ID:34
si=lib.findItemIndex("symbol_34.swf");
if (si=='') {si=lib.findItemIndex("symbol_34");}
lib.items[si].name="Symbol_34";
si=lib.findItemIndex("Symbol_34");
//symbol_35.swf saved. character ID:35
si=lib.findItemIndex("symbol_35.swf");
if (si=='') {si=lib.findItemIndex("symbol_35");}
lib.items[si].name="Symbol_35";
si=lib.findItemIndex("Symbol_35");
//symbol_37.swf saved. character ID:37
si=lib.findItemIndex("symbol_37.swf");
if (si=='') {si=lib.findItemIndex("symbol_37");}
lib.items[si].name="Symbol_37";
si=lib.findItemIndex("Symbol_37");
//symbol_38.swf saved. character ID:38
si=lib.findItemIndex("symbol_38.swf");
if (si=='') {si=lib.findItemIndex("symbol_38");}
lib.items[si].name="Symbol_38";
si=lib.findItemIndex("Symbol_38");
//symbol_40.swf saved. character ID:40
si=lib.findItemIndex("symbol_40.swf");
if (si=='') {si=lib.findItemIndex("symbol_40");}
lib.items[si].name="Symbol_40";
si=lib.findItemIndex("Symbol_40");
//symbol_44.swf saved. character ID:44
si=lib.findItemIndex("symbol_44.swf");
if (si=='') {si=lib.findItemIndex("symbol_44");}
lib.items[si].name="Symbol_44";
si=lib.findItemIndex("Symbol_44");
//symbol_46.swf saved. character ID:46
si=lib.findItemIndex("symbol_46.swf");
if (si=='') {si=lib.findItemIndex("symbol_46");}
lib.items[si].name="Symbol_46";
si=lib.findItemIndex("Symbol_46");
//symbol_57.swf saved. character ID:57
si=lib.findItemIndex("symbol_57.swf");
if (si=='') {si=lib.findItemIndex("symbol_57");}
lib.items[si].name="Symbol_57";
si=lib.findItemIndex("Symbol_57");
//symbol_67.swf saved. character ID:67
si=lib.findItemIndex("symbol_67.swf");
if (si=='') {si=lib.findItemIndex("symbol_67");}
lib.items[si].name="Symbol_67";
si=lib.findItemIndex("Symbol_67");
//symbol_68.swf saved. character ID:68
si=lib.findItemIndex("symbol_68.swf");
if (si=='') {si=lib.findItemIndex("symbol_68");}
lib.items[si].name="Symbol_68";
si=lib.findItemIndex("Symbol_68");
//symbol_70.swf saved. character ID:70
si=lib.findItemIndex("symbol_70.swf");
if (si=='') {si=lib.findItemIndex("symbol_70");}
lib.items[si].name="Symbol_70";
si=lib.findItemIndex("Symbol_70");
//symbol_71.swf saved. character ID:71
si=lib.findItemIndex("symbol_71.swf");
if (si=='') {si=lib.findItemIndex("symbol_71");}
lib.items[si].name="Symbol_71";
si=lib.findItemIndex("Symbol_71");
//symbol_72.swf saved. character ID:72
si=lib.findItemIndex("symbol_72.swf");
if (si=='') {si=lib.findItemIndex("symbol_72");}
lib.items[si].name="Symbol_72";
si=lib.findItemIndex("Symbol_72");
//symbol_74.swf saved. character ID:74
si=lib.findItemIndex("symbol_74.swf");
if (si=='') {si=lib.findItemIndex("symbol_74");}
lib.items[si].name="Symbol_74";
si=lib.findItemIndex("Symbol_74");
//symbol_76.swf saved. character ID:76
si=lib.findItemIndex("symbol_76.swf");
if (si=='') {si=lib.findItemIndex("symbol_76");}
lib.items[si].name="Symbol_76";
si=lib.findItemIndex("Symbol_76");
//symbol_78.swf saved. character ID:78
si=lib.findItemIndex("symbol_78.swf");
if (si=='') {si=lib.findItemIndex("symbol_78");}
lib.items[si].name="Symbol_78";
si=lib.findItemIndex("Symbol_78");
//symbol_79.swf saved. character ID:79
si=lib.findItemIndex("symbol_79.swf");
if (si=='') {si=lib.findItemIndex("symbol_79");}
lib.items[si].name="Symbol_79";
si=lib.findItemIndex("Symbol_79");
//symbol_80.swf saved. character ID:80
si=lib.findItemIndex("symbol_80.swf");
if (si=='') {si=lib.findItemIndex("symbol_80");}
lib.items[si].name="Symbol_80";
si=lib.findItemIndex("Symbol_80");
//symbol_82.swf saved. character ID:82
si=lib.findItemIndex("symbol_82.swf");
if (si=='') {si=lib.findItemIndex("symbol_82");}
lib.items[si].name="Symbol_82";
si=lib.findItemIndex("Symbol_82");
//symbol_84.swf saved. character ID:84
si=lib.findItemIndex("symbol_84.swf");
if (si=='') {si=lib.findItemIndex("symbol_84");}
lib.items[si].name="Symbol_84";
si=lib.findItemIndex("Symbol_84");
//symbol_86.swf saved. character ID:86
si=lib.findItemIndex("symbol_86.swf");
if (si=='') {si=lib.findItemIndex("symbol_86");}
lib.items[si].name="Symbol_86";
si=lib.findItemIndex("Symbol_86");
//symbol_87.swf saved. character ID:87
si=lib.findItemIndex("symbol_87.swf");
if (si=='') {si=lib.findItemIndex("symbol_87");}
lib.items[si].name="Symbol_87";
si=lib.findItemIndex("Symbol_87");
//symbol_88.swf saved. character ID:88
si=lib.findItemIndex("symbol_88.swf");
if (si=='') {si=lib.findItemIndex("symbol_88");}
lib.items[si].name="Symbol_88";
si=lib.findItemIndex("Symbol_88");
//symbol_90.swf saved. character ID:90
si=lib.findItemIndex("symbol_90.swf");
if (si=='') {si=lib.findItemIndex("symbol_90");}
lib.items[si].name="Symbol_90";
si=lib.findItemIndex("Symbol_90");
//symbol_92.swf saved. character ID:92
si=lib.findItemIndex("symbol_92.swf");
if (si=='') {si=lib.findItemIndex("symbol_92");}
lib.items[si].name="Symbol_92";
si=lib.findItemIndex("Symbol_92");
//symbol_94.swf saved. character ID:94
si=lib.findItemIndex("symbol_94.swf");
if (si=='') {si=lib.findItemIndex("symbol_94");}
lib.items[si].name="Symbol_94";
si=lib.findItemIndex("Symbol_94");
//symbol_96.swf saved. character ID:96
si=lib.findItemIndex("symbol_96.swf");
if (si=='') {si=lib.findItemIndex("symbol_96");}
lib.items[si].name="Symbol_96";
si=lib.findItemIndex("Symbol_96");
//symbol_97.swf saved. character ID:97
si=lib.findItemIndex("symbol_97.swf");
if (si=='') {si=lib.findItemIndex("symbol_97");}
lib.items[si].name="Symbol_97";
si=lib.findItemIndex("Symbol_97");
//symbol_98.swf saved. character ID:98
si=lib.findItemIndex("symbol_98.swf");
if (si=='') {si=lib.findItemIndex("symbol_98");}
lib.items[si].name="Symbol_98";
si=lib.findItemIndex("Symbol_98");
//symbol_100.swf saved. character ID:100
si=lib.findItemIndex("symbol_100.swf");
if (si=='') {si=lib.findItemIndex("symbol_100");}
lib.items[si].name="Symbol_100";
si=lib.findItemIndex("Symbol_100");
//symbol_102.swf saved. character ID:102
si=lib.findItemIndex("symbol_102.swf");
if (si=='') {si=lib.findItemIndex("symbol_102");}
lib.items[si].name="Symbol_102";
si=lib.findItemIndex("Symbol_102");
//symbol_104.swf saved. character ID:104
si=lib.findItemIndex("symbol_104.swf");
if (si=='') {si=lib.findItemIndex("symbol_104");}
lib.items[si].name="Symbol_104";
si=lib.findItemIndex("Symbol_104");
//symbol_106.swf saved. character ID:106
si=lib.findItemIndex("symbol_106.swf");
if (si=='') {si=lib.findItemIndex("symbol_106");}
lib.items[si].name="Symbol_106";
si=lib.findItemIndex("Symbol_106");
//symbol_108.swf saved. character ID:108
si=lib.findItemIndex("symbol_108.swf");
if (si=='') {si=lib.findItemIndex("symbol_108");}
lib.items[si].name="Symbol_108";
si=lib.findItemIndex("Symbol_108");
//symbol_109.swf saved. character ID:109
si=lib.findItemIndex("symbol_109.swf");
if (si=='') {si=lib.findItemIndex("symbol_109");}
lib.items[si].name="Symbol_109";
si=lib.findItemIndex("Symbol_109");
//symbol_110.swf saved. character ID:110
si=lib.findItemIndex("symbol_110.swf");
if (si=='') {si=lib.findItemIndex("symbol_110");}
lib.items[si].name="Symbol_110";
si=lib.findItemIndex("Symbol_110");
//symbol_111.swf saved. character ID:111
si=lib.findItemIndex("symbol_111.swf");
if (si=='') {si=lib.findItemIndex("symbol_111");}
lib.items[si].name="Symbol_111";
si=lib.findItemIndex("Symbol_111");
//symbol_112.swf saved. character ID:112
si=lib.findItemIndex("symbol_112.swf");
if (si=='') {si=lib.findItemIndex("symbol_112");}
lib.items[si].name="Symbol_112";
si=lib.findItemIndex("Symbol_112");
//symbol_114.swf saved. character ID:114
si=lib.findItemIndex("symbol_114.swf");
if (si=='') {si=lib.findItemIndex("symbol_114");}
lib.items[si].name="Symbol_114";
si=lib.findItemIndex("Symbol_114");
//symbol_115.swf saved. character ID:115
si=lib.findItemIndex("symbol_115.swf");
if (si=='') {si=lib.findItemIndex("symbol_115");}
lib.items[si].name="Symbol_115";
si=lib.findItemIndex("Symbol_115");
//symbol_117.swf saved. character ID:117
si=lib.findItemIndex("symbol_117.swf");
if (si=='') {si=lib.findItemIndex("symbol_117");}
lib.items[si].name="Symbol_117";
si=lib.findItemIndex("Symbol_117");
//symbol_118.swf saved. character ID:118
si=lib.findItemIndex("symbol_118.swf");
if (si=='') {si=lib.findItemIndex("symbol_118");}
lib.items[si].name="Symbol_118";
si=lib.findItemIndex("Symbol_118");
//symbol_120.swf saved. character ID:120
si=lib.findItemIndex("symbol_120.swf");
if (si=='') {si=lib.findItemIndex("symbol_120");}
lib.items[si].name="Symbol_120";
si=lib.findItemIndex("Symbol_120");
//symbol_121.swf saved. character ID:121
si=lib.findItemIndex("symbol_121.swf");
if (si=='') {si=lib.findItemIndex("symbol_121");}
lib.items[si].name="Symbol_121";
si=lib.findItemIndex("Symbol_121");
//symbol_123.swf saved. character ID:123
si=lib.findItemIndex("symbol_123.swf");
if (si=='') {si=lib.findItemIndex("symbol_123");}
lib.items[si].name="Symbol_123";
si=lib.findItemIndex("Symbol_123");
//symbol_125.swf saved. character ID:125
si=lib.findItemIndex("symbol_125.swf");
if (si=='') {si=lib.findItemIndex("symbol_125");}
lib.items[si].name="Symbol_125";
si=lib.findItemIndex("Symbol_125");
//symbol_127.swf saved. character ID:127
si=lib.findItemIndex("symbol_127.swf");
if (si=='') {si=lib.findItemIndex("symbol_127");}
lib.items[si].name="Symbol_127";
si=lib.findItemIndex("Symbol_127");
//symbol_129.swf saved. character ID:129
si=lib.findItemIndex("symbol_129.swf");
if (si=='') {si=lib.findItemIndex("symbol_129");}
lib.items[si].name="Symbol_129";
si=lib.findItemIndex("Symbol_129");
//symbol_131.swf saved. character ID:131
si=lib.findItemIndex("symbol_131.swf");
if (si=='') {si=lib.findItemIndex("symbol_131");}
lib.items[si].name="Symbol_131";
si=lib.findItemIndex("Symbol_131");
//symbol_132.swf saved. character ID:132
si=lib.findItemIndex("symbol_132.swf");
if (si=='') {si=lib.findItemIndex("symbol_132");}
lib.items[si].name="Symbol_132";
si=lib.findItemIndex("Symbol_132");
//symbol_133.swf saved. character ID:133
si=lib.findItemIndex("symbol_133.swf");
if (si=='') {si=lib.findItemIndex("symbol_133");}
lib.items[si].name="Symbol_133";
si=lib.findItemIndex("Symbol_133");
//symbol_135.swf saved. character ID:135
si=lib.findItemIndex("symbol_135.swf");
if (si=='') {si=lib.findItemIndex("symbol_135");}
lib.items[si].name="Symbol_135";
si=lib.findItemIndex("Symbol_135");
//symbol_137.swf saved. character ID:137
si=lib.findItemIndex("symbol_137.swf");
if (si=='') {si=lib.findItemIndex("symbol_137");}
lib.items[si].name="Symbol_137";
si=lib.findItemIndex("Symbol_137");
//symbol_139.swf saved. character ID:139
si=lib.findItemIndex("symbol_139.swf");
if (si=='') {si=lib.findItemIndex("symbol_139");}
lib.items[si].name="Symbol_139";
si=lib.findItemIndex("Symbol_139");
//symbol_141.swf saved. character ID:141
si=lib.findItemIndex("symbol_141.swf");
if (si=='') {si=lib.findItemIndex("symbol_141");}
lib.items[si].name="Symbol_141";
si=lib.findItemIndex("Symbol_141");
//symbol_143.swf saved. character ID:143
si=lib.findItemIndex("symbol_143.swf");
if (si=='') {si=lib.findItemIndex("symbol_143");}
lib.items[si].name="Symbol_143";
si=lib.findItemIndex("Symbol_143");
//symbol_145.swf saved. character ID:145
si=lib.findItemIndex("symbol_145.swf");
if (si=='') {si=lib.findItemIndex("symbol_145");}
lib.items[si].name="Symbol_145";
si=lib.findItemIndex("Symbol_145");
//symbol_147.swf saved. character ID:147
si=lib.findItemIndex("symbol_147.swf");
if (si=='') {si=lib.findItemIndex("symbol_147");}
lib.items[si].name="Symbol_147";
si=lib.findItemIndex("Symbol_147");
//symbol_149.swf saved. character ID:149
si=lib.findItemIndex("symbol_149.swf");
if (si=='') {si=lib.findItemIndex("symbol_149");}
lib.items[si].name="Symbol_149";
si=lib.findItemIndex("Symbol_149");
//symbol_151.swf saved. character ID:151
si=lib.findItemIndex("symbol_151.swf");
if (si=='') {si=lib.findItemIndex("symbol_151");}
lib.items[si].name="Symbol_151";
si=lib.findItemIndex("Symbol_151");
//symbol_153.swf saved. character ID:153
si=lib.findItemIndex("symbol_153.swf");
if (si=='') {si=lib.findItemIndex("symbol_153");}
lib.items[si].name="Symbol_153";
si=lib.findItemIndex("Symbol_153");
//symbol_155.swf saved. character ID:155
si=lib.findItemIndex("symbol_155.swf");
if (si=='') {si=lib.findItemIndex("symbol_155");}
lib.items[si].name="Symbol_155";
si=lib.findItemIndex("Symbol_155");
//symbol_157.swf saved. character ID:157
si=lib.findItemIndex("symbol_157.swf");
if (si=='') {si=lib.findItemIndex("symbol_157");}
lib.items[si].name="Symbol_157";
si=lib.findItemIndex("Symbol_157");
//symbol_158.swf saved. character ID:158
si=lib.findItemIndex("symbol_158.swf");
if (si=='') {si=lib.findItemIndex("symbol_158");}
lib.items[si].name="Symbol_158";
si=lib.findItemIndex("Symbol_158");
//symbol_159.swf saved. character ID:159
si=lib.findItemIndex("symbol_159.swf");
if (si=='') {si=lib.findItemIndex("symbol_159");}
lib.items[si].name="Symbol_159";
si=lib.findItemIndex("Symbol_159");
//symbol_161.swf saved. character ID:161
si=lib.findItemIndex("symbol_161.swf");
if (si=='') {si=lib.findItemIndex("symbol_161");}
lib.items[si].name="Symbol_161";
si=lib.findItemIndex("Symbol_161");
//symbol_162.swf saved. character ID:162
si=lib.findItemIndex("symbol_162.swf");
if (si=='') {si=lib.findItemIndex("symbol_162");}
lib.items[si].name="Symbol_162";
si=lib.findItemIndex("Symbol_162");
//symbol_163.swf saved. character ID:163
si=lib.findItemIndex("symbol_163.swf");
if (si=='') {si=lib.findItemIndex("symbol_163");}
lib.items[si].name="Symbol_163";
si=lib.findItemIndex("Symbol_163");
//symbol_165.swf saved. character ID:165
si=lib.findItemIndex("symbol_165.swf");
if (si=='') {si=lib.findItemIndex("symbol_165");}
lib.items[si].name="Symbol_165";
si=lib.findItemIndex("Symbol_165");
//symbol_166.swf saved. character ID:166
si=lib.findItemIndex("symbol_166.swf");
if (si=='') {si=lib.findItemIndex("symbol_166");}
lib.items[si].name="Symbol_166";
si=lib.findItemIndex("Symbol_166");
//symbol_168.swf saved. character ID:168
si=lib.findItemIndex("symbol_168.swf");
if (si=='') {si=lib.findItemIndex("symbol_168");}
lib.items[si].name="Symbol_168";
si=lib.findItemIndex("Symbol_168");
//symbol_171.swf saved. character ID:171
si=lib.findItemIndex("symbol_171.swf");
if (si=='') {si=lib.findItemIndex("symbol_171");}
lib.items[si].name="Symbol_171";
si=lib.findItemIndex("Symbol_171");
//symbol_174.swf saved. character ID:174
si=lib.findItemIndex("symbol_174.swf");
if (si=='') {si=lib.findItemIndex("symbol_174");}
lib.items[si].name="Symbol_174";
si=lib.findItemIndex("Symbol_174");
//symbol_175.swf saved. character ID:175
si=lib.findItemIndex("symbol_175.swf");
if (si=='') {si=lib.findItemIndex("symbol_175");}
lib.items[si].name="Symbol_175";
si=lib.findItemIndex("Symbol_175");
//symbol_181.swf saved. character ID:181
si=lib.findItemIndex("symbol_181.swf");
if (si=='') {si=lib.findItemIndex("symbol_181");}
lib.items[si].name="Symbol_181";
si=lib.findItemIndex("Symbol_181");
//symbol_186.swf saved. character ID:186
si=lib.findItemIndex("symbol_186.swf");
if (si=='') {si=lib.findItemIndex("symbol_186");}
lib.items[si].name="Symbol_186";
si=lib.findItemIndex("Symbol_186");
//symbol_191.swf saved. character ID:191
si=lib.findItemIndex("symbol_191.swf");
if (si=='') {si=lib.findItemIndex("symbol_191");}
lib.items[si].name="Symbol_191";
si=lib.findItemIndex("Symbol_191");
//symbol_193.swf saved. character ID:193
si=lib.findItemIndex("symbol_193.swf");
if (si=='') {si=lib.findItemIndex("symbol_193");}
lib.items[si].name="Symbol_193";
si=lib.findItemIndex("Symbol_193");
//symbol_198.swf saved. character ID:198
si=lib.findItemIndex("symbol_198.swf");
if (si=='') {si=lib.findItemIndex("symbol_198");}
lib.items[si].name="Symbol_198";
si=lib.findItemIndex("Symbol_198");
//symbol_200.swf saved. character ID:200
si=lib.findItemIndex("symbol_200.swf");
if (si=='') {si=lib.findItemIndex("symbol_200");}
lib.items[si].name="Symbol_200";
si=lib.findItemIndex("Symbol_200");
//symbol_204.swf saved. character ID:204
si=lib.findItemIndex("symbol_204.swf");
if (si=='') {si=lib.findItemIndex("symbol_204");}
lib.items[si].name="Symbol_204";
si=lib.findItemIndex("Symbol_204");
//symbol_206.swf saved. character ID:206
si=lib.findItemIndex("symbol_206.swf");
if (si=='') {si=lib.findItemIndex("symbol_206");}
lib.items[si].name="Symbol_206";
si=lib.findItemIndex("Symbol_206");
//symbol_211.swf saved. character ID:211
si=lib.findItemIndex("symbol_211.swf");
if (si=='') {si=lib.findItemIndex("symbol_211");}
lib.items[si].name="Symbol_211";
si=lib.findItemIndex("Symbol_211");
//symbol_216.swf saved. character ID:216
si=lib.findItemIndex("symbol_216.swf");
if (si=='') {si=lib.findItemIndex("symbol_216");}
lib.items[si].name="Symbol_216";
si=lib.findItemIndex("Symbol_216");
//symbol_227.swf saved. character ID:227
si=lib.findItemIndex("symbol_227.swf");
if (si=='') {si=lib.findItemIndex("symbol_227");}
lib.items[si].name="Symbol_227";
si=lib.findItemIndex("Symbol_227");
//symbol_228.swf saved. character ID:228
si=lib.findItemIndex("symbol_228.swf");
if (si=='') {si=lib.findItemIndex("symbol_228");}
lib.items[si].name="Symbol_228";
si=lib.findItemIndex("Symbol_228");
//symbol_230.swf saved. character ID:230
si=lib.findItemIndex("symbol_230.swf");
if (si=='') {si=lib.findItemIndex("symbol_230");}
lib.items[si].name="Symbol_230";
si=lib.findItemIndex("Symbol_230");
//symbol_236.swf saved. character ID:236
si=lib.findItemIndex("symbol_236.swf");
if (si=='') {si=lib.findItemIndex("symbol_236");}
lib.items[si].name="Symbol_236";
si=lib.findItemIndex("Symbol_236");
//symbol_239.swf saved. character ID:239
si=lib.findItemIndex("symbol_239.swf");
if (si=='') {si=lib.findItemIndex("symbol_239");}
lib.items[si].name="Symbol_239";
si=lib.findItemIndex("Symbol_239");
//symbol_240.swf saved. character ID:240
si=lib.findItemIndex("symbol_240.swf");
if (si=='') {si=lib.findItemIndex("symbol_240");}
lib.items[si].name="Symbol_240";
si=lib.findItemIndex("Symbol_240");
//symbol_242.swf saved. character ID:242
si=lib.findItemIndex("symbol_242.swf");
if (si=='') {si=lib.findItemIndex("symbol_242");}
lib.items[si].name="Symbol_242";
si=lib.findItemIndex("Symbol_242");
//symbol_244.swf saved. character ID:244
si=lib.findItemIndex("symbol_244.swf");
if (si=='') {si=lib.findItemIndex("symbol_244");}
lib.items[si].name="Symbol_244";
si=lib.findItemIndex("Symbol_244");
//symbol_246.swf saved. character ID:246
si=lib.findItemIndex("symbol_246.swf");
if (si=='') {si=lib.findItemIndex("symbol_246");}
lib.items[si].name="Symbol_246";
si=lib.findItemIndex("Symbol_246");
//symbol_248.swf saved. character ID:248
si=lib.findItemIndex("symbol_248.swf");
if (si=='') {si=lib.findItemIndex("symbol_248");}
lib.items[si].name="Symbol_248";
si=lib.findItemIndex("Symbol_248");
//symbol_250.swf saved. character ID:250
si=lib.findItemIndex("symbol_250.swf");
if (si=='') {si=lib.findItemIndex("symbol_250");}
lib.items[si].name="Symbol_250";
si=lib.findItemIndex("Symbol_250");
//symbol_252.swf saved. character ID:252
si=lib.findItemIndex("symbol_252.swf");
if (si=='') {si=lib.findItemIndex("symbol_252");}
lib.items[si].name="Symbol_252";
si=lib.findItemIndex("Symbol_252");
//symbol_254.swf saved. character ID:254
si=lib.findItemIndex("symbol_254.swf");
if (si=='') {si=lib.findItemIndex("symbol_254");}
lib.items[si].name="Symbol_254";
si=lib.findItemIndex("Symbol_254");
//symbol_256.swf saved. character ID:256
si=lib.findItemIndex("symbol_256.swf");
if (si=='') {si=lib.findItemIndex("symbol_256");}
lib.items[si].name="Symbol_256";
si=lib.findItemIndex("Symbol_256");
//symbol_258.swf saved. character ID:258
si=lib.findItemIndex("symbol_258.swf");
if (si=='') {si=lib.findItemIndex("symbol_258");}
lib.items[si].name="Symbol_258";
si=lib.findItemIndex("Symbol_258");
//symbol_260.swf saved. character ID:260
si=lib.findItemIndex("symbol_260.swf");
if (si=='') {si=lib.findItemIndex("symbol_260");}
lib.items[si].name="Symbol_260";
si=lib.findItemIndex("Symbol_260");
//symbol_262.swf saved. character ID:262
si=lib.findItemIndex("symbol_262.swf");
if (si=='') {si=lib.findItemIndex("symbol_262");}
lib.items[si].name="Symbol_262";
si=lib.findItemIndex("Symbol_262");
//symbol_264.swf saved. character ID:264
si=lib.findItemIndex("symbol_264.swf");
if (si=='') {si=lib.findItemIndex("symbol_264");}
lib.items[si].name="Symbol_264";
si=lib.findItemIndex("Symbol_264");
//symbol_265.swf saved. character ID:265
si=lib.findItemIndex("symbol_265.swf");
if (si=='') {si=lib.findItemIndex("symbol_265");}
lib.items[si].name="Symbol_265";
si=lib.findItemIndex("Symbol_265");
//symbol_269.swf saved. character ID:269
si=lib.findItemIndex("symbol_269.swf");
if (si=='') {si=lib.findItemIndex("symbol_269");}
lib.items[si].name="Symbol_269";
si=lib.findItemIndex("Symbol_269");
//symbol_270.swf saved. character ID:270
si=lib.findItemIndex("symbol_270.swf");
if (si=='') {si=lib.findItemIndex("symbol_270");}
lib.items[si].name="Symbol_270";
si=lib.findItemIndex("Symbol_270");
//symbol_271.swf saved. character ID:271
si=lib.findItemIndex("symbol_271.swf");
if (si=='') {si=lib.findItemIndex("symbol_271");}
lib.items[si].name="Symbol_271";
si=lib.findItemIndex("Symbol_271");
//symbol_273.swf saved. character ID:273
si=lib.findItemIndex("symbol_273.swf");
if (si=='') {si=lib.findItemIndex("symbol_273");}
lib.items[si].name="Symbol_273";
si=lib.findItemIndex("Symbol_273");
//symbol_274.swf saved. character ID:274
si=lib.findItemIndex("symbol_274.swf");
if (si=='') {si=lib.findItemIndex("symbol_274");}
lib.items[si].name="Symbol_274";
si=lib.findItemIndex("Symbol_274");
//symbol_276.swf saved. character ID:276
si=lib.findItemIndex("symbol_276.swf");
if (si=='') {si=lib.findItemIndex("symbol_276");}
lib.items[si].name="Symbol_276";
si=lib.findItemIndex("Symbol_276");
//symbol_277.swf saved. character ID:277
si=lib.findItemIndex("symbol_277.swf");
if (si=='') {si=lib.findItemIndex("symbol_277");}
lib.items[si].name="Symbol_277";
si=lib.findItemIndex("Symbol_277");
//symbol_278.swf saved. character ID:278
si=lib.findItemIndex("symbol_278.swf");
if (si=='') {si=lib.findItemIndex("symbol_278");}
lib.items[si].name="Symbol_278";
si=lib.findItemIndex("Symbol_278");
//symbol_279.swf saved. character ID:279
si=lib.findItemIndex("symbol_279.swf");
if (si=='') {si=lib.findItemIndex("symbol_279");}
lib.items[si].name="Symbol_279";
si=lib.findItemIndex("Symbol_279");
//symbol_280.swf saved. character ID:280
si=lib.findItemIndex("symbol_280.swf");
if (si=='') {si=lib.findItemIndex("symbol_280");}
lib.items[si].name="Symbol_280";
si=lib.findItemIndex("Symbol_280");
//symbol_283.swf saved. character ID:283
si=lib.findItemIndex("symbol_283.swf");
if (si=='') {si=lib.findItemIndex("symbol_283");}
lib.items[si].name="Symbol_283";
si=lib.findItemIndex("Symbol_283");
//symbol_284.swf saved. character ID:284
si=lib.findItemIndex("symbol_284.swf");
if (si=='') {si=lib.findItemIndex("symbol_284");}
lib.items[si].name="Symbol_284";
si=lib.findItemIndex("Symbol_284");
//symbol_286.swf saved. character ID:286
si=lib.findItemIndex("symbol_286.swf");
if (si=='') {si=lib.findItemIndex("symbol_286");}
lib.items[si].name="Symbol_286";
si=lib.findItemIndex("Symbol_286");
//symbol_289.swf saved. character ID:289
si=lib.findItemIndex("symbol_289.swf");
if (si=='') {si=lib.findItemIndex("symbol_289");}
lib.items[si].name="Symbol_289";
si=lib.findItemIndex("Symbol_289");
//symbol_290.swf saved. character ID:290
si=lib.findItemIndex("symbol_290.swf");
if (si=='') {si=lib.findItemIndex("symbol_290");}
lib.items[si].name="Symbol_290";
si=lib.findItemIndex("Symbol_290");
//symbol_292.swf saved. character ID:292
si=lib.findItemIndex("symbol_292.swf");
if (si=='') {si=lib.findItemIndex("symbol_292");}
lib.items[si].name="Symbol_292";
si=lib.findItemIndex("Symbol_292");
//symbol_294.swf saved. character ID:294
si=lib.findItemIndex("symbol_294.swf");
if (si=='') {si=lib.findItemIndex("symbol_294");}
lib.items[si].name="Symbol_294";
si=lib.findItemIndex("Symbol_294");
//symbol_297.swf saved. character ID:297
si=lib.findItemIndex("symbol_297.swf");
if (si=='') {si=lib.findItemIndex("symbol_297");}
lib.items[si].name="Symbol_297";
si=lib.findItemIndex("Symbol_297");
//symbol_299.swf saved. character ID:299
si=lib.findItemIndex("symbol_299.swf");
if (si=='') {si=lib.findItemIndex("symbol_299");}
lib.items[si].name="Symbol_299";
si=lib.findItemIndex("Symbol_299");
//symbol_301.swf saved. character ID:301
si=lib.findItemIndex("symbol_301.swf");
if (si=='') {si=lib.findItemIndex("symbol_301");}
lib.items[si].name="Symbol_301";
si=lib.findItemIndex("Symbol_301");
//symbol_303.swf saved. character ID:303
si=lib.findItemIndex("symbol_303.swf");
if (si=='') {si=lib.findItemIndex("symbol_303");}
lib.items[si].name="Symbol_303";
si=lib.findItemIndex("Symbol_303");
//symbol_304.swf saved. character ID:304
si=lib.findItemIndex("symbol_304.swf");
if (si=='') {si=lib.findItemIndex("symbol_304");}
lib.items[si].name="Symbol_304";
si=lib.findItemIndex("Symbol_304");
//symbol_306.swf saved. character ID:306
si=lib.findItemIndex("symbol_306.swf");
if (si=='') {si=lib.findItemIndex("symbol_306");}
lib.items[si].name="Symbol_306";
si=lib.findItemIndex("Symbol_306");
//symbol_308.swf saved. character ID:308
si=lib.findItemIndex("symbol_308.swf");
if (si=='') {si=lib.findItemIndex("symbol_308");}
lib.items[si].name="Symbol_308";
si=lib.findItemIndex("Symbol_308");
//symbol_309.swf saved. character ID:309
si=lib.findItemIndex("symbol_309.swf");
if (si=='') {si=lib.findItemIndex("symbol_309");}
lib.items[si].name="Symbol_309";
si=lib.findItemIndex("Symbol_309");
//symbol_311.swf saved. character ID:311
si=lib.findItemIndex("symbol_311.swf");
if (si=='') {si=lib.findItemIndex("symbol_311");}
lib.items[si].name="Symbol_311";
si=lib.findItemIndex("Symbol_311");
//symbol_313.swf saved. character ID:313
si=lib.findItemIndex("symbol_313.swf");
if (si=='') {si=lib.findItemIndex("symbol_313");}
lib.items[si].name="Symbol_313";
si=lib.findItemIndex("Symbol_313");
//symbol_314.swf saved. character ID:314
si=lib.findItemIndex("symbol_314.swf");
if (si=='') {si=lib.findItemIndex("symbol_314");}
lib.items[si].name="Symbol_314";
si=lib.findItemIndex("Symbol_314");
//symbol_315.swf saved. character ID:315
si=lib.findItemIndex("symbol_315.swf");
if (si=='') {si=lib.findItemIndex("symbol_315");}
lib.items[si].name="Symbol_315";
si=lib.findItemIndex("Symbol_315");
//symbol_316.swf saved. character ID:316
si=lib.findItemIndex("symbol_316.swf");
if (si=='') {si=lib.findItemIndex("symbol_316");}
lib.items[si].name="Symbol_316";
si=lib.findItemIndex("Symbol_316");
//symbol_317.swf saved. character ID:317
si=lib.findItemIndex("symbol_317.swf");
if (si=='') {si=lib.findItemIndex("symbol_317");}
lib.items[si].name="Symbol_317";
si=lib.findItemIndex("Symbol_317");
//symbol_318.swf saved. character ID:318
si=lib.findItemIndex("symbol_318.swf");
if (si=='') {si=lib.findItemIndex("symbol_318");}
lib.items[si].name="Symbol_318";
si=lib.findItemIndex("Symbol_318");
//symbol_319.swf saved. character ID:319
si=lib.findItemIndex("symbol_319.swf");
if (si=='') {si=lib.findItemIndex("symbol_319");}
lib.items[si].name="Symbol_319";
si=lib.findItemIndex("Symbol_319");
//symbol_321.swf saved. character ID:321
si=lib.findItemIndex("symbol_321.swf");
if (si=='') {si=lib.findItemIndex("symbol_321");}
lib.items[si].name="Symbol_321";
si=lib.findItemIndex("Symbol_321");
//symbol_322.swf saved. character ID:322
si=lib.findItemIndex("symbol_322.swf");
if (si=='') {si=lib.findItemIndex("symbol_322");}
lib.items[si].name="Symbol_322";
si=lib.findItemIndex("Symbol_322");
//symbol_323.swf saved. character ID:323
si=lib.findItemIndex("symbol_323.swf");
if (si=='') {si=lib.findItemIndex("symbol_323");}
lib.items[si].name="Symbol_323";
si=lib.findItemIndex("Symbol_323");
//symbol_324.swf saved. character ID:324
si=lib.findItemIndex("symbol_324.swf");
if (si=='') {si=lib.findItemIndex("symbol_324");}
lib.items[si].name="Symbol_324";
si=lib.findItemIndex("Symbol_324");
//symbol_327.swf saved. character ID:327
si=lib.findItemIndex("symbol_327.swf");
if (si=='') {si=lib.findItemIndex("symbol_327");}
lib.items[si].name="Symbol_327";
si=lib.findItemIndex("Symbol_327");
//symbol_331.swf saved. character ID:331
si=lib.findItemIndex("symbol_331.swf");
if (si=='') {si=lib.findItemIndex("symbol_331");}
lib.items[si].name="Symbol_331";
si=lib.findItemIndex("Symbol_331");
//symbol_332.swf saved. character ID:332
si=lib.findItemIndex("symbol_332.swf");
if (si=='') {si=lib.findItemIndex("symbol_332");}
lib.items[si].name="Symbol_332";
si=lib.findItemIndex("Symbol_332");
//symbol_333.swf saved. character ID:333
si=lib.findItemIndex("symbol_333.swf");
if (si=='') {si=lib.findItemIndex("symbol_333");}
lib.items[si].name="Symbol_333";
si=lib.findItemIndex("Symbol_333");
//symbol_341.swf saved. character ID:341
si=lib.findItemIndex("symbol_341.swf");
if (si=='') {si=lib.findItemIndex("symbol_341");}
lib.items[si].name="Symbol_341";
si=lib.findItemIndex("Symbol_341");
//symbol_342.swf saved. character ID:342
si=lib.findItemIndex("symbol_342.swf");
if (si=='') {si=lib.findItemIndex("symbol_342");}
lib.items[si].name="Symbol_342";
si=lib.findItemIndex("Symbol_342");
//symbol_343.swf saved. character ID:343
si=lib.findItemIndex("symbol_343.swf");
if (si=='') {si=lib.findItemIndex("symbol_343");}
lib.items[si].name="Symbol_343";
si=lib.findItemIndex("Symbol_343");
//symbol_345.swf saved. character ID:345
si=lib.findItemIndex("symbol_345.swf");
if (si=='') {si=lib.findItemIndex("symbol_345");}
lib.items[si].name="Symbol_345";
si=lib.findItemIndex("Symbol_345");
//symbol_347.swf saved. character ID:347
si=lib.findItemIndex("symbol_347.swf");
if (si=='') {si=lib.findItemIndex("symbol_347");}
lib.items[si].name="Symbol_347";
si=lib.findItemIndex("Symbol_347");
//symbol_349.swf saved. character ID:349
si=lib.findItemIndex("symbol_349.swf");
if (si=='') {si=lib.findItemIndex("symbol_349");}
lib.items[si].name="Symbol_349";
si=lib.findItemIndex("Symbol_349");
//symbol_350.swf saved. character ID:350
si=lib.findItemIndex("symbol_350.swf");
if (si=='') {si=lib.findItemIndex("symbol_350");}
lib.items[si].name="Symbol_350";
si=lib.findItemIndex("Symbol_350");
//symbol_352.swf saved. character ID:352
si=lib.findItemIndex("symbol_352.swf");
if (si=='') {si=lib.findItemIndex("symbol_352");}
lib.items[si].name="Symbol_352";
si=lib.findItemIndex("Symbol_352");
//symbol_353.swf saved. character ID:353
si=lib.findItemIndex("symbol_353.swf");
if (si=='') {si=lib.findItemIndex("symbol_353");}
lib.items[si].name="Symbol_353";
si=lib.findItemIndex("Symbol_353");
//symbol_355.swf saved. character ID:355
si=lib.findItemIndex("symbol_355.swf");
if (si=='') {si=lib.findItemIndex("symbol_355");}
lib.items[si].name="Symbol_355";
si=lib.findItemIndex("Symbol_355");
//symbol_356.swf saved. character ID:356
si=lib.findItemIndex("symbol_356.swf");
if (si=='') {si=lib.findItemIndex("symbol_356");}
lib.items[si].name="Symbol_356";
si=lib.findItemIndex("Symbol_356");
//symbol_358.swf saved. character ID:358
si=lib.findItemIndex("symbol_358.swf");
if (si=='') {si=lib.findItemIndex("symbol_358");}
lib.items[si].name="Symbol_358";
si=lib.findItemIndex("Symbol_358");
//symbol_359.swf saved. character ID:359
si=lib.findItemIndex("symbol_359.swf");
if (si=='') {si=lib.findItemIndex("symbol_359");}
lib.items[si].name="Symbol_359";
si=lib.findItemIndex("Symbol_359");
//symbol_360.swf saved. character ID:360
si=lib.findItemIndex("symbol_360.swf");
if (si=='') {si=lib.findItemIndex("symbol_360");}
lib.items[si].name="Symbol_360";
si=lib.findItemIndex("Symbol_360");
//symbol_362.swf saved. character ID:362
si=lib.findItemIndex("symbol_362.swf");
if (si=='') {si=lib.findItemIndex("symbol_362");}
lib.items[si].name="Symbol_362";
si=lib.findItemIndex("Symbol_362");
//symbol_363.swf saved. character ID:363
si=lib.findItemIndex("symbol_363.swf");
if (si=='') {si=lib.findItemIndex("symbol_363");}
lib.items[si].name="Symbol_363";
si=lib.findItemIndex("Symbol_363");
//symbol_365.swf saved. character ID:365
si=lib.findItemIndex("symbol_365.swf");
if (si=='') {si=lib.findItemIndex("symbol_365");}
lib.items[si].name="Symbol_365";
si=lib.findItemIndex("Symbol_365");
//symbol_367.swf saved. character ID:367
si=lib.findItemIndex("symbol_367.swf");
if (si=='') {si=lib.findItemIndex("symbol_367");}
lib.items[si].name="Symbol_367";
si=lib.findItemIndex("Symbol_367");
//symbol_368.swf saved. character ID:368
si=lib.findItemIndex("symbol_368.swf");
if (si=='') {si=lib.findItemIndex("symbol_368");}
lib.items[si].name="Symbol_368";
si=lib.findItemIndex("Symbol_368");
//symbol_370.swf saved. character ID:370
si=lib.findItemIndex("symbol_370.swf");
if (si=='') {si=lib.findItemIndex("symbol_370");}
lib.items[si].name="Symbol_370";
si=lib.findItemIndex("Symbol_370");
//symbol_371.swf saved. character ID:371
si=lib.findItemIndex("symbol_371.swf");
if (si=='') {si=lib.findItemIndex("symbol_371");}
lib.items[si].name="Symbol_371";
si=lib.findItemIndex("Symbol_371");
//symbol_373.swf saved. character ID:373
si=lib.findItemIndex("symbol_373.swf");
if (si=='') {si=lib.findItemIndex("symbol_373");}
lib.items[si].name="Symbol_373";
si=lib.findItemIndex("Symbol_373");
//symbol_378.swf saved. character ID:378
si=lib.findItemIndex("symbol_378.swf");
if (si=='') {si=lib.findItemIndex("symbol_378");}
lib.items[si].name="Symbol_378";
si=lib.findItemIndex("Symbol_378");
//symbol_382.swf saved. character ID:382
si=lib.findItemIndex("symbol_382.swf");
if (si=='') {si=lib.findItemIndex("symbol_382");}
lib.items[si].name="Symbol_382";
si=lib.findItemIndex("Symbol_382");
//symbol_383.swf saved. character ID:383
si=lib.findItemIndex("symbol_383.swf");
if (si=='') {si=lib.findItemIndex("symbol_383");}
lib.items[si].name="Symbol_383";
si=lib.findItemIndex("Symbol_383");
//symbol_386.swf saved. character ID:386
si=lib.findItemIndex("symbol_386.swf");
if (si=='') {si=lib.findItemIndex("symbol_386");}
lib.items[si].name="Symbol_386";
si=lib.findItemIndex("Symbol_386");
//symbol_390.swf saved. character ID:390
si=lib.findItemIndex("symbol_390.swf");
if (si=='') {si=lib.findItemIndex("symbol_390");}
lib.items[si].name="Symbol_390";
si=lib.findItemIndex("Symbol_390");
//symbol_392.swf saved. character ID:392
si=lib.findItemIndex("symbol_392.swf");
if (si=='') {si=lib.findItemIndex("symbol_392");}
lib.items[si].name="Symbol_392";
si=lib.findItemIndex("Symbol_392");
//symbol_394.swf saved. character ID:394
si=lib.findItemIndex("symbol_394.swf");
if (si=='') {si=lib.findItemIndex("symbol_394");}
lib.items[si].name="Symbol_394";
si=lib.findItemIndex("Symbol_394");
//symbol_396.swf saved. character ID:396
si=lib.findItemIndex("symbol_396.swf");
if (si=='') {si=lib.findItemIndex("symbol_396");}
lib.items[si].name="Symbol_396";
si=lib.findItemIndex("Symbol_396");
//symbol_398.swf saved. character ID:398
si=lib.findItemIndex("symbol_398.swf");
if (si=='') {si=lib.findItemIndex("symbol_398");}
lib.items[si].name="Symbol_398";
si=lib.findItemIndex("Symbol_398");
//symbol_399.swf saved. character ID:399
si=lib.findItemIndex("symbol_399.swf");
if (si=='') {si=lib.findItemIndex("symbol_399");}
lib.items[si].name="Symbol_399";
si=lib.findItemIndex("Symbol_399");
//symbol_400.swf saved. character ID:400
si=lib.findItemIndex("symbol_400.swf");
if (si=='') {si=lib.findItemIndex("symbol_400");}
lib.items[si].name="Symbol_400";
si=lib.findItemIndex("Symbol_400");
//symbol_405.swf saved. character ID:405
si=lib.findItemIndex("symbol_405.swf");
if (si=='') {si=lib.findItemIndex("symbol_405");}
lib.items[si].name="Symbol_405";
si=lib.findItemIndex("Symbol_405");
//symbol_406.swf saved. character ID:406
si=lib.findItemIndex("symbol_406.swf");
if (si=='') {si=lib.findItemIndex("symbol_406");}
lib.items[si].name="Symbol_406";
si=lib.findItemIndex("Symbol_406");
//symbol_407.swf saved. character ID:407
si=lib.findItemIndex("symbol_407.swf");
if (si=='') {si=lib.findItemIndex("symbol_407");}
lib.items[si].name="Symbol_407";
si=lib.findItemIndex("Symbol_407");
//symbol_408.swf saved. character ID:408
si=lib.findItemIndex("symbol_408.swf");
if (si=='') {si=lib.findItemIndex("symbol_408");}
lib.items[si].name="Symbol_408";
si=lib.findItemIndex("Symbol_408");
//symbol_409.swf saved. character ID:409
si=lib.findItemIndex("symbol_409.swf");
if (si=='') {si=lib.findItemIndex("symbol_409");}
lib.items[si].name="Symbol_409";
si=lib.findItemIndex("Symbol_409");
//symbol_410.swf saved. character ID:410
si=lib.findItemIndex("symbol_410.swf");
if (si=='') {si=lib.findItemIndex("symbol_410");}
lib.items[si].name="Symbol_410";
si=lib.findItemIndex("Symbol_410");
//symbol_411.swf saved. character ID:411
si=lib.findItemIndex("symbol_411.swf");
if (si=='') {si=lib.findItemIndex("symbol_411");}
lib.items[si].name="Symbol_411";
si=lib.findItemIndex("Symbol_411");
//symbol_412.swf saved. character ID:412
si=lib.findItemIndex("symbol_412.swf");
if (si=='') {si=lib.findItemIndex("symbol_412");}
lib.items[si].name="Symbol_412";
si=lib.findItemIndex("Symbol_412");
//symbol_413.swf saved. character ID:413
si=lib.findItemIndex("symbol_413.swf");
if (si=='') {si=lib.findItemIndex("symbol_413");}
lib.items[si].name="Symbol_413";
si=lib.findItemIndex("Symbol_413");
//symbol_414.swf saved. character ID:414
si=lib.findItemIndex("symbol_414.swf");
if (si=='') {si=lib.findItemIndex("symbol_414");}
lib.items[si].name="Symbol_414";
si=lib.findItemIndex("Symbol_414");
//symbol_415.swf saved. character ID:415
si=lib.findItemIndex("symbol_415.swf");
if (si=='') {si=lib.findItemIndex("symbol_415");}
lib.items[si].name="Symbol_415";
si=lib.findItemIndex("Symbol_415");
//symbol_416.swf saved. character ID:416
si=lib.findItemIndex("symbol_416.swf");
if (si=='') {si=lib.findItemIndex("symbol_416");}
lib.items[si].name="Symbol_416";
si=lib.findItemIndex("Symbol_416");
//symbol_417.swf saved. character ID:417
si=lib.findItemIndex("symbol_417.swf");
if (si=='') {si=lib.findItemIndex("symbol_417");}
lib.items[si].name="Symbol_417";
si=lib.findItemIndex("Symbol_417");
//symbol_418.swf saved. character ID:418
si=lib.findItemIndex("symbol_418.swf");
if (si=='') {si=lib.findItemIndex("symbol_418");}
lib.items[si].name="Symbol_418";
si=lib.findItemIndex("Symbol_418");
//symbol_420.swf saved. character ID:420
si=lib.findItemIndex("symbol_420.swf");
if (si=='') {si=lib.findItemIndex("symbol_420");}
lib.items[si].name="Symbol_420";
si=lib.findItemIndex("Symbol_420");
//symbol_421.swf saved. character ID:421
si=lib.findItemIndex("symbol_421.swf");
if (si=='') {si=lib.findItemIndex("symbol_421");}
lib.items[si].name="Symbol_421";
si=lib.findItemIndex("Symbol_421");
//symbol_422.swf saved. character ID:422
si=lib.findItemIndex("symbol_422.swf");
if (si=='') {si=lib.findItemIndex("symbol_422");}
lib.items[si].name="Symbol_422";
si=lib.findItemIndex("Symbol_422");
//symbol_423.swf saved. character ID:423
si=lib.findItemIndex("symbol_423.swf");
if (si=='') {si=lib.findItemIndex("symbol_423");}
lib.items[si].name="Symbol_423";
si=lib.findItemIndex("Symbol_423");
//symbol_424.swf saved. character ID:424
si=lib.findItemIndex("symbol_424.swf");
if (si=='') {si=lib.findItemIndex("symbol_424");}
lib.items[si].name="Symbol_424";
si=lib.findItemIndex("Symbol_424");
//symbol_425.swf saved. character ID:425
si=lib.findItemIndex("symbol_425.swf");
if (si=='') {si=lib.findItemIndex("symbol_425");}
lib.items[si].name="Symbol_425";
si=lib.findItemIndex("Symbol_425");
//symbol_427.swf saved. character ID:427
si=lib.findItemIndex("symbol_427.swf");
if (si=='') {si=lib.findItemIndex("symbol_427");}
lib.items[si].name="Symbol_427";
si=lib.findItemIndex("Symbol_427");
//symbol_428.swf saved. character ID:428
si=lib.findItemIndex("symbol_428.swf");
if (si=='') {si=lib.findItemIndex("symbol_428");}
lib.items[si].name="Symbol_428";
si=lib.findItemIndex("Symbol_428");
//symbol_429.swf saved. character ID:429
si=lib.findItemIndex("symbol_429.swf");
if (si=='') {si=lib.findItemIndex("symbol_429");}
lib.items[si].name="Symbol_429";
si=lib.findItemIndex("Symbol_429");
//symbol_430.swf saved. character ID:430
si=lib.findItemIndex("symbol_430.swf");
if (si=='') {si=lib.findItemIndex("symbol_430");}
lib.items[si].name="Symbol_430";
si=lib.findItemIndex("Symbol_430");
//symbol_431.swf saved. character ID:431
si=lib.findItemIndex("symbol_431.swf");
if (si=='') {si=lib.findItemIndex("symbol_431");}
lib.items[si].name="Symbol_431";
si=lib.findItemIndex("Symbol_431");
//symbol_437.swf saved. character ID:437
si=lib.findItemIndex("symbol_437.swf");
if (si=='') {si=lib.findItemIndex("symbol_437");}
lib.items[si].name="Symbol_437";
si=lib.findItemIndex("Symbol_437");
//symbol_442.swf saved. character ID:442
si=lib.findItemIndex("symbol_442.swf");
if (si=='') {si=lib.findItemIndex("symbol_442");}
lib.items[si].name="Symbol_442";
si=lib.findItemIndex("Symbol_442");
//symbol_443.swf saved. character ID:443
si=lib.findItemIndex("symbol_443.swf");
if (si=='') {si=lib.findItemIndex("symbol_443");}
lib.items[si].name="Symbol_443";
si=lib.findItemIndex("Symbol_443");
//symbol_444.swf saved. character ID:444
si=lib.findItemIndex("symbol_444.swf");
if (si=='') {si=lib.findItemIndex("symbol_444");}
lib.items[si].name="Symbol_444";
si=lib.findItemIndex("Symbol_444");
//symbol_445.swf saved. character ID:445
si=lib.findItemIndex("symbol_445.swf");
if (si=='') {si=lib.findItemIndex("symbol_445");}
lib.items[si].name="Symbol_445";
si=lib.findItemIndex("Symbol_445");
//symbol_446.swf saved. character ID:446
si=lib.findItemIndex("symbol_446.swf");
if (si=='') {si=lib.findItemIndex("symbol_446");}
lib.items[si].name="Symbol_446";
si=lib.findItemIndex("Symbol_446");
//symbol_447.swf saved. character ID:447
si=lib.findItemIndex("symbol_447.swf");
if (si=='') {si=lib.findItemIndex("symbol_447");}
lib.items[si].name="Symbol_447";
si=lib.findItemIndex("Symbol_447");
//symbol_448.swf saved. character ID:448
si=lib.findItemIndex("symbol_448.swf");
if (si=='') {si=lib.findItemIndex("symbol_448");}
lib.items[si].name="Symbol_448";
si=lib.findItemIndex("Symbol_448");
//symbol_449.swf saved. character ID:449
si=lib.findItemIndex("symbol_449.swf");
if (si=='') {si=lib.findItemIndex("symbol_449");}
lib.items[si].name="Symbol_449";
si=lib.findItemIndex("Symbol_449");
//symbol_450.swf saved. character ID:450
si=lib.findItemIndex("symbol_450.swf");
if (si=='') {si=lib.findItemIndex("symbol_450");}
lib.items[si].name="Symbol_450";
si=lib.findItemIndex("Symbol_450");
//symbol_451.swf saved. character ID:451
si=lib.findItemIndex("symbol_451.swf");
if (si=='') {si=lib.findItemIndex("symbol_451");}
lib.items[si].name="Symbol_451";
si=lib.findItemIndex("Symbol_451");
//symbol_452.swf saved. character ID:452
si=lib.findItemIndex("symbol_452.swf");
if (si=='') {si=lib.findItemIndex("symbol_452");}
lib.items[si].name="Symbol_452";
si=lib.findItemIndex("Symbol_452");
//symbol_453.swf saved. character ID:453
si=lib.findItemIndex("symbol_453.swf");
if (si=='') {si=lib.findItemIndex("symbol_453");}
lib.items[si].name="Symbol_453";
si=lib.findItemIndex("Symbol_453");
//symbol_454.swf saved. character ID:454
si=lib.findItemIndex("symbol_454.swf");
if (si=='') {si=lib.findItemIndex("symbol_454");}
lib.items[si].name="Symbol_454";
si=lib.findItemIndex("Symbol_454");
//symbol_455.swf saved. character ID:455
si=lib.findItemIndex("symbol_455.swf");
if (si=='') {si=lib.findItemIndex("symbol_455");}
lib.items[si].name="Symbol_455";
si=lib.findItemIndex("Symbol_455");
//symbol_465.swf saved. character ID:465
si=lib.findItemIndex("symbol_465.swf");
if (si=='') {si=lib.findItemIndex("symbol_465");}
lib.items[si].name="Symbol_465";
si=lib.findItemIndex("Symbol_465");
//symbol_466.swf saved. character ID:466
si=lib.findItemIndex("symbol_466.swf");
if (si=='') {si=lib.findItemIndex("symbol_466");}
lib.items[si].name="Symbol_466";
si=lib.findItemIndex("Symbol_466");
//symbol_468.swf saved. character ID:468
si=lib.findItemIndex("symbol_468.swf");
if (si=='') {si=lib.findItemIndex("symbol_468");}
lib.items[si].name="Symbol_468";
si=lib.findItemIndex("Symbol_468");
//symbol_470.swf saved. character ID:470
si=lib.findItemIndex("symbol_470.swf");
if (si=='') {si=lib.findItemIndex("symbol_470");}
lib.items[si].name="Symbol_470";
si=lib.findItemIndex("Symbol_470");
//symbol_472.swf saved. character ID:472
si=lib.findItemIndex("symbol_472.swf");
if (si=='') {si=lib.findItemIndex("symbol_472");}
lib.items[si].name="Symbol_472";
si=lib.findItemIndex("Symbol_472");
//symbol_473.swf saved. character ID:473
si=lib.findItemIndex("symbol_473.swf");
if (si=='') {si=lib.findItemIndex("symbol_473");}
lib.items[si].name="Symbol_473";
si=lib.findItemIndex("Symbol_473");
//symbol_483.swf saved. character ID:483
si=lib.findItemIndex("symbol_483.swf");
if (si=='') {si=lib.findItemIndex("symbol_483");}
lib.items[si].name="Symbol_483";
si=lib.findItemIndex("Symbol_483");
//symbol_494.swf saved. character ID:494
si=lib.findItemIndex("symbol_494.swf");
if (si=='') {si=lib.findItemIndex("symbol_494");}
lib.items[si].name="Symbol_494";
si=lib.findItemIndex("Symbol_494");
//symbol_496.swf saved. character ID:496
si=lib.findItemIndex("symbol_496.swf");
if (si=='') {si=lib.findItemIndex("symbol_496");}
lib.items[si].name="Symbol_496";
si=lib.findItemIndex("Symbol_496");
//symbol_497.swf saved. character ID:497
si=lib.findItemIndex("symbol_497.swf");
if (si=='') {si=lib.findItemIndex("symbol_497");}
lib.items[si].name="Symbol_497";
si=lib.findItemIndex("Symbol_497");
//symbol_500.swf saved. character ID:500
si=lib.findItemIndex("symbol_500.swf");
if (si=='') {si=lib.findItemIndex("symbol_500");}
lib.items[si].name="Symbol_500";
si=lib.findItemIndex("Symbol_500");
//symbol_501.swf saved. character ID:501
si=lib.findItemIndex("symbol_501.swf");
if (si=='') {si=lib.findItemIndex("symbol_501");}
lib.items[si].name="Symbol_501";
si=lib.findItemIndex("Symbol_501");
//symbol_502.swf saved. character ID:502
si=lib.findItemIndex("symbol_502.swf");
if (si=='') {si=lib.findItemIndex("symbol_502");}
lib.items[si].name="Symbol_502";
si=lib.findItemIndex("Symbol_502");
//symbol_503.swf saved. character ID:503
si=lib.findItemIndex("symbol_503.swf");
if (si=='') {si=lib.findItemIndex("symbol_503");}
lib.items[si].name="Symbol_503";
si=lib.findItemIndex("Symbol_503");
//symbol_504.swf saved. character ID:504
si=lib.findItemIndex("symbol_504.swf");
if (si=='') {si=lib.findItemIndex("symbol_504");}
lib.items[si].name="Symbol_504";
si=lib.findItemIndex("Symbol_504");
//symbol_506.swf saved. character ID:506
si=lib.findItemIndex("symbol_506.swf");
if (si=='') {si=lib.findItemIndex("symbol_506");}
lib.items[si].name="Symbol_506";
si=lib.findItemIndex("Symbol_506");
//symbol_519.swf saved. character ID:519
si=lib.findItemIndex("symbol_519.swf");
if (si=='') {si=lib.findItemIndex("symbol_519");}
lib.items[si].name="Symbol_519";
si=lib.findItemIndex("Symbol_519");
//symbol_520.swf saved. character ID:520
si=lib.findItemIndex("symbol_520.swf");
if (si=='') {si=lib.findItemIndex("symbol_520");}
lib.items[si].name="Symbol_520";
si=lib.findItemIndex("Symbol_520");
//symbol_521.swf saved. character ID:521
si=lib.findItemIndex("symbol_521.swf");
if (si=='') {si=lib.findItemIndex("symbol_521");}
lib.items[si].name="Symbol_521";
si=lib.findItemIndex("Symbol_521");
//symbol_562.swf saved. character ID:523
si=lib.findItemIndex("symbol_562.swf");
if (si=='') {si=lib.findItemIndex("symbol_562");}
lib.items[si].name="Symbol_562";
si=lib.findItemIndex("Symbol_562");
//symbol_563.swf saved. character ID:524
si=lib.findItemIndex("symbol_563.swf");
if (si=='') {si=lib.findItemIndex("symbol_563");}
lib.items[si].name="Symbol_563";
si=lib.findItemIndex("Symbol_563");
//symbol_564.swf saved. character ID:525
si=lib.findItemIndex("symbol_564.swf");
if (si=='') {si=lib.findItemIndex("symbol_564");}
lib.items[si].name="Symbol_564";
si=lib.findItemIndex("Symbol_564");
//symbol_565.swf saved. character ID:526
si=lib.findItemIndex("symbol_565.swf");
if (si=='') {si=lib.findItemIndex("symbol_565");}
lib.items[si].name="Symbol_565";
si=lib.findItemIndex("Symbol_565");
//symbol_568.swf saved. character ID:529
si=lib.findItemIndex("symbol_568.swf");
if (si=='') {si=lib.findItemIndex("symbol_568");}
lib.items[si].name="Symbol_568";
si=lib.findItemIndex("Symbol_568");
//symbol_569.swf saved. character ID:530
si=lib.findItemIndex("symbol_569.swf");
if (si=='') {si=lib.findItemIndex("symbol_569");}
lib.items[si].name="Symbol_569";
si=lib.findItemIndex("Symbol_569");
//symbol_571.swf saved. character ID:532
si=lib.findItemIndex("symbol_571.swf");
if (si=='') {si=lib.findItemIndex("symbol_571");}
lib.items[si].name="Symbol_571";
si=lib.findItemIndex("Symbol_571");
li=lib.items[lib.findItemIndex("Symbol_571")];
li.symbolType="movie clip";
lib.editItem("Symbol_571");
tl=doc.getTimeline();
doc.selectAll();
doc.breakApart();
el=tl.layers[0].frames[0].elements;
if (el.length==2){
el[0].setTextAttr("bold", false);
el[0].setTextAttr("italic", false);
el[0].setTextAttr("face", el[0].getTextAttr("face"));
el[1].setTextAttr("bold", false);
el[1].setTextAttr("italic", false);
el[1].setTextAttr("face", el[1].getTextAttr("face"));
}
el=tl.layers[0].frames[0].elements;
for(var n=0;n<el.length;n++){
tx=el[n];
tx.fontRenderingMode="standard";
}
if (el.length==2){
el[0].setTextAttr("alignment", "left");
el[0].setTextAttr("letterSpacing", -0.6);
el[0].setTextAttr("autoKern", true);
el[1].setTextAttr("alignment", "left");
el[1].setTextAttr("letterSpacing", -0.9);
el[1].setTextAttr("autoKern", true);
}
doc.exitEditMode();
tl=doc.getTimeline();
//symbol_573.swf saved. character ID:534
si=lib.findItemIndex("symbol_573.swf");
if (si=='') {si=lib.findItemIndex("symbol_573");}
lib.items[si].name="Symbol_573";
si=lib.findItemIndex("Symbol_573");
//symbol_575.swf saved. character ID:536
si=lib.findItemIndex("symbol_575.swf");
if (si=='') {si=lib.findItemIndex("symbol_575");}
lib.items[si].name="Symbol_575";
si=lib.findItemIndex("Symbol_575");
//symbol_576.swf saved. character ID:537
si=lib.findItemIndex("symbol_576.swf");
if (si=='') {si=lib.findItemIndex("symbol_576");}
lib.items[si].name="Symbol_576";
si=lib.findItemIndex("Symbol_576");
//symbol_577.swf saved. character ID:538
si=lib.findItemIndex("symbol_577.swf");
if (si=='') {si=lib.findItemIndex("symbol_577");}
lib.items[si].name="Symbol_577";
si=lib.findItemIndex("Symbol_577");
//symbol_585.swf saved. character ID:546
si=lib.findItemIndex("symbol_585.swf");
if (si=='') {si=lib.findItemIndex("symbol_585");}
lib.items[si].name="Symbol_585";
si=lib.findItemIndex("Symbol_585");
//symbol_586.swf saved. character ID:547
si=lib.findItemIndex("symbol_586.swf");
if (si=='') {si=lib.findItemIndex("symbol_586");}
lib.items[si].name="Symbol_586";
si=lib.findItemIndex("Symbol_586");
//symbol_590.swf saved. character ID:551
si=lib.findItemIndex("symbol_590.swf");
if (si=='') {si=lib.findItemIndex("symbol_590");}
lib.items[si].name="Symbol_590";
si=lib.findItemIndex("Symbol_590");
//symbol_598.swf saved. character ID:559
si=lib.findItemIndex("symbol_598.swf");
if (si=='') {si=lib.findItemIndex("symbol_598");}
lib.items[si].name="Symbol_598";
si=lib.findItemIndex("Symbol_598");
//symbol_602.swf saved. character ID:563
si=lib.findItemIndex("symbol_602.swf");
if (si=='') {si=lib.findItemIndex("symbol_602");}
lib.items[si].name="Symbol_602";
si=lib.findItemIndex("Symbol_602");
//symbol_603.swf saved. character ID:564
si=lib.findItemIndex("symbol_603.swf");
if (si=='') {si=lib.findItemIndex("symbol_603");}
lib.items[si].name="Symbol_603";
si=lib.findItemIndex("Symbol_603");
//create Symbol_16. character ID:16
lib.addNewItem("button","Symbol_16");
lib.editItem("Symbol_16");
tl=doc.getTimeline();
tl.layers[0].name="L1";
lib.addItemToDocument({x:0, y:0},"Symbol_15");
newSel[0]=tl.layers[0].frames[0].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0);
doc.selectNone();
tl.layers[0].locked=true;
tl.addNewLayer();
tl.setSelectedFrames([0,0,0],true);
tl.setSelectedLayers(0);
tl.insertFrames(2);
tl.layers[0].name="L2";
tl.convertToBlankKeyframes(2);
lib.addItemToDocument({x:0, y:0},"Symbol_15");
newSel[0]=tl.layers[0].frames[2].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0);
doc.selectNone();
tl.layers[0].locked=true;
tl.addNewLayer();
tl.setSelectedFrames([0,2,2],true);
tl.setSelectedLayers(0);
tl.insertFrames(1);
tl.layers[0].name="L3";
tl.convertToBlankKeyframes(3);
lib.addItemToDocument({x:0, y:0},"Symbol_15");
newSel[0]=tl.layers[0].frames[3].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0);
doc.selectNone();
tl.layers[0].locked=false;
tl.layers[1].locked=false;
tl.layers[2].locked=false;
doc.exitEditMode();
//create Symbol_19. character ID:19
lib.addNewItem("movie clip","Symbol_19");
lib.editItem("Symbol_19");
tl=doc.getTimeline();
tl.layers[0].name="L1";
doc.addNewText({left:-2, top:-2, right:72, bottom:34} );
tx=tl.layers[0].frames[0].elements[0];
r0=tx.textRuns[0];
ta=r0.textAttrs;
tx.fontRenderingMode="standard";
tx.textType="dynamic";
tx.selectable=false;
tx.border=false;
tx.lineType="multiline";
tx.autoExpand=false;
ta.size=24;
ta.face="cpBurbankSmall";
ta.bold=false;
ta.italic=false;
ta.face=ta.face;
ta.indent=0;
ta.lineSpacing=2;
ta.leftMargin=0;
ta.rightMargin=0;
ta.alignment="center";
ta.letterSpacing=0;
ta.autoKern=true;
ta.fillColor="#FFFFFFFF";
doc.setTextRectangle({left:-2, top:-2, right:70, bottom:32} );
tx.renderAsHTML=true;
tx.variableName="scoreLabel";
r0.characters="0";
doc.setTextString("");
newSel[0]=tl.layers[0].frames[0].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.moveSelectionBy({x:-17, y:-6.75});
newSel[0].name="scoreLabel";
doc.selectNone();
tl.layers[0].locked=false;
tl.setSelectedFrames([0,0,0],true);
doc.exitEditMode();
//create Symbol_23. character ID:23
lib.addNewItem("movie clip","Symbol_23");
lib.editItem("Symbol_23");
tl=doc.getTimeline();
tl.setSelectedLayers(0);
tl.insertFrames(49);
tl.layers[0].name="L1";
lib.addItemToDocument({x:0, y:0},"Symbol_20");
newSel[0]=tl.layers[0].frames[0].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0);
doc.selectNone();
tl.convertToBlankKeyframes(8);
lib.addItemToDocument({x:0, y:0},"Symbol_21");
newSel[0]=tl.layers[0].frames[8].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0);
doc.selectNone();
tl.convertToBlankKeyframes(12);
lib.addItemToDocument({x:0, y:0},"Symbol_22");
newSel[0]=tl.layers[0].frames[12].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0);
doc.selectNone();
tl.layers[0].locked=false;
tl.setSelectedFrames([0,0,0],true);
doc.exitEditMode();
//create Symbol_24. character ID:24
lib.addNewItem("movie clip","Symbol_24");
lib.editItem("Symbol_24");
tl=doc.getTimeline();
tl.setSelectedLayers(0);
tl.insertFrames(14);
tl.layers[0].name="L1";
lib.addItemToDocument({x:0, y:0},"Symbol_23");
newSel[0]=tl.layers[0].frames[0].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0);
doc.moveSelectionBy({x:-409.95, y:109.85});
newSel[0].name="bag_mc";
doc.selectNone();
tl.convertToKeyframes(1);
newSel[0]=tl.layers[0].frames[1].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.moveSelectionBy({x:10.25, y:-21.35});
doc.selectNone();
tl.convertToKeyframes(2);
newSel[0]=tl.layers[0].frames[2].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.moveSelectionBy({x:11.55, y:-20.75});
doc.selectNone();
tl.convertToKeyframes(3);
newSel[0]=tl.layers[0].frames[3].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.moveSelectionBy({x:13, y:-19.9});
doc.selectNone();
tl.convertToKeyframes(4);
newSel[0]=tl.layers[0].frames[4].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.moveSelectionBy({x:14.75, y:-18.55});
doc.selectNone();
tl.convertToKeyframes(5);
newSel[0]=tl.layers[0].frames[5].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.moveSelectionBy({x:16.9, y:-16.65});
doc.selectNone();
tl.convertToKeyframes(6);
newSel[0]=tl.layers[0].frames[6].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.moveSelectionBy({x:19.3, y:-13.75});
doc.selectNone();
tl.convertToKeyframes(7);
newSel[0]=tl.layers[0].frames[7].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.moveSelectionBy({x:21.65, y:-9.65});
doc.selectNone();
tl.convertToKeyframes(8);
newSel[0]=tl.layers[0].frames[8].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.moveSelectionBy({x:23.3, y:-4.4});
doc.selectNone();
tl.convertToKeyframes(9);
newSel[0]=tl.layers[0].frames[9].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.moveSelectionBy({x:23.65, y:1});
doc.selectNone();
tl.convertToKeyframes(10);
newSel[0]=tl.layers[0].frames[10].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.moveSelectionBy({x:23.05, y:5.65});
doc.selectNone();
tl.convertToKeyframes(11);
newSel[0]=tl.layers[0].frames[11].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.moveSelectionBy({x:21.9, y:9.2});
doc.selectNone();
tl.convertToKeyframes(12);
newSel[0]=tl.layers[0].frames[12].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.moveSelectionBy({x:20.65, y:11.7});
doc.selectNone();
tl.convertToKeyframes(13);
newSel[0]=tl.layers[0].frames[13].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.moveSelectionBy({x:19.45, y:13.5});
doc.selectNone();
tl.convertToKeyframes(14);
newSel[0]=tl.layers[0].frames[14].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.moveSelectionBy({x:18.55, y:14.9});
doc.selectNone();
tl.layers[0].locked=false;
tl.addNewLayer();
tl.layers[0].name="actions";
tl.setSelectedFrames([0,0,0],true);
tl.layers[0].frames[0].actionScript=
"    throwLength = 30;\n"+
"    stop();\n";
doc.selectNone();
tl.setSelectedFrames([0,14,14],true);
tl.convertToBlankKeyframes(14);
tl.layers[0].frames[14].actionScript=
"    stop();\n"+
"    _parent.onLastFrame(this);\n";
doc.selectNone();
tl.setSelectedFrames([0,0,0],true);
doc.exitEditMode();
//create Symbol_25. character ID:25
lib.addNewItem("movie clip","Symbol_25");
lib.editItem("Symbol_25");
tl=doc.getTimeline();
tl.layers[0].name="L1";
lib.addItemToDocument({x:0, y:0},"Symbol_24");
newSel[0]=tl.layers[0].frames[0].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0);
newSel[0].name="bag";
doc.selectNone();
tl.layers[0].locked=false;
tl.addNewLayer();
tl.layers[0].name="actions";
tl.addNewLayer();
tl.layers[0].name="actions";
tl.setSelectedFrames([0,0,0],true);
tl.layers[0].frames[0].actionScript=
"    stop();\n";
doc.selectNone();
tl.setSelectedFrames([1,0,0],true);
tl.layers[1].frames[0].actionScript=
"#initclip 63\n"+
"    Object.registerClass(\"back_into_truck\", com.clubpenguin.games.beancounters.BackIntoTruckBag);\n"+
"#endinitclip\n";
doc.selectNone();
tl.setSelectedFrames([0,0,0],true);
doc.exitEditMode();
//create Symbol_31. character ID:31
lib.addNewItem("movie clip","Symbol_31");
lib.editItem("Symbol_31");
tl=doc.getTimeline();
tl.setSelectedLayers(0);
tl.insertFrames(92);
tl.layers[0].name="L1";
doc.addNewText({left:-48.1, top:-2, right:430.9, bottom:137.3} );
tx=tl.layers[0].frames[0].elements[0];
r0=tx.textRuns[0];
ta=r0.textAttrs;
tx.fontRenderingMode="standard";
tx.textType="dynamic";
tx.selectable=false;
tx.border=false;
tx.lineType="single line";
tx.autoExpand=false;
ta.size=48;
ta.face="cpBurbankSmallBold";
ta.bold=false;
ta.italic=false;
ta.face=ta.face;
ta.indent=0;
ta.lineSpacing=2;
ta.leftMargin=0;
ta.rightMargin=0;
ta.alignment="center";
ta.letterSpacing=0;
ta.autoKern=true;
ta.fillColor="#FFFFFFFF";
doc.setTextRectangle({left:-48.1, top:-2, right:428.9, bottom:135.3} );
tx.renderAsHTML=true;
tx.variableName="";
r0.characters="try again";
doc.setTextString("");
newSel[0]=tl.layers[0].frames[0].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.moveSelectionBy({x:-190.9, y:171.7});
newSel[0].name="msg_tryagain";
doc.removeAllFilters();
doc.addFilter("dropShadowFilter");
fs=doc.getFilters();
fs[0].blurX=5;
fs[0].blurY=5;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].angle=45;
fs[0].distance=0;
fs[0].knockout=false;
fs[0].inner=false;
fs[0].hideObject=false;
doc.setFilters(fs);
doc.selectNone();
tl.layers[0].locked=true;
tl.addNewLayer();
tl.setSelectedFrames([0,92,92],true);
tl.layers[0].name="L2";
tl.convertToBlankKeyframes(20);
lib.addItemToDocument({x:0, y:0},"Symbol_28");
newSel[0]=tl.layers[0].frames[20].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-87.35, y:-69.1});
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(21);
lib.addItemToDocument({x:0, y:0},"Symbol_28");
newSel[0]=tl.layers[0].frames[21].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-89.15, y:-70.8});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.02500915527344, 0, 0, 1.02500915527344);
newSel[0].colorAlphaPercent=95.3125;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(22);
lib.addItemToDocument({x:0, y:0},"Symbol_28");
newSel[0]=tl.layers[0].frames[22].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-90.95, y:-72.55});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.05000305175781, 0, 0, 1.05000305175781);
newSel[0].colorAlphaPercent=90.625;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(23);
lib.addItemToDocument({x:0, y:0},"Symbol_28");
newSel[0]=tl.layers[0].frames[23].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-92.8, y:-74.25});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.07499694824219, 0, 0, 1.07499694824219);
newSel[0].colorAlphaPercent=85.9375;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(24);
lib.addItemToDocument({x:0, y:0},"Symbol_28");
newSel[0]=tl.layers[0].frames[24].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-94.6, y:-75.95});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.10000610351563, 0, 0, 1.10000610351563);
newSel[0].colorAlphaPercent=80.859375;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(25);
lib.addItemToDocument({x:0, y:0},"Symbol_28");
newSel[0]=tl.layers[0].frames[25].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-96.4, y:-77.6});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.125, 0, 0, 1.125);
newSel[0].colorAlphaPercent=76.171875;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(26);
lib.addItemToDocument({x:0, y:0},"Symbol_28");
newSel[0]=tl.layers[0].frames[26].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-98.2, y:-79.4});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.15000915527344, 0, 0, 1.15000915527344);
newSel[0].colorAlphaPercent=71.484375;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(27);
lib.addItemToDocument({x:0, y:0},"Symbol_28");
newSel[0]=tl.layers[0].frames[27].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-100.05, y:-81.1});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.17500305175781, 0, 0, 1.17500305175781);
newSel[0].colorAlphaPercent=66.796875;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(28);
lib.addItemToDocument({x:0, y:0},"Symbol_28");
newSel[0]=tl.layers[0].frames[28].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-101.85, y:-82.8});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.19999694824219, 0, 0, 1.19999694824219);
newSel[0].colorAlphaPercent=62.109375;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(29);
lib.addItemToDocument({x:0, y:0},"Symbol_28");
newSel[0]=tl.layers[0].frames[29].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-103.65, y:-84.5});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.22500610351563, 0, 0, 1.22500610351563);
newSel[0].colorAlphaPercent=57.421875;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(30);
lib.addItemToDocument({x:0, y:0},"Symbol_28");
newSel[0]=tl.layers[0].frames[30].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-105.4, y:-86.2});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.25, 0, 0, 1.25);
newSel[0].colorAlphaPercent=52.734375;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(31);
lib.addItemToDocument({x:0, y:0},"Symbol_28");
newSel[0]=tl.layers[0].frames[31].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-107.25, y:-87.95});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.27500915527344, 0, 0, 1.27500915527344);
newSel[0].colorAlphaPercent=47.65625;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(32);
lib.addItemToDocument({x:0, y:0},"Symbol_28");
newSel[0]=tl.layers[0].frames[32].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-109.1, y:-89.65});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.30000305175781, 0, 0, 1.30000305175781);
newSel[0].colorAlphaPercent=42.96875;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(33);
lib.addItemToDocument({x:0, y:0},"Symbol_28");
newSel[0]=tl.layers[0].frames[33].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-110.9, y:-91.35});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.32499694824219, 0, 0, 1.32499694824219);
newSel[0].colorAlphaPercent=38.28125;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(34);
lib.addItemToDocument({x:0, y:0},"Symbol_28");
newSel[0]=tl.layers[0].frames[34].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-112.7, y:-93.1});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.35000610351563, 0, 0, 1.35000610351563);
newSel[0].colorAlphaPercent=33.59375;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(35);
lib.addItemToDocument({x:0, y:0},"Symbol_28");
newSel[0]=tl.layers[0].frames[35].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-114.5, y:-94.75});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.375, 0, 0, 1.375);
newSel[0].colorAlphaPercent=28.90625;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(36);
lib.addItemToDocument({x:0, y:0},"Symbol_28");
newSel[0]=tl.layers[0].frames[36].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-116.35, y:-96.5});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.40000915527344, 0, 0, 1.40000915527344);
newSel[0].colorAlphaPercent=24.21875;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(37);
lib.addItemToDocument({x:0, y:0},"Symbol_28");
newSel[0]=tl.layers[0].frames[37].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-118.15, y:-98.2});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.42500305175781, 0, 0, 1.42500305175781);
newSel[0].colorAlphaPercent=19.140625;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(38);
lib.addItemToDocument({x:0, y:0},"Symbol_28");
newSel[0]=tl.layers[0].frames[38].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-119.95, y:-99.9});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.44999694824219, 0, 0, 1.44999694824219);
newSel[0].colorAlphaPercent=14.453125;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(39);
lib.addItemToDocument({x:0, y:0},"Symbol_28");
newSel[0]=tl.layers[0].frames[39].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-121.75, y:-101.65});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.47500610351563, 0, 0, 1.47500610351563);
newSel[0].colorAlphaPercent=9.765625;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(40);
lib.addItemToDocument({x:0, y:0},"Symbol_28");
newSel[0]=tl.layers[0].frames[40].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-123.55, y:-103.35});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.5, 0, 0, 1.5);
newSel[0].colorAlphaPercent=5.078125;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(41);
tl.convertToBlankKeyframes(44);
lib.addItemToDocument({x:0, y:0},"Symbol_29");
newSel[0]=tl.layers[0].frames[44].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-87.35, y:-69.1});
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(45);
lib.addItemToDocument({x:0, y:0},"Symbol_29");
newSel[0]=tl.layers[0].frames[45].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-89.15, y:-70.8});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.02500915527344, 0, 0, 1.02500915527344);
newSel[0].colorAlphaPercent=95.3125;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(46);
lib.addItemToDocument({x:0, y:0},"Symbol_29");
newSel[0]=tl.layers[0].frames[46].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-90.95, y:-72.55});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.05000305175781, 0, 0, 1.05000305175781);
newSel[0].colorAlphaPercent=90.625;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(47);
lib.addItemToDocument({x:0, y:0},"Symbol_29");
newSel[0]=tl.layers[0].frames[47].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-92.8, y:-74.25});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.07499694824219, 0, 0, 1.07499694824219);
newSel[0].colorAlphaPercent=85.9375;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(48);
lib.addItemToDocument({x:0, y:0},"Symbol_29");
newSel[0]=tl.layers[0].frames[48].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-94.6, y:-75.95});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.10000610351563, 0, 0, 1.10000610351563);
newSel[0].colorAlphaPercent=80.859375;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(49);
lib.addItemToDocument({x:0, y:0},"Symbol_29");
newSel[0]=tl.layers[0].frames[49].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-96.4, y:-77.6});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.125, 0, 0, 1.125);
newSel[0].colorAlphaPercent=76.171875;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(50);
lib.addItemToDocument({x:0, y:0},"Symbol_29");
newSel[0]=tl.layers[0].frames[50].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-98.2, y:-79.4});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.15000915527344, 0, 0, 1.15000915527344);
newSel[0].colorAlphaPercent=71.484375;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(51);
lib.addItemToDocument({x:0, y:0},"Symbol_29");
newSel[0]=tl.layers[0].frames[51].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-100.05, y:-81.1});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.17500305175781, 0, 0, 1.17500305175781);
newSel[0].colorAlphaPercent=66.796875;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(52);
lib.addItemToDocument({x:0, y:0},"Symbol_29");
newSel[0]=tl.layers[0].frames[52].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-101.85, y:-82.8});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.19999694824219, 0, 0, 1.19999694824219);
newSel[0].colorAlphaPercent=62.109375;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(53);
lib.addItemToDocument({x:0, y:0},"Symbol_29");
newSel[0]=tl.layers[0].frames[53].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-103.65, y:-84.5});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.22500610351563, 0, 0, 1.22500610351563);
newSel[0].colorAlphaPercent=57.421875;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(54);
lib.addItemToDocument({x:0, y:0},"Symbol_29");
newSel[0]=tl.layers[0].frames[54].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-105.4, y:-86.2});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.25, 0, 0, 1.25);
newSel[0].colorAlphaPercent=52.734375;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(55);
lib.addItemToDocument({x:0, y:0},"Symbol_29");
newSel[0]=tl.layers[0].frames[55].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-107.25, y:-87.95});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.27500915527344, 0, 0, 1.27500915527344);
newSel[0].colorAlphaPercent=47.65625;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(56);
lib.addItemToDocument({x:0, y:0},"Symbol_29");
newSel[0]=tl.layers[0].frames[56].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-109.1, y:-89.65});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.30000305175781, 0, 0, 1.30000305175781);
newSel[0].colorAlphaPercent=42.96875;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(57);
lib.addItemToDocument({x:0, y:0},"Symbol_29");
newSel[0]=tl.layers[0].frames[57].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-110.9, y:-91.35});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.32499694824219, 0, 0, 1.32499694824219);
newSel[0].colorAlphaPercent=38.28125;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(58);
lib.addItemToDocument({x:0, y:0},"Symbol_29");
newSel[0]=tl.layers[0].frames[58].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-112.7, y:-93.1});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.35000610351563, 0, 0, 1.35000610351563);
newSel[0].colorAlphaPercent=33.59375;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(59);
lib.addItemToDocument({x:0, y:0},"Symbol_29");
newSel[0]=tl.layers[0].frames[59].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-114.5, y:-94.75});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.375, 0, 0, 1.375);
newSel[0].colorAlphaPercent=28.90625;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(60);
lib.addItemToDocument({x:0, y:0},"Symbol_29");
newSel[0]=tl.layers[0].frames[60].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-116.35, y:-96.5});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.40000915527344, 0, 0, 1.40000915527344);
newSel[0].colorAlphaPercent=24.21875;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(61);
lib.addItemToDocument({x:0, y:0},"Symbol_29");
newSel[0]=tl.layers[0].frames[61].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-118.15, y:-98.2});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.42500305175781, 0, 0, 1.42500305175781);
newSel[0].colorAlphaPercent=19.140625;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(62);
lib.addItemToDocument({x:0, y:0},"Symbol_29");
newSel[0]=tl.layers[0].frames[62].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-119.95, y:-99.9});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.44999694824219, 0, 0, 1.44999694824219);
newSel[0].colorAlphaPercent=14.453125;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(63);
lib.addItemToDocument({x:0, y:0},"Symbol_29");
newSel[0]=tl.layers[0].frames[63].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-121.75, y:-101.65});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.47500610351563, 0, 0, 1.47500610351563);
newSel[0].colorAlphaPercent=9.765625;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(64);
lib.addItemToDocument({x:0, y:0},"Symbol_29");
newSel[0]=tl.layers[0].frames[64].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-123.55, y:-103.35});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.5, 0, 0, 1.5);
newSel[0].colorAlphaPercent=5.078125;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(65);
tl.convertToBlankKeyframes(68);
lib.addItemToDocument({x:0, y:0},"Symbol_30");
newSel[0]=tl.layers[0].frames[68].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-87.35, y:-69.1});
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(69);
lib.addItemToDocument({x:0, y:0},"Symbol_30");
newSel[0]=tl.layers[0].frames[69].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-89.15, y:-70.8});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.02500915527344, 0, 0, 1.02500915527344);
newSel[0].colorAlphaPercent=95.3125;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(70);
lib.addItemToDocument({x:0, y:0},"Symbol_30");
newSel[0]=tl.layers[0].frames[70].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-90.95, y:-72.55});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.05000305175781, 0, 0, 1.05000305175781);
newSel[0].colorAlphaPercent=90.625;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(71);
lib.addItemToDocument({x:0, y:0},"Symbol_30");
newSel[0]=tl.layers[0].frames[71].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-92.8, y:-74.25});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.07499694824219, 0, 0, 1.07499694824219);
newSel[0].colorAlphaPercent=85.9375;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(72);
lib.addItemToDocument({x:0, y:0},"Symbol_30");
newSel[0]=tl.layers[0].frames[72].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-94.6, y:-75.95});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.10000610351563, 0, 0, 1.10000610351563);
newSel[0].colorAlphaPercent=80.859375;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(73);
lib.addItemToDocument({x:0, y:0},"Symbol_30");
newSel[0]=tl.layers[0].frames[73].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-96.4, y:-77.6});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.125, 0, 0, 1.125);
newSel[0].colorAlphaPercent=76.171875;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(74);
lib.addItemToDocument({x:0, y:0},"Symbol_30");
newSel[0]=tl.layers[0].frames[74].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-98.2, y:-79.4});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.15000915527344, 0, 0, 1.15000915527344);
newSel[0].colorAlphaPercent=71.484375;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(75);
lib.addItemToDocument({x:0, y:0},"Symbol_30");
newSel[0]=tl.layers[0].frames[75].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-100.05, y:-81.1});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.17500305175781, 0, 0, 1.17500305175781);
newSel[0].colorAlphaPercent=66.796875;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(76);
lib.addItemToDocument({x:0, y:0},"Symbol_30");
newSel[0]=tl.layers[0].frames[76].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-101.85, y:-82.8});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.19999694824219, 0, 0, 1.19999694824219);
newSel[0].colorAlphaPercent=62.109375;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(77);
lib.addItemToDocument({x:0, y:0},"Symbol_30");
newSel[0]=tl.layers[0].frames[77].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-103.65, y:-84.5});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.22500610351563, 0, 0, 1.22500610351563);
newSel[0].colorAlphaPercent=57.421875;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(78);
lib.addItemToDocument({x:0, y:0},"Symbol_30");
newSel[0]=tl.layers[0].frames[78].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-105.4, y:-86.2});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.25, 0, 0, 1.25);
newSel[0].colorAlphaPercent=52.734375;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(79);
lib.addItemToDocument({x:0, y:0},"Symbol_30");
newSel[0]=tl.layers[0].frames[79].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-107.25, y:-87.95});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.27500915527344, 0, 0, 1.27500915527344);
newSel[0].colorAlphaPercent=47.65625;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(80);
lib.addItemToDocument({x:0, y:0},"Symbol_30");
newSel[0]=tl.layers[0].frames[80].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-109.1, y:-89.65});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.30000305175781, 0, 0, 1.30000305175781);
newSel[0].colorAlphaPercent=42.96875;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(81);
lib.addItemToDocument({x:0, y:0},"Symbol_30");
newSel[0]=tl.layers[0].frames[81].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-110.9, y:-91.35});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.32499694824219, 0, 0, 1.32499694824219);
newSel[0].colorAlphaPercent=38.28125;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(82);
lib.addItemToDocument({x:0, y:0},"Symbol_30");
newSel[0]=tl.layers[0].frames[82].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-112.7, y:-93.1});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.35000610351563, 0, 0, 1.35000610351563);
newSel[0].colorAlphaPercent=33.59375;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(83);
lib.addItemToDocument({x:0, y:0},"Symbol_30");
newSel[0]=tl.layers[0].frames[83].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-114.5, y:-94.75});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.375, 0, 0, 1.375);
newSel[0].colorAlphaPercent=28.90625;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(84);
lib.addItemToDocument({x:0, y:0},"Symbol_30");
newSel[0]=tl.layers[0].frames[84].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-116.35, y:-96.5});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.40000915527344, 0, 0, 1.40000915527344);
newSel[0].colorAlphaPercent=24.21875;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(85);
lib.addItemToDocument({x:0, y:0},"Symbol_30");
newSel[0]=tl.layers[0].frames[85].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-118.15, y:-98.2});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.42500305175781, 0, 0, 1.42500305175781);
newSel[0].colorAlphaPercent=19.140625;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(86);
lib.addItemToDocument({x:0, y:0},"Symbol_30");
newSel[0]=tl.layers[0].frames[86].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-119.95, y:-99.9});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.44999694824219, 0, 0, 1.44999694824219);
newSel[0].colorAlphaPercent=14.453125;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(87);
lib.addItemToDocument({x:0, y:0},"Symbol_30");
newSel[0]=tl.layers[0].frames[87].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-121.75, y:-101.65});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.47500610351563, 0, 0, 1.47500610351563);
newSel[0].colorAlphaPercent=9.765625;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(88);
lib.addItemToDocument({x:0, y:0},"Symbol_30");
newSel[0]=tl.layers[0].frames[88].elements[0];
doc.selectNone();
doc.selection=newSel;
doc.setElementProperty("x",0);
doc.setElementProperty("y",0.2);
doc.moveSelectionBy({x:-123.55, y:-103.35});
doc.setTransformationPoint({x:0,y:0});
doc.transformSelection(1.5, 0, 0, 1.5);
newSel[0].colorAlphaPercent=5.078125;
doc.removeAllFilters();
doc.addFilter("glowFilter");
fs=doc.getFilters();
fs[0].blurX=7;
fs[0].blurY=7;
fs[0].strength=1000;
fs[0].quality="low";
fs[0].color="#000000FF";
fs[0].knockout=false;
fs[0].inner=false;
doc.setFilters(fs);
doc.selectNone();
tl.convertToBlankKeyframes(89);
tl.layers[0].locked=false;
tl.layers[1].locked=false;
tl.addNewLayer();
tl.layers[0].name="actions";
tl.addNewLayer();
tl.layers[0].name="actions";
tl.setSelectedFrames([0,0,0],true);
tl.layers[0].frames[0].actionScript=
"    msg_tryagain.text = com.clubpenguin.util.LocaleText.getText(\"msg_tryagain\").toUpperCase();\n"+
"    stop();\n";
doc.selectNone();
tl.setSelectedFrames([1,0,0],true);
tl.layers[1].frames[0].actionScript=
"#initclip 40\n"+
"    Object.registerClass(\"TryAgain\", com.clubpenguin.games.beancounters.TryAgainClip);\n"+
"#endinitclip\n";
doc.selectNone();
tl.setSelectedFrames([0,92,92],true);
tl.convertToBlankKeyframes(92);
tl.layers[0].frames[92].actionScript=
"    _parent.GC.continueLevel();\n"+
"    gotoAndStop (1);\n"+
"    this._visible = false;\n";
doc.selectNone();
tl.setSelectedFrames([0,0,0],true);
doc.exitEditMode();
