# symmetric group arising from inhibitory connections partial
petrinet := rec(
inputs:= [[1,0,0,0,0]],
          
outputs := [[0],[2],[3],[4],[5]],

inhibcons := [[0,1,1,1,1]],
capacity:= [5],
initial := []
);
DumpPetriNet(petrinet,"C5P",StrictFiringPreCondition,MaxAllowedFiringPostCondition,true);
