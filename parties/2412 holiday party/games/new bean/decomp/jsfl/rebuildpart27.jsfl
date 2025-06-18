var doc=fl.getDocumentDOM();
var tl=doc.getTimeline();
var lib=doc.library;
var newSel=new Array();
var si,li,ci,pi,tx,r0,nr,cx,cy,el,sm;

//embed font Symbol_17. character ID:17
if (fl.isFontInstalled("cpBurbankSmall")){
lib.addNewItem("font","Symbol_17");
li=lib.items[lib.findItemIndex("Symbol_17")];
if (li.font!="cpBurbankSmall") {li.font="cpBurbankSmall";}
li.bold=false;
li.italic=false;
li.embeddedCharacters=" !\u0022#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\u005C]^_`abcdefghijklmnopqrstuvwxyz{|}~ ¡¢£¥§¨©ª«®¯°²³´¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ\u02C6\u02DC\u0401\u0402\u0403\u0404\u0405\u0406\u0407\u0408\u0409\u040A\u040B\u040C\u040E\u040F\u0410\u0411\u0412\u0413\u0414\u0415\u0416\u0417\u0418\u0419\u041A\u041B\u041C\u041D\u041E\u041F\u0420\u0421\u0422\u0423\u0424\u0425\u0426\u0427\u0428\u0429\u042A\u042B\u042C\u042D\u042E\u042F\u0430\u0431\u0432\u0433\u0434\u0435\u0436\u0437\u0438\u0439\u043A\u043B\u043C\u043D\u043E\u043F\u0440\u0441\u0442\u0443\u0444\u0445\u0446\u0447\u0448\u0449\u044A\u044B\u044C\u044D\u044E\u044F\u0451\u0452\u0453\u0454\u0455\u0456\u0457\u0458\u0459\u045A\u045B\u045C\u045E\u045F\u0490\u0491\u2013\u2014\u2018\u2019\u201A\u201C\u201D\u201E\u2020\u2021\u2022\u2026\u2030\u2039\u203A\u2044\u20AC\u2116\u2120\u2122";
li.bitmap=false;
} else {fl.trace("Message from ASV: required font 'cpBurbankSmall' is not installed. Open the saved font file in 'fonts' folder by double-clicking on it and leave it open, exit Flash, then restart the rebuild.");}
//embed font Symbol_26. character ID:26
if (fl.isFontInstalled("cpBurbankSmallBold")){
lib.addNewItem("font","Symbol_26");
li=lib.items[lib.findItemIndex("Symbol_26")];
if (li.font!="cpBurbankSmallBold") {li.font="cpBurbankSmallBold";}
li.bold=false;
li.italic=false;
li.embeddedCharacters=" !\u0022#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\u005C]^_`abcdefghijklmnopqrstuvwxyz{|}~ ¡¢£¥§¨©ª«®¯°²³´¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ\u02C6\u02DC\u0401\u0402\u0403\u0404\u0405\u0406\u0407\u0408\u0409\u040A\u040B\u040C\u040E\u040F\u0410\u0411\u0412\u0413\u0414\u0415\u0416\u0417\u0418\u0419\u041A\u041B\u041C\u041D\u041E\u041F\u0420\u0421\u0422\u0423\u0424\u0425\u0426\u0427\u0428\u0429\u042A\u042B\u042C\u042D\u042E\u042F\u0430\u0431\u0432\u0433\u0434\u0435\u0436\u0437\u0438\u0439\u043A\u043B\u043C\u043D\u043E\u043F\u0440\u0441\u0442\u0443\u0444\u0445\u0446\u0447\u0448\u0449\u044A\u044B\u044C\u044D\u044E\u044F\u0451\u0452\u0453\u0454\u0455\u0456\u0457\u0458\u0459\u045A\u045B\u045C\u045E\u045F\u0490\u0491\u2013\u2014\u2018\u2019\u201A\u201C\u201D\u201E\u2020\u2021\u2022\u2026\u2030\u2039\u203A\u2044\u20AC\u2116\u2120\u2122";
li.bitmap=false;
} else {fl.trace("Message from ASV: required font 'cpBurbankSmallBold' is not installed. Open the saved font file in 'fonts' folder by double-clicking on it and leave it open, exit Flash, then restart the rebuild.");}
//embed font Symbol_217. character ID:217
if (fl.isFontInstalled("cpCCComicrazy")){
lib.addNewItem("font","Symbol_217");
li=lib.items[lib.findItemIndex("Symbol_217")];
if (li.font!="cpCCComicrazy") {li.font="cpCCComicrazy";}
li.bold=false;
li.italic=false;
li.embeddedCharacters=" !\u0022#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\u005C]^_`abcdefghijklmnopqrstuvwxyz{|}~ ¡¢£¥¦§¨©ª«¬®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ\u02C6\u02DC\u0401\u0402\u0403\u0404\u0405\u0406\u0407\u0408\u0409\u040A\u040B\u040C\u040E\u040F\u0410\u0411\u0412\u0413\u0414\u0415\u0416\u0417\u0418\u0419\u041A\u041B\u041C\u041D\u041E\u041F\u0420\u0421\u0422\u0423\u0424\u0425\u0426\u0427\u0428\u0429\u042A\u042B\u042C\u042D\u042E\u042F\u0430\u0431\u0432\u0433\u0434\u0435\u0436\u0437\u0438\u0439\u043A\u043B\u043C\u043D\u043E\u043F\u0440\u0441\u0442\u0443\u0444\u0445\u0446\u0447\u0448\u0449\u044A\u044B\u044C\u044D\u044E\u044F\u0451\u0452\u0453\u0454\u0455\u0456\u0457\u0458\u0459\u045A\u045B\u045C\u045E\u045F\u0490\u0491\u2013\u2014\u2018\u2019\u201A\u201C\u201D\u201E\u2020\u2021\u2022\u2026\u2030\u2039\u203A\u2044\u20AC\u2116\u2122\u2126";
li.bitmap=false;
} else {fl.trace("Message from ASV: required font 'cpCCComicrazy' is not installed. Open the saved font file in 'fonts' folder by double-clicking on it and leave it open, exit Flash, then restart the rebuild.");}
//embed font Symbol_335. character ID:335
if (fl.isFontInstalled("cpBurbankBgWdBold")){
lib.addNewItem("font","Symbol_335");
li=lib.items[lib.findItemIndex("Symbol_335")];
if (li.font!="cpBurbankBgWdBold") {li.font="cpBurbankBgWdBold";}
li.bold=false;
li.italic=false;
li.embeddedCharacters=" !\u0022#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\u005C]^_`abcdefghijklmnopqrstuvwxyz{|}~ ¡¢£¥§¨©ª«®¯°²³´¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ\u02C6\u02DC\u0401\u0402\u0403\u0404\u0405\u0406\u0407\u0408\u0409\u040A\u040B\u040C\u040E\u040F\u0410\u0411\u0412\u0413\u0414\u0415\u0416\u0417\u0418\u0419\u041A\u041B\u041C\u041D\u041E\u041F\u0420\u0421\u0422\u0423\u0424\u0425\u0426\u0427\u0428\u0429\u042A\u042B\u042C\u042D\u042E\u042F\u0430\u0431\u0432\u0433\u0434\u0435\u0436\u0437\u0438\u0439\u043A\u043B\u043C\u043D\u043E\u043F\u0440\u0441\u0442\u0443\u0444\u0445\u0446\u0447\u0448\u0449\u044A\u044B\u044C\u044D\u044E\u044F\u0451\u0452\u0453\u0454\u0455\u0456\u0457\u0458\u0459\u045A\u045B\u045C\u045E\u045F\u0490\u0491\u2013\u2014\u2018\u2019\u201A\u201C\u201D\u201E\u2020\u2021\u2022\u2026\u2030\u2039\u203A\u2044\u20AC\u2116\u2120\u2122";
li.bitmap=false;
} else {fl.trace("Message from ASV: required font 'cpBurbankBgWdBold' is not installed. Open the saved font file in 'fonts' folder by double-clicking on it and leave it open, exit Flash, then restart the rebuild.");}
//embed font Symbol_570. character ID:531
if (fl.isFontInstalled("cpGeorgia")){
lib.addNewItem("font","Symbol_570");
li=lib.items[lib.findItemIndex("Symbol_570")];
if (li.font!="cpGeorgia") {li.font="cpGeorgia";}
li.bold=false;
li.italic=false;
li.embeddedCharacters=" !\u0022#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\u005C]^_`abcdefghijklmnopqrstuvwxyz{|}~ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ\u02C6\u02DC\u0401\u0402\u0403\u0404\u0405\u0406\u0407\u0408\u0409\u040A\u040B\u040C\u040E\u040F\u0410\u0411\u0412\u0413\u0414\u0415\u0416\u0417\u0418\u0419\u041A\u041B\u041C\u041D\u041E\u041F\u0420\u0421\u0422\u0423\u0424\u0425\u0426\u0427\u0428\u0429\u042A\u042B\u042C\u042D\u042E\u042F\u0430\u0431\u0432\u0433\u0434\u0435\u0436\u0437\u0438\u0439\u043A\u043B\u043C\u043D\u043E\u043F\u0440\u0441\u0442\u0443\u0444\u0445\u0446\u0447\u0448\u0449\u044A\u044B\u044C\u044D\u044E\u044F\u0451\u0452\u0453\u0454\u0455\u0456\u0457\u0458\u0459\u045A\u045B\u045C\u045E\u045F\u0490\u0491\u2013\u2014\u2015\u2017\u2018\u2019\u201A\u201B\u201C\u201D\u201E\u2020\u2021\u2022\u2026\u2030\u2032\u2033\u2039\u203A\u203C\u203E\u2044\u20A3\u20A4\u20A7\u20AC\u2105\u2113\u2116\u2120\u2122\u2126\u212E\u215B\u215C\u215D\u215E";
li.bitmap=false;
} else {fl.trace("Message from ASV: required font 'cpGeorgia' is not installed. Open the saved font file in 'fonts' folder by double-clicking on it and leave it open, exit Flash, then restart the rebuild.");}
