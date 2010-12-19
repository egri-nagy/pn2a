#BZ
state:=[0,0,0];
for i in [1..64] do
    Print(GetOrderNumberOfPetriNetState(state, 3));
    Print(state);
    Print("\n");
    state := NextPetriNetStateInOrder(state, 3);
    
    od;
inputs:= [[1,1,0,0,0],
          [0,1,1,0,0],
          [0,0,1,1,0]];
outputs := [[0,1,0],
            [0,2,0],
            [0,0,2],
            [0,0,0],
	    [1,0,0]];
t:=GetTransformationOfPetriNetTransition(inputs,outputs,1,3,StrictFiringPreCondition,StrictFiringPostCondition);