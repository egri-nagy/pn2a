# nice example of a group component arising from an inhibitory connection (getting the idea while listening to haydn, I guess...)
petrinet := rec(
inputs:= [[1,0,0,0,0,0,0,0]],
          
outputs := [[0],[2],[3],[4],[5],[6],[7],[8]],

inhibcons := [[0,1,1,1,1,1,1,1]],
capacity:= [8],
initial := []
);
DumpPetriNet(petrinet,"oxford_Cap8",StrictFiringPreCondition,MaxAllowedFiringPostCondition,false);
