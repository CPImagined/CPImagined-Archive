//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.merch.catalogs.CatalogOpcodeJournal
    {
        var clothingTypes, furnitureTypes, iglooUpgradeTypes;
        function CatalogOpcodeJournal (learnerId) {
            clothingTypes = new Array();
            clothingTypes[INVENTORY_TYPE_COLOUR] = "DDC6F4D5-3C6D-D62D-E032-03E147F45E60";
            clothingTypes[INVENTORY_TYPE_HEAD] = "B65955B0-4F8E-BB3B-AA08-E8E0F4ED094F";
            clothingTypes[INVENTORY_TYPE_FACE] = "0ED3CC07-DF3A-FA1D-912E-D7C2B7E64D78";
            clothingTypes[INVENTORY_TYPE_NECK] = "0BBCC80B-4B7D-7296-0D72-EC0E0EB154C3";
            clothingTypes[INVENTORY_TYPE_BODY] = "77C691BB-2A0F-A041-9CB4-5F818E3F1004";
            clothingTypes[INVENTORY_TYPE_HAND] = "24E7E47E-EAB8-A103-A234-65AC0561B269";
            clothingTypes[INVENTORY_TYPE_FEET] = "109A5737-6BC3-B162-9E0C-763B52A388D4";
            clothingTypes[INVENTORY_TYPE_FLAG] = "745251DE-4AE0-BC26-1A48-80ED5229E681";
            clothingTypes[INVENTORY_TYPE_PHOTO] = "4EE15FF4-85D0-C25F-11D3-449264447A4E";
            clothingTypes[INVENTORY_TYPE_OTHER] = "B18B5912-C7D9-E04E-7072-F701D6A30BC4";
            furnitureTypes = new Array();
            furnitureTypes[FURNITURE_TYPE_ROOM] = "35E78E74-FF35-1F55-E958-6A3FC9308FEF";
            furnitureTypes[FURNITURE_TYPE_WALL] = "65F6B0F9-6FAF-DCD8-C037-95CFF93FC7B0";
            furnitureTypes[FURNITURE_TYPE_FLOOR] = "EE3E018D-0C68-CE07-B42A-E1F207AD9573";
            iglooUpgradeTypes = new Array();
            iglooUpgradeTypes[IGLOO_UPGRADE] = "403D0198-E3BE-572E-051A-28E4CB8F51A4";
        }
        function buyClothes(itemId, type) {
            if ((type == null) || (type == undefined)) {
                type = 9;
            }
            if ((itemId < 546) && (itemId > 499)) {
            } else if (checkIfSpecialItem(itemId)) {
            }
        }
        function buyFurniture(itemId, type) {
            if ((type == null) || (type == undefined)) {
                type = 0;
            }
            if (checkIfSpecialItem(itemId)) {
            }
        }
        function buyIglooUpgrade(iglooId, type) {
            if ((type == null) || (type == undefined)) {
                type = 0;
            }
            if (checkIfSpecialItem(iglooId)) {
            }
        }
        function insufficientFunds() {
        }
        function dlsmCallback(returnString) {
        }
        function checkIfSpecialItem(itemId) {
            switch (itemId) {
                case 782 : 
                    return(true);
                case 263 : 
                    return(true);
                case 424 : 
                    return(true);
                case 660 : 
                    return(true);
                case 4209 : 
                    return(true);
                case 1137 : 
                    return(true);
                case 1239 : 
                    return(true);
                case 4318 : 
                    return(true);
                case 383 : 
                    return(true);
                case 4064 : 
                    return(true);
                case 7051 : 
                case 7052 : 
                case 7053 : 
                case 7054 : 
                case 7055 : 
                case 7056 : 
                    return(true);
                case 7016 : 
                    return(true);
                case 678 : 
                    return(true);
                case 681 : 
                    return(true);
                case 612 : 
                    return(true);
                case 369 : 
                    return(true);
                case 344 : 
                    return(true);
                case 345 : 
                    return(true);
                case 626 : 
                    return(true);
                case 31 : 
                    return(true);
                case 767 : 
                case 123 : 
                case 302 : 
                case 124 : 
                case 315 : 
                case 489 : 
                case 995 : 
                    return(true);
                case 195 : 
                    return(true);
                case 765 : 
                    return(true);
                case 766 : 
                    return(true);
                case 4455 : 
                    return(true);
                case 4455 : 
                    return(true);
                case 4457 : 
                    return(true);
                case 1317 : 
                case 5128 : 
                case 4449 : 
                    return(true);
                case 1317 : 
                case 5128 : 
                case 4449 : 
                    return(true);
                case 729 : 
                    return(true);
                case 293 : 
                    return(true);
                case 233 : 
                    return(true);
                case 234 : 
                    return(true);
                case 349 : 
                    return(true);
                case 180 : 
                    return(true);
                case 1342 : 
                    return(true);
                case 4291 : 
                    return(true);
                case 4290 : 
                    return(true);
                case 4289 : 
                    return(true);
                case 4466 : 
                    return(true);
                case 4467 : 
                    return(true);
                case 4468 : 
                    return(true);
                case 1106 : 
                case 2014 : 
                case 4146 : 
                    return(true);
            }
            return(false);
        }
        var INVENTORY_TYPE_COLOUR = 0;
        var INVENTORY_TYPE_HEAD = 1;
        var INVENTORY_TYPE_FACE = 2;
        var INVENTORY_TYPE_NECK = 3;
        var INVENTORY_TYPE_BODY = 4;
        var INVENTORY_TYPE_HAND = 5;
        var INVENTORY_TYPE_FEET = 6;
        var INVENTORY_TYPE_FLAG = 7;
        var INVENTORY_TYPE_PHOTO = 8;
        var INVENTORY_TYPE_OTHER = 9;
        var FURNITURE_TYPE_ROOM = 0;
        var FURNITURE_TYPE_WALL = 1;
        var FURNITURE_TYPE_FLOOR = 2;
        var IGLOO_UPGRADE = 0;
        var NOT_ENOUGH_COINS = "DF2A58E5-3544-3BCE-6252-5583C4A0BB2E";
        var INVENTORY_FLAG = "745251DE-4AE0-BC26-1A48-80ED5229E681";
    }
