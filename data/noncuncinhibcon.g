# Example for demonstrating the problems with concurrency
petrinet := rec(
inputs:= [[1,0],
          [0,0],
          [0,1],
          [0,0]],
          
outputs := [[0,1,0,0],
            [0,0,0,1]],

inhibcons := [[0,0],              
              [0,1],
              [0,0],              
              [1,0]],
capacity:= [1,1,1,1],
initial := [[1,1,0,0]]
);
DumpPetriNet(petrinet,"inhibex",StrictFiringPreCondition,MaxAllowedFiringPostCondition,false);
