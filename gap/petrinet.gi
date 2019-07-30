#############################################################################
##
#W  petri-net.gd           SgpDec         Attila Egri-Nagy
##
##  Simple functions to convert a petri-net to generator transfromations.
##

InstallGlobalFunction(GetTransformationOfPetriNetTransition, 
function(petrinet, transition, precond, postcond,ispartial)
  local i,j,numofplaces, state, counter, maxstate, tlist, transientstate,lookup, inhibited, marking;
  numofplaces := NumberOfPlacesOfPetriNet(petrinet);

  if not ("states" in RecNames(petrinet)) then 
      CalculateStatesOfPetriNet(petrinet,precond,postcond,ispartial);
  fi;
  maxstate := Size(petrinet.states);

  if (ispartial) then
      tlist:= List([1..maxstate+1], i ->( maxstate+1) );
  else
      tlist:= List([1..maxstate], i -> i );
  fi;

  #first we fill up the lookup global markings -> integers 
  lookup := AssociativeList(petrinet.states);
  #Print(lookup);
  #calculating the state transitions
  for i in [1..maxstate] do
    state := petrinet.states[i];
    if (precond(petrinet, transition, state))
       and (postcond(petrinet, transition, state)) then 
      #so now everything is fine, but it might be inhibited
      inhibited := false;
      for j in [1..Size(state)] do
        if (petrinet.inhibcons[j][transition] > 0) and (state[j] >= petrinet.inhibcons[j][transition]) then 
          inhibited := true;
        fi;                  
      od;
      if (not inhibited) then
        #when it is not inhibited
        marking := lookup[ExecutePetriNetTransition(petrinet,transition,state,precond,postcond)];
        if (marking = fail) and (ispartial) then
          # go to garbage state if transition goes outside of allowable states
          tlist[i] := maxstate + 1;
        else
          tlist[i] := marking;
        fi;
      else
        #it is inhibited, so it is the identity
        tlist[i] := i;
      fi;
    else
      if (ispartial) then
        tlist[i]:= maxstate+1;
      else
        tlist[i]:=i;
      fi;
    fi;
  od;
  return Transformation(tlist);
end);

InstallGlobalFunction(ExecutePetriNetTransition, 
  function(petrinet, transition, state, precond, postcond)
  
  local result,i;
  #Print(state, "I ");
  if not (precond(petrinet, transition, state)
          and postcond(petrinet, transition, state)) then
    return state;
  fi;
  #Ok, now we actually do the two phases together.
  result := List([1..Size(state)], x -> 0);
  for i in [1..Size(state)] do
      result[i] := state[i] - petrinet.inputs[i][transition];
      result[i] := result[i] + petrinet.outputs[transition][i];
      if (result[i] > petrinet.capacity[i]) then result[i] := petrinet.capacity[i];fi;
  od;
  #Print(result, "O\n");
  return result;
end);

InstallGlobalFunction(NumberOfPlacesOfPetriNet, 
  function(petrinet)
  return  DimensionsMat(petrinet.inputs)[1];
end);

InstallGlobalFunction(NumberOfTransitionsOfPetriNet, 
  function(petrinet)
  return  DimensionsMat(petrinet.inputs)[2];
end);
