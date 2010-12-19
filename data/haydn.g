# nice example of a group component arising from an inhibitory connection (getting the idea while listening to haydn, I guess...)
petrinet := rec(
inputs:= [[1,0],
          [0,1]],
          
outputs := [[1,2],
            [0,0]],

inhibcons := [[0,0],              
              [1,0]],
capacity:= [2,2],
initial := [[1,0]]
);
petrigens := DumpPetriNet(petrinet,"haydn",StrictFiringPreCondition,MaxAllowedFiringPostCondition,false);
