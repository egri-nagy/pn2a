# if initial states are given only reachable states are calculated
InstallGlobalFunction(CalculateStatesOfPetriNet, 
  function(petrinet,precond,postcond)
  if IsEmpty(petrinet.initial) then
    petrinet.states := AllGlobalMarkingsOfPetriNet(petrinet);
  else
    petrinet.states := ReachableMarkingsOfPetriNet(petrinet,precond,postcond);
  fi;
  return petrinet;
end);

#just the direct product
InstallGlobalFunction(AllGlobalMarkingsOfPetriNet, 
function(petrinet)
local output, states, i;
  if "condition" in RecNames(petrinet) then
    states := EnumeratorOfCartesianProduct(List(petrinet.capacity, x->[0..x]));
    output := [];
    for i in [1..Size(states)] do
      if petrinet.condition(states[i]) then
        Add(output, states[i]);
      fi;
    od;
    return output;
  else
    return EnumeratorOfCartesianProduct(List(petrinet.capacity, x->[0..x]));
  fi;
end);

# basically a breadth-first search
InstallGlobalFunction(ReachableMarkingsOfPetriNet, 
function(petrinet,precond,postcond)
local resultset, base,nbase, numoftransitions,i,j,nelem;
  numoftransitions := NumberOfTransitionsOfPetriNet(petrinet);
  Sort(petrinet.initial); # ensure initial is a Set
  resultset := petrinet.initial;
  base := petrinet.initial;
  while not IsEmpty(base) do
    nbase:= [];
    for i in [1..numoftransitions] do 
      for j in [1..Size(base)] do
        #here are the new elements generated
        nelem := ExecutePetriNetTransition(petrinet,i,base[j],precond,postcond);
        if not (nelem in resultset) then
          AddSet(resultset,nelem);
          Add(nbase,nelem);
        fi;
      od;
    od;
    base := nbase;
  od;
  return resultset;
end);

# the number of all possible global markings
InstallGlobalFunction(GetNumberOfStatesOfPetriNets, 
function(petrinet)
  return Product(List([1..Size(petrinet.capacity)],
                 x->petrinet.capacity[x]+1)); #+1 for empty place
end);
