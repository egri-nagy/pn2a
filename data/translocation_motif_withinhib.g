# maria's example from the translocation model with inhibition
petrinet := rec(
inputs:= [[1,0,0,0],
          [0,1,0,0],  
          [0,0,0,0],
          [0,0,1,0],
          [0,0,0,1]],
          
outputs := [[0,1,0,0,0],
            [0,0,1,0,0],
            [0,0,0,0,1],
            [0,0,0,1,0]],

inhibcons :=  [[0,0,0,0],
          [0,0,0,0],  
          [0,0,0,0],
          [1,0,0,0],
          [0,0,0,0]],

capacity:= [1,1,1,1,1],
initial := []
);
DumpPetriNet(petrinet,"translocation_motif_withinhib",StrictFiringPreCondition,MaxAllowedFiringPostCondition,false);
