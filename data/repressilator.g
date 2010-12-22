# Repressilator Petri-Net. Version by Maria Schilstra and Chrystopher Nehaniv 

petrinet := rec(
inputs:= [[0,0,0,1,0,0],  # I_ij = number of i tokens required transition j 
          [0,0,0,0,1,0], 
          [0,0,0,0,0,1]  
         ],
          
outputs := [[1,0,0], #make token A
            [0,1,0], #make token B
            [0,0,1], #make token C
            [0,0,0], #destroy token A
            [0,0,0], #destroy token B
            [0,0,0]  #destroy token C
            ],

inhibcons :=  [
               [0,1,0,0,0,0], #A inhibits production of B
               [0,0,1,0,0,0], #B inhibits production of C
               [1,0,0,0,0,0]  #C inhibits production of A
               ],

capacity := [1,1,1],
initial := []
);


petrigens := DumpPetriNet(petrinet,"repressilator",StrictFiringPreCondition,MaxAllowedFiringPostCondition,false); 

SetInfoLevel(SkeletonInfoClass,2);
SetInfoLevel(HolonomyInfoClass,2);

S := Semigroup(petrigens);
hd := HolonomyDecomposition(S);


