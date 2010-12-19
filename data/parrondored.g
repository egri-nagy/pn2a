# parrrondo OPAALS,BIONETS
petrinet := rec(
inputs:= [[0,0,0,1,1,0],
          [0,0,0,0,0,1],
          [0,1,0,0,1,0]
          ],

          
outputs := [[0,0,1],
            [0,0,0],
            [1,0,0],
            [0,0,0],
            [0,1,0],
            [1,0,0]
            ],

inhibcons :=  [[0,0,0,0,0,0],
          [0,0,0,0,0,0],
          [0,0,0,0,0,0]
          ],



capacity:= [2,2,2],
initial := [[0,0,0]]
);
petrigens := DumpPetriNet(petrinet,"parrondo",StrictFiringPreCondition,MaxAllowedFiringPostCondition,false);
