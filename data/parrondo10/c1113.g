Read("../../loader.g");
# parrrondo OPAALS,BIONETS
# This is a variant of the petri-net with ten transitions (matching numbering in
# figure 35A in OPAALS deliverable 1). It includes a transition to dissociate complex C # into P (p53)  and M (mdm2)
#  M C P R
petrinet := rec(
inputs:= [[0,0,0,1,1, 0, 0,0,0,0],
          [0,0,0,0,0, 1, 1,0,0,0],
          [0,1,0,0,1, 0, 0,1,0,0],
          [0,0,0,0,0, 0, 0,0,1,1]
          ],

          
outputs := [[0,0,1,0],
            [0,0,0,0],
            [1,0,0,0],
            [0,0,0,0],
            [0,1,0,0],
            [1,0,1,0],  # C dissociates to M and P
            [1,0,0,0],
            [0,0,0,1],
            [0,0,1,0],
            [0,0,0,0]
            ],

inhibcons :=  [[0,0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,0,0,0,0,0]
          ],



capacity:= [1,1,1,3],
initial := [[0,0,0,0]]
);
petrigens := DumpPetriNet(petrinet,"c1113",StrictFiringPreCondition,MaxAllowedFiringPostCondition,false);

SetInfoLevel(SkeletonInfoClass,2);
SetInfoLevel(HolonomyInfoClass,2);


hd := HolonomyDecomposition(Semigroup(petrigens));

SaveWorkspace("c1113.ws");
