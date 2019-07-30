# if initial states are given only reachable states are calculated
InstallGlobalFunction(CalculateStatesOfPetriNet, 
  function(petrinet,precond,postcond,ispartial)
  if IsEmpty(petrinet.initial) then
    if "condition" in RecNames(petrinet) then
      # set initial to be all possible states that satisfy the condition
      petrinet.initial := AllGlobalMarkingsOfPetriNet(petrinet);
      # calculate all reachable states from the generated initial states
      petrinet.states := ReachableMarkingsOfPetriNet(petrinet,precond,postcond,ispartial);
    else
      petrinet.states := AllGlobalMarkingsOfPetriNet(petrinet);
    fi;
  else
    petrinet.states := ReachableMarkingsOfPetriNet(petrinet,precond,postcond,ispartial);
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
function(petrinet,precond,postcond,ispartial)
local resultset, base,nbase, numoftransitions,i,j,nelem;
  numoftransitions := NumberOfTransitionsOfPetriNet(petrinet);
  
  Sort(petrinet.initial); # ensure initial is a Set
  # check if initial states satisfy condition
  if "condition" in RecNames(petrinet) then
    for i in [1..Size(petrinet.initial)] do
      # print warning if a state does not satisfy petrinet.condition
      if not petrinet.condition(petrinet.initial[i]) then
        Print(Concatenation("WARNING: Initial state: ",
                            String(petrinet.initial[i]),
                            " that does not satisfy petrinet.condition.\n"));
      fi;
    od;
  fi;
  resultset := ShallowCopy(petrinet.initial);
  base := ShallowCopy(petrinet.initial);
  while not IsEmpty(base) do
    nbase:= [];
    for i in [1..numoftransitions] do 
      for j in [1..Size(base)] do
        # get new marking by applying transition i to state base[j]
        nelem := ExecutePetriNetTransition(petrinet,i,base[j],precond,postcond);
        if not (nelem in resultset) then
          if "condition" in RecNames(petrinet) then
            # If new marking does not satisfy petrinet.condition
            if not petrinet.condition(nelem) then
              if ispartial then
                # If ispartial is true, don't allow new marking and skip
                Print(Concatenation("WARNING: Found reachable state: ",
                                    String(nelem),
                                    " that does not satisfy petrinet.condition. ",
                                    "Disallow and go to garbage state.\n"));
                continue;
              else
                # Otherwise, allow marking anyway
                Print(Concatenation("WARNING: Added reachable marking: ", 
                                    String(nelem), 
                                    " that does not satisfy petrinet.condition.\n"));
              fi;
            fi;   
          fi;
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
