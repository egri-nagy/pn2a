# simple harmonic oscillator by Paolo Dini
petrinet := rec(
inputs:= [[1,1,0,0],
          [0,0,1,1]
         ],
          
outputs := [[0,1],
            [0,1],
            [1,0],
            [1,0]
            ],

inhibcons :=  [[0,0,0,0],
               [0,0,0,0]
               ],

capacity := [3,3],
initial := []
);


petrigens := DumpPetriNet(petrinet,"SHO",StrictFiringPreCondition,MaxAllowedFiringPostCondition,false);

SetInfoLevel(SkeletonInfoClass,2);
SetInfoLevel(HolonomyInfoClass,2);

S := Semigroup(petrigens);
hd := HolonomyDecomposition(S);


