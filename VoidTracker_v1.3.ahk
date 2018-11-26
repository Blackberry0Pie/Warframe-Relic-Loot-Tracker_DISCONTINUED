;v1.3
#SingleInstance force
#Include OCR_capitals.ahk
#Include LevenshteinDistance.ahk

global minRewardLength = 10 ;minus 4
global undercountmulti = 0.65
global widthToScan := A_ScreenWidth*3/4
global heightToScan := A_ScreenHeight*1/40
global topLeftX := A_ScreenWidth*1/8
global topLeftY := A_ScreenHeight*7/16
global topLeftY2 := A_ScreenHeight*33/80 ;A_ScreenHeight*7/16 - A_ScreenHeight*1/40

;unpack resources ---------------------------------
SetWorkingDir, %A_AppData%
FileCreateDir, VoidTracker
SetWorkingDir, VoidTracker
FileCreateDir, GUI\blueprint
FileCreateDir, GUI\misc
FileCreateDir, GUI\warframe
FileCreateDir, GUI\weapon


FileInstall, djpeg.exe, djpeg.exe
FileInstall, gocr.exe, gocr.exe

FileInstall, GUI\gold.png, GUI\gold.png
FileInstall, GUI\move.png, GUI\move.png
FileInstall, GUI\25D.png, GUI\25D.png
;FileInstall, GUI\corner.png, GUI\corner.png

FileInstall, GUI\blueprint\archwing_harness.png, GUI\blueprint\archwing_harness.png
FileInstall, GUI\blueprint\archwing_systems.png, GUI\blueprint\archwing_systems.png
FileInstall, GUI\blueprint\archwing_wings.png, GUI\blueprint\archwing_wings.png
FileInstall, GUI\blueprint\Barrel.png, GUI\blueprint\Barrel.png
FileInstall, GUI\blueprint\Blade.inverted.png, GUI\blueprint\Blade.inverted.png
FileInstall, GUI\blueprint\Blade.png, GUI\blueprint\Blade.png
FileInstall, GUI\blueprint\Blueprint.crop.png, GUI\blueprint\Blueprint.crop.png
FileInstall, GUI\blueprint\Chassis.png, GUI\blueprint\Chassis.png
FileInstall, GUI\blueprint\Grip.png, GUI\blueprint\Grip.png
FileInstall, GUI\blueprint\Guard.png, GUI\blueprint\Guard.png
FileInstall, GUI\blueprint\Handle.png, GUI\blueprint\Handle.png
FileInstall, GUI\blueprint\Link.png, GUI\blueprint\Link.png
FileInstall, GUI\blueprint\Neuroptics.png, GUI\blueprint\Neuroptics.png
FileInstall, GUI\blueprint\Receiver.png, GUI\blueprint\Receiver.png
FileInstall, GUI\blueprint\Stock.png, GUI\blueprint\Stock.png
FileInstall, GUI\blueprint\Systems.png, GUI\blueprint\Systems.png

FileInstall, GUI\misc\Carrier.png, GUI\misc\Carrier.png
FileInstall, GUI\misc\Forma.png, GUI\misc\Forma.png
FileInstall, GUI\misc\Helios.png, GUI\misc\Helios.png
FileInstall, GUI\misc\Kavasa.png, GUI\misc\Kavasa.png
FileInstall, GUI\misc\Odonata.crop.gradient.png, GUI\misc\Odonata.crop.gradient.png

FileInstall, GUI\warframe\Ash.png, GUI\warframe\Ash.png
FileInstall, GUI\warframe\Banshee.png, GUI\warframe\Banshee.png
FileInstall, GUI\warframe\Ember.png, GUI\warframe\Ember.png
FileInstall, GUI\warframe\Frost.png, GUI\warframe\Frost.png
FileInstall, GUI\warframe\Mag.png, GUI\warframe\Mag.png
FileInstall, GUI\warframe\Nekros.png, GUI\warframe\Nekros.png
FileInstall, GUI\warframe\Nova.png, GUI\warframe\Nova.png
FileInstall, GUI\warframe\Nyx.png, GUI\warframe\Nyx.png
FileInstall, GUI\warframe\Oberon.png, GUI\warframe\Oberon.png
FileInstall, GUI\warframe\Saryn.png, GUI\warframe\Saryn.png
FileInstall, GUI\warframe\Trinity.png, GUI\warframe\Trinity.png
FileInstall, GUI\warframe\Valkyr.png, GUI\warframe\Valkyr.png
FileInstall, GUI\warframe\Vauban.png, GUI\warframe\Vauban.png
FileInstall, GUI\warframe\Volt.png, GUI\warframe\Volt.png

FileInstall, GUI\weapon\Akbronco.png, GUI\weapon\Akbronco.png
FileInstall, GUI\weapon\Akstiletto.png, GUI\weapon\Akstiletto.png
FileInstall, GUI\weapon\Boar.png, GUI\weapon\Boar.png
FileInstall, GUI\weapon\Braton.png, GUI\weapon\Braton.png
FileInstall, GUI\weapon\Bronco.png, GUI\weapon\Bronco.png
FileInstall, GUI\weapon\Burston.png, GUI\weapon\Burston.png
FileInstall, GUI\weapon\Cernos.png, GUI\weapon\Cernos.png
FileInstall, GUI\weapon\Dakra.png, GUI\weapon\Dakra.png
FileInstall, GUI\weapon\DualKamas.png, GUI\weapon\DualKamas.png
FileInstall, GUI\weapon\Euphona.png, GUI\weapon\Euphona.png
FileInstall, GUI\weapon\Fang.png, GUI\weapon\Fang.png
FileInstall, GUI\weapon\Fragor.png, GUI\weapon\Fragor.png
FileInstall, GUI\weapon\Galatine.png, GUI\weapon\Galatine.png
FileInstall, GUI\weapon\Glaive.png, GUI\weapon\Glaive.png
FileInstall, GUI\weapon\Hikou.png, GUI\weapon\Hikou.png
FileInstall, GUI\weapon\Latron.png, GUI\weapon\Latron.png
FileInstall, GUI\weapon\Lex.png, GUI\weapon\Lex.png
FileInstall, GUI\weapon\Nikana.png, GUI\weapon\Nikana.png
FileInstall, GUI\weapon\Orthos.png, GUI\weapon\Orthos.png
FileInstall, GUI\weapon\Paris.png, GUI\weapon\Paris.png
FileInstall, GUI\weapon\Reaper.png, GUI\weapon\Reaper.png
FileInstall, GUI\weapon\Scindo.png, GUI\weapon\Scindo.png
FileInstall, GUI\weapon\Sicarus.png, GUI\weapon\Sicarus.png
FileInstall, GUI\weapon\Silva.png, GUI\weapon\Silva.png
FileInstall, GUI\weapon\Soma.png, GUI\weapon\Soma.png
FileInstall, GUI\weapon\Spira.png, GUI\weapon\Spira.png
FileInstall, GUI\weapon\Sybaris.png, GUI\weapon\Sybaris.png
FileInstall, GUI\weapon\Tigris.png, GUI\weapon\Tigris.png
FileInstall, GUI\weapon\Vasto.png, GUI\weapon\Vasto.png
FileInstall, GUI\weapon\Vectis.png, GUI\weapon\Vectis.png
FileInstall, GUI\weapon\Venka.png, GUI\weapon\Venka.png
;end unpack resources ---------------------------------

global rewardArray := ["FORMABLUEPRINT", "AKBRONCOPRIMEBLUEPRINT", "AKBRONCOPRIMELINK", "AKSTILETTOPRIMEBLUEPRINT", "AKSTILETTOPRIMEBARREL", "AKSTILETTOPRIMERECEIVER", "AKSTILETTOPRIMELINK", "ASHPRIMEBLUEPRINT", "ASHPRIMECHASSISBLUEPRINT", "ASHPRIMENEUROPTICSBLUEPRINT"
    , "ASHPRIMESYSTEMSBLUEPRINT", "BOARPRIMEBLUEPRINT", "BOARPRIMEBARREL", "BOARPRIMERECEIVER", "BOARPRIMESTOCK", "BRATONPRIMEBLUEPRINT", "BRATONPRIMEBARREL", "BRATONPRIMERECEIVER", "BRATONPRIMESTOCK", "BRONCOPRIMEBLUEPRINT", "BRONCOPRIMEBARREL"
    , "BRONCOPRIMERECEIVER", "BURSTONPRIMEBLUEPRINT", "BURSTONPRIMEBARREL", "BURSTONPRIMERECEIVER", "BURSTONPRIMESTOCK", "CARRIERPRIMEBLUEPRINT", "CARRIERPRIMECARAPACE", "CARRIERPRIMECEREBRUM", "CARRIERPRIMESYSTEMS", "DAKRAPRIMEBLUEPRINT", "DAKRAPRIMEBLADE"
    , "DAKRAPRIMEHANDLE", "DUALKAMASPRIMEBLUEPRINT", "DUALKAMASPRIMEBLADE", "DUALKAMASPRIMEHANDLE", "FANGPRIMEBLUEPRINT", "FANGPRIMEBLADE", "FANGPRIMEHANDLE", "FRAGORPRIMEBLUEPRINT", "FRAGORPRIMEHEAD", "FRAGORPRIMEHANDLE", "GALATINEPRIMEBLUEPRINT"
    , "GALATINEPRIMEBLADE", "GALATINEPRIMEHANDLE"
    , "HIKOUPRIMEBLUEPRINT", "HIKOUPRIMESTARS", "HIKOUPRIMEPOUCH", "KAVASAPRIMEKUBROWCOLLARBLUEPRINT", "KAVASAPRIMEBAND", "KAVASAPRIMEBUCKLE"
    , "LEXPRIMEBLUEPRINT", "LEXPRIMEBARREL", "LEXPRIMERECEIVER", "MAGPRIMEBLUEPRINT", "MAGPRIMECHASSISBLUEPRINT"
    , "MAGPRIMENEUROPTICSBLUEPRINT", "MAGPRIMESYSTEMSBLUEPRINT", "NEKROSPRIMEBLUEPRINT", "NEKROSPRIMECHASSISBLUEPRINT", "NEKROSPRIMENEUROPTICSBLUEPRINT", "NEKROSPRIMESYSTEMSBLUEPRINT", "NIKANAPRIMEBLUEPRINT", "NIKANAPRIMEBLADE", "NIKANAPRIMEHILT"
    , "NOVAPRIMEBLUEPRINT", "NOVAPRIMECHASSISBLUEPRINT", "NOVAPRIMENEUROPTICSBLUEPRINT", "NOVAPRIMESYSTEMSBLUEPRINT", "NYXPRIMEBLUEPRINT", "NYXPRIMECHASSISBLUEPRINT", "NYXPRIMENEUROPTICSBLUEPRINT", "NYXPRIMESYSTEMSBLUEPRINT", "ODONATAPRIMEBLUEPRINT"
    , "ODONATAPRIMEHARNESSBLUEPRINT", "ODONATAPRIMESYSTEMSBLUEPRINT", "ODONATAPRIMEWINGSBLUEPRINT", "ORTHOSPRIMEBLUEPRINT", "ORTHOSPRIMEBLADE", "ORTHOSPRIMEHANDLE", "PARISPRIMEBLUEPRINT", "PARISPRIMEUPPERLIMB", "PARISPRIMEGRIP", "PARISPRIMELOWERLIMB"
    , "PARISPRIMESTRING", "SARYNPRIMEBLUEPRINT", "SARYNPRIMECHASSISBLUEPRINT", "SARYNPRIMENEUROPTICSBLUEPRINT", "SARYNPRIMESYSTEMSBLUEPRINT", "SCINDOPRIMEBLUEPRINT", "SCINDOPRIMEBLADE", "SCINDOPRIMEHANDLE", "SOMAPRIMEBLUEPRINT", "SOMAPRIMEBARREL"
    , "SOMAPRIMERECEIVER", "SOMAPRIMESTOCK", "SPIRAPRIMEBLUEPRINT", "SPIRAPRIMEBLADE", "SPIRAPRIMEPOUCH", "TIGRISPRIMEBLUEPRINT"
    , "TIGRISPRIMEBARREL", "TIGRISPRIMERECEIVER", "TIGRISPRIMESTOCK"
    , "TRINITYPRIMEBLUEPRINT", "TRINITYPRIMECHASSISBLUEPRINT", "TRINITYPRIMENEUROPTICSBLUEPRINT", "TRINITYPRIMESYSTEMSBLUEPRINT"
    , "VASTOPRIMEBARREL", "VASTOPRIMEBLUEPRINT", "VASTOPRIMERECEIVER", "VAUBANPRIMEBLUEPRINT", "VAUBANPRIMECHASSISBLUEPRINT", "VAUBANPRIMENEUROPTICSBLUEPRINT", "VAUBANPRIMESYSTEMSBLUEPRINT", "VECTISPRIMEBLUEPRINT", "VECTISPRIMEBARREL", "VECTISPRIMERECEIVER"
    , "VECTISPRIMESTOCK", "VOLTPRIMEBLUEPRINT", "VOLTPRIMECHASSISBLUEPRINT", "VOLTPRIMENEUROPTICSBLUEPRINT", "VOLTPRIMESYSTEMSBLUEPRINT"
    , "VALKYRPRIMEBLUEPRINT", "VALKYRPRIMECHASSISBLUEPRINT", "VALKYRPRIMENEUROPTICSBLUEPRINT", "VALKYRPRIMESYSTEMSBLUEPRINT"
    , "EMBERPRIMEBLUEPRINT", "EMBERPRIMECHASSISBLUEPRINT", "EMBERPRIMENEUROPTICSBLUEPRINT", "EMBERPRIMESYSTEMSBLUEPRINT", "FROSTPRIMEBLUEPRINT", "FROSTPRIMECHASSISBLUEPRINT", "FROSTPRIMENEUROPTICSBLUEPRINT", "FROSTPRIMESYSTEMSBLUEPRINT"
    , "CERNOSPRIMEBLUEPRINT", "CERNOSPRIMEUPPERLIMB", "CERNOSPRIMEGRIP", "CERNOSPRIMELOWERLIMB", "CERNOSPRIMESTRING", "VENKAPRIMEBLUEPRINT", "VENKAPRIMEBLADE", "VENKAPRIMEGAUNTLET"
    , "GLAIVEPRIMEBLUEPRINT", "GLAIVEPRIMEBLADE", "GLAIVEPRIMEDISC", "LATRONPRIMEBLUEPRINT", "LATRONPRIMEBARREL", "LATRONPRIMERECEIVER", "LATRONPRIMESTOCK"
    , "REAPERPRIMEBLUEPRINT", "REAPERPRIMEBLADE", "REAPERPRIMEHANDLE", "SICARUSPRIMEBLUEPRINT", "SICARUSPRIMEBARREL", "SICARUSPRIMERECEIVER", "SYBARISPRIMEBLUEPRINT", "SYBARISPRIMEBARREL", "SYBARISPRIMERECEIVER", "SYBARISPRIMESTOCK"
    , "SILVAPRIMEBLUEPRINT", "SILVAPRIMEBLADE", "SILVAPRIMEGUARD", "SILVAPRIMEHILT", "EUPHONAPRIMEBLUEPRINT", "EUPHONAPRIMEBARREL", "EUPHONAPRIMERECEIVER", "HELIOSPRIMEBLUEPRINT", "HELIOSPRIMECARAPACE", "HELIOSPRIMECEREBRUM", "HELIOSPRIMESYSTEMS"
    , "BANSHEEPRIMEBLUEPRINT", "BANSHEEPRIMECHASSIS", "BANSHEEPRIMENEUROPTICS", "BANSHEEPRIMESYSTEMS", "OBERONPRIMEBLUEPRINT", "OBERONPRIMECHASSIS", "OBERONPRIMENEUROPTICS", "OBERONPRIMESYSTEMS"]
    
global setArray := ["Forma", "Akbronco", "Akbronco", "Akstiletto", "Akstiletto", "Akstiletto", "Akstiletto", "Ash", "Ash", "Ash", "Ash", "Boar", "Boar", "Boar"
    , "Boar", "Braton", "Braton", "Braton", "Braton", "Bronco", "Bronco", "Bronco", "Burston", "Burston", "Burston", "Burston", "Carrier", "Carrier"
    , "Carrier", "Carrier", "Dakra", "Dakra", "Dakra", "DualKamas", "DualKamas", "DualKamas", "Fang", "Fang", "Fang", "Fragor", "Fragor", "Fragor"
    , "Galatine", "Galatine", "Galatine", "Hikou", "Hikou", "Hikou", "Kavasa", "Kavasa", "Kavasa", "Lex", "Lex", "Lex", "Mag", "Mag", "Mag"
    , "Mag", "Nekros", "Nekros", "Nekros", "Nekros", "Nikana", "Nikana", "Nikana", "Nova", "Nova", "Nova", "Nova", "Nyx"
    , "Nyx", "Nyx", "Nyx", "Odonata", "Odonata", "Odonata", "Odonata", "Orthos", "Orthos", "Orthos", "Paris", "Paris", "Paris"
    , "Paris", "Paris", "Saryn", "Saryn", "Saryn", "Saryn", "Scindo", "Scindo", "Scindo", "Soma", "Soma", "Soma", "Soma", "Spira"
    , "Spira", "Spira", "Tigris", "Tigris", "Tigris", "Tigris", "Trinity", "Trinity", "Trinity", "Trinity", "Vasto", "Vasto", "Vasto", "Vauban"
    , "Vauban", "Vauban", "Vauban", "Vectis", "Vectis", "Vectis", "Vectis", "Volt", "Volt", "Volt", "Volt", "Valkyr"
    , "Valkyr", "Valkyr", "Valkyr", "Ember", "Ember", "Ember", "Ember", "Frost", "Frost", "Frost", "Frost", "Cernos"
    , "Cernos", "Cernos", "Cernos", "Cernos", "Venka", "Venka", "Venka", "Glaive", "Glaive", "Glaive", "Latron", "Latron", "Latron", "Latron"
    , "Reaper", "Reaper", "Reaper", "Sicarus", "Sicarus", "Sicarus", "Sybaris", "Sybaris", "Sybaris", "Sybaris", "Silva", "Silva", "Silva", "Silva"
    , "Euphona", "Euphona", "Euphona", "Helios", "Helios", "Helios", "Helios", "Banshee", "Banshee", "Banshee", "Banshee", "Oberon", "Oberon", "Oberon", "Oberon"]
    
global partArray := ["BP", "BP", "Link", "BP", "Barrel", "Receiver", "Link", "BP", "Chassis", "Neuroptics", "Systems", "BP", "Barrel", "Receiver"
    , "Stock", "BP", "Barrel", "Receiver", "Stock", "BP", "Barrel", "Receiver", "BP", "Barrel", "Receiver", "Stock", "BP", "Carapace"
    , "Cerebrum", "Systems", "BP", "Blade", "Handle", "BP", "Blade", "Handle", "BP", "Blade", "Handle", "BP", "Head", "Handle"
    , "BP", "Blade", "Handle", "BP", "Stars", "Pouch", "BP", "Band", "Buckle", "BP", "Barrel", "Receiver", "BP", "Chassis", "Neuroptics"
    , "Systems", "BP", "Chassis", "Neuroptics", "Systems", "BP", "Blade", "Hilt", "BP", "Chassis", "Neuroptics", "Systems", "BP"
    , "Chassis", "Neuroptics", "Systems", "BP", "Harness", "Systems", "Wings", "BP", "Blade", "Handle", "BP", "UpperLimb", "Grip"
    , "LowerLimb", "String", "BP", "Chassis", "Neuroptics", "Systems", "BP", "Blade", "Handle", "BP", "Barrel", "Receiver", "Stock", "BP"
    , "Blade", "Pouch", "BP", "Barrel", "Receiver", "Stock", "BP", "Chassis", "Neuroptics", "Systems", "BP", "Barrel", "Receiver", "BP"
    , "Chassis", "Neuroptics", "Systems", "BP", "Barrel", "Receiver", "Stock", "BP", "Chassis", "Neuroptics", "Systems", "BP"
    , "Chassis", "Neuroptics", "Systems", "BP", "Chassis", "Neuroptics", "Systems", "BP", "Chassis", "Neuroptics", "Systems", "BP"
    , "UpperLimb", "Grip", "LowerLimb", "String", "BP", "Blade", "Gauntlet", "BP", "Blade", "Disc", "BP", "Barrel", "Receiver", "Stock"
    , "BP", "Blade", "Handle", "BP", "Barrel", "Receiver", "BP", "Barrel", "Receiver", "Stock", "BP", "Blade", "Guard", "Hilt"
    , "BP", "Barrel", "Receiver", "BP", "Carapace", "Cerebrum", "Systems", "BP", "Chassis", "Neuroptics", "Systems", "BP", "Chassis", "Neuroptics", "Systems"]

gosub, iniread

global FormaBPKeys := "Lots!"
global AkbroncoBPKeys := "MO1C`n[LS2]C`n[LS3]C`n[MS3]C"
global AkbroncoLinkKeys := "LA2U`n[LN1]U`n[LS5]U`n[AS1]U"
global AkstilettoBPKeys := "LA2R`n[LA1]R`n[NA1]R"
global AkstilettoBarrelKeys := "AA1U`nAH2U"
global AkstilettoReceiverKeys := "AO1U`n[AH1]U`n[AK1]U`n[AT1]U"
global AkstilettoLinkKeys := "MO1U`n[NN5]U`n[AN1]U"
global AshBPKeys := "[LS3]U`n[MC1]U`n[MS3]U"
global AshChassisKeys := "[MV2]C`n[NN4]C`n[AB1]C"
global AshNeuropticsKeys := "[MN2]U`n[NN3]U`n[NV4]U`n[AN2]U"
global AshSystemsKeys := "[NN5]U`n[AN1]R"
global BoarBPKeys := "[ND1]C"
global BoarBarrelKeys := "[AV2]U"
global BoarReceiverKeys := "[LM1]C"
global BoarStockKeys := "[MB1]R"
global BratonBPKeys := "AC2C`nLN3U`nLV3C`n[MV1]U`n[AN1]C"
global BratonBarrelKeys := "MS5C`n[LA1]C`n[MN3]C`n[NA1]C"
global BratonReceiverKeys := "[AV2]U`n[AV3]U`nAV5U"
global BratonStockKeys := "AE2C`nNB2C`n[MN1]C`n[MN3]C`n[NN4]C`nNV2C`nAA1C"
global BroncoBPKeys := "MV5C`n[LN1]C`n[LS1]C`n[MC2]C`n[MN2]C`n[MN3]C`nMS2C`n[AN2]C`n[AS1]C"
global BroncoBarrelKeys := "AE2U`n[NV1]U`n[AN3]U"
global BroncoReceiverKeys :="NN6C`nMF1C`n[NB1]C`n[NN4]C`n[NV4]C`n[AS1]C"
global BurstonBPKeys := "NT1C`n[MV1]C"
global BurstonBarrelKeys := "NV5U`n[LF2]U`n[NB1]U`n[AT1]U"
global BurstonReceiverKeys := "LN3C`n[LS5]C`n[NS3]C"
global BurstonStockKeys := "MS5C`n[LK1]C`n[LV1]C`n[NS2]C"
global CarrierBPKeys := "[MV1]C`n[MV3]C`n[NS3]C"
global CarrierCarapaceKeys := "[LS5]C`n[NS1]C`n[AN2]C"
global CarrierCerebrumKeys := "[LC1]R`n[MC1]R`n[MC2]R`n[MN3]U"
global CarrierSystemsKeys := "[LS2]C`n[LS3]C`n[LN2]C`n[NA1]C`n[NV3]C`n[AV1]C"
global DakraBPKeys := "[LM1]U"
global DakraBladeKeys := "[ND1]R"
global DakraHandleKeys := "[MB1]C"
global DualKamasBPKeys := "NT1C`nLS6C`n[NV1]C`n[AN3]C`n[AV1]C`nAV5C"
global DualKamasBladeKeys := "MD1R"
global DualKamasHandleKeys := "MF1U`n[MN1]U`nAA1U"
global FangBPKeys := "NB2C`nMS4C`n[LK1]C`nLV2C`n[MN1]C`n[NN2]C`n[NS5]C",
global FangBladeKeys := "AB2C`nMS6C`nLS6C`n[LC1]C`n[LF1]C`n[LN1]C`n[LS5]C`n[AB1]C`n[AN1]C"
global FangHandleKeys := "AH2C`nNT1U`nMS4U`n[LF2]U`n[MN1]C`n[MN2]C`n[NN3]U`nNV2C"
global FragorBPKeys := "[LF1]R`nMF1R"
global FragorHeadKeys := "AB2C`nAA1C`n[AH1]C"
global FragorHandleKeys := "AC2U`n[LV1]R"
global GalatineBPKeys := "AG1R"
global GalatineBladeKeys := "NN6C`nMS4C`n[MC2]C`nMS2C`nNV2C`n[NV3]C"
global GalatineHandleKeys := "AO1U`n[LS5]U`nNV2U"
global HikouBPKeys := "[LS1]C`n[MN2]C"
global HikouStarsKeys := "[LF2]C`n[NN1]C"
global HikouPouchKeys := "[AK1]C`n[AV2]C"
global KavasaBPKeys := "LS4U`n[NN1]U`nAG1U"
global KavasaBandKeys := "LS6U`n[LC1]U`n[LN2]U`n[LS2]U`n[MV3]U"
global KavasaBuckleKeys := "[LK1]R`n[AB1]U`n[AK1]R"
global LexBPKeys := "LS4C`nMD1C`n[NN2]C"
global LexBarrelKeys := "MS5C`nLA2C`nLV2C`n[NN3]C`n[NS1]C`n[NS5]C`n[AK1]C"
global LexReceiverKeys := "AH2C`nAE2C`n[LM1]C`n[AC1]C`n[AN2]C"
global MagBPKeys := "[LM1]R"
global MagChassisKeys := "[MB1]U"
global MagNeuropticsKeys := "[AV2]C"
global MagSystemsKeys := "[ND1]C"
global NekrosBPKeys := "LN3R`n[LN2]C`n[MN3]R`n[AN3]R"
global NekrosChassisKeys := "LV4C`n[LN1]C`n[MS3]C`nAG1C"
global NekrosNeuropticsKeys := "MF1U"
global NekrosSystemsKeys := "[NN3]R"
global NikanaBPKeys := "[NN5]R`nAA1R"
global NikanaBladeKeys := "MN4R`n[MV2]R`n[NN4]R"
global NikanaHiltKeys := "NN6R`n[AN2]R"
global NovaBPKeys := "[NN2]U"
global NovaChassisKeys := "[LN1]R`n[NV1]R"
global NovaNeuropticsKeys := "[LC1]C`n[MC1]C"
global NovaSystemsKeys := "[LC1]C`n[MS1]C`n[NS2]C"
global NyxBPKeys := "[LS2]C`n[NV1]C"
global NyxChassisKeys := "[NN1]R"
global NyxNeuropticsKeys := "[MN1]R"
global NyxSystemsKeys := "[NS2]U"
global OdonataBPKeys := "[LF1]U`n[MC2]U`n[MS1]U"
global OdonataHarnessKeys := "[LK1]C`n[AK1]C`n[AT1]C`n[AV4]C"
global OdonataSystemsKeys := "[LF2]C`n[NN3]C`n[AV1]C"
global OdonataWingsKeys := "[AN1]U"
global OrthosBPKeys := "AB2U`n[MB1]U`n[AC1]U`n[AV3]U"
global OrthosBladeKeys := "MD1U"
global OrthosHandleKeys := "MN4C`n[MB1]C`nMD1C"
global ParisBPKeys := "AO1C`nAE2C`n[LF1]C`nLS4C`n[MS1]C`n[MV2]C`nAG1C`n[AV4]C"
global ParisUpperLimbKeys := "MN4C`n[LF2]C`n[LN2]C`n[LV1]C`nLV2U`n[MS1]U`n[NS2]U`n[AN3]C"
global ParisGripKeys := "[LS1]U`nMS2U"
global ParisLowerLimbKeys := "MO1C`n[LV1]C`nLV2C`nLV3C`nMF1C`n[NS2]C`n[NS5]C"
global ParisStringKeys := "NV5C`n[LS1]C`n[LS3]C`nMS2C`n[NB1]C`n[NN3]C`n[NN4]C`n[NV3]C"
global SarynBPKeys := "MS4R`nLS4R`n[NS1]R"
global SarynChassisKeys := "MS2R`n[NS2]R"
global SarynNeuropticsKeys := "MS5U`n[LA1]U`n[NV4]U"
global SarynSystemsKeys := "MN4C`n[MC1]C`nMF1C`n[NN5]C`nAG1C`n[AT1]C"
global ScindoBPKeys := "[LF1]U"
global ScindoBladeKeys := "[AS1]R"
global ScindoHandleKeys := "[MC1]U"
global SomaBPKeys := "[LM1]U`n[NS1]C"
global SomaBarrelKeys := "[NS3]C"
global SomaReceiverKeys := "[LS3]U`n[NN1]U"
global SomaStockKeys := "[LS2]R`n[MS1]R"
global SpiraBPKeys := "MV5C`nLV4C`n[LN2]C`n[MV1]C`n[MV3]C"
global SpiraBladeKeys := "MS6R`n[LS5]R`n[NS3]R"
global SpiraPouchKeys := "LS6R`n[LS1]R`n[LS3]R`n[MS3]R"
global TigrisBPKeys := "NT1R`n[AT1]R"
global TigrisBarrelKeys := "LV3U`nLV4U`n[LK1]U"
global TigrisReceiverKeys := "MS6U`n[NV3]U`nAV5U"
global TigrisStockKeys := "NB2C`n[MS1]C`n[NV4]C"
global TrinityBPKeys := "NN6U`nMS4U`n[LK1]U`n[AS1]U"
global TrinityChassisKeys := "AH2U`nLS4U`n[NS1]U`n[AH1]U"
global TrinityNeuropticsKeys := "NN7C`n[ND1]U`n[AC1]C`n[AV3]C"
global TrinitySystemsKeys := "AC2C`n[NB1]C`nAA1C`n[AV2]C`n[AV3]C`n[AV4]C"
global VastoBPKeys := "[NS3]U"
global VastoBarrelKeys := "[ND1]C`n[NN2]C`n[AV3]C"
global VastoReceiverKeys := "[LA1]C`n[MV2]C"
global VaubanBPKeys := "[LF2]R`nNV2R"
global VaubanChassisKeys := "LV4R`n[AV1]R"
global VaubanNeuropticsKeys := "NV5R`n[MN2]R`n[NV3]R"
global VaubanSystemsKeys := "LV2R`n[NN2]R`n[NS5]R"
global VectisBPKeys := "[LA1]U`n[NA1]U"
global VectisBarrelKeys := "[NN1]C`n[AC1]C`n[AH1]C`n[AT1]C"
global VectisReceiverKeys := "[MV1]R"
global VectisStockKeys := "[NB1]U`n[AV2]R`n[AV3]R`n[AV4]R"
global VoltBPKeys := "[NV1]U`n[AN3]U"
global VoltChassisKeys := "[MV2]U`n[MV3]U"
global VoltNeuropticsKeys := "[AV1]U"
global VoltSystemsKeys := "LV3R`n[LV1]U"
global ValkyrBPKeys := "MS6C`nLA2C`nLN3C`n[MS3]C"
global ValkyrChassisKeys := "AV5R"
global ValkyrNeuropticsKeys := "NN7U`nLS6U`n[MC2]U"
global ValkyrSystemsKeys := "[MV3]R"
global EmberBPKeys := "[AE1]R"
global EmberChassisKeys := "[MF2]C"
global EmberNeuropticsKeys := "[NS5]C"
global EmberSystemsKeys := "[LG1]U"
global FrostBPKeys := "[MF2]R"
global FrostChassisKeys := "[LG1]C"
global FrostNeuropticsKeys := "[AE1]C"
global FrostSystemsKeys := "[NS5]U"
global CernosBPKeys := "LA2U`n[AB1]U`n[AV4]U"
global CernosUpperLimbKeys := "NN6C`nLV3C`n[MC2]C"
global CernosGripKeys := "MV5C`n[NV4]C"
global CernosLowerLimbKeys := "AC2R`n[AC1]R"
global CernosStringKeys := "MS6U`nMO1U`n[NA1]U"
global VenkaBPKeys := "NB2U`n[NN4]U"
global VenkaBladeKeys := "NN7C`nLV4C`nAV5C"
global VenkaGauntletKeys := "MV5R`n[NV4]R"
global GlaiveBPKeys := "[LG1]R"
global GlaiveBladeKeys := "[AE1]U"
global GlaiveDiscKeys := "[NS5]U"
global LatronBPKeys := "[LG1]C"
global LatronBarrelKeys := "[AE1]C"
global LatronReceiverKeys := "[NS5]C"
global LatronStockKeys := "[MF2]C"
global ReaperBPKeys := "[NS5]C"
global ReaperBladeKeys := "[MF2]U"
global ReaperHandleKeys := "[LG1]C"
global SicarusBPKeys := "[AE1]C"
global SicarusBarrelKeys := "[MF2]C"
global SicarusReceiverKeys := "[NS5]R"
global SybarisBPKeys := "AB2C"
global SybarisBarrelKeys := "MS5R"
global SybarisReceiverKeys := "NN6U"
global SybarisStockKeys := "LN3C"
global SilvaBPKeys := "MV5U"
global SilvaBladeKeys := "AC2U"
global SilvaGuardKeys := "NS6R"
global SilvaHiltKeys := "NV5C"
global EuphonaBPKeys := "AO1C`nNN7C`n[AB1]C"
global EuphonaBarrelKeys := "MV5U`n[MN3]U"
global EuphonaReceiverKeys := "AE2R"
global HeliosBPKeys := "LV4U`n[LN2]U"
global HeliosCarapaceKeys := "MS6C`nNV5C`n[NN5]C"
global HeliosCerebrumKeys := "AH2R`n[AH1]R"
global HeliosSystemsKeys := "LV3U"
global BansheeBPKeys := "NN7U`nNT1U"
global BansheeChassisKeys := "NB2R`n[NB1]R"
global BansheeNeuropticsKeys := "MS4C"
global BansheeSystemsKeys := "AB2R`n[AB1]R"
global OberonBPKeys := "MN4U"
global OberonChassisKeys := "AH2C"
global OberonNeuropticsKeys := "MO1R"
global OberonSystemsKeys := "AO1R"

global valuesArray := [FormaBP, AkbroncoBP, AkbroncoLink, AkstilettoBP, AkstilettoBarrel, AkstilettoReceiver, AkstilettoLink, AshBP, AshChassis, AshNeuroptics, AshSystems, BoarBP, BoarBarrel
    , BoarReceiver, BoarStock, BratonBP, BratonBarrel, BratonReceiver, BratonStock, BroncoBP, BroncoBarrel, BroncoReceiver, BurstonBP, BurstonBarrel, BurstonReceiver
    , BurstonStock, CarrierBP, CarrierCarapace, CarrierCerebrum, CarrierSystems, DakraBP, DakraBlade, DakraHandle, DualKamasBP, DualKamasBlade, DualKamasHandle, FangBP
    , FangBlade, FangHandle, FragorBP, FragorHead, FragorHandle, GalatineBP, GalatineBlade, GalatineHandle, HikouBP, HikouStars, HikouPouch, KavasaBP, KavasaBand
    , KavasaBuckle, LexBP, LexBarrel, LexReceiver, MagBP, MagChassis, MagNeuroptics, MagSystems, NekrosBP, NekrosChassis, NekrosNeuroptics, NekrosSystems
    , NikanaBP, NikanaBlade, NikanaHilt, NovaBP, NovaChassis, NovaNeuroptics, NovaSystems, NyxBP, NyxChassis, NyxNeuroptics, NyxSystems, OdonataBP, OdonataHarness
    , OdonataSystems, OdonataWings, OrthosBP, OrthosBlade, OrthosHandle, ParisBP, ParisUpperLimb, ParisGrip, ParisLowerLimb, ParisString, SarynBP, SarynChassis
    , SarynNeuroptics, SarynSystems, ScindoBP, ScindoBlade, ScindoHandle, SomaBP, SomaBarrel, SomaReceiver, SomaStock, SpiraBP, SpiraBlade, SpiraPouch, TigrisBP
    , TigrisBarrel, TigrisReceiver, TigrisStock, TrinityBP, TrinityChassis, TrinityNeuroptics, TrinitySystems, VastoBP, VastoBarrel, VastoReceiver, VaubanBP, VaubanChassis
    , VaubanNeuroptics, VaubanSystems, VectisBP, VectisBarrel, VectisReceiver, VectisStock, VoltBP, VoltChassis, VoltNeuroptics, VoltSystems, ValkyrBP, ValkyrChassis, ValkyrNeuroptics
    , ValkyrSystems, EmberBP, EmberChassis, EmberNeuroptics, EmberSystems, FrostBP, FrostChassis, FrostNeuroptics, FrostSystems, CernosBP, CernosUpperLimb, CernosGrip, CernosLowerLimb
    , CernosString, VenkaBP, VenkaBlade, VenkaGauntlet, GlaiveBP, GlaiveBlade, GlaiveDisc, LatronBP, LatronBarrel, LatronReceiver, LatronStock, ReaperBP
    , ReaperBlade, ReaperHandle, SicarusBP, SicarusBarrel, SicarusReceiver, SybarisBP, SybarisBarrel, SybarisReceiver, SybarisStock, SilvaBP, SilvaBlade, SilvaGuard, SilvaHilt
    , EuphonaBP, EuphonaBarrel, EuphonaReceiver, HeliosBP, HeliosCarapace, HeliosCerebrum, HeliosSystems, BansheeBP, BansheeChassis, BansheeNeuroptics, BansheeSystems, OberonBP, OberonChassis, OberonNeuroptics, OberonSystems]
    
global vaultedArray := ["Mag", "Nova", "Nyx", "Ember", "Frost", "Loki", "Rhino", "Wyrm", "Ankyros", "Boar", "Bo", "Boltor", "Dakra", "Glaive", "Hikou", "Latron", "Reaper", "Scindo", "Sicarus", "Soma", "Vasto", "Ash", "Vectis", "Carrier", "Volt", "Odonata"]

global commonUncommonArray := ["TrinityNeuroptics", "BratonBP", "FangHandle", "ParisUpperLimb"]

global pageArray := ["m", "w", "w", "w", "w", "w", "w", "f", "f", "f", "f", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "m", "m", "m", "m", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "m", "m", "m"
    , "w", "w", "w", "f", "f", "f", "f", "f", "f", "f", "f", "w", "w", "w", "f", "f", "f", "f", "f", "f", "f", "f", "m", "m", "m", "m", "w", "w", "w", "w", "w", "w", "w", "w", "f", "f", "f", "f", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w"
    , "f", "f", "f", "f", "w", "w", "w", "f", "f", "f", "f", "w", "w", "w", "w", "f", "f", "f", "f", "f", "f", "f", "f", "f", "f", "f", "f", "f", "f", "f", "f", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w"
    , "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "w", "m", "m", "m", "m", "f", "f", "f", "f", "f", "f", "f", "f"]

global Forma = 1
global Akbronco = 2
global Akstiletto = 4
global Ash = 8
global Boar = 12
global Braton = 16
global Bronco = 20
global Burston = 23
global Carrier = 27
global Dakra = 31
global DualKamas = 34
global Fang = 37
global Fragor = 40
global Galatine = 43
global Hikou = 46
global Kavasa = 49
global Lex = 52
global Mag = 55
global Nekros = 59
global Nikana = 63
global Nova = 66
global Nyx = 70
global Odonata = 74
global Orthos = 78
global Paris = 81
global Saryn = 86
global Scindo = 90
global Soma = 93
global Spira = 97
global Tigris = 100
global Trinity = 104
global Vasto = 108
global Vauban = 111
global Vectis = 115
global Volt = 119
global Valkyr = 123
global Ember = 127
global Frost = 131
global Cernos = 135
global Venka = 140
global Glaive = 143
global Latron = 146
global Reaper = 150
global Sicarus = 153
global Sybaris = 156
global Silva = 160
global Euphona = 164
global Helios = 167
global Banshee = 171
global Oberon = 175

global minimized = 1
global item1 = ""
global item2 = ""
global item3 = ""
global item4 = ""
global found1 = 0
global found1 = 0
global found3 = 0
global found4 = 0
global wftabs = ""
global wepstabs = ""
global misctabs = ""

Gui, Add, Button,  x12 y10 w60 h20 gwarframes, Warframes
Gui, Add, Button,  x82 y10 w60 h20 gweapons, Weapons
Gui, Add, Button, x152 y10 w40 h20 gmisc, Misc
Gui, Add, Button, x212 y10 w70 h20 gocr, OCR
Gui, Add, Button, x297 y10 w40 h20 ghide vhidelabel, Show
Gui, Font, s9 cFFFFFF
Gui, Add, Picture, x338 y1 w18 h18 guimove, GUI\move.png
Gui, Add, Picture,   x8 y40 w72 h71 hidden vgold1, GUI\gold.png
Gui, Add, Picture,  x98 y40 w72 h71 hidden vgold2, GUI\gold.png
Gui, Add, Picture, x188 y40 w72 h71 hidden vgold3, GUI\gold.png
Gui, Add, Picture, x278 y40 w72 h71 hidden vgold4, GUI\gold.png
Gui, Add, Picture,   x8 y40 w72 h71 hidden vsilver1, GUI\25D.png
Gui, Add, Picture,  x98 y40 w72 h71 hidden vsilver2, GUI\25D.png
Gui, Add, Picture, x188 y40 w72 h71 hidden vsilver3, GUI\25D.png
Gui, Add, Picture, x278 y40 w72 h71 hidden vsilver4, GUI\25D.png
Gui, Add, Button,  x12 y44 w65 h30 vitem1 gIncItem1,
Gui, Add, Button, x102 y44 w65 h30 vitem2 gIncItem2,
Gui, Add, Button, x192 y44 w65 h30 vitem3 gIncItem3,
Gui, Add, Button, x282 y44 w65 h30 vitem4 gIncItem4,
Gui, Font, s20 cFFFFFF
Gui, Add, Text,  x15 y79 w60 h27 +Center vedit1,
Gui, Add, Text, x105 y79 w60 h27 +Center vedit2,
Gui, Add, Text, x195 y79 w60 h27 +Center vedit3,
Gui, Add, Text, x285 y79 w60 h27 +Center vedit4,
Gui, Font,
Gui, Add, Button,   x22 y116 w40 h20 gset1, Parts
Gui, Add, Button,  x112 y116 w40 h20 gset2, Parts
Gui, Add, Button,  x202 y116 w40 h20 gset3, Parts
Gui, Add, Button,  x292 y116 w40 h20 gset4, Parts

; Generated partially using SmartGUI Creator 4.0
Gui, Color, 000000
Gui +LastFound
WinSet, TransColor, 000000, 100
WinSet, Transparent, 200
Gui -Caption ;+Border
guixpos := A_ScreenWidth - 387
Gui, Show, h40 w357 x%guixpos% y0, Void Tracker

OnMessage(0x200, "Help")

Return

GuiClose:
ExitApp

uiMove:
  PostMessage, 0xA1, 2,,, A ;click and drag this control to move the window
return

Help() {
    If RegExMatch(A_GuiControl, "\.|\+|-")
        return
    ToolTip % %A_GuiControl%Keys
}

set1:
    if(found1 != 0) {
        if(pageArray[found1] = "f"){
            warframes(setArray[found1])
        } else if (pageArray[found1] = "w"){
            weapons(setArray[found1])
        } else if (pageArray[found1] = "m") {
            misc(setArray[found1])
        }
    }
return

set2:
    if(found2 != 0) {
        if(pageArray[found2] = "f"){
            warframes(setArray[found2])
        } else if (pageArray[found2] = "w"){
            weapons(setArray[found2])
        } else if (pageArray[found2] = "m") {
            misc(setArray[found2])
        }
    }
return

set3:
    if(found3 != 0) {
        if(pageArray[found3] = "f"){
            warframes(setArray[found3])
        } else if (pageArray[found3] = "w"){
            weapons(setArray[found3])
        } else if (pageArray[found3] = "m") {
            misc(setArray[found3])
        }
    }
return

set4:
    if(found4 != 0) {
        if(pageArray[found4] = "f"){
            warframes(setArray[found4])
        } else if (pageArray[found4] = "w"){
            weapons(setArray[found4])
        } else if (pageArray[found4] = "m") {
            misc(setArray[found4])
        }
    }
return

FormaBP:
AkbroncoBP:
AkbroncoLink:
AkstilettoBP:
AkstilettoBarrel:
AkstilettoReceiver:
AkstilettoLink:
AshBP:
AshChassis:
AshNeuroptics:
AshSystems:
BoarBP:
BoarBarrel:
BoarReceiver:
BoarStock:
BratonBP:
BratonBarrel:
BratonReceiver:
BratonStock:
BroncoBP:
BroncoBarrel:
BroncoReceiver:
BurstonBP:
BurstonBarrel:
BurstonReceiver:
BurstonStock:
CarrierBP:
CarrierCarapace:
CarrierCerebrum:
CarrierSystems:
DakraBP:
DakraBlade:
DakraHandle:
DualKamasBP:
DualKamasBlade:
DualKamasHandle:
FangBP:
FangBlade:
FangHandle:
FragorBP:
FragorHead:
FragorHandle:
GalatineBP:
GalatineBlade:
GalatineHandle:
HikouBP:
HikouStars:
HikouPouch:
KavasaBP:
KavasaBand:
KavasaBuckle:
LexBP:
LexBarrel:
LexReceiver:
MagBP:
MagChassis:
MagNeuroptics:
MagSystems:
NekrosBP:
NekrosChassis:
NekrosNeuroptics:
NekrosSystems:
NikanaBP:
NikanaBlade:
NikanaHilt:
NovaBP:
NovaChassis:
NovaNeuroptics:
NovaSystems:
NyxBP:
NyxChassis:
NyxNeuroptics:
NyxSystems:
OdonataBP:
OdonataHarness:
OdonataSystems:
OdonataWings:
OrthosBP:
OrthosBlade:
OrthosHandle:
ParisBP:
ParisUpperLimb:
ParisGrip:
ParisLowerLimb:
ParisString:
SarynBP:
SarynChassis:
SarynNeuroptics:
SarynSystems:
ScindoBP:
ScindoBlade:
ScindoHandle:
SomaBP:
SomaBarrel:
SomaReceiver:
SomaStock:
SpiraBP:
SpiraBlade:
SpiraPouch:
TigrisBP:
TigrisBarrel:
TigrisReceiver:
TigrisStock:
TrinityBP:
TrinityChassis:
TrinityNeuroptics:
TrinitySystems:
VastoBP:
VastoBarrel:
VastoReceiver:
VaubanBP:
VaubanChassis:
VaubanNeuroptics:
VaubanSystems:
VectisBP:
VectisBarrel:
VectisReceiver:
VectisStock:
VoltBP:
VoltChassis:
VoltNeuroptics:
VoltSystems:
ValkyrBP:
ValkyrChassis:
ValkyrNeuroptics:
ValkyrSystems:
EmberBP:
EmberChassis:
EmberNeuroptics:
EmberSystems:
FrostBP:
FrostChassis:
FrostNeuroptics:
FrostSystems:
CernosBP:
CernosUpperLimb:
CernosGrip:
CernosLowerLimb:
CernosString:
VenkaBP:
VenkaBlade:
VenkaGauntlet:
GlaiveBP:
GlaiveBlade:
GlaiveDisc:
LatronBP:
LatronBarrel:
LatronReceiver:
LatronStock:
ReaperBP:
ReaperBlade:
ReaperHandle:
SicarusBP:
SicarusBarrel:
SicarusReceiver:

SybarisBP:
SybarisBarrel:
SybarisReceiver:
SybarisStock:
SilvaBP:
SilvaBlade:
SilvaGuard:
SilvaHilt:
EuphonaBP:
EuphonaBarrel:
EuphonaReceiver:
HeliosBP:
HeliosCarapace:
HeliosCerebrum:
HeliosSystems:
BansheeBP:
BansheeChassis:
BansheeNeuroptics:
BansheeSystems:
OberonBP:
OberonChassis:
OberonNeuroptics:
OberonSystems:
return

warframes(tab="")
{
    Gui, WF:Destroy
    Gui, WF:Add, Picture, x0 y40 w520 h370 BackgroundTrans,  GUI\blueprint\Blueprint.crop.png
    Gui, WF:Add, Picture, x280 y60 w128 h-1 BackgroundTrans,  GUI\blueprint\Neuroptics.png
    Gui, WF:Add, Picture, x280 y+28 w128 h-1 BackgroundTrans,  GUI\blueprint\Chassis.png
    Gui, WF:Add, Picture, x280 y282 w128 h-1 BackgroundTrans,  GUI\blueprint\Systems.png
    Gui, WF:Add, Tab, x0 y0 w520 h370 vwftabs, Ash|Banshee|Ember|Frost|Mag|Nekros|Nova|Nyx|Oberon|Saryn|Trinity|Valkyr|Vauban|Volt
    
    Gui, WF:Add, Picture, x0 y40 w-1 h360 BackgroundTrans,  GUI\warframe\Ash.png
    Gui, WF:Add, Button,  x168 y60 w20 h32 gDecAshBP, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y60 w20 h32 +Center vAshBP gAshBP, % valuesArray[Ash]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y60 w20 h32 gIncAshBP, +
    Gui, WF:Add, Button,  x398 y205 w20 h32 gDecAshChas, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y205 w20 h32 +Center vAshChassis gAshChassis, % valuesArray[Ash+1]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y205 w20 h32 gIncAshChas, +
    Gui, WF:Add, Button,  x398 y85 w20 h32 gDecAshNeuro, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y85 w20 h32 +Center vAshNeuroptics gAshNeuroptics, % valuesArray[Ash+2]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y85 w20 h32 gIncAshNeuro, +
    Gui, WF:Add, Button,  x398 y317 w20 h32 gDecAshSys, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y317 w20 h32 +Center vAshSystems gAshSystems, % valuesArray[Ash+3]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y317 w20 h32 gIncAshSys, +
    
    GUI, WF:Tab, 2
    Gui, WF:Add, Picture, x0 y107 w278 h-1 BackgroundTrans,  GUI\warframe\Banshee.png
    Gui, WF:Add, Button,  x168 y60 w20 h32 gDecBansheeBP, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y60 w20 h32 +Center vBansheeBP gBansheeBP, % valuesArray[Banshee]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y60 w20 h32 gIncBansheeBP, +
    Gui, WF:Add, Button,  x398 y205 w20 h32 gDecBansheeChas, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y205 w20 h32 +Center vBansheeChassis gBansheeChassis, % valuesArray[Banshee+1]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y205 w20 h32 gIncBansheeChas, +
    Gui, WF:Add, Button,  x398 y85 w20 h32 gDecBansheeNeuro, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y85 w20 h32 +Center vBansheeNeuroptics gBansheeNeuroptics, % valuesArray[Banshee+2]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y85 w20 h32 gIncBansheeNeuro, +
    Gui, WF:Add, Button,  x398 y317 w20 h32 gDecBansheeSys, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y317 w20 h32 +Center vBansheeSystems gBansheeSystems, % valuesArray[Banshee+3]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y317 w20 h32 gIncBansheeSys, +
    
    GUI, WF:Tab, 3
    Gui, WF:Add, Picture, x0 y40 w-1 h360 BackgroundTrans,  GUI\warframe\Ember.png
    Gui, WF:Add, Button,  x168 y60 w20 h32 gDecEmberBP, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y60 w20 h32 +Center vEmberBP gEmberBP, % valuesArray[Ember]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y60 w20 h32 gIncEmberBP, +
    Gui, WF:Add, Button,  x398 y205 w20 h32 gDecEmberChas, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y205 w20 h32 +Center vEmberChassis gEmberChassis, % valuesArray[Ember+1]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y205 w20 h32 gIncEmberChas, +
    Gui, WF:Add, Button,  x398 y85 w20 h32 gDecEmberNeuro, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y85 w20 h32 +Center vEmberNeuroptics gEmberNeuroptics, % valuesArray[Ember+2]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y85 w20 h32 gIncEmberNeuro, +
    Gui, WF:Add, Button,  x398 y317 w20 h32 gDecEmberSys, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y317 w20 h32 +Center vEmberSystems gEmberSystems, % valuesArray[Ember+3]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y317 w20 h32 gIncEmberSys, +
    
    GUI, WF:Tab, 4
    Gui, WF:Add, Picture, x0 y40 w-1 h360 BackgroundTrans,  GUI\warframe\Frost.png
    Gui, WF:Add, Button,  x168 y60 w20 h32 gDecFrostBP, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y60 w20 h32 +Center vFrostBP gFrostBP, % valuesArray[Frost]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y60 w20 h32 gIncFrostBP, +
    Gui, WF:Add, Button,  x398 y205 w20 h32 gDecFrostChas, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y205 w20 h32 +Center vFrostChassis gFrostChassis, % valuesArray[Frost+1]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y205 w20 h32 gIncFrostChas, +
    Gui, WF:Add, Button,  x398 y85 w20 h32 gDecFrostNeuro, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y85 w20 h32 +Center vFrostNeuroptics gFrostNeuroptics, % valuesArray[Frost+2]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y85 w20 h32 gIncFrostNeuro, +
    Gui, WF:Add, Button,  x398 y317 w20 h32 gDecFrostSys, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y317 w20 h32 +Center vFrostSystems gFrostSystems, % valuesArray[Frost+3]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y317 w20 h32 gIncFrostSys, +
    
    GUI, WF:Tab, 5
    Gui, WF:Add, Picture, x0 y40 w-1 h360 BackgroundTrans,  GUI\warframe\Mag.png
    Gui, WF:Add, Button,  x168 y60 w20 h32 gDecMagBP, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y60 w20 h32 +Center vMagBP gMagBP, % valuesArray[Mag]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y60 w20 h32 gIncMagBP, +
    Gui, WF:Add, Button,  x398 y205 w20 h32 gDecMagChas, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y205 w20 h32 +Center vMagChassis gMagChassis, % valuesArray[Mag+1]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y205 w20 h32 gIncMagChas, +
    Gui, WF:Add, Button,  x398 y85 w20 h32 gDecMagNeuro, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y85 w20 h32 +Center vMagNeuroptics gMagNeuroptics, % valuesArray[Mag+2]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y85 w20 h32 gIncMagNeuro, +
    Gui, WF:Add, Button,  x398 y317 w20 h32 gDecMagSys, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y317 w20 h32 +Center vMagSystems gMagSystems, % valuesArray[Mag+3]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y317 w20 h32 gIncMagSys, +
    
    GUI, WF:Tab, 6
    Gui, WF:Add, Picture, x0 y107 w278 h-1 BackgroundTrans,  GUI\warframe\Nekros.png
    Gui, WF:Add, Button,  x168 y60 w20 h32 gDecNekrosBP, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y60 w20 h32 +Center vNekrosBP gNekrosBP, % valuesArray[Nekros]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y60 w20 h32 gIncNekrosBP, +
    Gui, WF:Add, Button,  x398 y205 w20 h32 gDecNekrosChas, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y205 w20 h32 +Center vNekrosChassis gNekrosChassis, % valuesArray[Nekros+1]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y205 w20 h32 gIncNekrosChas, +
    Gui, WF:Add, Button,  x398 y85 w20 h32 gDecNekrosNeuro, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y85 w20 h32 +Center vNekrosNeuroptics gNekrosNeuroptics, % valuesArray[Nekros+2]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y85 w20 h32 gIncNekrosNeuro, +
    Gui, WF:Add, Button,  x398 y317 w20 h32 gDecNekrosSys, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y317 w20 h32 +Center vNekrosSystems gNekrosSystems, % valuesArray[Nekros+3]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y317 w20 h32 gIncNekrosSys, +
    
    GUI, WF:Tab, 7
    Gui, WF:Add, Picture, x0 y40 w-1 h360 BackgroundTrans,  GUI\warframe\Nova.png
    Gui, WF:Add, Button,  x168 y60 w20 h32 gDecNovaBP, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y60 w20 h32 +Center vNovaBP gNovaBP, % valuesArray[Nova]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y60 w20 h32 gIncNovaBP, +
    Gui, WF:Add, Button,  x398 y205 w20 h32 gDecNovaChas, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y205 w20 h32 +Center vNovaChassis gNovaChassis, % valuesArray[Nova+1]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y205 w20 h32 gIncNovaChas, +
    Gui, WF:Add, Button,  x398 y85 w20 h32 gDecNovaNeuro, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y85 w20 h32 +Center vNovaNeuroptics gNovaNeuroptics, % valuesArray[Nova+2]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y85 w20 h32 gIncNovaNeuro, +
    Gui, WF:Add, Button,  x398 y317 w20 h32 gDecNovaSys, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y317 w20 h32 +Center vNovaSystems gNovaSystems, % valuesArray[Nova+3]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y317 w20 h32 gIncNovaSys, +
    
    GUI, WF:Tab, 8
    Gui, WF:Add, Picture, x0 y40 w-1 h360 BackgroundTrans,  GUI\warframe\Nyx.png
    Gui, WF:Add, Button,  x168 y60 w20 h32 gDecNyxBP, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y60 w20 h32 +Center vNyxBP gNyxBP, % valuesArray[Nyx]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y60 w20 h32 gIncNyxBP, +
    Gui, WF:Add, Button,  x398 y205 w20 h32 gDecNyxChas, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y205 w20 h32 +Center vNyxChassis gNyxChassis, % valuesArray[Nyx+1]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y205 w20 h32 gIncNyxChas, +
    Gui, WF:Add, Button,  x398 y85 w20 h32 gDecNyxNeuro, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y85 w20 h32 +Center vNyxNeuroptics gNyxNeuroptics, % valuesArray[Nyx+2]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y85 w20 h32 gIncNyxNeuro, +
    Gui, WF:Add, Button,  x398 y317 w20 h32 gDecNyxSys, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y317 w20 h32 +Center vNyxSystems gNyxSystems, % valuesArray[Nyx+3]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y317 w20 h32 gIncNyxSys, +
    
    GUI, WF:Tab, 9
    Gui, WF:Add, Picture, x0 y40 w-1 h360 BackgroundTrans,  GUI\warframe\Oberon.png
    Gui, WF:Add, Button,  x168 y60 w20 h32 gDecOberonBP, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y60 w20 h32 +Center vOberonBP gOberonBP, % valuesArray[Oberon]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y60 w20 h32 gIncOberonBP, +
    Gui, WF:Add, Button,  x398 y205 w20 h32 gDecOberonChas, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y205 w20 h32 +Center vOberonChassis gOberonChassis, % valuesArray[Oberon+1]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y205 w20 h32 gIncOberonChas, +
    Gui, WF:Add, Button,  x398 y85 w20 h32 gDecOberonNeuro, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y85 w20 h32 +Center vOberonNeuroptics gOberonNeuroptics, % valuesArray[Oberon+2]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y85 w20 h32 gIncOberonNeuro, +
    Gui, WF:Add, Button,  x398 y317 w20 h32 gDecOberonSys, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y317 w20 h32 +Center vOberonSystems gOberonSystems, % valuesArray[Oberon+3]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y317 w20 h32 gIncOberonSys, +
    
    GUI, WF:Tab, 10
    Gui, WF:Add, Picture, x0 y40 w-1 h360 BackgroundTrans,  GUI\warframe\Saryn.png
    Gui, WF:Add, Button,  x168 y60 w20 h32 gDecSarynBP, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y60 w20 h32 +Center vSarynBP gSarynBP, % valuesArray[Saryn]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y60 w20 h32 gIncSarynBP, +
    Gui, WF:Add, Button,  x398 y205 w20 h32 gDecSarynChas, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y205 w20 h32 +Center vSarynChassis gSarynChassis, % valuesArray[Saryn+1]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y205 w20 h32 gIncSarynChas, +
    Gui, WF:Add, Button,  x398 y85 w20 h32 gDecSarynNeuro, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y85 w20 h32 +Center vSarynNeuroptics gSarynNeuroptics, % valuesArray[Saryn+2]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y85 w20 h32 gIncSarynNeuro, +
    Gui, WF:Add, Button,  x398 y317 w20 h32 gDecSarynSys, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y317 w20 h32 +Center vSarynSystems gSarynSystems, % valuesArray[Saryn+3]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y317 w20 h32 gIncSarynSys, +
    
    GUI, WF:Tab, 11
    Gui, WF:Add, Picture, x0 y40 w-1 h360 BackgroundTrans,  GUI\warframe\Trinity.png
    Gui, WF:Add, Button,  x168 y60 w20 h32 gDecTrinityBP, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y60 w20 h32 +Center vTrinityBP gTrinityBP, % valuesArray[Trinity]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y60 w20 h32 gIncTrinityBP, +
    Gui, WF:Add, Button,  x398 y205 w20 h32 gDecTrinityChas, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y205 w20 h32 +Center vTrinityChassis gTrinityChassis, % valuesArray[Trinity+1]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y205 w20 h32 gIncTrinityChas, +
    Gui, WF:Add, Button,  x398 y85 w20 h32 gDecTrinityNeuro, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y85 w20 h32 +Center vTrinityNeuroptics gTrinityNeuroptics, % valuesArray[Trinity+2]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y85 w20 h32 gIncTrinityNeuro, +
    Gui, WF:Add, Button,  x398 y317 w20 h32 gDecTrinitySys, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y317 w20 h32 +Center vTrinitySystems gTrinitySystems, % valuesArray[Trinity+3]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y317 w20 h32 gIncTrinitySys, +
    
    GUI, WF:Tab, 12
    Gui, WF:Add, Picture, x0 y107 w278 h-1 BackgroundTrans,  GUI\warframe\Valkyr.png
    Gui, WF:Add, Button,  x168 y60 w20 h32 gDecValkyrBP, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y60 w20 h32 +Center vValkyrBP gValkyrBP, % valuesArray[Valkyr]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y60 w20 h32 gIncValkyrBP, +
    Gui, WF:Add, Button,  x398 y205 w20 h32 gDecValkyrChas, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y205 w20 h32 +Center vValkyrChassis gValkyrChassis, % valuesArray[Valkyr+1]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y205 w20 h32 gIncValkyrChas, +
    Gui, WF:Add, Button,  x398 y85 w20 h32 gDecValkyrNeuro, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y85 w20 h32 +Center vValkyrNeuroptics gValkyrNeuroptics, % valuesArray[Valkyr+2]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y85 w20 h32 gIncValkyrNeuro, +
    Gui, WF:Add, Button,  x398 y317 w20 h32 gDecValkyrSys, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y317 w20 h32 +Center vValkyrSystems gValkyrSystems, % valuesArray[Valkyr+3]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y317 w20 h32 gIncValkyrSys, +
    
    GUI, WF:Tab, 13
    Gui, WF:Add, Picture, x0 y40 w-1 h360 BackgroundTrans,  GUI\warframe\Vauban.png
    Gui, WF:Add, Button,  x168 y60 w20 h32 gDecVaubanBP, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y60 w20 h32 +Center vVaubanBP gVaubanBP, % valuesArray[Vauban]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y60 w20 h32 gIncVaubanBP, +
    Gui, WF:Add, Button,  x398 y205 w20 h32 gDecVaubanChas, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y205 w20 h32 +Center vVaubanChassis gVaubanChassis, % valuesArray[Vauban+1]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y205 w20 h32 gIncVaubanChas, +
    Gui, WF:Add, Button,  x398 y85 w20 h32 gDecVaubanNeuro, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y85 w20 h32 +Center vVaubanNeuroptics gVaubanNeuroptics, % valuesArray[Vauban+2]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y85 w20 h32 gIncVaubanNeuro, +
    Gui, WF:Add, Button,  x398 y317 w20 h32 gDecVaubanSys, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y317 w20 h32 +Center vVaubanSystems gVaubanSystems, % valuesArray[Vauban+3]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y317 w20 h32 gIncVaubanSys, +
    
    GUI, WF:Tab, 14
    Gui, WF:Add, Picture, x0 y40 w-1 h360 BackgroundTrans,  GUI\warframe\Volt.png
    Gui, WF:Add, Button,  x168 y60 w20 h32 gDecVoltBP, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y60 w20 h32 +Center vVoltBP gVoltBP, % valuesArray[Volt]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y60 w20 h32 gIncVoltBP, +
    Gui, WF:Add, Button,  x398 y205 w20 h32 gDecVoltChas, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y205 w20 h32 +Center vVoltChassis gVoltChassis, % valuesArray[Volt+1]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y205 w20 h32 gIncVoltChas, +
    Gui, WF:Add, Button,  x398 y85 w20 h32 gDecVoltNeuro, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y85 w20 h32 +Center vVoltNeuroptics gVoltNeuroptics, % valuesArray[Volt+2]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y85 w20 h32 gIncVoltNeuro, +
    Gui, WF:Add, Button,  x398 y317 w20 h32 gDecVoltSys, -
    Gui, WF:Font, s20
    Gui, WF:Add, Text,  x+10 y317 w20 h32 +Center vVoltSystems gVoltSystems, % valuesArray[Volt+3]
    Gui, WF:Font,
    Gui, WF:Add, Button,  x+10 y317 w20 h32 gIncVoltSys, +
    
    Gui, WF:+ToolWindow
    
    if(tab != "")
        guicontrol, WF:choosestring, wftabs, %tab%

    Gui, WF:Show, h391 w515, Warframes
}

IncAshBP:
    key := Ash
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, AshBP, % valuesArray[key]
return
DecAshBP:
    key := Ash
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, AshBP, % valuesArray[key]
    }
return
IncAshChas:
    key := Ash + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, AshChassis, % valuesArray[key]
return
DecAshChas:
    key := Ash + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, AshChassis, % valuesArray[key]
    }
return
IncAshNeuro:
    key := Ash + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, AshNeuroptics, % valuesArray[key]
return
DecAshNeuro:
    key := Ash + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, AshNeuroptics, % valuesArray[key]
    }
return
IncAshSys:
    key := Ash + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, AshSystems, % valuesArray[key]
return
DecAshSys:
    key := Ash + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, AshSystems, % valuesArray[key]
    }
return


IncBansheeBP:
    key := Banshee
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, BansheeBP, % valuesArray[key]
return
DecBansheeBP:
    key := Banshee
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, BansheeBP, % valuesArray[key]
    }
return
IncBansheeChas:
    key := Banshee + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, BansheeChassis, % valuesArray[key]
return
DecBansheeChas:
    key := Banshee + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, BansheeChassis, % valuesArray[key]
    }
return
IncBansheeNeuro:
    key := Banshee + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, BansheeNeuroptics, % valuesArray[key]
return
DecBansheeNeuro:
    key := Banshee + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, BansheeNeuroptics, % valuesArray[key]
    }
return
IncBansheeSys:
    key := Banshee + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, BansheeSystems, % valuesArray[key]
return
DecBansheeSys:
    key := Banshee + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, BansheeSystems, % valuesArray[key]
    }
return


IncEmberBP:
    key := Ember
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, EmberBP, % valuesArray[key]
return
DecEmberBP:
    key := Ember
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, EmberBP, % valuesArray[key]
    }
return
IncEmberChas:
    key := Ember + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, EmberChassis, % valuesArray[key]
return
DecEmberChas:
    key := Ember + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, EmberChassis, % valuesArray[key]
    }
return
IncEmberNeuro:
    key := Ember + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, EmberNeuroptics, % valuesArray[key]
return
DecEmberNeuro:
    key := Ember + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, EmberNeuroptics, % valuesArray[key]
    }
return
IncEmberSys:
    key := Ember + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, EmberSystems, % valuesArray[key]
return
DecEmberSys:
    key := Ember + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, EmberSystems, % valuesArray[key]
    }
return


IncFrostBP:
    key := Frost
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, FrostBP, % valuesArray[key]
return
DecFrostBP:
    key := Frost
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, FrostBP, % valuesArray[key]
    }
return
IncFrostChas:
    key := Frost + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, FrostChassis, % valuesArray[key]
return
DecFrostChas:
    key := Frost + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, FrostChassis, % valuesArray[key]
    }
return
IncFrostNeuro:
    key := Frost + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, FrostNeuroptics, % valuesArray[key]
return
DecFrostNeuro:
    key := Frost + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, FrostNeuroptics, % valuesArray[key]
    }
return
IncFrostSys:
    key := Frost + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, FrostSystems, % valuesArray[key]
return
DecFrostSys:
    key := Frost + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, FrostSystems, % valuesArray[key]
    }
return


IncMagBP:
    key := Mag
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, MagBP, % valuesArray[key]
return
DecMagBP:
    key := Mag
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, MagBP, % valuesArray[key]
    }
return
IncMagChas:
    key := Mag + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, MagChassis, % valuesArray[key]
return
DecMagChas:
    key := Mag + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, MagChassis, % valuesArray[key]
    }
return
IncMagNeuro:
    key := Mag + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, MagNeuroptics, % valuesArray[key]
return
DecMagNeuro:
    key := Mag + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, MagNeuroptics, % valuesArray[key]
    }
return
IncMagSys:
    key := Mag + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, MagSystems, % valuesArray[key]
return
DecMagSys:
    key := Mag + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, MagSystems, % valuesArray[key]
    }
return


IncNekrosBP:
    key := Nekros
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, NekrosBP, % valuesArray[key]
return
DecNekrosBP:
    key := Nekros
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, NekrosBP, % valuesArray[key]
    }
return
IncNekrosChas:
    key := Nekros + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, NekrosChassis, % valuesArray[key]
return
DecNekrosChas:
    key := Nekros + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, NekrosChassis, % valuesArray[key]
    }
return
IncNekrosNeuro:
    key := Nekros + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, NekrosNeuroptics, % valuesArray[key]
return
DecNekrosNeuro:
    key := Nekros + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, NekrosNeuroptics, % valuesArray[key]
    }
return
IncNekrosSys:
    key := Nekros + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, NekrosSystems, % valuesArray[key]
return
DecNekrosSys:
    key := Nekros + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, NekrosSystems, % valuesArray[key]
    }
return


IncNovaBP:
    key := Nova
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, NovaBP, % valuesArray[key]
return
DecNovaBP:
    key := Nova
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, NovaBP, % valuesArray[key]
    }
return
IncNovaChas:
    key := Nova + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, NovaChassis, % valuesArray[key]
return
DecNovaChas:
    key := Nova + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, NovaChassis, % valuesArray[key]
    }
return
IncNovaNeuro:
    key := Nova + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, NovaNeuroptics, % valuesArray[key]
return
DecNovaNeuro:
    key := Nova + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, NovaNeuroptics, % valuesArray[key]
    }
return
IncNovaSys:
    key := Nova + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, NovaSystems, % valuesArray[key]
return
DecNovaSys:
    key := Nova + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, NovaSystems, % valuesArray[key]
    }
return


IncNyxBP:
    key := Nyx
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, NyxBP, % valuesArray[key]
return
DecNyxBP:
    key := Nyx
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, NyxBP, % valuesArray[key]
    }
return
IncNyxChas:
    key := Nyx + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, NyxChassis, % valuesArray[key]
return
DecNyxChas:
    key := Nyx + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, NyxChassis, % valuesArray[key]
    }
return
IncNyxNeuro:
    key := Nyx + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, NyxNeuroptics, % valuesArray[key]
return
DecNyxNeuro:
    key := Nyx + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, NyxNeuroptics, % valuesArray[key]
    }
return
IncNyxSys:
    key := Nyx + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, NyxSystems, % valuesArray[key]
return
DecNyxSys:
    key := Nyx + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, NyxSystems, % valuesArray[key]
    }
return


IncOberonBP:
    key := Oberon
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, OberonBP, % valuesArray[key]
return
DecOberonBP:
    key := Oberon
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, OberonBP, % valuesArray[key]
    }
return
IncOberonChas:
    key := Oberon + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, OberonChassis, % valuesArray[key]
return
DecOberonChas:
    key := Oberon + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, OberonChassis, % valuesArray[key]
    }
return
IncOberonNeuro:
    key := Oberon + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, OberonNeuroptics, % valuesArray[key]
return
DecOberonNeuro:
    key := Oberon + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, OberonNeuroptics, % valuesArray[key]
    }
return
IncOberonSys:
    key := Oberon + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, OberonSystems, % valuesArray[key]
return
DecOberonSys:
    key := Oberon + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, OberonSystems, % valuesArray[key]
    }
return


IncSarynBP:
    key := Saryn
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, SarynBP, % valuesArray[key]
return
DecSarynBP:
    key := Saryn
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, SarynBP, % valuesArray[key]
    }
return
IncSarynChas:
    key := Saryn + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, SarynChassis, % valuesArray[key]
return
DecSarynChas:
    key := Saryn + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, SarynChassis, % valuesArray[key]
    }
return
IncSarynNeuro:
    key := Saryn + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, SarynNeuroptics, % valuesArray[key]
return
DecSarynNeuro:
    key := Saryn + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, SarynNeuroptics, % valuesArray[key]
    }
return
IncSarynSys:
    key := Saryn + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, SarynSystems, % valuesArray[key]
return
DecSarynSys:
    key := Saryn + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, SarynSystems, % valuesArray[key]
    }
return


IncTrinityBP:
    key := Trinity
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, TrinityBP, % valuesArray[key]
return
DecTrinityBP:
    key := Trinity
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, TrinityBP, % valuesArray[key]
    }
return
IncTrinityChas:
    key := Trinity + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, TrinityChassis, % valuesArray[key]
return
DecTrinityChas:
    key := Trinity + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, TrinityChassis, % valuesArray[key]
    }
return
IncTrinityNeuro:
    key := Trinity + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, TrinityNeuroptics, % valuesArray[key]
return
DecTrinityNeuro:
    key := Trinity + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, TrinityNeuroptics, % valuesArray[key]
    }
return
IncTrinitySys:
    key := Trinity + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, TrinitySystems, % valuesArray[key]
return
DecTrinitySys:
    key := Trinity + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, TrinitySystems, % valuesArray[key]
    }
return


IncValkyrBP:
    key := Valkyr
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, ValkyrBP, % valuesArray[key]
return
DecValkyrBP:
    key := Valkyr
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, ValkyrBP, % valuesArray[key]
    }
return
IncValkyrChas:
    key := Valkyr + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, ValkyrChassis, % valuesArray[key]
return
DecValkyrChas:
    key := Valkyr + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, ValkyrChassis, % valuesArray[key]
    }
return
IncValkyrNeuro:
    key := Valkyr + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, ValkyrNeuroptics, % valuesArray[key]
return
DecValkyrNeuro:
    key := Valkyr + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, ValkyrNeuroptics, % valuesArray[key]
    }
return
IncValkyrSys:
    key := Valkyr + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, ValkyrSystems, % valuesArray[key]
return
DecValkyrSys:
    key := Valkyr + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, ValkyrSystems, % valuesArray[key]
    }
return


IncVaubanBP:
    key := Vauban
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, VaubanBP, % valuesArray[key]
return
DecVaubanBP:
    key := Vauban
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, VaubanBP, % valuesArray[key]
    }
return
IncVaubanChas:
    key := Vauban + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, VaubanChassis, % valuesArray[key]
return
DecVaubanChas:
    key := Vauban + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, VaubanChassis, % valuesArray[key]
    }
return
IncVaubanNeuro:
    key := Vauban + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, VaubanNeuroptics, % valuesArray[key]
return
DecVaubanNeuro:
    key := Vauban + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, VaubanNeuroptics, % valuesArray[key]
    }
return
IncVaubanSys:
    key := Vauban + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, VaubanSystems, % valuesArray[key]
return
DecVaubanSys:
    key := Vauban + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, VaubanSystems, % valuesArray[key]
    }
return


IncVoltBP:
    key := Volt
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, VoltBP, % valuesArray[key]
return
DecVoltBP:
    key := Volt
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, VoltBP, % valuesArray[key]
    }
return
IncVoltChas:
    key := Volt + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, VoltChassis, % valuesArray[key]
return
DecVoltChas:
    key := Volt + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, VoltChassis, % valuesArray[key]
    }
return
IncVoltNeuro:
    key := Volt + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, VoltNeuroptics, % valuesArray[key]
return
DecVoltNeuro:
    key := Volt + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, VoltNeuroptics, % valuesArray[key]
    }
return
IncVoltSys:
    key := Volt + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, VoltSystems, % valuesArray[key]
return
DecVoltSys:
    key := Volt + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, VoltSystems, % valuesArray[key]
    }
return


weapons(tab="")
{
    Gui, WEPS:Destroy
    Gui, WEPS:Add, Picture, x0 y60 w520 h370 BackgroundTrans,  GUI\blueprint\Blueprint.crop.png
    Gui, WEPS:Add, Tab, x0 y0 w520 h370 vwepstabs, Akbronco|Akstiletto|Boar|Braton|Bronco|Burston|Cernos|Dakra|D.Kamas|Euphona|Fang|Fragor|Galatine|Glaive|Hikou|Latron|Lex|Nikana|Orthos|Paris|Reaper|Scindo|Sicarus|Silva|Soma|Spira|Sybaris|Tigris|Vasto|Vectis|Venka
    
    Gui, WEPS:Add, Picture, x280 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Link.png
    ;
    Gui, WEPS:Add, Picture, x20 y130 w223 h-1 BackgroundTrans,  GUI\weapon\Akbronco.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecAkbroncoBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vAkbroncoBP gAkbroncoBP, % valuesArray[Akbronco]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncAkbroncoBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecAkbroncoLink, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vAkbroncoLink gAkbroncoLink, % valuesArray[Akbronco+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncAkbroncoLink, +
    Gui, WEPS:Font, s12
    Gui, WEPS:Add, Text,  x398 y+20 w80 h122 +Center, Also requires two completed Bronco Primes
    Gui, WEPS:Font,
    
    Gui, WEPS:Tab, 2
    Gui, WEPS:Add, Picture, x260 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Barrel.png
    Gui, WEPS:Add, Picture, x280 y+28 w-1 h80 BackgroundTrans,  GUI\blueprint\Receiver.png
    Gui, WEPS:Add, Picture, x280 y302 w-1 h80 BackgroundTrans,  GUI\blueprint\Link.png
    ;
    Gui, WEPS:Add, Picture, x20 y130 w223 h-1 BackgroundTrans,  GUI\weapon\Akstiletto.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecAkstilettoBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vAkstilettoBP gAkstilettoBP, % valuesArray[Akstiletto]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncAkstilettoBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecAkstilettoBarrel, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vAkstilettoBarrel gAkstilettoBarrel, % valuesArray[Akstiletto+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncAkstilettoBarrel, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecAkstilettoReceiver, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vAkstilettoReceiver gAkstilettoReceiver, % valuesArray[Akstiletto+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncAkstilettoReceiver, +
    Gui, WEPS:Add, Button,  x398 y337 w20 h32 gDecAkstilettoLink, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y337 w20 h32 +Center vAkstilettoLink gAkstilettoLink, % valuesArray[Akstiletto+3]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y337 w20 h32 gIncAkstilettoLink, +
    
    Gui, WEPS:Tab, 3
    Gui, WEPS:Add, Picture, x260 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Barrel.png
    Gui, WEPS:Add, Picture, x280 y+28 w-1 h80 BackgroundTrans,  GUI\blueprint\Stock.png
    Gui, WEPS:Add, Picture, x280 y302 w-1 h80 BackgroundTrans,  GUI\blueprint\Receiver.png
    ;
    Gui, WEPS:Add, Picture, x20 y200 w223 h-1 BackgroundTrans,  GUI\weapon\Boar.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecBoarBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vBoarBP gBoarBP, % valuesArray[Boar]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncBoarBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecBoarBarrel, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vBoarBarrel gBoarBarrel, % valuesArray[Boar+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncBoarBarrel, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecBoarReceiver, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vBoarReceiver gBoarReceiver, % valuesArray[Boar+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncBoarReceiver, +
    Gui, WEPS:Add, Button,  x398 y337 w20 h32 gDecBoarStock, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y337 w20 h32 +Center vBoarStock gBoarStock, % valuesArray[Boar+3]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y337 w20 h32 gIncBoarStock, +
    
    Gui, WEPS:Tab, 4
    Gui, WEPS:Add, Picture, x260 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Barrel.png
    Gui, WEPS:Add, Picture, x280 y+28 w-1 h80 BackgroundTrans,  GUI\blueprint\Stock.png
    Gui, WEPS:Add, Picture, x280 y302 w-1 h80 BackgroundTrans,  GUI\blueprint\Receiver.png
    ;
    Gui, WEPS:Add, Picture, x20 y200 w223 h-1 BackgroundTrans,  GUI\weapon\Braton.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecBratonBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vBratonBP gBratonBP, % valuesArray[Braton]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncBratonBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecBratonBarrel, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vBratonBarrel gBratonBarrel, % valuesArray[Braton+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncBratonBarrel, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecBratonReceiver, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vBratonReceiver gBratonReceiver, % valuesArray[Braton+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncBratonReceiver, +
    Gui, WEPS:Add, Button,  x398 y337 w20 h32 gDecBratonStock, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y337 w20 h32 +Center vBratonStock gBratonStock, % valuesArray[Braton+3]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y337 w20 h32 gIncBratonStock, +
    
    Gui, WEPS:Tab, 5
    Gui, WEPS:Add, Picture, x260 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Barrel.png
    Gui, WEPS:Add, Picture, x280 y+28 w-1 h80 BackgroundTrans,  GUI\blueprint\Receiver.png
    ;
    Gui, WEPS:Add, Picture, x20 y130 w223 h-1 BackgroundTrans,  GUI\weapon\Bronco.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecBroncoBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vBroncoBP gBroncoBP, % valuesArray[Bronco]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncBroncoBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecBroncoBarrel, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vBroncoBarrel gBroncoBarrel, % valuesArray[Bronco+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncBroncoBarrel, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecBroncoReceiver, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vBroncoReceiver gBroncoReceiver, % valuesArray[Bronco+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncBroncoReceiver, +

    Gui, WEPS:Tab, 6
    Gui, WEPS:Add, Picture, x260 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Barrel.png
    Gui, WEPS:Add, Picture, x280 y+28 w-1 h80 BackgroundTrans,  GUI\blueprint\Stock.png
    Gui, WEPS:Add, Picture, x280 y302 w-1 h80 BackgroundTrans,  GUI\blueprint\Receiver.png
    ;
    Gui, WEPS:Add, Picture, x20 y200 w223 h-1 BackgroundTrans,  GUI\weapon\Burston.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecBurstonBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vBurstonBP gBurstonBP, % valuesArray[Burston]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncBurstonBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecBurstonBarrel, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vBurstonBarrel gBurstonBarrel, % valuesArray[Burston+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncBurstonBarrel, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecBurstonReceiver, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vBurstonReceiver gBurstonReceiver, % valuesArray[Burston+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncBurstonReceiver, +
    Gui, WEPS:Add, Button,  x398 y337 w20 h32 gDecBurstonStock, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y337 w20 h32 +Center vBurstonStock gBurstonStock, % valuesArray[Burston+3]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y337 w20 h32 gIncBurstonStock, +
    
    Gui, WEPS:Tab, 7
    Gui, WEPS:Add, Picture, x290 y80 w-1 h60 BackgroundTrans,  GUI\blueprint\Blade.png
    Gui, WEPS:Add, Picture, x310 y+28 w-1 h60 BackgroundTrans,  GUI\blueprint\Grip.png
    Gui, WEPS:Add, Picture, x290 y+28 w-1 h60 BackgroundTrans,  GUI\blueprint\Blade.inverted.png
    Gui, WEPS:Add, Picture, x310 y+28 w-1 h60 BackgroundTrans,  GUI\blueprint\Stock.png
    ;
    Gui, WEPS:Add, Picture, x20 y110 w223 h-1 BackgroundTrans,  GUI\weapon\Cernos.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecCernosBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vCernosBP gCernosBP, % valuesArray[Cernos]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncCernosBP, +
    Gui, WEPS:Add, Button,  x398 y95 w20 h32 gDecCernosUpperLimb, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y95 w20 h32 +Center vCernosUpperLimb gCernosUpperLimb, % valuesArray[Cernos+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y95 w20 h32 gIncCernosUpperLimb, +
    Gui, WEPS:Add, Button,  x398 y179 w20 h32 gDecCernosGrip, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y179 w20 h32 +Center vCernosGrip gCernosGrip, % valuesArray[Cernos+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y179 w20 h32 gIncCernosGrip, +
    Gui, WEPS:Add, Button,  x398 y263 w20 h32 gDecCernosLowerLimb, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y263 w20 h32 +Center vCernosLowerLimb gCernosLowerLimb, % valuesArray[Cernos+3]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y263 w20 h32 gIncCernosLowerLimb, +
    Gui, WEPS:Add, Button,  x398 y357 w20 h32 gDecCernosString, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y357 w20 h32 +Center vCernosString gCernosString, % valuesArray[Cernos+4]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y357 w20 h32 gIncCernosString, +
    
    Gui, WEPS:Tab, 8
    Gui, WEPS:Add, Picture, x270 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Blade.png
    Gui, WEPS:Add, Picture, x280 y+28 w-1 h80 BackgroundTrans,  GUI\blueprint\Handle.png
    ;
    Gui, WEPS:Add, Picture, x20 y160 w223 h-1 BackgroundTrans,  GUI\weapon\Dakra.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecDakraBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vDakraBP gDakraBP, % valuesArray[Dakra]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncDakraBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecDakraBlade, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vDakraBlade gDakraBlade, % valuesArray[Dakra+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncDakraBlade, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecDakraHandle, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vDakraHandle gDakraHandle, % valuesArray[Dakra+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncDakraHandle, +
    
    Gui, WEPS:Tab, 9
    Gui, WEPS:Add, Picture, x270 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Blade.png
    Gui, WEPS:Add, Picture, x280 y+28 w-1 h80 BackgroundTrans,  GUI\blueprint\Handle.png
    ;
    Gui, WEPS:Add, Picture, x20 y150 w223 h-1 BackgroundTrans,  GUI\weapon\DualKamas.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecDualKamasBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vDualKamasBP gDualKamasBP, % valuesArray[DualKamas]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncDualKamasBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecDualKamasBlade, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vDualKamasBlade gDualKamasBlade, % valuesArray[DualKamas+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncDualKamasBlade, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecDualKamasHandle, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vDualKamasHandle gDualKamasHandle, % valuesArray[DualKamas+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncDualKamasHandle, +
    
    Gui, WEPS:Tab, 10
    Gui, WEPS:Add, Picture, x260 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Barrel.png
    Gui, WEPS:Add, Picture, x280 y+28 w-1 h80 BackgroundTrans,  GUI\blueprint\Receiver.png
    ;
    Gui, WEPS:Add, Picture, x20 y200 w223 h-1 BackgroundTrans,  GUI\weapon\Euphona.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecEuphonaBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vEuphonaBP gEuphonaBP, % valuesArray[Euphona]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncEuphonaBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecEuphonaBarrel, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vEuphonaBarrel gEuphonaBarrel, % valuesArray[Euphona+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncEuphonaBarrel, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecEuphonaReceiver, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vEuphonaReceiver gEuphonaReceiver, % valuesArray[Euphona+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncEuphonaReceiver, +
    
    Gui, WEPS:Tab, 11
    Gui, WEPS:Add, Picture, x270 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Blade.png
    Gui, WEPS:Add, Picture, x280 y+28 w-1 h80 BackgroundTrans,  GUI\blueprint\Handle.png
    ;
    Gui, WEPS:Add, Picture, x20 y160 w223 h-1 BackgroundTrans,  GUI\weapon\Fang.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecFangBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vFangBP gFangBP, % valuesArray[Fang]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncFangBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecFangBlade, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vFangBlade gFangBlade, % valuesArray[Fang+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncFangBlade, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecFangHandle, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vFangHandle gFangHandle, % valuesArray[Fang+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncFangHandle, +
    
    Gui, WEPS:Tab, 12
    Gui, WEPS:Add, Picture, x270 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Blade.png
    Gui, WEPS:Add, Picture, x280 y188 w-1 h80 BackgroundTrans,  GUI\blueprint\Handle.png
    ;
    Gui, WEPS:Add, Picture, x20 y150 w223 h-1 BackgroundTrans,  GUI\weapon\Fragor.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecFragorBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vFragorBP gFragorBP, % valuesArray[Fragor]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncFragorBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecFragorHead, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vFragorHead gFragorHead, % valuesArray[Fragor+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncFragorHead, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecFragorHandle, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vFragorHandle gFragorHandle, % valuesArray[Fragor+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncFragorHandle, +
    
    Gui, WEPS:Tab, 13
    Gui, WEPS:Add, Picture, x270 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Blade.png
    Gui, WEPS:Add, Picture, x280 y+28 w-1 h80 BackgroundTrans,  GUI\blueprint\Handle.png
    ;
    Gui, WEPS:Add, Picture, x10 y150 w243 h-1 BackgroundTrans,  GUI\weapon\Galatine.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecGalatineBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vGalatineBP gGalatineBP, % valuesArray[Galatine]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncGalatineBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecGalatineBlade, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vGalatineBlade gGalatineBlade, % valuesArray[Galatine+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncGalatineBlade, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecGalatineHandle, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vGalatineHandle gGalatineHandle, % valuesArray[Galatine+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncGalatineHandle, +
    
    Gui, WEPS:Tab, 14
    Gui, WEPS:Add, Picture, x270 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Blade.png
    Gui, WEPS:Add, Picture, x270 y+28 w-1 h80 BackgroundTrans,  GUI\blueprint\Blade.png
    ;
    Gui, WEPS:Add, Picture, x20 y130 w223 h-1 BackgroundTrans,  GUI\weapon\Glaive.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecGlaiveBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vGlaiveBP gGlaiveBP, % valuesArray[Glaive]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncGlaiveBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecGlaiveBlade, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vGlaiveBlade gGlaiveBlade, % valuesArray[Glaive+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncGlaiveBlade, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecGlaiveDisc, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vGlaiveDisc gGlaiveDisc, % valuesArray[Glaive+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncGlaiveDisc, +
    
    Gui, WEPS:Tab, 15
    Gui, WEPS:Add, Picture, x270 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Blade.png
    Gui, WEPS:Add, Picture, x310 y+38 w-1 h80 BackgroundTrans,  GUI\blueprint\Grip.png
    ;
    Gui, WEPS:Add, Picture, x20 y160 w223 h-1 BackgroundTrans,  GUI\weapon\Hikou.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecHikouBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vHikouBP gHikouBP, % valuesArray[Hikou]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncHikouBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecHikouStars, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vHikouStars gHikouStars, % valuesArray[Hikou+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncHikouStars, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecHikouPouch, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vHikouPouch gHikouPouch, % valuesArray[Hikou+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncHikouPouch, +
    
    Gui, WEPS:Tab, 16
    Gui, WEPS:Add, Picture, x260 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Barrel.png
    Gui, WEPS:Add, Picture, x280 y+28 w-1 h80 BackgroundTrans,  GUI\blueprint\Stock.png
    Gui, WEPS:Add, Picture, x280 y302 w-1 h80 BackgroundTrans,  GUI\blueprint\Receiver.png
    ;
    Gui, WEPS:Add, Picture, x20 y200 w223 h-1 BackgroundTrans,  GUI\weapon\Latron.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecLatronBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vLatronBP gLatronBP, % valuesArray[Latron]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncLatronBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecLatronBarrel, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vLatronBarrel gLatronBarrel, % valuesArray[Latron+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncLatronBarrel, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecLatronReceiver, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vLatronReceiver gLatronReceiver, % valuesArray[Latron+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncLatronReceiver, +
    Gui, WEPS:Add, Button,  x398 y337 w20 h32 gDecLatronStock, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y337 w20 h32 +Center vLatronStock gLatronStock, % valuesArray[Latron+3]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y337 w20 h32 gIncLatronStock, +
    
    Gui, WEPS:Tab, 17
    Gui, WEPS:Add, Picture, x260 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Barrel.png
    Gui, WEPS:Add, Picture, x280 y+28 w-1 h80 BackgroundTrans,  GUI\blueprint\Receiver.png
    ;
    Gui, WEPS:Add, Picture, x20 y170 w223 h-1 BackgroundTrans,  GUI\weapon\Lex.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecLexBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vLexBP gLexBP, % valuesArray[Lex]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncLexBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecLexBarrel, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vLexBarrel gLexBarrel, % valuesArray[Lex+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncLexBarrel, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecLexReceiver, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vLexReceiver gLexReceiver, % valuesArray[Lex+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncLexReceiver, +
    
    Gui, WEPS:Tab, 18
    Gui, WEPS:Add, Picture, x270 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Blade.png
    Gui, WEPS:Add, Picture, x280 y+28 w-1 h80 BackgroundTrans,  GUI\blueprint\Handle.png
    ;
    Gui, WEPS:Add, Picture, x20 y190 w223 h-1 BackgroundTrans,  GUI\weapon\Nikana.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecNikanaBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vNikanaBP gNikanaBP, % valuesArray[Nikana]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncNikanaBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecNikanaBlade, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vNikanaBlade gNikanaBlade, % valuesArray[Nikana+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncNikanaBlade, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecNikanaHilt, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vNikanaHilt gNikanaHilt, % valuesArray[Nikana+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncNikanaHilt, +
    
    Gui, WEPS:Tab, 19
    Gui, WEPS:Add, Picture, x270 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Blade.png
    Gui, WEPS:Add, Picture, x280 y+28 w-1 h80 BackgroundTrans,  GUI\blueprint\Handle.png
    ;
    Gui, WEPS:Add, Picture, x20 y160 w223 h-1 BackgroundTrans,  GUI\weapon\Orthos.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecOrthosBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vOrthosBP gOrthosBP, % valuesArray[Orthos]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncOrthosBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecOrthosBlade, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vOrthosBlade gOrthosBlade, % valuesArray[Orthos+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncOrthosBlade, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecOrthosHandle, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vOrthosHandle gOrthosHandle, % valuesArray[Orthos+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncOrthosHandle, +
    
    Gui, WEPS:Tab, 20
    Gui, WEPS:Add, Picture, x300 y80 w-1 h60 BackgroundTrans,  GUI\blueprint\Blade.png
    Gui, WEPS:Add, Picture, x310 y+28 w-1 h60 BackgroundTrans,  GUI\blueprint\Grip.png
    Gui, WEPS:Add, Picture, x300 y+28 w-1 h60 BackgroundTrans,  GUI\blueprint\Blade.inverted.png
    Gui, WEPS:Add, Picture, x310 y+28 w-1 h60 BackgroundTrans,  GUI\blueprint\Stock.png
    ;
    Gui, WEPS:Add, Picture, x20 y165 w223 h-1 BackgroundTrans,  GUI\weapon\Paris.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecParisBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vParisBP gParisBP, % valuesArray[Paris]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncParisBP, +
    Gui, WEPS:Add, Button,  x398 y95 w20 h32 gDecParisUpperLimb, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y95 w20 h32 +Center vParisUpperLimb gParisUpperLimb, % valuesArray[Paris+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y95 w20 h32 gIncParisUpperLimb, +
    Gui, WEPS:Add, Button,  x398 y179 w20 h32 gDecParisGrip, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y179 w20 h32 +Center vParisGrip gParisGrip, % valuesArray[Paris+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y179 w20 h32 gIncParisGrip, +
    Gui, WEPS:Add, Button,  x398 y263 w20 h32 gDecParisLowerLimb, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y263 w20 h32 +Center vParisLowerLimb gParisLowerLimb, % valuesArray[Paris+3]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y263 w20 h32 gIncParisLowerLimb, +
    Gui, WEPS:Add, Button,  x398 y357 w20 h32 gDecParisString, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y357 w20 h32 +Center vParisString gParisString, % valuesArray[Paris+4]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y357 w20 h32 gIncParisString, +
    
    Gui, WEPS:Tab, 21
    Gui, WEPS:Add, Picture, x270 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Blade.png
    Gui, WEPS:Add, Picture, x280 y+28 w-1 h80 BackgroundTrans,  GUI\blueprint\Handle.png
    ;
    Gui, WEPS:Add, Picture, x20 y160 w223 h-1 BackgroundTrans,  GUI\weapon\Reaper.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecReaperBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vReaperBP gReaperBP, % valuesArray[Reaper]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncReaperBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecReaperBlade, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vReaperBlade gReaperBlade, % valuesArray[Reaper+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncReaperBlade, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecReaperHandle, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vReaperHandle gReaperHandle, % valuesArray[Reaper+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncReaperHandle, +
    
    Gui, WEPS:Tab, 22
    Gui, WEPS:Add, Picture, x270 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Blade.png
    Gui, WEPS:Add, Picture, x280 y+28 w-1 h80 BackgroundTrans,  GUI\blueprint\Handle.png
    ;
    Gui, WEPS:Add, Picture, x20 y170 w223 h-1 BackgroundTrans,  GUI\weapon\Scindo.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecScindoBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vScindoBP gScindoBP, % valuesArray[Scindo]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncScindoBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecScindoBlade, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vScindoBlade gScindoBlade, % valuesArray[Scindo+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncScindoBlade, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecScindoHandle, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vScindoHandle gScindoHandle, % valuesArray[Scindo+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncScindoHandle, +
    
    Gui, WEPS:Tab, 23
    Gui, WEPS:Add, Picture, x260 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Barrel.png
    Gui, WEPS:Add, Picture, x280 y+28 w-1 h80 BackgroundTrans,  GUI\blueprint\Receiver.png
    ;
    Gui, WEPS:Add, Picture, x20 y190 w223 h-1 BackgroundTrans,  GUI\weapon\Sicarus.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecSicarusBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vSicarusBP gSicarusBP, % valuesArray[Sicarus]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncSicarusBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecSicarusBarrel, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vSicarusBarrel gSicarusBarrel, % valuesArray[Sicarus+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncSicarusBarrel, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecSicarusReceiver, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vSicarusReceiver gSicarusReceiver, % valuesArray[Sicarus+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncSicarusReceiver, +
    
    Gui, WEPS:Tab, 24
    Gui, WEPS:Add, Picture, x260 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Blade.png
    Gui, WEPS:Add, Picture, x280 y+28 w-1 h80 BackgroundTrans,  GUI\blueprint\Guard.png
    Gui, WEPS:Add, Picture, x280 y302 w-1 h80 BackgroundTrans,  GUI\blueprint\Handle.png
    ;
    Gui, WEPS:Add, Picture, x20 y160 w223 h-1 BackgroundTrans,  GUI\weapon\Silva.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecSilvaBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vSilvaBP gSilvaBP, % valuesArray[Silva]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncSilvaBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecSilvaBlade, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vSilvaBlade gSilvaBlade, % valuesArray[Silva+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncSilvaBlade, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecSilvaGuard, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vSilvaGuard gSilvaGuard, % valuesArray[Silva+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncSilvaGuard, +
    Gui, WEPS:Add, Button,  x398 y337 w20 h32 gDecSilvaHilt, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y337 w20 h32 +Center vSilvaHilt gSilvaHilt, % valuesArray[Silva+3]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y337 w20 h32 gIncSilvaHilt, +
    
    Gui, WEPS:Tab, 25
    Gui, WEPS:Add, Picture, x260 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Barrel.png
    Gui, WEPS:Add, Picture, x280 y+28 w-1 h80 BackgroundTrans,  GUI\blueprint\Stock.png
    Gui, WEPS:Add, Picture, x280 y302 w-1 h80 BackgroundTrans,  GUI\blueprint\Receiver.png
    ;
    Gui, WEPS:Add, Picture, x20 y180 w223 h-1 BackgroundTrans,  GUI\weapon\Soma.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecSomaBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vSomaBP gSomaBP, % valuesArray[Soma]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncSomaBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecSomaBarrel, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vSomaBarrel gSomaBarrel, % valuesArray[Soma+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncSomaBarrel, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecSomaReceiver, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vSomaReceiver gSomaReceiver, % valuesArray[Soma+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncSomaReceiver, +
    Gui, WEPS:Add, Button,  x398 y337 w20 h32 gDecSomaStock, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y337 w20 h32 +Center vSomaStock gSomaStock, % valuesArray[Soma+3]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y337 w20 h32 gIncSomaStock, +
    
    Gui, WEPS:Tab, 26
    Gui, WEPS:Add, Picture, x270 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Blade.png
    Gui, WEPS:Add, Picture, x310 y+38 w-1 h80 BackgroundTrans,  GUI\blueprint\Grip.png
    ;
    Gui, WEPS:Add, Picture, x20 y130 w223 h-1 BackgroundTrans,  GUI\weapon\Spira.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecSpiraBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vSpiraBP gSpiraBP, % valuesArray[Spira]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncSpiraBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecSpiraBlade, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vSpiraBlade gSpiraBlade, % valuesArray[Spira+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncSpiraBlade, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecSpiraPouch, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vSpiraPouch gSpiraPouch, % valuesArray[Spira+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncSpiraPouch, +
    
    Gui, WEPS:Tab, 27
    Gui, WEPS:Add, Picture, x260 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Barrel.png
    Gui, WEPS:Add, Picture, x280 y+28 w-1 h80 BackgroundTrans,  GUI\blueprint\Stock.png
    Gui, WEPS:Add, Picture, x280 y302 w-1 h80 BackgroundTrans,  GUI\blueprint\Receiver.png
    ;
    Gui, WEPS:Add, Picture, x20 y180 w223 h-1 BackgroundTrans,  GUI\weapon\Sybaris.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecSybarisBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vSybarisBP gSybarisBP, % valuesArray[Sybaris]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncSybarisBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecSybarisBarrel, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vSybarisBarrel gSybarisBarrel, % valuesArray[Sybaris+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncSybarisBarrel, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecSybarisReceiver, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vSybarisReceiver gSybarisReceiver, % valuesArray[Sybaris+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncSybarisReceiver, +
    Gui, WEPS:Add, Button,  x398 y337 w20 h32 gDecSybarisStock, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y337 w20 h32 +Center vSybarisStock gSybarisStock, % valuesArray[Sybaris+3]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y337 w20 h32 gIncSybarisStock, +
    
    Gui, WEPS:Tab, 28
    Gui, WEPS:Add, Picture, x260 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Barrel.png
    Gui, WEPS:Add, Picture, x280 y+28 w-1 h80 BackgroundTrans,  GUI\blueprint\Stock.png
    Gui, WEPS:Add, Picture, x280 y302 w-1 h80 BackgroundTrans,  GUI\blueprint\Receiver.png
    ;
    Gui, WEPS:Add, Picture, x20 y180 w223 h-1 BackgroundTrans,  GUI\weapon\Tigris.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecTigrisBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vTigrisBP gTigrisBP, % valuesArray[Tigris]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncTigrisBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecTigrisBarrel, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vTigrisBarrel gTigrisBarrel, % valuesArray[Tigris+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncTigrisBarrel, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecTigrisReceiver, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vTigrisReceiver gTigrisReceiver, % valuesArray[Tigris+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncTigrisReceiver, +
    Gui, WEPS:Add, Button,  x398 y337 w20 h32 gDecTigrisStock, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y337 w20 h32 +Center vTigrisStock gTigrisStock, % valuesArray[Tigris+3]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y337 w20 h32 gIncTigrisStock, +
    
    Gui, WEPS:Tab, 29
    Gui, WEPS:Add, Picture, x260 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Barrel.png
    Gui, WEPS:Add, Picture, x280 y+28 w-1 h80 BackgroundTrans,  GUI\blueprint\Receiver.png
    ;
    Gui, WEPS:Add, Picture, x20 y180 w223 h-1 BackgroundTrans,  GUI\weapon\Vasto.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecVastoBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vVastoBP gVastoBP, % valuesArray[Vasto]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncVastoBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecVastoBarrel, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vVastoBarrel gVastoBarrel, % valuesArray[Vasto+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncVastoBarrel, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecVastoReceiver, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vVastoReceiver gVastoReceiver, % valuesArray[Vasto+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncVastoReceiver, +
    
    Gui, WEPS:Tab, 30
    Gui, WEPS:Add, Picture, x260 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Barrel.png
    Gui, WEPS:Add, Picture, x280 y+28 w-1 h80 BackgroundTrans,  GUI\blueprint\Stock.png
    Gui, WEPS:Add, Picture, x280 y302 w-1 h80 BackgroundTrans,  GUI\blueprint\Receiver.png
    ;
    Gui, WEPS:Add, Picture, x20 y200 w223 h-1 BackgroundTrans,  GUI\weapon\Vectis.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecVectisBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vVectisBP gVectisBP, % valuesArray[Vectis]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncVectisBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecVectisBarrel, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vVectisBarrel gVectisBarrel, % valuesArray[Vectis+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncVectisBarrel, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecVectisReceiver, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vVectisReceiver gVectisReceiver, % valuesArray[Vectis+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncVectisReceiver, +
    Gui, WEPS:Add, Button,  x398 y337 w20 h32 gDecVectisStock, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y337 w20 h32 +Center vVectisStock gVectisStock, % valuesArray[Vectis+3]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y337 w20 h32 gIncVectisStock, +
    
    Gui, WEPS:Tab, 31
    Gui, WEPS:Add, Picture, x260 y80 w-1 h80 BackgroundTrans,  GUI\blueprint\Blade.png
    Gui, WEPS:Add, Picture, x280 y+28 w-1 h80 BackgroundTrans,  GUI\blueprint\Handle.png
    ;
    Gui, WEPS:Add, Picture, x20 y140 w223 h-1 BackgroundTrans,  GUI\weapon\Venka.png
    Gui, WEPS:Add, Button,  x168 y80 w20 h32 gDecVenkaBP, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y80 w20 h32 +Center vVenkaBP gVenkaBP, % valuesArray[Venka]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y80 w20 h32 gIncVenkaBP, +
    Gui, WEPS:Add, Button,  x398 y105 w20 h32 gDecVenkaBlade, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y105 w20 h32 +Center vVenkaBlade gVenkaBlade, % valuesArray[Venka+1]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y105 w20 h32 gIncVenkaBlade, +
    Gui, WEPS:Add, Button,  x398 y225 w20 h32 gDecVenkaGauntlet, -
    Gui, WEPS:Font, s20
    Gui, WEPS:Add, Text,  x+10 y225 w20 h32 +Center vVenkaGauntlet gVenkaGauntlet, % valuesArray[Venka+2]
    Gui, WEPS:Font,
    Gui, WEPS:Add, Button,  x+10 y225 w20 h32 gIncVenkaGauntlet, +
    
    Gui, WEPS:+ToolWindow
    Gui, WEPS:Show, h411 w515, Weapons
    
    if(tab != "")
        guicontrol, WEPS:choosestring, wepstabs, %tab%
return
}


IncAkbroncoBP:
    key := Akbronco
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, AkbroncoBP, % valuesArray[key]
return
DecAkbroncoBP:
    key := Akbronco
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, AkbroncoBP, % valuesArray[key]
    }
return
IncAkbroncoLink:
    key := Akbronco + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, AkbroncoLink, % valuesArray[key]
return
DecAkbroncoLink:
    key := Akbronco + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, AkbroncoLink, % valuesArray[key]
    }
return


IncAkstilettoBP:
    key := Akstiletto
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, AkstilettoBP, % valuesArray[key]
return
DecAkstilettoBP:
    key := Akstiletto
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, AkstilettoBP, % valuesArray[key]
    }
return
IncAkstilettoBarrel:
    key := Akstiletto + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, AkstilettoBarrel, % valuesArray[key]
return
DecAkstilettoBarrel:
    key := Akstiletto + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, AkstilettoBarrel, % valuesArray[key]
    }
return
IncAkstilettoReceiver:
    key := Akstiletto + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, AkstilettoReceiver, % valuesArray[key]
return
DecAkstilettoReceiver:
    key := Akstiletto + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, AkstilettoReceiver, % valuesArray[key]
    }
return
IncAkstilettoLink:
    key := Akstiletto + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, AkstilettoLink, % valuesArray[key]
return
DecAkstilettoLink:
    key := Akstiletto + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, AkstilettoLink, % valuesArray[key]
    }
return


IncBoarBP:
    key := Boar
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, BoarBP, % valuesArray[key]
return
DecBoarBP:
    key := Boar
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, BoarBP, % valuesArray[key]
    }
return
IncBoarBarrel:
    key := Boar + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, BoarBarrel, % valuesArray[key]
return
DecBoarBarrel:
    key := Boar + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, BoarBarrel, % valuesArray[key]
    }
return
IncBoarReceiver:
    key := Boar + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, BoarReceiver, % valuesArray[key]
return
DecBoarReceiver:
    key := Boar + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, BoarReceiver, % valuesArray[key]
    }
return
IncBoarStock:
    key := Boar + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, BoarStock, % valuesArray[key]
return
DecBoarStock:
    key := Boar + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, BoarStock, % valuesArray[key]
    }
return


IncBratonBP:
    key := Braton
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, BratonBP, % valuesArray[key]
return
DecBratonBP:
    key := Braton
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, BratonBP, % valuesArray[key]
    }
return
IncBratonBarrel:
    key := Braton + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, BratonBarrel, % valuesArray[key]
return
DecBratonBarrel:
    key := Braton + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, BratonBarrel, % valuesArray[key]
    }
return
IncBratonReceiver:
    key := Braton + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, BratonReceiver, % valuesArray[key]
return
DecBratonReceiver:
    key := Braton + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, BratonReceiver, % valuesArray[key]
    }
return
IncBratonStock:
    key := Braton + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, BratonStock, % valuesArray[key]
return
DecBratonStock:
    key := Braton + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, BratonStock, % valuesArray[key]
    }
return


IncBroncoBP:
    key := Bronco
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, BroncoBP, % valuesArray[key]
return
DecBroncoBP:
    key := Bronco
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, BroncoBP, % valuesArray[key]
    }
return
IncBroncoBarrel:
    key := Bronco + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, BroncoBarrel, % valuesArray[key]
return
DecBroncoBarrel:
    key := Bronco + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, BroncoBarrel, % valuesArray[key]
    }
return
IncBroncoReceiver:
    key := Bronco + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, BroncoReceiver, % valuesArray[key]
return
DecBroncoReceiver:
    key := Bronco + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, BroncoReceiver, % valuesArray[key]
    }
return


IncBurstonBP:
    key := Burston
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, BurstonBP, % valuesArray[key]
return
DecBurstonBP:
    key := Burston
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, BurstonBP, % valuesArray[key]
    }
return
IncBurstonBarrel:
    key := Burston + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, BurstonBarrel, % valuesArray[key]
return
DecBurstonBarrel:
    key := Burston + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, BurstonBarrel, % valuesArray[key]
    }
return
IncBurstonReceiver:
    key := Burston + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, BurstonReceiver, % valuesArray[key]
return
DecBurstonReceiver:
    key := Burston + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, BurstonReceiver, % valuesArray[key]
    }
return
IncBurstonStock:
    key := Burston + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, BurstonStock, % valuesArray[key]
return
DecBurstonStock:
    key := Burston + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, BurstonStock, % valuesArray[key]
    }
return


IncLatronBP:
    key := Latron
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, LatronBP, % valuesArray[key]
return
DecLatronBP:
    key := Latron
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, LatronBP, % valuesArray[key]
    }
return
IncLatronBarrel:
    key := Latron + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, LatronBarrel, % valuesArray[key]
return
DecLatronBarrel:
    key := Latron + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, LatronBarrel, % valuesArray[key]
    }
return
IncLatronReceiver:
    key := Latron + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, LatronReceiver, % valuesArray[key]
return
DecLatronReceiver:
    key := Latron + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, LatronReceiver, % valuesArray[key]
    }
return
IncLatronStock:
    key := Latron + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, LatronStock, % valuesArray[key]
return
DecLatronStock:
    key := Latron + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, LatronStock, % valuesArray[key]
    }
return


IncSybarisBP:
    key := Sybaris
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, SybarisBP, % valuesArray[key]
return
DecSybarisBP:
    key := Sybaris
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, SybarisBP, % valuesArray[key]
    }
return
IncSybarisBarrel:
    key := Sybaris + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, SybarisBarrel, % valuesArray[key]
return
DecSybarisBarrel:
    key := Sybaris + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, SybarisBarrel, % valuesArray[key]
    }
return
IncSybarisReceiver:
    key := Sybaris + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, SybarisReceiver, % valuesArray[key]
return
DecSybarisReceiver:
    key := Sybaris + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, SybarisReceiver, % valuesArray[key]
    }
return
IncSybarisStock:
    key := Sybaris + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, SybarisStock, % valuesArray[key]
return
DecSybarisStock:
    key := Sybaris + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, SybarisStock, % valuesArray[key]
    }
return


IncLexBP:
    key := Lex
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, LexBP, % valuesArray[key]
return
DecLexBP:
    key := Lex
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, LexBP, % valuesArray[key]
    }
return
IncLexBarrel:
    key := Lex + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, LexBarrel, % valuesArray[key]
return
DecLexBarrel:
    key := Lex + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, LexBarrel, % valuesArray[key]
    }
return
IncLexReceiver:
    key := Lex + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, LexReceiver, % valuesArray[key]
return
DecLexReceiver:
    key := Lex + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, LexReceiver, % valuesArray[key]
    }
return


IncEuphonaBP:
    key := Euphona
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, EuphonaBP, % valuesArray[key]
return
DecEuphonaBP:
    key := Euphona
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, EuphonaBP, % valuesArray[key]
    }
return
IncEuphonaBarrel:
    key := Euphona + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, EuphonaBarrel, % valuesArray[key]
return
DecEuphonaBarrel:
    key := Euphona + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, EuphonaBarrel, % valuesArray[key]
    }
return
IncEuphonaReceiver:
    key := Euphona + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, EuphonaReceiver, % valuesArray[key]
return
DecEuphonaReceiver:
    key := Euphona + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, EuphonaReceiver, % valuesArray[key]
    }
return


IncSicarusBP:
    key := Sicarus
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, SicarusBP, % valuesArray[key]
return
DecSicarusBP:
    key := Sicarus
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, SicarusBP, % valuesArray[key]
    }
return
IncSicarusBarrel:
    key := Sicarus + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, SicarusBarrel, % valuesArray[key]
return
DecSicarusBarrel:
    key := Sicarus + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, SicarusBarrel, % valuesArray[key]
    }
return
IncSicarusReceiver:
    key := Sicarus + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, SicarusReceiver, % valuesArray[key]
return
DecSicarusReceiver:
    key := Sicarus + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, SicarusReceiver, % valuesArray[key]
    }
return


IncSomaBP:
    key := Soma
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, SomaBP, % valuesArray[key]
return
DecSomaBP:
    key := Soma
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, SomaBP, % valuesArray[key]
    }
return
IncSomaBarrel:
    key := Soma + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, SomaBarrel, % valuesArray[key]
return
DecSomaBarrel:
    key := Soma + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, SomaBarrel, % valuesArray[key]
    }
return
IncSomaReceiver:
    key := Soma + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, SomaReceiver, % valuesArray[key]
return
DecSomaReceiver:
    key := Soma + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, SomaReceiver, % valuesArray[key]
    }
return
IncSomaStock:
    key := Soma + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, SomaStock, % valuesArray[key]
return
DecSomaStock:
    key := Soma + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, SomaStock, % valuesArray[key]
    }
return


IncTigrisBP:
    key := Tigris
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, TigrisBP, % valuesArray[key]
return
DecTigrisBP:
    key := Tigris
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, TigrisBP, % valuesArray[key]
    }
return
IncTigrisBarrel:
    key := Tigris + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, TigrisBarrel, % valuesArray[key]
return
DecTigrisBarrel:
    key := Tigris + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, TigrisBarrel, % valuesArray[key]
    }
return
IncTigrisReceiver:
    key := Tigris + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, TigrisReceiver, % valuesArray[key]
return
DecTigrisReceiver:
    key := Tigris + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, TigrisReceiver, % valuesArray[key]
    }
return
IncTigrisStock:
    key := Tigris + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, TigrisStock, % valuesArray[key]
return
DecTigrisStock:
    key := Tigris + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, TigrisStock, % valuesArray[key]
    }
return


IncVastoBP:
    key := Vasto
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, VastoBP, % valuesArray[key]
return
DecVastoBP:
    key := Vasto
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, VastoBP, % valuesArray[key]
    }
return
IncVastoBarrel:
    key := Vasto + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, VastoBarrel, % valuesArray[key]
return
DecVastoBarrel:
    key := Vasto + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, VastoBarrel, % valuesArray[key]
    }
return
IncVastoReceiver:
    key := Vasto + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, VastoReceiver, % valuesArray[key]
return
DecVastoReceiver:
    key := Vasto + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, VastoReceiver, % valuesArray[key]
    }
return


IncVectisBP:
    key := Vectis
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, VectisBP, % valuesArray[key]
return
DecVectisBP:
    key := Vectis
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, VectisBP, % valuesArray[key]
    }
return
IncVectisBarrel:
    key := Vectis + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, VectisBarrel, % valuesArray[key]
return
DecVectisBarrel:
    key := Vectis + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, VectisBarrel, % valuesArray[key]
    }
return
IncVectisReceiver:
    key := Vectis + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, VectisReceiver, % valuesArray[key]
return
DecVectisReceiver:
    key := Vectis + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, VectisReceiver, % valuesArray[key]
    }
return
IncVectisStock:
    key := Vectis + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, VectisStock, % valuesArray[key]
return
DecVectisStock:
    key := Vectis + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, VectisStock, % valuesArray[key]
    }
return


IncCernosBP:
    key := Cernos
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, CernosBP, % valuesArray[key]
return
DecCernosBP:
    key := Cernos
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, CernosBP, % valuesArray[key]
    }
return
IncCernosUpperLimb:
    key := Cernos + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, CernosUpperLimb, % valuesArray[key]
return
DecCernosUpperLimb:
    key := Cernos + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, CernosUpperLimb, % valuesArray[key]
    }
return
IncCernosGrip:
    key := Cernos + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, CernosGrip, % valuesArray[key]
return
DecCernosGrip:
    key := Cernos + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, CernosGrip, % valuesArray[key]
    }
return
IncCernosLowerLimb:
    key := Cernos + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, CernosLowerLimb, % valuesArray[key]
return
DecCernosLowerLimb:
    key := Cernos + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, CernosLowerLimb, % valuesArray[key]
    }
return
IncCernosString:
    key := Cernos + 4
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, CernosString, % valuesArray[key]
return
DecCernosString:
    key := Cernos + 4
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, CernosString, % valuesArray[key]
    }
return


IncParisBP:
    key := Paris
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, ParisBP, % valuesArray[key]
return
DecParisBP:
    key := Paris
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, ParisBP, % valuesArray[key]
    }
return
IncParisUpperLimb:
    key := Paris + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, ParisUpperLimb, % valuesArray[key]
return
DecParisUpperLimb:
    key := Paris + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, ParisUpperLimb, % valuesArray[key]
    }
return
IncParisGrip:
    key := Paris + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, ParisGrip, % valuesArray[key]
return
DecParisGrip:
    key := Paris + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, ParisGrip, % valuesArray[key]
    }
return
IncParisLowerLimb:
    key := Paris + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, ParisLowerLimb, % valuesArray[key]
return
DecParisLowerLimb:
    key := Paris + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, ParisLowerLimb, % valuesArray[key]
    }
return
IncParisString:
    key := Paris + 4
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, ParisString, % valuesArray[key]
return
DecParisString:
    key := Paris + 4
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, ParisString, % valuesArray[key]
    }
return


IncGlaiveBP:
    key := Glaive
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, GlaiveBP, % valuesArray[key]
return
DecGlaiveBP:
    key := Glaive
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, GlaiveBP, % valuesArray[key]
    }
return
IncGlaiveBlade:
    key := Glaive + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, GlaiveBlade, % valuesArray[key]
return
DecGlaiveBlade:
    key := Glaive + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, GlaiveBlade, % valuesArray[key]
    }
return
IncGlaiveDisc:
    key := Glaive + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, GlaiveDisc, % valuesArray[key]
return
DecGlaiveDisc:
    key := Glaive + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, GlaiveDisc, % valuesArray[key]
    }
return


IncHikouBP:
    key := Hikou
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, HikouBP, % valuesArray[key]
return
DecHikouBP:
    key := Hikou
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, HikouBP, % valuesArray[key]
    }
return
IncHikouStars:
    key := Hikou + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, HikouStars, % valuesArray[key]
return
DecHikouStars:
    key := Hikou + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, HikouStars, % valuesArray[key]
    }
return
IncHikouPouch:
    key := Hikou + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, HikouPouch, % valuesArray[key]
return
DecHikouPouch:
    key := Hikou + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, HikouPouch, % valuesArray[key]
    }
return


IncSpiraBP:
    key := Spira
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, SpiraBP, % valuesArray[key]
return
DecSpiraBP:
    key := Spira
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, SpiraBP, % valuesArray[key]
    }
return
IncSpiraBlade:
    key := Spira + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, SpiraBlade, % valuesArray[key]
return
DecSpiraBlade:
    key := Spira + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, SpiraBlade, % valuesArray[key]
    }
return
IncSpiraPouch:
    key := Spira + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, SpiraPouch, % valuesArray[key]
return
DecSpiraPouch:
    key := Spira + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, SpiraPouch, % valuesArray[key]
    }
return


IncVenkaBP:
    key := Venka
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, VenkaBP, % valuesArray[key]
return
DecVenkaBP:
    key := Venka
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, VenkaBP, % valuesArray[key]
    }
return
IncVenkaBlade:
    key := Venka + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, VenkaBlade, % valuesArray[key]
return
DecVenkaBlade:
    key := Venka + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, VenkaBlade, % valuesArray[key]
    }
return
IncVenkaGauntlet:
    key := Venka + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, VenkaGauntlet, % valuesArray[key]
return
DecVenkaGauntlet:
    key := Venka + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, VenkaGauntlet, % valuesArray[key]
    }
return


IncFragorBP:
    key := Fragor
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, FragorBP, % valuesArray[key]
return
DecFragorBP:
    key := Fragor
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, FragorBP, % valuesArray[key]
    }
return
IncFragorHead:
    key := Fragor + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, FragorHead, % valuesArray[key]
return
DecFragorHead:
    key := Fragor + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, FragorHead, % valuesArray[key]
    }
return
IncFragorHandle:
    key := Fragor + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, FragorHandle, % valuesArray[key]
return
DecFragorHandle:
    key := Fragor + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, FragorHandle, % valuesArray[key]
    }
return


IncNikanaBP:
    key := Nikana
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, NikanaBP, % valuesArray[key]
return
DecNikanaBP:
    key := Nikana
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, NikanaBP, % valuesArray[key]
    }
return
IncNikanaBlade:
    key := Nikana + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, NikanaBlade, % valuesArray[key]
return
DecNikanaBlade:
    key := Nikana + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, NikanaBlade, % valuesArray[key]
    }
return
IncNikanaHilt:
    key := Nikana + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, NikanaHilt, % valuesArray[key]
return
DecNikanaHilt:
    key := Nikana + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, NikanaHilt, % valuesArray[key]
    }
return


IncSilvaBP:
    key := Silva
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, SilvaBP, % valuesArray[key]
return
DecSilvaBP:
    key := Silva
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, SilvaBP, % valuesArray[key]
    }
return
IncSilvaBlade:
    key := Silva + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, SilvaBlade, % valuesArray[key]
return
DecSilvaBlade:
    key := Silva + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, SilvaBlade, % valuesArray[key]
    }
return
IncSilvaGuard:
    key := Silva + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, SilvaGuard, % valuesArray[key]
return
DecSilvaGuard:
    key := Silva + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, SilvaGuard, % valuesArray[key]
    }
return
IncSilvaHilt:
    key := Silva + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, SilvaHilt, % valuesArray[key]
return
DecSilvaHilt:
    key := Silva + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, SilvaHilt, % valuesArray[key]
    }
return


IncDakraBP:
    key := Dakra
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, DakraBP, % valuesArray[key]
return
DecDakraBP:
    key := Dakra
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, DakraBP, % valuesArray[key]
    }
return
IncDakraBlade:
    key := Dakra + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, DakraBlade, % valuesArray[key]
return
DecDakraBlade:
    key := Dakra + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, DakraBlade, % valuesArray[key]
    }
return
IncDakraHandle:
    key := Dakra + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, DakraHandle, % valuesArray[key]
return
DecDakraHandle:
    key := Dakra + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, DakraHandle, % valuesArray[key]
    }
return


IncDualKamasBP:
    key := DualKamas
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, DualKamasBP, % valuesArray[key]
return
DecDualKamasBP:
    key := DualKamas
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, DualKamasBP, % valuesArray[key]
    }
return
IncDualKamasBlade:
    key := DualKamas + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, DualKamasBlade, % valuesArray[key]
return
DecDualKamasBlade:
    key := DualKamas + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, DualKamasBlade, % valuesArray[key]
    }
return
IncDualKamasHandle:
    key := DualKamas + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, DualKamasHandle, % valuesArray[key]
return
DecDualKamasHandle:
    key := DualKamas + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, DualKamasHandle, % valuesArray[key]
    }
return


IncFangBP:
    key := Fang
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, FangBP, % valuesArray[key]
return
DecFangBP:
    key := Fang
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, FangBP, % valuesArray[key]
    }
return
IncFangBlade:
    key := Fang + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, FangBlade, % valuesArray[key]
return
DecFangBlade:
    key := Fang + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, FangBlade, % valuesArray[key]
    }
return
IncFangHandle:
    key := Fang + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, FangHandle, % valuesArray[key]
return
DecFangHandle:
    key := Fang + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, FangHandle, % valuesArray[key]
    }
return


IncGalatineBP:
    key := Galatine
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, GalatineBP, % valuesArray[key]
return
DecGalatineBP:
    key := Galatine
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, GalatineBP, % valuesArray[key]
    }
return
IncGalatineBlade:
    key := Galatine + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, GalatineBlade, % valuesArray[key]
return
DecGalatineBlade:
    key := Galatine + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, GalatineBlade, % valuesArray[key]
    }
return
IncGalatineHandle:
    key := Galatine + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, GalatineHandle, % valuesArray[key]
return
DecGalatineHandle:
    key := Galatine + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, GalatineHandle, % valuesArray[key]
    }
return


IncOrthosBP:
    key := Orthos
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, OrthosBP, % valuesArray[key]
return
DecOrthosBP:
    key := Orthos
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, OrthosBP, % valuesArray[key]
    }
return
IncOrthosBlade:
    key := Orthos + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, OrthosBlade, % valuesArray[key]
return
DecOrthosBlade:
    key := Orthos + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, OrthosBlade, % valuesArray[key]
    }
return
IncOrthosHandle:
    key := Orthos + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, OrthosHandle, % valuesArray[key]
return
DecOrthosHandle:
    key := Orthos + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, OrthosHandle, % valuesArray[key]
    }
return


IncReaperBP:
    key := Reaper
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, ReaperBP, % valuesArray[key]
return
DecReaperBP:
    key := Reaper
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, ReaperBP, % valuesArray[key]
    }
return
IncReaperBlade:
    key := Reaper + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, ReaperBlade, % valuesArray[key]
return
DecReaperBlade:
    key := Reaper + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, ReaperBlade, % valuesArray[key]
    }
return
IncReaperHandle:
    key := Reaper + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, ReaperHandle, % valuesArray[key]
return
DecReaperHandle:
    key := Reaper + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, ReaperHandle, % valuesArray[key]
    }
return


IncScindoBP:
    key := Scindo
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, ScindoBP, % valuesArray[key]
return
DecScindoBP:
    key := Scindo
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, ScindoBP, % valuesArray[key]
    }
return
IncScindoBlade:
    key := Scindo + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, ScindoBlade, % valuesArray[key]
return
DecScindoBlade:
    key := Scindo + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, ScindoBlade, % valuesArray[key]
    }
return
IncScindoHandle:
    key := Scindo + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, ScindoHandle, % valuesArray[key]
return
DecScindoHandle:
    key := Scindo + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, ScindoHandle, % valuesArray[key]
    }
return


misc(tab="")
{
    Gui, MISC:Destroy
    Gui, MISC:Add, Picture, x0 y20 w520 h370 BackgroundTrans,  GUI\blueprint\Blueprint.crop.png
    Gui, MISC:Add, Tab, x0 y0 w520 h370 vmisctabs, Carrier|Helios|Kavasa|Odonata|Forma
    
    Gui, MISC:Add, Picture, x280 y40 w128 h-1 BackgroundTrans,  GUI\blueprint\Neuroptics.png
    Gui, MISC:Add, Picture, x280 y+28 w128 h-1 BackgroundTrans,  GUI\blueprint\Chassis.png
    Gui, MISC:Add, Picture, x280 y262 w128 h-1 BackgroundTrans,  GUI\blueprint\Systems.png
    ;
    Gui, MISC:Add, Picture, x40 y60 w193 h288 BackgroundTrans,  GUI\misc\Carrier.png
    Gui, MISC:Add, Button,  x168 y40 w20 h32 gDecCarrierBP, -
    Gui, MISC:Font, s20
    Gui, MISC:Add, Text,  x+10 y40 w20 h32 +Center vCarrierBP gCarrierBP, % valuesArray[Carrier]
    Gui, MISC:Font,
    Gui, MISC:Add, Button,  x+10 y40 w20 h32 gIncCarrierBP, +
    Gui, MISC:Add, Button,  x398 y185 w20 h32 gDecCarrierCarapace, -
    Gui, MISC:Font, s20
    Gui, MISC:Add, Text,  x+10 y185 w20 h32 +Center vCarrierCarapace gCarrierCarapace, % valuesArray[Carrier+1]
    Gui, MISC:Font,
    Gui, MISC:Add, Button,  x+10 y185 w20 h32 gIncCarrierCarapace, +
    Gui, MISC:Add, Button,  x398 y65 w20 h32 gDecCarrierCerebrum, -
    Gui, MISC:Font, s20
    Gui, MISC:Add, Text,  x+10 y65 w20 h32 +Center vCarrierCerebrum gCarrierCerebrum, % valuesArray[Carrier+2]
    Gui, MISC:Font,
    Gui, MISC:Add, Button,  x+10 y65 w20 h32 gIncCarrierCerebrum, +
    Gui, MISC:Add, Button,  x398 y297 w20 h32 gDecCarrierSystems, -
    Gui, MISC:Font, s20
    Gui, MISC:Add, Text,  x+10 y297 w20 h32 +Center vCarrierSystems gCarrierSystems, % valuesArray[Carrier+3]
    Gui, MISC:Font,
    Gui, MISC:Add, Button,  x+10 y297 w20 h32 gIncCarrierSystems, +
    
    Gui, MISC:Tab, 2
    Gui, MISC:Add, Picture, x280 y40 w128 h-1 BackgroundTrans,  GUI\blueprint\Neuroptics.png
    Gui, MISC:Add, Picture, x280 y+28 w128 h-1 BackgroundTrans,  GUI\blueprint\Chassis.png
    Gui, MISC:Add, Picture, x280 y262 w128 h-1 BackgroundTrans,  GUI\blueprint\Systems.png
    ;
    Gui, MISC:Add, Picture, x40 y60 w193 h288 BackgroundTrans,  GUI\misc\Helios.png
    Gui, MISC:Add, Button,  x168 y40 w20 h32 gDecHeliosBP, -
    Gui, MISC:Font, s20
    Gui, MISC:Add, Text,  x+10 y40 w20 h32 +Center vHeliosBP gHeliosBP, % valuesArray[Helios]
    Gui, MISC:Font,
    Gui, MISC:Add, Button,  x+10 y40 w20 h32 gIncHeliosBP, +
    Gui, MISC:Add, Button,  x398 y185 w20 h32 gDecHeliosCarapace, -
    Gui, MISC:Font, s20
    Gui, MISC:Add, Text,  x+10 y185 w20 h32 +Center vHeliosCarapace gHeliosCarapace, % valuesArray[Helios+1]
    Gui, MISC:Font,
    Gui, MISC:Add, Button,  x+10 y185 w20 h32 gIncHeliosCarapace, +
    Gui, MISC:Add, Button,  x398 y65 w20 h32 gDecHeliosCerebrum, -
    Gui, MISC:Font, s20
    Gui, MISC:Add, Text,  x+10 y65 w20 h32 +Center vHeliosCerebrum gHeliosCerebrum, % valuesArray[Helios+2]
    Gui, MISC:Font,
    Gui, MISC:Add, Button,  x+10 y65 w20 h32 gIncHeliosCerebrum, +
    Gui, MISC:Add, Button,  x398 y297 w20 h32 gDecHeliosSystems, -
    Gui, MISC:Font, s20
    Gui, MISC:Add, Text,  x+10 y297 w20 h32 +Center vHeliosSystems gHeliosSystems, % valuesArray[Helios+3]
    Gui, MISC:Font,
    Gui, MISC:Add, Button,  x+10 y297 w20 h32 gIncHeliosSystems, +
    
    Gui, MISC:Tab, 3
    Gui, MISC:Add, Picture, x310 y40 w-1 h80 BackgroundTrans,  GUI\blueprint\Grip.png
    Gui, MISC:Add, Picture, x280 y+28 w-1 h80 BackgroundTrans,  GUI\blueprint\Link.png
    ;
    Gui, MISC:Add, Picture, x0 y80 w500 h-1 BackgroundTrans,  GUI\misc\Kavasa.png
    Gui, MISC:Add, Button,  x168 y40 w20 h32 gDecKavasaBP, -
    Gui, MISC:Font, s20
    Gui, MISC:Add, Text,  x+10 y40 w20 h32 +Center vKavasaBP gKavasaBP, % valuesArray[Kavasa]
    Gui, MISC:Font,
    Gui, MISC:Add, Button,  x+10 y40 w20 h32 gIncKavasaBP, +
    Gui, MISC:Add, Button,  x398 y65 w20 h32 gDecKavasaBand, -
    Gui, MISC:Font, s20
    Gui, MISC:Add, Text,  x+10 y65 w20 h32 +Center vKavasaBand gKavasaBand, % valuesArray[Kavasa+1]
    Gui, MISC:Font,
    Gui, MISC:Add, Button,  x+10 y65 w20 h32 gIncKavasaBand, +
    Gui, MISC:Add, Button,  x398 y185 w20 h32 gDecKavasaBuckle, -
    Gui, MISC:Font, s20
    Gui, MISC:Add, Text,  x+10 y185 w20 h32 +Center vKavasaBuckle gKavasaBuckle, % valuesArray[Kavasa+2]
    Gui, MISC:Font,
    Gui, MISC:Add, Button,  x+10 y185 w20 h32 gIncKavasaBuckle, +
    
    Gui, MISC:Tab, 4
    Gui, MISC:Add, Picture, x280 y40 w128 h-1 BackgroundTrans,  GUI\blueprint\archwing_harness.png
    Gui, MISC:Add, Picture, x280 y155 w128 h-1 BackgroundTrans,  GUI\blueprint\archwing_wings.png
    Gui, MISC:Add, Picture, x280 y262 w128 h-1 BackgroundTrans,  GUI\blueprint\archwing_systems.png
    ;
    Gui, MISC:Add, Picture, x0 y60 w256 h-1 BackgroundTrans,  GUI\misc\Odonata.crop.gradient.png
    Gui, MISC:Add, Button,  x168 y40 w20 h32 gDecOdonataBP, -
    Gui, MISC:Font, s20
    Gui, MISC:Add, Text,  x+10 y40 w20 h32 +Center vOdonataBP gOdonataBP, % valuesArray[Odonata]
    Gui, MISC:Font,
    Gui, MISC:Add, Button,  x+10 y40 w20 h32 gIncOdonataBP, +
    Gui, MISC:Add, Button,  x398 y65 w20 h32 gDecOdonataHarness, -
    Gui, MISC:Font, s20
    Gui, MISC:Add, Text,  x+10 y65 w20 h32 +Center vOdonataHarness gOdonataHarness, % valuesArray[Odonata+1]
    Gui, MISC:Font,
    Gui, MISC:Add, Button,  x+10 y65 w20 h32 gIncOdonataHarness, +
    Gui, MISC:Add, Button,  x398 y185 w20 h32 gDecOdonataWings, -
    Gui, MISC:Font, s20
    Gui, MISC:Add, Text,  x+10 y185 w20 h32 +Center vOdonataWings gOdonataWings, % valuesArray[Odonata+3]
    Gui, MISC:Font,
    Gui, MISC:Add, Button,  x+10 y185 w20 h32 gIncOdonataWings, +
    Gui, MISC:Add, Button,  x398 y297 w20 h32 gDecOdonataSystems, -
    Gui, MISC:Font, s20
    Gui, MISC:Add, Text,  x+10 y297 w20 h32 +Center vOdonataSystems gOdonataSystems, % valuesArray[Odonata+2]
    Gui, MISC:Font,
    Gui, MISC:Add, Button,  x+10 y297 w20 h32 gIncOdonataSystems, +
    
    
    Gui, MISC:Tab, 5
    ;
    Gui, MISC:Add, Picture, x5 y80 w256 h-1 BackgroundTrans,  GUI\misc\Forma.png
    Gui, MISC:Add, Button,  x168 y40 w20 h32 gDecFormaBP, -
    Gui, MISC:Font, s20
    Gui, MISC:Add, Text,  x+10 y40 w20 h32 +Center vFormaBP gFormaBP, % valuesArray[Forma]
    Gui, MISC:Font,
    Gui, MISC:Add, Button,  x+10 y40 w20 h32 gIncFormaBP, +
    
    if(tab != "")
        guicontrol, MISC:choosestring, misctabs, %tab%
    
    Gui, MISC:+ToolWindow
    Gui, MISC:Show, h371 w515, Misc
return
}

IncFormaBP:
    key := Forma
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, FormaBP, % valuesArray[key]
return
DecFormaBP:
    key := Forma
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, FormaBP, % valuesArray[key]
    }
return


IncCarrierBP:
    key := Carrier
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, CarrierBP, % valuesArray[key]
return
DecCarrierBP:
    key := Carrier
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, CarrierBP, % valuesArray[key]
    }
return
IncCarrierCarapace:
    key := Carrier + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, CarrierCarapace, % valuesArray[key]
return
DecCarrierCarapace:
    key := Carrier + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, CarrierCarapace, % valuesArray[key]
    }
return
IncCarrierCerebrum:
    key := Carrier + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, CarrierCerebrum, % valuesArray[key]
return
DecCarrierCerebrum:
    key := Carrier + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, CarrierCerebrum, % valuesArray[key]
    }
return
IncCarrierSystems:
    key := Carrier + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, CarrierSystems, % valuesArray[key]
return
DecCarrierSystems:
    key := Carrier + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, CarrierSystems, % valuesArray[key]
    }
return


IncHeliosBP:
    key := Helios
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, HeliosBP, % valuesArray[key]
return
DecHeliosBP:
    key := Helios
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, HeliosBP, % valuesArray[key]
    }
return
IncHeliosCarapace:
    key := Helios + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, HeliosCarapace, % valuesArray[key]
return
DecHeliosCarapace:
    key := Helios + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, HeliosCarapace, % valuesArray[key]
    }
return
IncHeliosCerebrum:
    key := Helios + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, HeliosCerebrum, % valuesArray[key]
return
DecHeliosCerebrum:
    key := Helios + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, HeliosCerebrum, % valuesArray[key]
    }
return
IncHeliosSystems:
    key := Helios + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, HeliosSystems, % valuesArray[key]
return
DecHeliosSystems:
    key := Helios + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, HeliosSystems, % valuesArray[key]
    }
return


IncKavasaBP:
    key := Kavasa
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, KavasaBP, % valuesArray[key]
return
DecKavasaBP:
    key := Kavasa
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, KavasaBP, % valuesArray[key]
    }
return
IncKavasaBand:
    key := Kavasa + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, KavasaBand, % valuesArray[key]
return
DecKavasaBand:
    key := Kavasa + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, KavasaBand, % valuesArray[key]
    }
return
IncKavasaBuckle:
    key := Kavasa + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, KavasaBuckle, % valuesArray[key]
return
DecKavasaBuckle:
    key := Kavasa + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, KavasaBuckle, % valuesArray[key]
    }
return


IncOdonataBP:
    key := Odonata
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, OdonataBP, % valuesArray[key]
return
DecOdonataBP:
    key := Odonata
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, OdonataBP, % valuesArray[key]
    }
return
IncOdonataHarness:
    key := Odonata + 1
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, OdonataHarness, % valuesArray[key]
return
DecOdonataHarness:
    key := Odonata + 1
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, OdonataHarness, % valuesArray[key]
    }
return
IncOdonataSystems:
    key := Odonata + 2
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, OdonataSystems, % valuesArray[key]
return
DecOdonataSystems:
    key := Odonata + 2
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, OdonataSystems, % valuesArray[key]
    }
return
IncOdonataWings:
    key := Odonata + 3
    valuesArray[key] := valuesArray[key] + 1
    IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
    GUIControl,, OdonataWings, % valuesArray[key]
return
DecOdonataWings:
    key := Odonata + 3
    if (valuesArray[key] > 0)
    {
        valuesArray[key] := valuesArray[key] - 1
        IniWrite, % valuesArray[key], void_tracker.ini, % setArray[key], % partArray[key]
        GUIControl,, OdonataWings, % valuesArray[key]
    }
return


ocr:
    GuiControl, Hide, gold1
    GuiControl, Hide, gold2
    GuiControl, Hide, gold3
    GuiControl, Hide, gold4
    GuiControl, Hide, silver1
    GuiControl, Hide, silver2
    GuiControl, Hide, silver3
    GuiControl, Hide, silver4
    GUIControl,, item1,
    GUIControl,, item2,
    GUIControl,, item3,
    GUIControl,, item4,
    GUIControl,, edit1,
    GUIControl,, edit2,
    GUIControl,, edit3,
    GUIControl,, edit4,
    found1 = 0
    found2 = 0
    found3 = 0
    found4 = 0
    ;widthToScan := A_ScreenWidth*3/4
    ;heightToScan := A_ScreenHeight*1/40
    ;topLeftX := A_ScreenWidth*1/8
    ;topLeftY := A_ScreenHeight*7/16
    ;topLeftY2 := A_ScreenHeight*33/80
    
    ;check for even
    ;coordmode, screen
    ;ImageSearch, X, Y, topLeftX + 4, topLeftY, topLeftX + 14, topLeftY + 10, GUI\corner.png
    ;if (errorlevel) {
    ;    msgbox, error!
    ;    ;+180x
    ;}
    
    magicalText1 := GetOCR(topLeftX+10, topLeftY, widthToScan/4-20, heightToScan)
    magicalTextAlt1 := GetOCR(topLeftX+10, topLeftY2, widthToScan/4-20, heightToScan)
    
    magicalText2 := GetOCR(topLeftX+widthToScan/4+10, topLeftY, widthToScan/4-20, heightToScan)
    magicalTextAlt2 := GetOCR(topLeftX+widthToScan/4+10, topLeftY2, widthToScan/4-20, heightToScan)
    
    magicalText3 := GetOCR(topLeftX+widthToScan/2+10, topLeftY, widthToScan/4-20, heightToScan)
    magicalTextAlt3 := GetOCR(topLeftX+widthToScan/2+10, topLeftY2, widthToScan/4-20, heightToScan)
    
    magicalText4 := GetOCR(topLeftX+widthToScan*3/4+10, topLeftY, widthToScan/4-20, heightToScan)
    magicalTextAlt4 := GetOCR(topLeftX+widthToScan*3/4+10, topLeftY2, widthToScan/4-20, heightToScan)
    
    ;remove blanks
    underCount1 = 0
    underCount2 = 0
    underCount3 = 0
    underCount4 = 0
    underCount5 = 0
    underCount6 = 0
    underCount7 = 0
    underCount8 = 0
    Loop, Parse, magicalText1
    {
        if(A_LoopField = "_")
            underCount1++
    }
    if(underCount1 > undercountmulti * StrLen(magicalText1))
        magicalText1 =
    Loop, Parse, magicalText2
    {
        if(A_LoopField = "_")
            underCount2++
    }
    if(underCount2 > undercountmulti * StrLen(magicalText2))
        magicalText2 =
    Loop, Parse, magicalText3
    {
        if(A_LoopField = "_")
            underCount3++
    }
    if(underCount3 > undercountmulti * StrLen(magicalText3))
        magicalText3 =
    Loop, Parse, magicalText4
    {
        if(A_LoopField = "_")
            underCount4++
    }
    if(underCount4 > undercountmulti * StrLen(magicalText4))
        magicalText4 =
    Loop, Parse, magicalTextAlt1
    {
        if(A_LoopField = "_")
            underCount5++
    }
    if(underCount5 > undercountmulti * StrLen(magicalTextAlt1))
        magicalTextAlt1 =
    Loop, Parse, magicalTextAlt2
    {
        if(A_LoopField = "_")
            underCount6++
    }
    if(underCount6 > undercountmulti * StrLen(magicalTextAlt2))
        magicalTextAlt2 =
    Loop, Parse, magicalTextAlt3
    {
        if(A_LoopField = "_")
            underCount7++
    }
    if(underCount7 > undercountmulti * StrLen(magicalTextAlt3))
        magicalTextAlt3 =
    Loop, Parse, magicalTextAlt4
    {
        if(A_LoopField = "_")
            underCount8++
    }
    if(underCount8 > undercountmulti * StrLen(magicalTextAlt4))
        magicalTextAlt4 =
    
    ;msgbox, %magicalTextalt1%%magicalText1%`n%magicalTextalt2%%magicalText2%`n%magicalTextalt3%%magicalText3%`n%magicalTextalt4%%magicalText4% ;debug
    ld1 = 999999
    ld2 = 999999
    ld3 = 999999
    ld4 = 999999
    ldidx1 = -1
    ldidx2 = -1
    ldidx3 = -1
    ldidx4 = -1
    string1 := magicaltextalt1 . magicaltext1
    string2 := magicaltextalt2 . magicaltext2
    string3 := magicaltextalt3 . magicaltext3
    string4 := magicaltextalt4 . magicaltext4
    for index, element in rewardArray
    {
        if(ld1 != 0 && StrLen(string1) > minRewardLength) {
            tld1 := LevenshteinDistance(element, string1, 1)
            if (tld1 < ld1) {
                ld1 := tld1
                ldidx1 := index
            }
        }
        if(ld2 != 0 && StrLen(string2) > minRewardLength) {
            tld2 := LevenshteinDistance(element, string2, 1)
            if (tld2 < ld2) {
                ld2 := tld2
                ldidx2 := index
            }
        }
        if(ld3 != 0 && StrLen(string3) > minRewardLength) {
            tld3 := LevenshteinDistance(element, string3, 1)
            if (tld3 < ld3) {
                ld3 := tld3
                ldidx3 := index
            }
        }
        if(ld4 != 0 && StrLen(string4) > minRewardLength) {
            tld4 := LevenshteinDistance(element, string4, 1)
            if (tld4 < ld4) {
                ld4 := tld4
                ldidx4 := index
            }
        }
    }
    if (ld1 != 999999)
        ra1 := rewardArray[ldidx1]
    if (ld2 != 999999)
        ra2 := rewardArray[ldidx2]
    if (ld3 != 999999)
        ra3 := rewardArray[ldidx3]
    if (ld4 != 999999)
        ra4 := rewardArray[ldidx4]
    ;msgbox, %magicalTextalt1%%magicalText1% :: %ld1% : %ra1%`n%magicalTextalt2%%magicalText2% :: %ld2% : %ra2%`n%magicalTextalt3%%magicalText3% :: %ld3% : %ra3%`n%magicalTextalt4%%magicalText4% :: %ld4% : %ra4% ;debug
    
    if(StrLen(string1) > minRewardLength) {
        GUIControl,, item1, % setArray[ldidx1] . "`n" . partArray[ldidx1]
        GUIControl,, edit1, % valuesArray[ldidx1]
        found1 := ldidx1
    }
    if(StrLen(string2) > minRewardLength) {
        GUIControl,, item2, % setArray[ldidx2] . "`n" . partArray[ldidx2]
        GUIControl,, edit2, % valuesArray[ldidx2]
        found2 := ldidx2
    }
    if(StrLen(string3) > minRewardLength) {
        GUIControl,, item3, % setArray[ldidx3] . "`n" . partArray[ldidx3]
        GUIControl,, edit3, % valuesArray[ldidx3]
        found3 := ldidx3
    }
    if(StrLen(string4) > minRewardLength) {
        GUIControl,, item4, % setArray[ldidx4] . "`n" . partArray[ldidx4]
        GUIControl,, edit4, % valuesArray[ldidx4]
        found4 := ldidx4
    }
    
    for index, element in vaultedArray
    {
        if (found1 && setArray[found1] = element)
            GuiControl, Show, gold1
        if (found2 && setArray[found2] = element)
            GuiControl, Show, gold2
        if (found3 && setArray[found3] = element)
            GuiControl, Show, gold3
        if (found4 && setArray[found4] = element)
            GuiControl, Show, gold4
    }
    
    for index, element in commonUncommonArray
    {
        if (found1 && setArray[found1] . partArray[found1] = element)
            GuiControl, Show, silver1
        if (found2 && setArray[found2] . partArray[found2] = element)
            GuiControl, Show, silver2
        if (found3 && setArray[found3] . partArray[found3] = element)
            GuiControl, Show, silver3
        if (found4 && setArray[found4] . partArray[found4] = element)
            GuiControl, Show, silver4
    }
    if(minimized)
        gosub, hide
return

IncItem1:
    valuesArray[found1] := valuesArray[found1] + 1
    IniWrite, % valuesArray[found1], void_tracker.ini, % setArray[found1], % partArray[found1]
    GUIControl,, edit1, % valuesArray[found1]
return
IncItem2:
    valuesArray[found2] := valuesArray[found2] + 1
    IniWrite, % valuesArray[found2], void_tracker.ini, % setArray[found2], % partArray[found2]
    GUIControl,, edit2, % valuesArray[found2]
return
IncItem3:
    valuesArray[found3] := valuesArray[found3] + 1
    IniWrite, % valuesArray[found3], void_tracker.ini, % setArray[found3], % partArray[found3]
    GUIControl,, edit3, % valuesArray[found3]
return
IncItem4:
    valuesArray[found4] := valuesArray[found4] + 1
    IniWrite, % valuesArray[found4], void_tracker.ini, % setArray[found4], % partArray[found4]
    GUIControl,, edit4, % valuesArray[found4]
return

hide:
  if(minimized){
    minimized = 0
    GuiControl,, hidelabel, Hide
    Gui, Show, h146 w357, Void Tracker
  } else {
    minimized = 1
    GuiControl,, hidelabel, Show
    Gui, Show, h40 w357, Void Tracker
  }
return

iniread:
    IfNotExist, void_tracker.ini
    {
        Gosub, inimake
    } else
    {
        FileCopy, void_tracker.ini, void_tracker.bak, 1
    }
    
    ;when future relics are added, use IniRead, OutputVarSectionNames to check sections for updating existing ini files
    IniRead, iniSections, void_tracker.ini
    ;msgbox, % iniSections
    for index, element in setArray
    {
        IfNotInString, iniSections, %element%
        {
            IniWrite, 0, void_tracker.ini, % setArray[index], % partArray[index]
        }
    }

    for index, element in setArray
    {
        str := setArray[index] . partArray[index]
        IniRead, %str%, void_tracker.ini, % setArray[index], % partArray[index]
    }
return

inimake:
    ;vaulted no keys: rhino, loki, wyrm, ankyros, bo, boltor
    for index, element in setArray
    {
        IniWrite, 0, void_tracker.ini, % setArray[index], % partArray[index]
    }
return
