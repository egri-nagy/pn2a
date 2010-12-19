# assoc-dissoc BIONETS
petrinet := rec(
inputs:= [[1,0],
          [1,0],
          [0,1]],

          
outputs := [[0,0,1],
            [1,1,0]],

inhibcons :=  [[0,0],
          [0,0],
          [0,0]],


capacity:= [10,10,5],
initial := [[0,0,5]]
);
DumpPetriNet(petrinet,"assoc_dissoc",StrictFiringPreCondition,MaxAllowedFiringPostCondition,false);
