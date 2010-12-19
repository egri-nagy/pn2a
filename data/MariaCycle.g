# Petrinet with three places in a cycle of transitions with inhibitions to 'previous' place, suggested by Maria Schilstra
Read("../loader.g");

petrinet := rec(
inputs:= [[1,0,0],
          [0,1,0],
          [0,0,1]
         ],
          
outputs := [[0,1,0],
            [0,0,1],
            [1,0,0]
            ],

inhibcons :=  [[0,0,1],
               [1,0,0],
               [0,1,0]
               ],

capacity := [2,2,2],
initial := []
);


petrigens := DumpPetriNet(petrinet,"MariaCycle",StrictFiringPreCondition,MaxAllowedFiringPostCondition,false);

SetInfoLevel(SkeletonInfoClass,2);
SetInfoLevel(HolonomyInfoClass,2);

S := Semigroup(petrigens);
hd := HolonomyDecomposition(S);


