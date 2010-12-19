# very simple one way reaction with input and output reactions
inputs:= [[0,1,0],
          [0,0,1]];
outputs := [[1,0],
            [0,1],
	    [0,0]];
for i in [1..3] do
    PrintAsJGRASPGenerator(GetTransformationOfPetriNetTransition(inputs,outputs,i,2,StrictFiringPreCondition,StrictFiringPostCondition));
    Print("\n");
od;