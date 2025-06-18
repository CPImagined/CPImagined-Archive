This folder contains files created by ASV (https://www.buraks.com/asv) that will help you rebuild a .FLA file for the SWF file "E:\Club\PO\bean\new bean\BeanCounters.swf". Flash CS6 is required. Please refer to ASV help for more information.

You need to do the following:

1- Run Flash and open the file "BeanCounters_rebuild.fla" using File|Open command (at least Flash CS6 is required). (You can avoid this step by not selecting 'use relative paths' JSFL preference in ASV).

2- Double-click on the "rebuildcommand.jsfl" script in this folder.

(When importing FLV files, the following options must be selected:
Where is your video file? On your computer, Embed FLV in SWF and play in timeline.
How would you like to embed the video? Symbol type: Embedded video. Place instance on stage option must be unchecked.).

Note: During complex rebuilds, Flash may crash. In such cases, following workarounds may help:

Workaround 1 - Instead of running 'rebuildcommand.jsfl', run each JSFL script in the 'jsfl' folder manually (by double-clicking) in this order: 'import.jsfl', 'rebuildpart1.jsfl', 'rebuildpart2.jsfl' ... and so on. Wait for each script to finish before running the next.

Workaround 2 - ASV offers a 'JSFL Prompted Rebuild Mode'. When this mode is enabled, JSFL files are divided into smaller parts, Flash will display an alert dialog after each part is completed and the dialog must be dismissed before the next JSFL script is run. A helper program named 'asvac.exe' which clicks OK button automatically to close the dialog can be found in ASV installation folder. This mode is controlled via 'JsflPromptedMode' setting in ASV.INI file.*** This rebuild was exported in 'JSFL Prompted Rebuild Mode' ***

3- Review any notes below and fine tune the FLA.

Notes:

Original SWF version is 9.

warning: For version 9 SWF files, Flash Player may throw a null reference error at runtime when a movieclip keyframe is sought using gotoAndStop/gotoAndPlay methods, and a child symbol of the movieclip is accessed via its instance name. If this error occurs, most likely with dynamic text symbols, setting SWF version to 10+ will solve the issue, but may result in other script errors. As a workaround you can choose to clear the sought (target) keyframes, if the rebuilt SWF will be acceptable without the properties modified on the keyframes. (location of the keyframes can be found by searching for the instance names where the runtime errors occur) This is an issue of Flash Player and the SWF file (which may even not be produced by Flash) so there is no real workaround possible.

5 fonts saved. [If a saved font is not already installed on your system, open the saved font file by double-clicking on it (which will temporarily install the font), then keep the font file open during rebuild].

Warning: Alpha value changed from 0/255 to 1/255 for symbol 299 (character ID:299).
Warning: Converting html to plain text for Editable text 18 on frame 1 in movieclip 19.
Warning: Converting html to plain text for Editable text 27 on frame 1 in movieclip 31.
Warning: Converting html to plain text for Editable text 218 on frame 1 in movieclip 219.
Warning: Converting html to plain text for Editable text 221 on frame 1 in movieclip 222.
Warning: Converting html to plain text for Editable text 224 on frame 1 in movieclip 225.
Warning: 1 extra layer(s) created to fix mask conflict(s) in timeline of symbol 326 (ChrID: 326).
Warning: Converting html to plain text for Editable text 541 on frame 1 in movieclip 542.
Warning: Converting html to plain text for Editable text 557 on frame 1 in movieclip 558.
Warning: Converting html to plain text for Editable text 561 on frame 2 in movieclip 566.
Warning: Converting html to plain text for Editable text 562 on frame 2 in movieclip 566.
Warning: Converting html to plain text for Editable text 575 on frame 1 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 3 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 7 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 10 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 14 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 17 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 21 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 24 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 28 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 31 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 35 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 37 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 38 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 39 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 40 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 41 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 42 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 43 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 44 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 45 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 46 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 47 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 48 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 49 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 50 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 51 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 52 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 53 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 54 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 55 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 56 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 57 in movieclip 576.
Warning: Converting html to plain text for Editable text 575 on frame 58 in movieclip 576.
Warning: Converting html to plain text for Editable text 567 on frame 2.
Warning: Converting html to plain text for Editable text 569 on frame 2.
Warning: Converting html to plain text for Editable text 571 on frame 2.
Warning: Converting html to plain text for Editable text 573 on frame 2.
