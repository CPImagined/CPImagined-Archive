//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.ui.itembuttons.BuyButtonFactory
    {
        function BuyButtonFactory () {
        }
        static function getBuyButton(item, itemMC) {
            switch (item.type) {
                case com.clubpenguin.party.items.FurnitureItem.TYPE : 
                    return(new com.clubpenguin.ui.itembuttons.BuyFurnitureItemButton(item, itemMC));
                case com.clubpenguin.party.items.IglooItem.TYPE : 
                    return(new com.clubpenguin.ui.itembuttons.BuyIglooItemButton(item, itemMC));
                case com.clubpenguin.party.items.IglooLocationItem.TYPE : 
                    return(new com.clubpenguin.ui.itembuttons.BuyIglooLocationItemButton(item, itemMC));
                case com.clubpenguin.party.items.PaperItem.TYPE : 
                    return(new com.clubpenguin.ui.itembuttons.BuyPaperItemButton(item, itemMC));
                case com.clubpenguin.party.items.PuffleItem.TYPE : 
                    return(new com.clubpenguin.ui.itembuttons.BuyPuffleItemButton(item, itemMC));
            }
            return(null);
        }
    }
