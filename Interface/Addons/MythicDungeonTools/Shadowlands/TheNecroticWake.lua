local MDT = MDT
local L = MDT.L
local dungeonIndex = 35
MDT.dungeonList[dungeonIndex] = L["The Necrotic Wake"]
MDT.mapInfo[dungeonIndex] = {
    viewportPositionOverrides =
    {
        [1] = {
            zoomScale = 1.2999999523163;
            horizontalPan = 56.598399501064;
            verticalPan = 48.945189206469;
        };
        [2] = {
            zoomScale = 1.5999999046326;
            horizontalPan = 168.58704071777;
            verticalPan = 134.75893682504;
        };
        [3] = {
            zoomScale = 2.1999998092651;
            horizontalPan = 227.14468128678;
            verticalPan = 144.59570926349;
        };
    }
};
MDT.scaleMultiplier[dungeonIndex] = 1.3

MDT.dungeonMaps[dungeonIndex] = {
   [0] = "NecroticWake_A",
   [1] = "NecroticWake_Exterior",
   [2] = "NecroticWake_A",
   [3] = "NecroticWake_B",
}
MDT.dungeonSubLevels[dungeonIndex] = {
    [1] = L["TheNecroticWakeFloor1"],
    [2] = L["TheNecroticWakeFloor2"],
    [3] = L["TheNecroticWakeFloor3"],
}

MDT.dungeonTotalCount[dungeonIndex] = {normal=283,teeming=1000,teemingEnabled=true}
MDT.mapPOIs[dungeonIndex] = {
    [1] = {
        [1] = {
            ["y"] = -224.85072612286;
            ["x"] = 228.01889531903;
            ["connectionIndex"] = 1;
            ["target"] = 2;
            ["type"] = "mapLink";
            ["template"] = "MapLinkPinTemplate";
            ["direction"] = 1;
        };
    };
};

MDT.dungeonEnemies[dungeonIndex] = {
   [27] = {
      ["clones"] = {
         [1] = {
            ["y"] = -200.60122878109;
            ["x"] = 325.51598642195;
            ["g"] = 33;
            ["sublevel"] = 2;
         };
         [2] = {
            ["y"] = -210.88792224078;
            ["x"] = 322.25070980819;
            ["g"] = 33;
            ["sublevel"] = 2;
         };
         [3] = {
            ["y"] = -221.91578976504;
            ["x"] = 323.48339247663;
            ["g"] = 33;
            ["sublevel"] = 2;
         };
      };
      ["id"] = 163622;
      ["spells"] = {
         [338022] = {};
      };
      ["scale"] = 1;
      ["name"] = "Goregrind Bits";
      ["health"] = 80100;
      ["displayId"] = 97800;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 0;
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Shackle Undead"] = true;
         ["Root"] = true;
         ["Control Undead"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Stun"] = true;
         ["Slow"] = true;
         ["Silence"] = true;
         ["Repentance"] = true;
      };
   };
   [2] = {
      ["clones"] = {
         [1] = {
            ["y"] = -267.19125178169;
            ["x"] = 636.00936056606;
            ["g"] = 2;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -260.66134616311;
            ["x"] = 637.98762612267;
            ["g"] = 2;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -164.40364637533;
            ["x"] = 586.54961231973;
            ["g"] = 4;
            ["sublevel"] = 1;
         };
         [8] = {
            ["sublevel"] = 1;
            ["inspiring"] = true;
            ["x"] = 499.04391223695;
            ["g"] = 10;
            ["y"] = -217.41514755322;
         };
         [16] = {
            ["y"] = -460.66432611916;
            ["x"] = 441.33610776331;
            ["g"] = 15;
            ["sublevel"] = 1;
         };
         [17] = {
            ["y"] = -453.75256275402;
            ["x"] = 445.38780842536;
            ["g"] = 15;
            ["sublevel"] = 1;
         };
         [9] = {
            ["y"] = -212.66842554759;
            ["x"] = 492.81284184647;
            ["g"] = 10;
            ["sublevel"] = 1;
         };
         [5] = {
            ["y"] = -166.62872839749;
            ["x"] = 594.94517222651;
            ["g"] = 4;
            ["sublevel"] = 1;
         };
         [10] = {
            ["y"] = -212.17147153557;
            ["x"] = 502.06672987207;
            ["g"] = 10;
            ["sublevel"] = 1;
         };
         [11] = {
            ["sublevel"] = 1;
            ["x"] = 492.29038745918;
            ["patrol"] = {
               [13] = {
                  ["y"] = -201.4999620146;
                  ["x"] = 508.08238424453;
               };
               [7] = {
                  ["y"] = -275.05357741315;
                  ["x"] = 526.7261681876;
               };
               [1] = {
                  ["y"] = -218.84702666366;
                  ["x"] = 492.29038745918;
               };
               [2] = {
                  ["y"] = -228.06097137794;
                  ["x"] = 481.26595505651;
               };
               [4] = {
                  ["y"] = -268.15792168815;
                  ["x"] = 456.49269814007;
               };
               [8] = {
                  ["y"] = -249.00332549658;
                  ["x"] = 537.96356635975;
               };
               [9] = {
                  ["y"] = -222.69770307689;
                  ["x"] = 542.81603885282;
               };
               [5] = {
                  ["y"] = -270.96727123119;
                  ["x"] = 485.60767558297;
               };
               [10] = {
                  ["y"] = -207.11863917999;
                  ["x"] = 545.88076985934;
               };
               [3] = {
                  ["y"] = -243.12927234789;
                  ["x"] = 469.77321378208;
               };
               [6] = {
                  ["y"] = -272.75502915826;
                  ["x"] = 507.06081454925;
               };
               [12] = {
                  ["y"] = -185.41010230972;
                  ["x"] = 526.7261681876;
               };
               [11] = {
                  ["y"] = -172.1295866677;
                  ["x"] = 550.47788828979;
               };
            };
            ["g"] = 10;
            ["y"] = -218.84702666366;
         };
         [3] = {
            ["y"] = -267.43150244214;
            ["x"] = 644.29789093094;
            ["g"] = 2;
            ["sublevel"] = 1;
         };
         [6] = {
            ["y"] = -172.44777146502;
            ["x"] = 587.45596487713;
            ["g"] = 4;
            ["sublevel"] = 1;
         };
         [12] = {
            ["y"] = -205.93932806671;
            ["x"] = 496.21746123639;
            ["g"] = 10;
            ["sublevel"] = 1;
         };
         [13] = {
            ["y"] = -235.75250873611;
            ["x"] = 445.16897739889;
            ["g"] = 11;
            ["sublevel"] = 1;
         };
         [7] = {
            ["y"] = -173.35158979958;
            ["x"] = 595.50115230256;
            ["g"] = 4;
            ["sublevel"] = 1;
         };
         [14] = {
            ["y"] = -230.64388483857;
            ["x"] = 449.03872899225;
            ["g"] = 11;
            ["sublevel"] = 1;
         };
         [15] = {
            ["y"] = -451.85134508349;
            ["x"] = 437.3775162589;
            ["g"] = 15;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 165138;
      ["spells"] = {
         [335164] = {};
         [338022] = {};
      };
      ["scale"] = 0.7;
      ["name"] = "Blight Bag";
      ["health"] = 32040;
      ["displayId"] = 94761;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 1;
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Shackle Undead"] = true;
         ["Root"] = true;
         ["Control Undead"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Stun"] = true;
         ["Slow"] = true;
         ["Silence"] = true;
         ["Repentance"] = true;
      };
   };
   [38] = {
      ["clones"] = {
         [7] = {
            ["y"] = -122.37684320404;
            ["x"] = 241.32104003719;
            ["sublevel"] = 1;
         };
         [1] = {
            ["y"] = -256.47801864895;
            ["x"] = 575.68567958998;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -211.93821846404;
            ["x"] = 470.41498096638;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -257.62144343355;
            ["x"] = 405.77228315868;
            ["sublevel"] = 1;
         };
         [8] = {
            ["y"] = -198.73344511317;
            ["x"] = 167.4881111182;
            ["sublevel"] = 1;
         };
         [9] = {
            ["y"] = -397.34235682757;
            ["x"] = 539.50394489337;
            ["sublevel"] = 2;
         };
         [5] = {
            ["y"] = -384.93482708961;
            ["x"] = 369.76400995501;
            ["sublevel"] = 1;
         };
         [10] = {
            ["y"] = -253.76119975626;
            ["x"] = 543.17137391657;
            ["sublevel"] = 2;
         };
         [3] = {
            ["y"] = -141.34185196182;
            ["x"] = 520.1698257806;
            ["sublevel"] = 1;
         };
         [6] = {
            ["y"] = -169.67890116879;
            ["x"] = 315.3714818597;
            ["sublevel"] = 1;
         };
         [12] = {
            ["y"] = -276.18658896621;
            ["x"] = 400.69005772696;
            ["sublevel"] = 3;
         };
         [11] = {
            ["y"] = -172.61583809638;
            ["x"] = 412.16339581807;
            ["sublevel"] = 2;
         };
      };
      ["include"] = {
         ["affix"] = 130;
         ["level"] = 10;
      };
      ["name"] = "Urh Relic";
      ["level"] = 62;
      ["scale"] = 1;
      ["spells"] = {
         [368243] = {};
         [366297] = {};
         [366288] = {};
      };
      ["ignoreFortified"] = true;
      ["displayId"] = 105134;
      ["count"] = 0;
      ["badCreatureModel"] = true;
      ["health"] = 33022;
      ["bonusSpell"] = 368239;
      ["creatureType"] = "Mechanical";
      ["modelPosition"] = {
         [1] = 0;
         [2] = 0;
         [3] = 0.75;
      };
      ["id"] = 185685;
      ["iconTexture"] = 4335642;
   };
   [3] = {
      ["clones"] = {
         [6] = {
            ["y"] = -153.09341803332;
            ["x"] = 528.0121962859;
            ["g"] = 5;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -205.29184313564;
            ["x"] = 590.72328038327;
            ["g"] = 3;
            ["sublevel"] = 1;
         };
         [8] = {
            ["y"] = -261.78750238567;
            ["x"] = 431.01973551683;
            ["g"] = 12;
            ["sublevel"] = 1;
         };
         [3] = {
            ["sublevel"] = 1;
            ["inspiring"] = true;
            ["x"] = 528.20950260339;
            ["g"] = 7;
            ["y"] = -231.97162700879;
         };
         [1] = {
            ["y"] = -169.0870825603;
            ["x"] = 625.33044286157;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -288.81692623792;
            ["x"] = 527.25649379052;
            ["g"] = 9;
            ["sublevel"] = 1;
         };
         [5] = {
            ["y"] = -152.83270464034;
            ["x"] = 537.80754924368;
            ["g"] = 5;
            ["sublevel"] = 1;
         };
         [7] = {
            ["y"] = -256.56424975547;
            ["x"] = 421.41533899291;
            ["g"] = 12;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 166302;
      ["spells"] = {
         [334747] = {};
         [334749] = {
            ["interruptible"] = true;
         };
      };
      ["scale"] = 1;
      ["name"] = "Corpse Harvester";
      ["health"] = 112140;
      ["displayId"] = 98170;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 4;
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Fear"] = true;
         ["Disorient"] = true;
         ["Polymorph"] = true;
         ["Mind Control"] = true;
         ["Sap"] = true;
         ["Stun"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Imprison"] = true;
         ["Repentance"] = true;
      };
   };
   [4] = {
      ["clones"] = {
         [1] = {
            ["y"] = -198.97742264054;
            ["x"] = 582.76627145072;
            ["g"] = 3;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -223.86546602872;
            ["x"] = 522.22629180923;
            ["g"] = 7;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -162.19144306596;
            ["x"] = 539.75227117869;
            ["g"] = 5;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -238.40785446451;
            ["x"] = 518.52418985757;
            ["g"] = 7;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 163121;
      ["spells"] = {
         [320703] = {};
         [320696] = {};
         [323190] = {
            ["interruptible"] = true;
         };
      };
      ["scale"] = 1;
      ["name"] = "Stitched Vanguard";
      ["health"] = 112140;
      ["displayId"] = 95227;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 5;
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Shackle Undead"] = true;
         ["Root"] = true;
         ["Control Undead"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Stun"] = true;
         ["Repentance"] = true;
      };
   };
   [5] = {
      ["clones"] = {
         [1] = {
            ["y"] = -251.20442949907;
            ["x"] = 559.61845772685;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -196.67875988637;
            ["x"] = 552.824366159;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -271.3991187384;
            ["x"] = 478.61009600495;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 165137;
      ["spells"] = {
         [323347] = {};
         [322756] = {};
         [320462] = {
            ["interruptible"] = true;
         };
      };
      ["scale"] = 1.3;
      ["name"] = "Zolramus Gatekeeper";
      ["health"] = 144180;
      ["displayId"] = 95231;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 6;
      ["characteristics"] = {
         ["Taunt"] = true;
      };
   };
   [6] = {
      ["clones"] = {
         [1] = {
            ["y"] = -282.46182102424;
            ["x"] = 535.55348561245;
            ["g"] = 9;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -393.52460810338;
            ["x"] = 558.7518186685;
            ["g"] = 27;
            ["sublevel"] = 2;
         };
         [3] = {
            ["y"] = -243.8569580374;
            ["x"] = 344.50042639228;
            ["g"] = 31;
            ["sublevel"] = 2;
         };
      };
      ["id"] = 165872;
      ["spells"] = {
         [327130] = {
            ["interruptible"] = true;
         };
         [323496] = {};
      };
      ["scale"] = 1.4;
      ["name"] = "Flesh Crafter";
      ["health"] = 112140;
      ["displayId"] = 96480;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 4;
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Fear"] = true;
         ["Imprison"] = true;
         ["Polymorph"] = true;
         ["Mind Control"] = true;
         ["Sap"] = true;
         ["Silence"] = true;
         ["Stun"] = true;
         ["Slow"] = true;
         ["Disorient"] = true;
         ["Repentance"] = true;
      };
   };
   [7] = {
      ["clones"] = {
         [1] = {
            ["y"] = -191.93196037298;
            ["x"] = 474.12550258036;
            ["sublevel"] = 1;
         };
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["id"] = 162691;
      ["spells"] = {
         [320637] = {};
         [320596] = {};
         [320655] = {};
      };
      ["isBoss"] = true;
      ["encounterID"] = 2395;
      ["instanceID"] = 1182;
      ["name"] = "Blightbone";
      ["health"] = 560700;
      ["displayId"] = 95467;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 0;
      ["scale"] = 1;
   };
   [8] = {
      ["clones"] = {
         [6] = {
            ["y"] = -260.00834952995;
            ["x"] = 344.36337460144;
            ["g"] = 20;
            ["sublevel"] = 1;
         };
         [2] = {
            ["sublevel"] = 1;
            ["x"] = 371.75572151009;
            ["patrol"] = {
               [6] = {
                  ["y"] = -484.07221040944;
                  ["x"] = 411.00056690521;
               };
               [2] = {
                  ["y"] = -435.54724983132;
                  ["x"] = 389.29203003494;
               };
               [8] = {
                  ["y"] = -460.06510884377;
                  ["x"] = 372.4360314198;
               };
               [3] = {
                  ["y"] = -424.05448663621;
                  ["x"] = 413.04372821644;
               };
               [1] = {
                  ["y"] = -447.04294061339;
                  ["x"] = 371.75572151009;
               };
               [4] = {
                  ["y"] = -445.50763656283;
                  ["x"] = 417.13005083892;
               };
               [5] = {
                  ["y"] = -464.91762517822;
                  ["x"] = 416.36385712695;
               };
               [7] = {
                  ["y"] = -473.85642029377;
                  ["x"] = 389.54744985961;
               };
            };
            ["g"] = 16;
            ["y"] = -447.04294061339;
         };
         [3] = {
            ["sublevel"] = 1;
            ["inspiring"] = true;
            ["x"] = 372.19882316507;
            ["g"] = 17;
            ["y"] = -401.07502319109;
         };
         [1] = {
            ["y"] = -422.52237915355;
            ["x"] = 512.4238930362;
            ["g"] = 13;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -419.22321428571;
            ["x"] = 378.57231340972;
            ["g"] = 17;
            ["sublevel"] = 1;
         };
         [5] = {
            ["y"] = -232.03718381974;
            ["x"] = 323.22179736442;
            ["g"] = 21;
            ["sublevel"] = 1;
         };
         [7] = {
            ["y"] = -160.55690826205;
            ["x"] = 250.63511156517;
            ["g"] = 24;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 163128;
      ["spells"] = {
         [320571] = {
            ["interruptible"] = true;
         };
         [320462] = {
            ["interruptible"] = true;
         };
      };
      ["scale"] = 1;
      ["name"] = "Zolramus Sorcerer";
      ["health"] = 72090;
      ["displayId"] = 94992;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 4;
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Imprison"] = true;
         ["Fear"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Sap"] = true;
         ["Silence"] = true;
         ["Stun"] = true;
         ["Slow"] = true;
         ["Mind Control"] = true;
         ["Repentance"] = true;
      };
   };
   [10] = {
      ["clones"] = {
         [1] = {
            ["sublevel"] = 1;
            ["inspiring"] = true;
            ["x"] = 473.55032517807;
            ["g"] = 14;
            ["y"] = -431.54081632653;
         };
         [2] = {
            ["sublevel"] = 1;
            ["inspiring"] = true;
            ["x"] = 208.11726399436;
            ["g"] = 19;
            ["y"] = -315.56699466368;
         };
         [3] = {
            ["y"] = -116.97895008442;
            ["x"] = 219.23380883062;
            ["g"] = 25;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 163618;
      ["spells"] = {
         [320462] = {
            ["interruptible"] = true;
         };
         [321780] = {};
         [327393] = {};
         [321575] = {};
      };
      ["scale"] = 1;
      ["name"] = "Zolramus Necromancer";
      ["health"] = 112140;
      ["displayId"] = 95233;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 8;
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Fear"] = true;
         ["Imprison"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Sap"] = true;
         ["Stun"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Mind Control"] = true;
         ["Repentance"] = true;
      };
   };
   [12] = {
      ["clones"] = {
         [6] = {
            ["y"] = -111.76993397185;
            ["x"] = 209.73216749461;
            ["g"] = 25;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -421.05364831842;
            ["x"] = 472.35841442181;
            ["g"] = 14;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -320.26256426546;
            ["x"] = 220.53435785599;
            ["g"] = 19;
            ["sublevel"] = 1;
         };
         [1] = {
            ["y"] = -430.36955009276;
            ["x"] = 481.92691235677;
            ["g"] = 14;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -312.78875118092;
            ["x"] = 218.83792198129;
            ["g"] = 19;
            ["sublevel"] = 1;
         };
         [5] = {
            ["y"] = -306.80381678265;
            ["x"] = 215.29869223532;
            ["g"] = 19;
            ["sublevel"] = 1;
         };
         [7] = {
            ["y"] = -116.92727631302;
            ["x"] = 228.809996812;
            ["g"] = 25;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 163122;
      ["spells"] = {
         [321576] = {};
      };
      ["scale"] = 0.7;
      ["name"] = "Brittlebone Warrior";
      ["health"] = 80100;
      ["displayId"] = 96107;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 0;
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Shackle Undead"] = true;
         ["Root"] = true;
         ["Control Undead"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Stun"] = true;
         ["Repentance"] = true;
      };
   };
   [14] = {
      ["clones"] = {
         [1] = {
            ["y"] = -454.67116201069;
            ["x"] = 366.73633416573;
            ["g"] = 16;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -164.28608333693;
            ["x"] = 238.36587661194;
            ["g"] = 24;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 165222;
      ["spells"] = {
         [335143] = {
            ["interruptible"] = true;
         };
         [320822] = {
            ["interruptible"] = false;
         };
      };
      ["scale"] = 1;
      ["name"] = "Zolramus Bonemender";
      ["health"] = 80100;
      ["displayId"] = 97668;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 4;
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Fear"] = true;
         ["Imprison"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Sap"] = true;
         ["Silence"] = true;
         ["Stun"] = true;
         ["Slow"] = true;
         ["Mind Control"] = true;
         ["Repentance"] = true;
      };
   };
   [16] = {
      ["clones"] = {
         [1] = {
            ["y"] = -229.35824576779;
            ["x"] = 281.41711248243;
            ["patrol"] = {
               [1] = {
                  ["y"] = -229.35824576779;
                  ["x"] = 281.41711248243;
               };
               [2] = {
                  ["y"] = -243.7856346922;
                  ["x"] = 282.43999290261;
               };
               [4] = {
                  ["y"] = -271.85581489223;
                  ["x"] = 254.00993384542;
               };
               [8] = {
                  ["y"] = -271.85581489223;
                  ["x"] = 254.00993384542;
               };
               [16] = {
                  ["y"] = -134.3839293053;
                  ["x"] = 208.30593675021;
               };
               [17] = {
                  ["y"] = -152.73750391482;
                  ["x"] = 229.17863247165;
               };
               [9] = {
                  ["y"] = -255.66146709334;
                  ["x"] = 269.4845393741;
               };
               [18] = {
                  ["y"] = -180.44777436944;
                  ["x"] = 253.6500858765;
               };
               [5] = {
                  ["y"] = -288.76990496132;
                  ["x"] = 238.53535920499;
               };
               [10] = {
                  ["y"] = -243.7856346922;
                  ["x"] = 282.43999290261;
               };
               [20] = {
                  ["y"] = -202.75998551954;
                  ["x"] = 275.96229702659;
               };
               [11] = {
                  ["y"] = -229.35824576779;
                  ["x"] = 281.41711248243;
               };
               [3] = {
                  ["y"] = -255.66146709334;
                  ["x"] = 269.4845393741;
               };
               [6] = {
                  ["y"] = -299.56610079097;
                  ["x"] = 227.37923818582;
               };
               [12] = {
                  ["y"] = -202.75998551954;
                  ["x"] = 275.96229702659;
               };
               [13] = {
                  ["y"] = -190.52425881712;
                  ["x"] = 264.80617600743;
               };
               [7] = {
                  ["y"] = -288.76990496132;
                  ["x"] = 238.53535920499;
               };
               [14] = {
                  ["y"] = -180.44777436944;
                  ["x"] = 253.6500858765;
               };
               [19] = {
                  ["y"] = -190.52425881712;
                  ["x"] = 264.80617600743;
               };
               [15] = {
                  ["y"] = -152.73750391482;
                  ["x"] = 229.17863247165;
               };
            };
            ["sublevel"] = 1;
         };
      };
      ["id"] = 165197;
      ["spells"] = {
         [324394] = {};
         [324387] = {};
         [324381] = {};
         [324372] = {};
      };
      ["scale"] = 1.5;
      ["name"] = "Skeletal Monstrosity";
      ["health"] = 240300;
      ["displayId"] = 94814;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 12;
      ["characteristics"] = {
         ["Taunt"] = true;
      };
   };
   [20] = {
      ["clones"] = {
         [1] = {
            ["y"] = -401.66043555864;
            ["x"] = 318.35932575995;
            ["g"] = 26;
            ["sublevel"] = 2;
         };
         [2] = {
            ["sublevel"] = 2;
            ["x"] = 480.16714313076;
            ["patrol"] = {
               [1] = {
                  ["y"] = -340.82042587609;
                  ["x"] = 516.43828133821;
               };
               [2] = {
                  ["y"] = -388.04944749118;
                  ["x"] = 529.231447794;
               };
               [4] = {
                  ["y"] = -315.71477018049;
                  ["x"] = 508.3587829608;
               };
               [8] = {
                  ["y"] = -262.81325771845;
                  ["x"] = 380.24357777486;
               };
               [16] = {
                  ["y"] = -262.45340974952;
                  ["x"] = 456.53684529378;
               };
               [17] = {
                  ["y"] = -277.20825756386;
                  ["x"] = 494.32363108431;
               };
               [9] = {
                  ["y"] = -311.39628567098;
                  ["x"] = 362.9696088486;
               };
               [18] = {
                  ["y"] = -315.71477018049;
                  ["x"] = 508.3587829608;
               };
               [5] = {
                  ["y"] = -277.20825756386;
                  ["x"] = 494.32363108431;
               };
               [10] = {
                  ["y"] = -343.42505607923;
                  ["x"] = 355.41227640109;
               };
               [11] = {
                  ["y"] = -385.17046296622;
                  ["x"] = 339.21794404632;
               };
               [3] = {
                  ["y"] = -340.82042587609;
                  ["x"] = 516.43828133821;
               };
               [6] = {
                  ["y"] = -262.45340974952;
                  ["x"] = 456.53684529378;
               };
               [12] = {
                  ["y"] = -343.42505607923;
                  ["x"] = 355.41227640109;
               };
               [13] = {
                  ["y"] = -311.39628567098;
                  ["x"] = 362.9696088486;
               };
               [7] = {
                  ["y"] = -258.13495612825;
                  ["x"] = 420.90933264624;
               };
               [14] = {
                  ["y"] = -262.81325771845;
                  ["x"] = 380.24357777486;
               };
               [15] = {
                  ["y"] = -258.13495612825;
                  ["x"] = 420.90933264624;
               };
            };
            ["g"] = 28;
            ["y"] = -267.25639174782;
         };
         [4] = {
            ["y"] = -260.94682723462;
            ["x"] = 346.17264847671;
            ["g"] = 31;
            ["sublevel"] = 2;
         };
         [3] = {
            ["sublevel"] = 2;
            ["inspiring"] = true;
            ["y"] = -243.90869965329;
            ["g"] = 30;
            ["x"] = 527.40731699655;
         };
      };
      ["id"] = 173016;
      ["spells"] = {
         [334747] = {};
         [334748] = {
            ["interruptible"] = true;
         };
         [338353] = {
            ["interruptible"] = true;
         };
      };
      ["scale"] = 1.4;
      ["name"] = "Corpse Collector";
      ["health"] = 112140;
      ["displayId"] = 98170;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 4;
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Fear"] = true;
         ["Disorient"] = true;
         ["Polymorph"] = true;
         ["Mind Control"] = true;
         ["Sap"] = true;
         ["Stun"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Imprison"] = true;
         ["Repentance"] = true;
      };
   };
   [24] = {
      ["clones"] = {
         [1] = {
            ["y"] = -333.18280218782;
            ["x"] = 462.17634607938;
            ["g"] = 32;
            ["sublevel"] = 2;
         };
      };
      ["id"] = 167731;
      ["spells"] = {
         [338636] = {};
         [323496] = {};
         [338606] = {};
      };
      ["scale"] = 1.6;
      ["name"] = "Separation Assistant";
      ["health"] = 160200;
      ["displayId"] = 98227;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 4;
      ["characteristics"] = {
         ["Taunt"] = true;
      };
   };
   [28] = {
      ["clones"] = {
         [1] = {
            ["y"] = -197.7409049355;
            ["x"] = 545.73080072511;
            ["g"] = 34;
            ["sublevel"] = 2;
         };
         [2] = {
            ["y"] = -208.50249195281;
            ["x"] = 548.94901939488;
            ["g"] = 34;
            ["sublevel"] = 2;
         };
         [3] = {
            ["y"] = -219.60583613804;
            ["x"] = 546.96846714015;
            ["g"] = 34;
            ["sublevel"] = 2;
         };
      };
      ["id"] = 163623;
      ["spells"] = {
         [338022] = {};
      };
      ["scale"] = 1;
      ["name"] = "Rotspew Leftovers";
      ["health"] = 64080;
      ["displayId"] = 97801;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 0;
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Shackle Undead"] = true;
         ["Root"] = true;
         ["Control Undead"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Stun"] = true;
         ["Repentance"] = true;
      };
   };
   [32] = {
      ["clones"] = {
         [1] = {
            ["y"] = -276.58583505829;
            ["x"] = 427.52861110709;
            ["sublevel"] = 3;
         };
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["id"] = 162693;
      ["spells"] = {
         [321370] = {};
         [320771] = {};
         [320772] = {};
         [321894] = {};
         [321755] = {};
         [320788] = {};
      };
      ["isBoss"] = true;
      ["encounterID"] = 2396;
      ["instanceID"] = 1182;
      ["name"] = "Nalthor the Rimebinder";
      ["health"] = 512640;
      ["displayId"] = 96085;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 0;
      ["scale"] = 1;
   };
   [33] = {
      ["clones"] = {
         [1] = {
            ["y"] = -275.30696567058;
            ["x"] = 514.25048922962;
            ["week"] = {
               [6] = true;
               [2] = true;
               [10] = true;
               [1] = true;
               [5] = true;
               [9] = true;
            };
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -188.89626688555;
            ["x"] = 133.4112971858;
            ["week"] = {
               [11] = true;
               [7] = true;
               [8] = true;
               [3] = true;
               [12] = true;
               [4] = true;
            };
            ["sublevel"] = 1;
         };
      };
      ["powers"] = {
         [357864] = {
            ["dps"] = true;
         };
         [357889] = {
            ["healer"] = true;
         };
         [357848] = {
            ["dps"] = true;
         };
         [357900] = {
            ["healer"] = true;
         };
         [357839] = {
            ["tank"] = true;
         };
         [357897] = {
            ["tank"] = true;
         };
         [357575] = {
            ["tank"] = true;
            ["dps"] = true;
            ["healer"] = true;
         };
      };
      ["id"] = 179446;
      ["spells"] = {
         [355732] = {};
         [358967] = {
            ["interruptible"] = true;
         };
         [355707] = {};
         [355737] = {};
      };
      ["include"] = {
         ["affix"] = 128;
         ["level"] = 10;
      };
      ["health"] = 336131;
      ["count"] = 0;
      ["ignoreFortified"] = true;
      ["name"] = "Incinerator Arkolath";
      ["displayId"] = 100718;
      ["creatureType"] = "Humanoid";
      ["level"] = 61;
      ["scale"] = 1.5;
      ["iconTexture"] = 236297;
   };
   [17] = {
      ["clones"] = {
         [1] = {
            ["y"] = -105.74744064711;
            ["x"] = 221.1313948641;
            ["g"] = 25;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -107.20151298418;
            ["x"] = 213.82472624654;
            ["g"] = 25;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 166079;
      ["spells"] = {
         [321576] = {};
         [328687] = {};
      };
      ["scale"] = 0.7;
      ["name"] = "Brittlebone Crossbowman";
      ["health"] = 40050;
      ["displayId"] = 96114;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 0;
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Shackle Undead"] = true;
         ["Root"] = true;
         ["Control Undead"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Stun"] = true;
         ["Slow"] = true;
         ["Silence"] = true;
         ["Repentance"] = true;
      };
   };
   [21] = {
      ["clones"] = {
         [1] = {
            ["y"] = -280.4504047721;
            ["x"] = 489.40347391047;
            ["g"] = 28;
            ["sublevel"] = 2;
         };
         [2] = {
            ["y"] = -238.26548043315;
            ["x"] = 507.51241183571;
            ["g"] = 30;
            ["sublevel"] = 2;
         };
      };
      ["id"] = 172981;
      ["spells"] = {
         [338357] = {};
         [338456] = {};
      };
      ["scale"] = 2;
      ["name"] = "Kyrian Stitchwerk";
      ["health"] = 192240;
      ["displayId"] = 98190;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 5;
      ["characteristics"] = {
         ["Taunt"] = true;
      };
   };
   [25] = {
      ["clones"] = {
         [1] = {
            ["y"] = -332.88438845501;
            ["x"] = 399.20005470089;
            ["g"] = 32;
            ["sublevel"] = 2;
         };
      };
      ["id"] = 173044;
      ["spells"] = {
         [334748] = {
            ["interruptible"] = true;
         };
         [338653] = {};
         [323496] = {};
      };
      ["scale"] = 1.6;
      ["name"] = "Stitching Assistant";
      ["health"] = 160200;
      ["displayId"] = 98226;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 4;
      ["characteristics"] = {
         ["Taunt"] = true;
      };
   };
   [29] = {
      ["clones"] = {
         [1] = {
            ["y"] = -207.23853311225;
            ["x"] = 528.68301290168;
            ["g"] = 34;
            ["sublevel"] = 2;
         };
      };
      ["id"] = 163620;
      ["spells"] = {
         [333479] = {};
         [333482] = {};
         [338456] = {};
      };
      ["scale"] = 2;
      ["name"] = "Rotspew";
      ["health"] = 192240;
      ["displayId"] = 99121;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 6;
      ["characteristics"] = {
         ["Taunt"] = true;
      };
   };
   [34] = {
      ["clones"] = {
         [1] = {
            ["y"] = -277.26473786964;
            ["x"] = 230.04277792469;
            ["week"] = {
               [6] = true;
               [2] = true;
               [10] = true;
               [1] = true;
               [5] = true;
               [9] = true;
            };
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -318.59052389709;
            ["x"] = 547.17891536817;
            ["week"] = {
               [11] = true;
               [7] = true;
               [8] = true;
               [3] = true;
               [12] = true;
               [4] = true;
            };
            ["sublevel"] = 2;
         };
      };
      ["powers"] = {
         [357815] = {
            ["dps"] = true;
            ["healer"] = true;
         };
         [357817] = {
            ["tank"] = true;
         };
         [357842] = {
            ["healer"] = true;
         };
         [357834] = {
            ["dps"] = true;
            ["tank"] = true;
         };
         [357825] = {
            ["dps"] = true;
         };
         [357820] = {
            ["tank"] = true;
         };
         [357829] = {
            ["healer"] = true;
         };
      };
      ["id"] = 179892;
      ["spells"] = {
         [358894] = {};
         [356666] = {};
         [355710] = {};
         [356414] = {};
      };
      ["include"] = {
         ["affix"] = 128;
         ["level"] = 10;
      };
      ["health"] = 336131;
      ["count"] = 0;
      ["ignoreFortified"] = true;
      ["name"] = "Oros Coldheart";
      ["displayId"] = 97237;
      ["creatureType"] = "Humanoid";
      ["level"] = 61;
      ["scale"] = 1.5;
      ["iconTexture"] = 136213;
   };
   [9] = {
      ["clones"] = {
         [6] = {
            ["y"] = -161.30009276438;
            ["x"] = 285.55837720657;
            ["g"] = 23;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -410.86989795918;
            ["x"] = 387.30009290802;
            ["g"] = 17;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -219.61982716442;
            ["x"] = 322.98923904285;
            ["g"] = 21;
            ["sublevel"] = 1;
         };
         [1] = {
            ["y"] = -410.57386363636;
            ["x"] = 511.91638786622;
            ["g"] = 13;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -249.64703153989;
            ["x"] = 335.28460823784;
            ["g"] = 20;
            ["sublevel"] = 1;
         };
         [5] = {
            ["y"] = -167.59403988868;
            ["x"] = 290.90430473831;
            ["g"] = 23;
            ["sublevel"] = 1;
         };
         [7] = {
            ["y"] = -178.69230114914;
            ["x"] = 235.7955778904;
            ["g"] = 24;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 163619;
      ["spells"] = {
         [321807] = {};
      };
      ["scale"] = 1;
      ["name"] = "Zolramus Bonecarver";
      ["health"] = 80100;
      ["displayId"] = 93933;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 4;
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Root"] = true;
         ["Fear"] = true;
         ["Disorient"] = true;
         ["Polymorph"] = true;
         ["Mind Control"] = true;
         ["Sap"] = true;
         ["Stun"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Imprison"] = true;
         ["Repentance"] = true;
      };
   };
   [11] = {
      ["clones"] = {
         [1] = {
            ["y"] = -425.54362414449;
            ["x"] = 464.50724570395;
            ["g"] = 14;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -304.53244640151;
            ["x"] = 207.84858915843;
            ["g"] = 19;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -117.71565288417;
            ["x"] = 209.43075603715;
            ["g"] = 25;
            ["sublevel"] = 1;
         };
         [3] = {
            ["sublevel"] = 1;
            ["inspiring"] = true;
            ["x"] = 226.85021723566;
            ["g"] = 25;
            ["y"] = -110.02334659884;
         };
      };
      ["id"] = 163126;
      ["spells"] = {
         [320336] = {
            ["interruptible"] = true;
         };
         [321576] = {};
         [328667] = {
            ["interruptible"] = true;
         };
      };
      ["scale"] = 0.7;
      ["name"] = "Brittlebone Mage";
      ["health"] = 36045;
      ["displayId"] = 96112;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 0;
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Shackle Undead"] = true;
         ["Root"] = true;
         ["Control Undead"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Stun"] = true;
         ["Repentance"] = true;
      };
   };
   [13] = {
      ["clones"] = {
         [2] = {
            ["y"] = -314.6017442549;
            ["x"] = 275.17751039323;
            ["g"] = 18;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -304.97159288637;
            ["x"] = 284.73381683861;
            ["g"] = 18;
            ["sublevel"] = 1;
         };
         [1] = {
            ["y"] = -445.32431056607;
            ["x"] = 362.28095389471;
            ["g"] = 16;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -226.12420885162;
            ["x"] = 311.33505893631;
            ["patrol"] = {
               [1] = {
                  ["y"] = -203.55959339373;
                  ["x"] = 301.2010813;
               };
               [2] = {
                  ["y"] = -234.36347646038;
                  ["x"] = 289.12112004071;
               };
               [3] = {
                  ["y"] = -247.65139755652;
                  ["x"] = 308.44904768727;
               };
            };
            ["g"] = 21;
            ["sublevel"] = 1;
         };
         [5] = {
            ["y"] = -173.2824324214;
            ["x"] = 247.14214466835;
            ["g"] = 24;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 165919;
      ["spells"] = {
         [324323] = {};
         [324293] = {
            ["interruptible"] = true;
         };
         [343470] = {};
      };
      ["scale"] = 1.3;
      ["name"] = "Skeletal Marauder";
      ["health"] = 160200;
      ["displayId"] = 96115;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 6;
      ["characteristics"] = {
         ["Taunt"] = true;
      };
   };
   [15] = {
      ["clones"] = {
         [1] = {
            ["y"] = -413.16966503058;
            ["x"] = 364.96704633944;
            ["g"] = 17;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 165824;
      ["spells"] = {
         [327393] = {};
         [335141] = {};
         [345623] = {};
         [320462] = {
            ["interruptible"] = true;
         };
      };
      ["scale"] = 1.5;
      ["name"] = "Nar'zudah";
      ["health"] = 240300;
      ["displayId"] = 94780;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 15;
      ["characteristics"] = {
         ["Taunt"] = true;
      };
   };
   [18] = {
      ["clones"] = {
         [6] = {
            ["y"] = -194.12509375336;
            ["x"] = 322.29092952831;
            ["g"] = 22;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -180.0185191661;
            ["x"] = 325.38271515666;
            ["g"] = 22;
            ["sublevel"] = 1;
         };
         [8] = {
            ["y"] = -195.92445715095;
            ["x"] = 335.24647572154;
            ["g"] = 22;
            ["sublevel"] = 1;
         };
         [3] = {
            ["y"] = -188.23093803116;
            ["x"] = 328.27752421441;
            ["g"] = 22;
            ["sublevel"] = 1;
         };
         [1] = {
            ["y"] = -181.35558785632;
            ["x"] = 333.43862142354;
            ["g"] = 22;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -188.72695722824;
            ["x"] = 337.04580823089;
            ["g"] = 22;
            ["sublevel"] = 1;
         };
         [5] = {
            ["y"] = -186.56771497349;
            ["x"] = 322.29092952831;
            ["g"] = 22;
            ["sublevel"] = 1;
         };
         [7] = {
            ["y"] = -196.28436689635;
            ["x"] = 330.2082334977;
            ["g"] = 22;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 171500;
      ["spells"] = {};
      ["scale"] = 0.7;
      ["name"] = "Shuffling Corpse";
      ["health"] = 28836;
      ["displayId"] = 96132;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 1;
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Shackle Undead"] = true;
         ["Root"] = true;
         ["Control Undead"] = true;
         ["Disorient"] = true;
         ["Stun"] = true;
         ["Slow"] = true;
         ["Silence"] = true;
      };
   };
   [22] = {
      ["clones"] = {
         [7] = {
            ["y"] = -337.70181792228;
            ["x"] = 328.66172329585;
            ["g"] = 29;
            ["sublevel"] = 2;
         };
         [1] = {
            ["y"] = -264.92234647225;
            ["x"] = 496.81948021409;
            ["g"] = 28;
            ["sublevel"] = 2;
         };
         [2] = {
            ["y"] = -273.81426718665;
            ["x"] = 503.26332718268;
            ["g"] = 28;
            ["sublevel"] = 2;
         };
         [4] = {
            ["y"] = -344.41113256507;
            ["x"] = 321.91456123486;
            ["g"] = 29;
            ["sublevel"] = 2;
         };
         [8] = {
            ["y"] = -338.05096192215;
            ["x"] = 333.59885436133;
            ["g"] = 29;
            ["sublevel"] = 2;
         };
         [9] = {
            ["sublevel"] = 2;
            ["x"] = 327.30340070056;
            ["patrol"] = {
               [1] = {
                  ["y"] = -352.08800928078;
                  ["x"] = 327.30340070056;
               };
               [2] = {
                  ["y"] = -374.81865258765;
                  ["x"] = 325.54570837852;
               };
               [4] = {
                  ["y"] = -374.81865258765;
                  ["x"] = 325.54570837852;
               };
               [8] = {
                  ["y"] = -304.80570661162;
                  ["x"] = 545.45870878004;
               };
               [16] = {
                  ["y"] = -296.50071153449;
                  ["x"] = 438.35973149523;
               };
               [17] = {
                  ["y"] = -242.3529678811;
                  ["x"] = 336.58408786588;
               };
               [9] = {
                  ["y"] = -243.5482860266;
                  ["x"] = 449.07051045071;
               };
               [18] = {
                  ["y"] = -311.51228888137;
                  ["x"] = 335.88549947827;
               };
               [5] = {
                  ["y"] = -352.08800928078;
                  ["x"] = 327.30340070056;
               };
               [10] = {
                  ["y"] = -311.51228888137;
                  ["x"] = 335.88549947827;
               };
               [20] = {
                  ["y"] = -304.80570661162;
                  ["x"] = 545.45870878004;
               };
               [21] = {
                  ["y"] = -349.90267320038;
                  ["x"] = 438.48266538655;
               };
               [11] = {
                  ["y"] = -242.3529678811;
                  ["x"] = 336.58408786588;
               };
               [22] = {
                  ["y"] = -304.72788040391;
                  ["x"] = 326.24429676612;
               };
               [3] = {
                  ["y"] = -316.1380174959;
                  ["x"] = 431.26401864717;
               };
               [6] = {
                  ["y"] = -304.72788040391;
                  ["x"] = 326.24429676612;
               };
               [12] = {
                  ["y"] = -296.14356420564;
                  ["x"] = 436.9466537621;
               };
               [13] = {
                  ["y"] = -244.13830503854;
                  ["x"] = 538.95488815547;
               };
               [7] = {
                  ["y"] = -349.90267320038;
                  ["x"] = 438.48266538655;
               };
               [14] = {
                  ["y"] = -333.32355666562;
                  ["x"] = 532.20192703481;
               };
               [19] = {
                  ["y"] = -243.5482860266;
                  ["x"] = 449.07051045071;
               };
               [15] = {
                  ["y"] = -244.13830503854;
                  ["x"] = 538.95488815547;
               };
            };
            ["g"] = 29;
            ["y"] = -352.08800928078;
         };
         [5] = {
            ["y"] = -334.95803057736;
            ["x"] = 322.61187990022;
            ["g"] = 29;
            ["sublevel"] = 2;
         };
         [3] = {
            ["y"] = -284.30875546354;
            ["x"] = 504.84498579856;
            ["g"] = 28;
            ["sublevel"] = 2;
         };
         [6] = {
            ["y"] = -346.16218291332;
            ["x"] = 331.72958416192;
            ["g"] = 29;
            ["sublevel"] = 2;
         };
      };
      ["id"] = 166264;
      ["spells"] = {
         [334610] = {};
      };
      ["scale"] = 0.7;
      ["name"] = "Spare Parts";
      ["health"] = 8010;
      ["displayId"] = 95577;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 0;
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Shackle Undead"] = true;
         ["Root"] = true;
         ["Control Undead"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Stun"] = true;
      };
   };
   [26] = {
      ["clones"] = {
         [1] = {
            ["y"] = -211.78069692184;
            ["x"] = 343.72029006187;
            ["g"] = 33;
            ["sublevel"] = 2;
         };
      };
      ["id"] = 163621;
      ["spells"] = {
         [338357] = {};
         [333477] = {};
         [338456] = {};
      };
      ["scale"] = 2;
      ["name"] = "Goregrind";
      ["health"] = 224280;
      ["displayId"] = 99122;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 6;
      ["characteristics"] = {
         ["Taunt"] = true;
      };
   };
   [30] = {
      ["clones"] = {
         [1] = {
            ["y"] = -206.14354669664;
            ["x"] = 468.36784136928;
            ["g"] = 35;
            ["sublevel"] = 2;
         };
      };
      ["id"] = 164578;
      ["spells"] = {
         [320208] = {};
         [334322] = {};
         [320376] = {};
      };
      ["scale"] = 2;
      ["name"] = "Stitchflesh's Creation";
      ["health"] = 192240;
      ["displayId"] = 96218;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 0;
      ["characteristics"] = {
         ["Taunt"] = true;
      };
   };
   [36] = {
      ["clones"] = {
         [1] = {
            ["y"] = -188.89626688555;
            ["x"] = 133.4112971858;
            ["week"] = {
               [6] = true;
               [2] = true;
               [10] = true;
               [1] = true;
               [5] = true;
               [9] = true;
            };
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -275.30696567058;
            ["x"] = 514.25048922962;
            ["week"] = {
               [11] = true;
               [7] = true;
               [8] = true;
               [3] = true;
               [12] = true;
               [4] = true;
            };
            ["sublevel"] = 1;
         };
      };
      ["powers"] = {
         [357747] = {
            ["healer"] = true;
         };
         [357609] = {
            ["dps"] = true;
         };
         [357863] = {
            ["tank"] = true;
         };
         [357604] = {
            ["tank"] = true;
         };
         [357706] = {
            ["dps"] = true;
         };
         [357575] = {
            ["tank"] = true;
            ["dps"] = true;
            ["healer"] = true;
         };
         [357847] = {
            ["healer"] = true;
         };
      };
      ["id"] = 179890;
      ["spells"] = {
         [355714] = {};
         [356923] = {};
         [356925] = {};
         [358971] = {};
      };
      ["include"] = {
         ["affix"] = 128;
         ["level"] = 10;
      };
      ["health"] = 336131;
      ["count"] = 0;
      ["ignoreFortified"] = true;
      ["name"] = "Executioner Varruth";
      ["displayId"] = 92418;
      ["creatureType"] = "Humanoid";
      ["level"] = 61;
      ["scale"] = 1.5;
      ["iconTexture"] = 237552;
   };
   [37] = {
      ["clones"] = {
         [7] = {
            ["y"] = -132.78227250411;
            ["x"] = 227.26698263135;
            ["sublevel"] = 1;
         };
         [1] = {
            ["y"] = -267.60706198784;
            ["x"] = 560.84696436723;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -192.58339659725;
            ["x"] = 451.38273023493;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -271.00854009447;
            ["x"] = 418.19168025724;
            ["sublevel"] = 1;
         };
         [8] = {
            ["y"] = -224.67097046901;
            ["x"] = 144.05053876317;
            ["sublevel"] = 1;
         };
         [9] = {
            ["y"] = -416.09233960975;
            ["x"] = 537.3163351434;
            ["sublevel"] = 2;
         };
         [5] = {
            ["y"] = -395.74125776219;
            ["x"] = 356.37694098142;
            ["sublevel"] = 1;
         };
         [10] = {
            ["y"] = -238.04693291209;
            ["x"] = 543.52855222375;
            ["sublevel"] = 2;
         };
         [3] = {
            ["y"] = -139.2450911293;
            ["x"] = 535.81498960719;
            ["sublevel"] = 1;
         };
         [6] = {
            ["y"] = -185.00152154736;
            ["x"] = 309.88764796598;
            ["sublevel"] = 1;
         };
         [12] = {
            ["y"] = -251.18658523668;
            ["x"] = 426.82647934989;
            ["sublevel"] = 3;
         };
         [11] = {
            ["y"] = -167.48420743085;
            ["x"] = 435.20610169426;
            ["sublevel"] = 2;
         };
      };
      ["include"] = {
         ["affix"] = 130;
         ["level"] = 10;
      };
      ["health"] = 33022;
      ["level"] = 62;
      ["scale"] = 1;
      ["spells"] = {
         [368078] = {};
         [366566] = {};
      };
      ["ignoreFortified"] = true;
      ["displayId"] = 101046;
      ["count"] = 0;
      ["badCreatureModel"] = true;
      ["name"] = "Wo Relic";
      ["bonusSpell"] = 368241;
      ["creatureType"] = "Mechanical";
      ["modelPosition"] = {
         [1] = 0;
         [2] = 0;
         [3] = 0.6;
      };
      ["id"] = 185683;
      ["iconTexture"] = 4335644;
   };
   [39] = {
      ["clones"] = {
         [7] = {
            ["y"] = -106.43091486817;
            ["x"] = 239.96969371682;
            ["sublevel"] = 1;
         };
         [1] = {
            ["y"] = -239.38125010418;
            ["x"] = 572.7824424663;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -169.35758266978;
            ["x"] = 472.35046315306;
            ["sublevel"] = 1;
         };
         [4] = {
            ["y"] = -241.81495943014;
            ["x"] = 406.90134442884;
            ["sublevel"] = 1;
         };
         [8] = {
            ["y"] = -248.42093971907;
            ["x"] = 167.80061530159;
            ["sublevel"] = 1;
         };
         [9] = {
            ["y"] = -378.90490505088;
            ["x"] = 543.25383416144;
            ["sublevel"] = 2;
         };
         [5] = {
            ["y"] = -393.16061946117;
            ["x"] = 386.6995136976;
            ["sublevel"] = 1;
         };
         [10] = {
            ["y"] = -268.40402364035;
            ["x"] = 537.99284023123;
            ["sublevel"] = 2;
         };
         [3] = {
            ["y"] = -155.21281224757;
            ["x"] = 513.07303930456;
            ["sublevel"] = 1;
         };
         [6] = {
            ["y"] = -161.93215148703;
            ["x"] = 329.13273420253;
            ["sublevel"] = 1;
         };
         [12] = {
            ["y"] = -276.64114051799;
            ["x"] = 450.69014321391;
            ["sublevel"] = 3;
         };
         [11] = {
            ["y"] = -173.24080552417;
            ["x"] = 456.4560472022;
            ["sublevel"] = 2;
         };
      };
      ["include"] = {
         ["affix"] = 130;
         ["level"] = 10;
      };
      ["name"] = "Vy Relic";
      ["level"] = 62;
      ["id"] = 185680;
      ["spells"] = {
         [366406] = {};
         [368103] = {};
         [366409] = {};
      };
      ["ignoreFortified"] = true;
      ["displayId"] = 103111;
      ["health"] = 33022;
      ["badCreatureModel"] = true;
      ["count"] = 0;
      ["bonusSpell"] = 368240;
      ["creatureType"] = "Mechanical";
      ["modelPosition"] = {
         [1] = 0;
         [2] = 0;
         [3] = 0.75;
      };
      ["scale"] = 1;
      ["iconTexture"] = 4335643;
   };
   [35] = {
      ["clones"] = {
         [1] = {
            ["y"] = -318.59052389709;
            ["x"] = 547.17891536817;
            ["week"] = {
               [6] = true;
               [2] = true;
               [10] = true;
               [1] = true;
               [5] = true;
               [9] = true;
            };
            ["sublevel"] = 2;
         };
         [2] = {
            ["y"] = -277.26473786964;
            ["x"] = 230.04277792469;
            ["week"] = {
               [11] = true;
               [7] = true;
               [8] = true;
               [3] = true;
               [12] = true;
               [4] = true;
            };
            ["sublevel"] = 1;
         };
      };
      ["powers"] = {
         [356828] = {
            ["tank"] = true;
            ["dps"] = true;
         };
         [356827] = {
            ["dps"] = true;
            ["healer"] = true;
         };
         [357524] = {
            ["tank"] = true;
            ["dps"] = true;
            ["healer"] = true;
         };
         [357778] = {
            ["tank"] = true;
         };
         [357556] = {
            ["healer"] = true;
         };
      };
      ["id"] = 179891;
      ["spells"] = {
         [358970] = {};
         [355719] = {};
         [358784] = {};
         [358968] = {};
         [355806] = {};
      };
      ["include"] = {
         ["affix"] = 128;
         ["level"] = 10;
      };
      ["health"] = 358540;
      ["count"] = 0;
      ["ignoreFortified"] = true;
      ["name"] = "Soggodon the Breaker";
      ["displayId"] = 98535;
      ["creatureType"] = "Humanoid";
      ["level"] = 62;
      ["scale"] = 1.5;
      ["iconTexture"] = 2103898;
   };
   [1] = {
      ["clones"] = {
         [1] = {
            ["y"] = -222.57873870954;
            ["x"] = 634.44943930098;
            ["g"] = 1;
            ["sublevel"] = 1;
         };
         [2] = {
            ["y"] = -212.11171969476;
            ["x"] = 634.03286694412;
            ["g"] = 1;
            ["sublevel"] = 1;
         };
         [4] = {
            ["sublevel"] = 1;
            ["inspiring"] = true;
            ["x"] = 622.96773061204;
            ["g"] = 1;
            ["y"] = -211.08896875701;
         };
         [8] = {
            ["y"] = -279.14335164267;
            ["x"] = 542.60524207574;
            ["g"] = 9;
            ["sublevel"] = 1;
         };
         [16] = {
            ["y"] = -245.71898136959;
            ["x"] = 419.71393005741;
            ["g"] = 12;
            ["sublevel"] = 1;
         };
         [17] = {
            ["y"] = -158.69534235456;
            ["x"] = 548.02757692684;
            ["g"] = 5;
            ["sublevel"] = 1;
         };
         [9] = {
            ["sublevel"] = 1;
            ["x"] = 525.98715499635;
            ["patrol"] = {
               [7] = {
                  ["y"] = -204.59771915257;
                  ["x"] = 495.19187531962;
               };
               [1] = {
                  ["y"] = -199.14416302564;
                  ["x"] = 525.98715499635;
               };
               [2] = {
                  ["y"] = -196.42508486796;
                  ["x"] = 534.52262643769;
               };
               [4] = {
                  ["y"] = -196.42508486796;
                  ["x"] = 534.52262643769;
               };
               [8] = {
                  ["y"] = -204.81940842005;
                  ["x"] = 482.62700791643;
               };
               [9] = {
                  ["y"] = -204.59771915257;
                  ["x"] = 495.19187531962;
               };
               [5] = {
                  ["y"] = -199.14416302564;
                  ["x"] = 525.98715499635;
               };
               [10] = {
                  ["y"] = -202.55454688099;
                  ["x"] = 511.53712196815;
               };
               [3] = {
                  ["y"] = -191.06179464622;
                  ["x"] = 544.99380897718;
               };
               [6] = {
                  ["y"] = -202.55454688099;
                  ["x"] = 511.53712196815;
               };
            };
            ["g"] = 6;
            ["y"] = -199.14416302564;
         };
         [18] = {
            ["y"] = -163.75866402156;
            ["x"] = 528.6110476032;
            ["g"] = 5;
            ["sublevel"] = 1;
         };
         [5] = {
            ["y"] = -208.62104951716;
            ["x"] = 581.36600361522;
            ["g"] = 3;
            ["sublevel"] = 1;
         };
         [10] = {
            ["y"] = -195.5108985365;
            ["x"] = 518.53484462284;
            ["g"] = 6;
            ["sublevel"] = 1;
         };
         [20] = {
            ["y"] = -403.68421046567;
            ["x"] = 330.21843444811;
            ["g"] = 26;
            ["sublevel"] = 2;
         };
         [21] = {
            ["y"] = -280.23427925741;
            ["x"] = 472.84000063188;
            ["g"] = 28;
            ["sublevel"] = 2;
         };
         [11] = {
            ["sublevel"] = 1;
            ["x"] = 519.93836706451;
            ["g"] = 6;
            ["y"] = -204.71259406778;
         };
         [22] = {
            ["y"] = -254.45851236553;
            ["x"] = 518.88548008154;
            ["g"] = 30;
            ["sublevel"] = 2;
         };
         [3] = {
            ["y"] = -221.30744389803;
            ["x"] = 623.65755414698;
            ["g"] = 1;
            ["sublevel"] = 1;
         };
         [6] = {
            ["y"] = -234.33877343481;
            ["x"] = 536.95778927684;
            ["g"] = 7;
            ["sublevel"] = 1;
         };
         [12] = {
            ["sublevel"] = 1;
            ["x"] = 499.53908974431;
            ["patrol"] = {
               [7] = {
                  ["y"] = -235.05848951702;
                  ["x"] = 536.36237286977;
               };
               [1] = {
                  ["y"] = -247.69708502653;
                  ["x"] = 499.53908974431;
               };
               [2] = {
                  ["y"] = -243.74189768892;
                  ["x"] = 487.32663292418;
               };
               [4] = {
                  ["y"] = -236.84625292427;
                  ["x"] = 487.83742873216;
               };
               [8] = {
                  ["y"] = -243.48649978493;
                  ["x"] = 548.11052300852;
               };
               [9] = {
                  ["y"] = -250.63755341392;
                  ["x"] = 552.4522216143;
               };
               [5] = {
                  ["y"] = -235.8246613083;
                  ["x"] = 503.67187957271;
               };
               [10] = {
                  ["y"] = -250.63755341392;
                  ["x"] = 535.59620107848;
               };
               [3] = {
                  ["y"] = -238.63401633151;
                  ["x"] = 475.06768697744;
               };
               [6] = {
                  ["y"] = -233.52611305342;
                  ["x"] = 519.25093250927;
               };
               [11] = {
                  ["y"] = -249.36058581465;
                  ["x"] = 520.01712622124;
               };
            };
            ["g"] = 8;
            ["y"] = -247.69708502653;
         };
         [24] = {
            ["y"] = -245.37833861688;
            ["x"] = 332.01681681998;
            ["g"] = 31;
            ["sublevel"] = 2;
         };
         [25] = {
            ["sublevel"] = 2;
            ["inspiring"] = true;
            ["y"] = -256.34717010263;
            ["g"] = 31;
            ["x"] = 333.99546137051;
         };
         [13] = {
            ["y"] = -251.66312146101;
            ["x"] = 509.30228887343;
            ["g"] = 8;
            ["sublevel"] = 1;
         };
         [7] = {
            ["y"] = -225.02027482211;
            ["x"] = 536.36667443524;
            ["g"] = 7;
            ["sublevel"] = 1;
         };
         [14] = {
            ["y"] = -251.14684881901;
            ["x"] = 433.16111647083;
            ["g"] = 12;
            ["sublevel"] = 1;
         };
         [23] = {
            ["y"] = -258.12964012969;
            ["x"] = 528.86956076373;
            ["g"] = 30;
            ["sublevel"] = 2;
         };
         [19] = {
            ["y"] = -389.51616313679;
            ["x"] = 323.21091484491;
            ["g"] = 26;
            ["sublevel"] = 2;
         };
         [15] = {
            ["y"] = -245.5478806901;
            ["x"] = 427.21063543203;
            ["g"] = 12;
            ["sublevel"] = 1;
         };
      };
      ["id"] = 162729;
      ["spells"] = {
         [338022] = {};
      };
      ["scale"] = 0.8;
      ["name"] = "Patchwerk Soldier";
      ["health"] = 80100;
      ["displayId"] = 95222;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 4;
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Shackle Undead"] = true;
         ["Root"] = true;
         ["Control Undead"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Stun"] = true;
         ["Slow"] = true;
         ["Silence"] = true;
         ["Repentance"] = true;
      };
   };
   [19] = {
      ["clones"] = {
         [1] = {
            ["y"] = -224.0145497704;
            ["x"] = 169.18397830322;
            ["sublevel"] = 1;
         };
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["id"] = 163157;
      ["spells"] = {
         [333492] = {};
         [321247] = {};
         [320171] = {
            ["interruptible"] = true;
         };
         [333634] = {};
         [321226] = {};
         [333489] = {};
         [320012] = {};
      };
      ["isBoss"] = true;
      ["encounterID"] = 2391;
      ["instanceID"] = 1182;
      ["name"] = "Amarth";
      ["health"] = 576720;
      ["displayId"] = 94926;
      ["creatureType"] = "Beast";
      ["level"] = 60;
      ["count"] = 0;
      ["scale"] = 1;
   };
   [23] = {
      ["clones"] = {
         [1] = {
            ["y"] = -412.65302221547;
            ["x"] = 555.92876428203;
            ["g"] = 27;
            ["sublevel"] = 2;
         };
         [2] = {
            ["y"] = -248.5585823855;
            ["x"] = 360.30148473588;
            ["g"] = 31;
            ["sublevel"] = 2;
         };
      };
      ["id"] = 165911;
      ["spells"] = {
         [320696] = {};
         [327240] = {};
         [327155] = {};
      };
      ["scale"] = 1.4;
      ["name"] = "Loyal Creation";
      ["health"] = 136170;
      ["displayId"] = 95226;
      ["creatureType"] = "Undead";
      ["level"] = 60;
      ["count"] = 4;
      ["characteristics"] = {
         ["Taunt"] = true;
         ["Incapacitate"] = true;
         ["Shackle Undead"] = true;
         ["Root"] = true;
         ["Control Undead"] = true;
         ["Polymorph"] = true;
         ["Disorient"] = true;
         ["Silence"] = true;
         ["Slow"] = true;
         ["Stun"] = true;
         ["Repentance"] = true;
      };
   };
   [31] = {
      ["clones"] = {
         [1] = {
            ["y"] = -207.33818322552;
            ["x"] = 435.43723023701;
            ["g"] = 35;
            ["sublevel"] = 2;
         };
      };
      ["characteristics"] = {
         ["Taunt"] = true;
      };
      ["id"] = 162689;
      ["spells"] = {
         [320200] = {};
         [320358] = {};
         [343556] = {};
         [320359] = {};
         [334488] = {};
         [326574] = {};
         [327664] = {};
      };
      ["isBoss"] = true;
      ["encounterID"] = 2392;
      ["instanceID"] = 1182;
      ["name"] = "Surgeon Stitchflesh";
      ["health"] = 384480;
      ["displayId"] = 96477;
      ["creatureType"] = "Humanoid";
      ["level"] = 60;
      ["count"] = 0;
      ["scale"] = 2;
   };
};