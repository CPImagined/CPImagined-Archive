//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.puffles.adoption.commands
{
    import org.robotlegs.mvcs.SignalCommand;
    import com.clubpenguin.main.signal.as2world.HideAS2WorldSignal;
    import com.clubpenguin.puffles.adoption.model.AdoptionModel;
    import com.clubpenguin.puffles.adoption.view.RainbowAdoptionView;
    import com.clubpenguin.puffles.adoption.view.GoldAdoptionView;
    import com.clubpenguin.puffles.adoption.view.DinoAdoptionView;
    import com.clubpenguin.puffles.adoption.view.PuffleAdoptionView;
    import com.clubpenguin.puffles.adoption.view.SnowAdoptionView;
    import com.clubpenguin.puffles.adoption.view.GhostAdoptionView;
    import com.clubpenguin.puffles.adoption.view.CrystalAdoptionView;
    import com.clubpenguin.puffles.adoption.view.PufflePenView;
    import com.clubpenguin.puffles.adoption.view.EmbeddedAdoptionAssets;

    public class SetupViewsCommand extends SignalCommand 
    {

        [Inject]
        public var hideAS2WorldSignal:HideAS2WorldSignal;
        [Inject]
        public var model:AdoptionModel;


        override public function execute():void
        {
            var rainbowAdoptionView:RainbowAdoptionView;
            var goldPuffleAdoptionView:GoldAdoptionView;
            var dinoPuffleAdoptionView:DinoAdoptionView;
            var puffleAdoptionView:PuffleAdoptionView;
            var snowPuffleAdoptView:SnowAdoptionView;
            var ghostPuffleAdoptView:GhostAdoptionView;
            var crystalPuffleAdoptView:CrystalAdoptionView;
            var pufflePen:PufflePenView;
            var puffleAdoptionType:String = this.model.puffleAdoptType;
            switch (puffleAdoptionType)
            {
                case "rainbow":
                    rainbowAdoptionView = new RainbowAdoptionView(EmbeddedAdoptionAssets.RainbowAdoptionAsset);
                    contextView.addChild(rainbowAdoptionView);
                    break;
                case "gold":
                    goldPuffleAdoptionView = new GoldAdoptionView(EmbeddedAdoptionAssets.GoldAdoptionAsset);
                    contextView.addChild(goldPuffleAdoptionView);
                    break;
                case "1000":
                case "1001":
                case "1002":
                case "1003":
                case "1004":
                case "1005":
                    this.model.puffleAdoptionTypeId = Number(puffleAdoptionType);
                    dinoPuffleAdoptionView = new DinoAdoptionView(EmbeddedAdoptionAssets.DinoAdoptionAsset);
                    contextView.addChild(dinoPuffleAdoptionView);
                    break;
                case "1008":
                case "1009":
                case "1010":
                case "1011":
                case "1012":
                case "1013":
                case "1014":
                case "1015":
                case "1016":
                case "1017":
                case "1018":
                case "1019":
                case "1020":
                case "1024":
                case "1025":
                case "1026":
                case "1027":
                    this.model.puffleAdoptionTypeId = Number(puffleAdoptionType);
                    puffleAdoptionView = new PuffleAdoptionView(EmbeddedAdoptionAssets.PuffleAdoptionAsset);
                    contextView.addChild(puffleAdoptionView);
                    break;
                case "1021":
                    this.model.puffleAdoptionTypeId = Number(puffleAdoptionType);
                    snowPuffleAdoptView = new SnowAdoptionView(EmbeddedAdoptionAssets.SnowAdoptionAsset);
                    contextView.addChild(snowPuffleAdoptView);
                    break;
                case "1022":
                    this.model.puffleAdoptionTypeId = Number(puffleAdoptionType);
                    ghostPuffleAdoptView = new GhostAdoptionView(EmbeddedAdoptionAssets.GhostAdoptionAsset);
                    contextView.addChild(ghostPuffleAdoptView);
                    break;
                case "1023":
                    this.model.puffleAdoptionTypeId = Number(puffleAdoptionType);
                    crystalPuffleAdoptView = new CrystalAdoptionView(EmbeddedAdoptionAssets.CrystalAdoptionAsset);
                    contextView.addChild(crystalPuffleAdoptView);
                    break;
                default:
                    pufflePen = new PufflePenView(EmbeddedAdoptionAssets.PufflePenAsset);
                    contextView.addChild(pufflePen);
            };
            this.hideAS2WorldSignal.dispatch();
        }


    }
}//package com.clubpenguin.puffles.adoption.commands
