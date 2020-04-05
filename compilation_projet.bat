@echo off
rem **************************************************
rem ** script compilation de projet sur la PVcollib **
rem ** 5/4/2020                                   **
rem **************************************************

rem * Information *
rem - Le dossier de la "pvcollib" doit comporter le dossier - include - de la lib, 
rem - le dossier   - lib -  avec le fichier collib.lib et crtcol.rel  
rem - SDCC soit être installé (32 bits car les 64 bits ne reconnaisse pas les *rel
rem - le dossier devkitcol possède SDCC aprouvé par Alek Maul et sa lib. (Et fonctionnel)
rem - le dossier tools possède des utilitaire de dev pour coleco
rem - exemple d'organisation :
rem
rem  \repertoire_colecovision 
rem  ...........\emultwo 
rem  .....................emultwo.exe
rem  .....................fichier fonctionnel emultwo...

rem ............\devkitcol
rem ......................\bin
rem ......................\include
rem ......................\lib
rem ......................\tools

rem  ............\projets
rem  .....................\Nom_votre_projet
rem  ...........................\bin (pour recevoir votre .rom genere)
rem  ...........................\source
rem  ..................................\header
rem  .........................................fichier.h
rem  ...................................fichier.c
rem  ...........................compilation_projet.bat (ce fichier tout simplement)
 
rem  ............\pvcollib
rem  ....................\include
rem  ...........................\coleco
rem  ..................................fichier.h de la librairie
rem  ............................coleco.h 
rem  .....................\lib
rem  .........................collib.lib
rem  .........................crtcol.rel

rem ==================================
rem ** Configuration du fichier bat **
rem =================== ==============
rem --------------
rem - Nom du jeu -
rem --------------
set nom=programme
rem ------------------------------
rem - Nom du repertoir de sortie -
rem ------------------------------
set sortie=bin
rem -----------------------------------
rem - Nom du repertoir du code source -
rem -----------------------------------
SET dsource=source
rem -------------------------------------
rem - lien du dossier de la pvcollib -
rem -------------------------------------
SET adrsdk=..\..\pvcollib
rem --------------------------
rem - Lien de l'émulateur -
rem --------------------------
SET adremul=..\..\emultwo\emultwo.exe

rem --------------------------
rem - Lien du compilateur    -
rem --------------------------
SET l_compilateur=..\..\devkitcol\bin

rem -----------------------------
rem - Standard de programmation -
rem -----------------------------
rem --std-c89 : --std-c95 : --std-c99 :--std-c11 :--std-c2x
SET standard_c = --std-c99



rem ===============================================================
rem ** Test si le repertoir de sortie existe sinon il est genere **
rem ===============================================================

if not exist %sortie% mkdir %sortie%

echo ----------------------------------------------
echo -- compilation du projet %nom%
echo ----------------------------------------------
rem ===========================
rem ** Effacement du fichier **
rem ===========================
if exist "%sortie%\%nom%.rom" del %sortie%\%nom%.rom

echo -------------------------------------------
echo -- Creation de la ROM pour colecovision  --
echo -------------------------------------------

rem ================================
rem ** Compilation des fichiers C **
rem ================================ 
echo -----------------
echo -- compilation --
echo -----------------
for %%i in (%dsource%\*.c) do ( 
echo %%~nxi


%l_compilateur%\sdcc -c -mz80  -I%adrsdk%/include %standard_c% --opt-code-size  %dsource%/%%~nxi
 )

pause

rem =================================
rem ** linkage des fichiers objets **
rem =================================
echo -------------
echo -- linkage --
echo -------------

%l_compilateur%\sdcc -o coleco.ihx -mz80 --vc --no-std-crt0  --code-loc 0x8048 --data-loc 0x7000 %adrsdk%/lib/crtcol.rel %adrsdk%/lib/collib.lib *.rel 

echo -----------------------------
echo -- Creation du fichier rom --
echo -----------------------------
%l_compilateur%\sdobjcopy -R .sec5 -I ihex -O binary --pad-to 0xffff --gap-fill 0xff coleco.ihx %sortie%/%nom%.rom 

echo.
if exist "%sortie%/%nom%.rom" echo --- Le fichier %nom%.rom vient d'etre genere dans le repertoir %sortie% ---
echo.

rem ==============
rem ** Netoyage **
rem ==============
echo ----------------------------------------------------------------
echo - Debut effacement des fichiers sym,ihx,lk,noi,rel,lst,asm,map -
echo ----------------------------------------------------------------
pause


if exist "*.sym" del *.sym
if exist "*.ihx" del *.ihx
if exist "*.lk"  del *.lk
if exist "*.noi" del *.noi
if exist "*.rel" del *.rel
if exist "*.lst" del *.lst
if exist "*.asm" del *.asm
if exist "*.map" del *.map
pause



if exist "%sortie%/%nom%.rom" %adremul% %sortie%/%nom%.rom


exit


