### FIRING CONDITIONS###########################################################

# there must be enough input tokens
InstallGlobalFunction(StrictFiringPreCondition, 
function(petrinet, transition, state)
  return ForAll([1..Size(state)],
                x->(state[x]-petrinet.inputs[x][transition])>=0);  
end);

# there has to be enough capacity to accommodate new tokens
InstallGlobalFunction(StrictFiringPostCondition, 
  function(petrinet, transition, state)
  return ForAll([1..Size(state)],
                x->(state[x]
                    +petrinet.outputs[transition][x])
                    -petrinet.inputs[x][transition] #this may make room
                    <= petrinet.capacity[x]);
end);

# just constant true, overflow is the default behaviour
InstallGlobalFunction(MaxAllowedFiringPostCondition, 
function(petrinet, transition, state)
  return true;
end);

