# simple harmonic oscillator with inhibition by Paolo Dini

petrinet := rec(
inputs:= [[0,1,1,0],
          [1,1,0,0]
         ],
          
outputs := [[1,0],
            [0,0],
            [0,1],
            [1,1]
            ],

inhibcons :=  [[0,0,0,0],
               [2,0,0,0]
               ],

capacity := [3,3],
initial := [[3,2]]
);

petrigens := DumpPetriNet(petrinet,"SHO_V6",StrictFiringPreCondition,MaxAllowedFiringPostCondition,false);

SetInfoLevel(SkeletonInfoClass,2);
SetInfoLevel(HolonomyInfoClass,2);

S := Semigroup(petrigens);
hd := HolonomyDecomposition(S);


