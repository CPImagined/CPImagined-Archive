//Created by Action Script Viewer - https://www.buraks.com/asv
    class com.clubpenguin.world.rooms.common.AssemblyPart
    {
        var disassembledPart, assembledPart, preRequisite, xCorrection, yCorrection;
        function AssemblyPart (disassembledPart, assembledPart, preRequisite, xCorrection, yCorrection) {
            this.disassembledPart = disassembledPart;
            this.assembledPart = assembledPart;
            this.preRequisite = preRequisite;
            this.xCorrection = xCorrection;
            this.yCorrection = yCorrection;
        }
    }
