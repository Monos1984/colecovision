
  
@echo off

rem -------------------------------------------------------
rem * Fichier compilation.bat de la PVcolliob d'alek maul *
rem * version du 4/04/2020                                *
rem -------------------------------------------------------
rem Modification :
rem création automatique du dossier lib si il n'est pas présent.
rem effacement de l'ancient crtcol et collib si seulement ils sont présent dans le dossier lib.




rem ------------------
rem * Mode d'emplois *
rem ------------------
rem fichier bat qui permet de compiler la librairie d'alek maul "PVcollib" sur colecovision.
rem A place à coté du dossier "source et include" de la librairie PVcollib.
rem Deux fichiers vont se crées dans le dossier lib. crtcol.rel et collib.lib.

if not exist lib echo ===========================
if not exist lib echo * creation du dossier lib *
if not exist lib echo ===========================
if not exist lib mkdir lib

if exist lib\crtcol.rel del lib\crtcol.rel
if exist lib\collib.lib del lib\collib.lib

echo ================================
echo * Compilation de la lib coleco *
echo ================================
rem -----------------------------------------------------------------------
rem * Routine pour compiler les .s en .rel contenu dans le dossier source *
rem -----------------------------------------------------------------------
for %%i in (source\*s) do (

sdasz80 -o source/%%~nxi
)


rem -------------------------------------------------------------------------------------------------------------
rem * Copier le fichier crtcol.rel pour le placer dans le dossier lib et netoyages des .rel contenu dans source *
rem -------------------------------------------------------------------------------------------------------------
copy source\crtcol.rel lib\crtcol.rel
del  source\crtcol.rel

rem -----------------------------------------------------------------------------------------------------------
rem * réunir les fichier .rel contenu dans source (et donc sans le crtcol.rel effacé pour faire la collib.lib *
rem -----------------------------------------------------------------------------------------------------------
sdcclib collib.lib source/*.rel
copy collib.lib lib\collib.lib
del collib.lib

echo =============================================
echo * fichier crtcol.rel et collib.lib compiles *
echo =============================================
pause


