package com.clubpenguin.tools.localtext.component
{
    import com.clubpenguin.tools.localtext.core.*;

    public interface ILocalTextComponent
    {

        public function ILocalTextComponent();

        function get localTextField() : ILocalTextField;

        function getMetaData() : String;

    }
}
