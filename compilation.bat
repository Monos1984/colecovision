@echo off

rem -------------------------------------------------------
rem * Fichier compilation.bat de la PVcolliob d'alek maul *
rem * version du 15/12/2019                               *
rem -------------------------------------------------------

rem ------------------
rem * Mode d'emplois *
rem ------------------
rem fichier bat qui permet de compiler la librairie d'alek maul "PVcollib" sur colecovision.
rem A place à coté du dossier "source" de la librairie PVcollib.
rem Deux fichiers vont se crées à coté de ce .bat. crtcol.rel et collib.lib. A replacer dans le dossier lib.


echo compilation de lib coleco

rem -----------------------------------------------------------------------
rem * Routine pour compiler les .s en .rel contenu dans le dossier source *
rem -----------------------------------------------------------------------
for %%i in (source\*s) do (

sdasz80 -o source/%%~nxi
)


rem -----------------------------------------------------------------------------------------------------------
rem * Copier le fichier crtcol.rel pour le placer à coté du .bat et affecement de ce .rel contenu dans source *
rem -----------------------------------------------------------------------------------------------------------
copy source\crtcol.rel crtcol.rel
del  source\crtcol.rel

rem -----------------------------------------------------------------------------------------------------------
rem * réunir les fichier .rel contenu dans source (et donc sans le crtcol.rel effacé pour faire la collib.lib *
rem -----------------------------------------------------------------------------------------------------------
sdcclib collib.lib source/*.rel

echo fichier crtcol.rel et collib.lib compiles !
pause



