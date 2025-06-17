//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.merch.ninja.CardNotFoundError extends Error
    {
        function CardNotFoundError (message) {
            super(message);
        }
        var message = "# Error: No card found for that ID.";
        var name = "CardNotFoundError";
    }
