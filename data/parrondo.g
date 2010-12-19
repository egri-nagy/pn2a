Read("../loader.g");
# parrrondo OPAALS,BIONETS
petrinet := rec(
inputs:= [[0,0,0,1,1,0,0,0,0],
          [0,0,0,0,0,0,0,1,0],
          [0,1,0,0,1,1,0,0,0],
          [0,0,0,0,0,0,1,0,1]
          ],

          
outputs := [[0,0,1,0],
            [0,0,0,0],
            [1,0,0,0],
            [0,0,0,0],
            [0,1,0,0],
            [0,0,0,1],
            [0,0,1,0],
            [1,0,0,0],
            [0,0,0,0]
            ],

inhibcons :=  [[0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,0,0,0,0]
          ],



capacity:= [2,1,1,1],
initial := [[0,0,0,0]]
);
petrigens := DumpPetriNet(petrinet,"parrondo",StrictFiringPreCondition,MaxAllowedFiringPostCondition,false);

SetInfoLevel(SkeletonInfoClass,2);
SetInfoLevel(HolonomyInfoClass,2);


hd := HolonomyDecomposition(Semigroup(petrigens));

SaveWorkspace("parrondo.ws");
