# colecovision
Des fichier d'aide pour la pvcollib d'alek maul

Voici un petit github four tout sur la programmation de la colecovision avec la librairie d'alek maul. PVcollib.
https://github.com/alekmaul/pvcollib

-Le fichier Compilation.bat
permet de compiler la librairie d'alek maul en cas ou si elle ne fonctionne pas sur windows. 
Il est fréquent de recompiler la lib. Le fichier se place à coté  du dossier "source" de sa lib et roule ma poule.
Le fichier type CRT0.rel et son fichier .lib se crée et à vous de les placer au bonne endroit. (ou de suivre mon organisation)

-Le fichier compilation_projet.bat 
permet de générer son projet c en .rom. C'est le .bat de compilation de projet.
Une archytecture est précise est vitale mais il est possible de configurer le bouzin.
Je n'utilise pas de makefile et les liens sont en relatif. C'est très portable.



rem  \repertoire_colecovision 
rem  ...........\emultwo 
rem  .....................emultwo.exe
rem  .....................fichier fonctionnel emultwo...

rem  ............\projets
rem  .....................\Nom_votre_projet
rem  ...........................\bin (pour recevoir votre .rom genere)
rem  ...........................\source
rem  ..................................\header
rem  .........................................fichier.h
rem  ...................................fichier.c
rem  ...........................compilation.bat

rem  ............\pvcollib
rem  ....................\include
rem  ...........................\coleco
rem  ..................................fichier.h de la librairie
rem  ............................coleco.h 
rem  .....................\lib
rem  .........................collib.lib
rem  .........................crtcol.rel
