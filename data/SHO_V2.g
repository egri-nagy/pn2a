# simple harmonic oscillator with inhibition by Paolo Dini

petrinet := rec(
inputs:= [[0,1],
          [1,0]
         ],
          
outputs := [[1,0],
            [0,1]
            ],

inhibcons :=  [[1,0],
               [0,1]
               ],

capacity := [2,2],
initial := []
);


petrigens := DumpPetriNet(petrinet,"SHO_V2",StrictFiringPreCondition,MaxAllowedFiringPostCondition,false);

SetInfoLevel(SkeletonInfoClass,2);
SetInfoLevel(HolonomyInfoClass,2);

S := Semigroup(petrigens);
hd := HolonomyDecomposition(S);


