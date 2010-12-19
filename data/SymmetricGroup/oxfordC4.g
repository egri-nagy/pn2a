# example of a symmetric group component arising from an inhibitory connections (getting the idea while fiddling in Oxford...)
petrinet := rec(
inputs:= [[1,0,0,0]],
          
outputs := [[0],[2],[3],[4]],

inhibcons := [[0,1,1,1]],
capacity:= [4],
initial := []
);
DumpPetriNet(petrinet,"i4",StrictFiringPreCondition,MaxAllowedFiringPostCondition,false);
