//Created by Action Script Viewer - https://www.buraks.com/asv
package com.clubpenguin.main.mediator
{
    import org.robotlegs.mvcs.Mediator;
    import com.clubpenguin.main.view.ui.PizzaTossLoadingAnimation;
    import com.clubpenguin.main.view.ui.SnowShovelLoadingAnimation;
    import com.clubpenguin.main.view.ui.CartSurferLoadingAnimation;
    import com.clubpenguin.main.view.ui.LoadingScreenView;
    import com.clubpenguin.main.model.LoadingScreenModel;
    import com.clubpenguin.main.signal.SignalBus;
    import com.clubpenguin.main.MainContext;
    import com.clubpenguin.main.view.LogoView;
    import flash.events.KeyboardEvent;
    import org.osflash.signals.Signal;

    public class LoadingScreenViewMediator extends Mediator 
    {

        private static const _animationClasses:Array = [PizzaTossLoadingAnimation, SnowShovelLoadingAnimation, CartSurferLoadingAnimation];

        [Inject]
        public var view:LoadingScreenView;
        [Inject]
        public var loadingScreenModel:LoadingScreenModel;
        [Inject]
        public var signalBus:SignalBus;
        [Inject]
        public var mainContext:MainContext;
        private var _usedAnimationIndices:Array;


        override public function onRegister():void
        {
            this.loadingScreenModel.viewStateChanged.add(this.onViewStateChange);
            this.loadingScreenModel.progressChanged.add(this.onProgressChanged);
            this._usedAnimationIndices = [];
        }

        override public function onRemove():void
        {
            this.loadingScreenModel.viewStateChanged.removeAll();
            this.loadingScreenModel.progressChanged.removeAll();
        }

        private function onProgressChanged():void
        {
            this.view.loadingBar.progressBar.scaleX = this.loadingScreenModel.progress;
        }

        private function onViewStateChange():void
        {
            if (this.loadingScreenModel.isShowing)
            {
                this.show();
            }
            else
            {
                this.hide();
            };
        }

        public function show():void
        {
            var logoView:LogoView;
            var animationClass:Class;
            this.view.visible = true;
            if (((this.loadingScreenModel.loadingText.length > 0) && (!(this.loadingScreenModel.isLoginFloodControlActive))))
            {
                this.view.loadingBar.visible = false;
                this.view.loadingBar.spinner.stop();
                this.view.loadingText.text = this.loadingScreenModel.loadingText;
            }
            else
            {
                this.view.loadingText.visible = false;
                this.view.loadingBar.spinner.gotoAndPlay(1);
                this.view.loadingBar.progressBar.scaleX = 0;
            };
            if (this.loadingScreenModel.isLogoScreen)
            {
                logoView = this.mainContext.getLogoView();
                this.view.addChild(logoView);
                logoView.play();
                this.view.loadingBar.y = (this.view.loadingBar.y + 100);
                contextView.stage.addEventListener(KeyboardEvent.KEY_UP, this.loadingScreenModel.onKeyPressedDuringLogo);
                logoView.addEventListener(LogoView.ANIMATION_COMPLETE, this.loadingScreenModel.onLogoAnimationComplete);
            }
            else
            {
                animationClass = _animationClasses[this.getRandomAnimationIndex()];
                this.view.addChild(new (animationClass)());
            };
            this.loadingScreenModel.checkLoginFloodControl();
        }

        public function hide():void
        {
            var logoView:LogoView;
            if (this.loadingScreenModel.isLogoScreen)
            {
                logoView = this.mainContext.getLogoView();
                contextView.stage.removeEventListener(KeyboardEvent.KEY_UP, this.loadingScreenModel.onKeyPressedDuringLogo);
                logoView.removeEventListener(LogoView.ANIMATION_COMPLETE, this.loadingScreenModel.onLogoAnimationComplete);
            };
            Signal(this.signalBus.closeView).dispatch(this.view);
        }

        private function getRandomAnimationIndex():uint
        {
            var randomIndex:uint;
            if (this._usedAnimationIndices.length == _animationClasses.length)
            {
                this._usedAnimationIndices = [];
            };
            do 
            {
                randomIndex = uint(Math.floor((_animationClasses.length * Math.random())));
            } while (this._usedAnimationIndices.indexOf(randomIndex) != -1);
            this._usedAnimationIndices.push(randomIndex);
            return (randomIndex);
        }


    }
}//package com.clubpenguin.main.mediator
