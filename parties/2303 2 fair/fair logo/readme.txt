This folder contains files created by ASV (https://www.buraks.com/asv) that will help you rebuild a .FLA file for the SWF file "C:\Users\Devon\Desktop\fair logo\logo.swf". Flash CS6 is required. Please refer to ASV help for more information.

You need to do the following:

1- Run Flash and open the file "logo_rebuild.fla" using File|Open command (at least Flash CS6 is required). (You can avoid this step by not selecting 'use relative paths' JSFL preference in ASV).

2- Double-click on the "rebuildcommand.jsfl" script in this folder.

(When importing FLV files, the following options must be selected:
Where is your video file? On your computer, Embed FLV in SWF and play in timeline.
How would you like to embed the video? Symbol type: Embedded video. Place instance on stage option must be unchecked.).

Note: During complex rebuilds, Flash may crash. In such cases, following workarounds may help:

Workaround 1 - Instead of running 'rebuildcommand.jsfl', run each JSFL script in the 'jsfl' folder manually (by double-clicking) in this order: 'import.jsfl', 'rebuildpart1.jsfl', 'rebuildpart2.jsfl' ... and so on. Wait for each script to finish before running the next.

Workaround 2 - ASV offers a 'JSFL Prompted Rebuild Mode'. When this mode is enabled, JSFL files are divided into smaller parts, Flash will display an alert dialog after each part is completed and the dialog must be dismissed before the next JSFL script is run. A helper program named 'asvac.exe' which clicks OK button automatically to close the dialog can be found in ASV installation folder. This mode is controlled via 'JsflPromptedMode' setting in ASV.INI file.

3- Review any notes below and fine tune the FLA.

Notes:

Original SWF version is 17.

1 fonts saved. [If a saved font is not already installed on your system, open the saved font file by double-clicking on it (which will temporarily install the font), then keep the font file open during rebuild].

Warning: SWF does not specify a document class. Dummy document class created.
