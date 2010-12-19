# simplified parrondo model by X
petrinet := rec(
inputs:= [[0,1,0,0,0,0,0,0,1],
          [0,0,1,0,1,0,1,0,1],
          [0,0,0,1,0,1,0,1,0]],

          
outputs := [[0,1,0],
            [0,0,0],
            [0,0,0],
            [0,0,0],
            [0,0,1],
            [0,1,0],
            [1,1,0],
            [1,0,1],
            [1,0,0]],

inhibcons :=  [[0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,0,0,0,0]],

capacity:= [1,2,1],
initial := []
);
DumpPetriNet(petrinet,"parraniv",StrictFiringPreCondition,MaxAllowedFiringPostCondition,false);
