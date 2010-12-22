#############################################################################
##
#W  petri-net.gd           SgpDec         Attila Egri-Nagy
##
##  Simple functions to convert a petri-net to generator transfromations.
##

#the old dictionary staff had to be hacked in here
AddAllToDictionary := function(dict,list)
  local i;
  for i in Iterator(list) do 
    AddDictionary(dict,i);
  od;
end;

Dictionary2List := function(dict)
    local i, l;
    l := [];
    for i in HashKeyEnumerator(dict) do
        Add(l, i);
    od;	
    return l;
end;

DictionaryOfListIndices := function(list)
  local i,dict;

  dict := NewDictionary(list[1], true);

  for i in [1..Size(list)] do 
    AddDictionary(dict,list[i],i);
  od;
  return dict;
end;



##  <#GAPDoc Label="PetriNetDataStructure">
##  The Petri-Net is represented with five matrices: the input arcs, the output arcs from transitions to places, inhibitory connections, capacity vector, and initial marking. Input: rows represent places, columns transitions, so one entry tells the weight/multiplicity of an arrow (0 if nonexistant). Output: rows are transitions, columns are places.
## Inhibotory connection: zero means there is no inhibition, positive value n means that there is inhibition if there are at least n tokens in place
##  <Example>
##petrinet := rec(
##inputs:= [[1,0],
##          [0,1]],
##          
##outputs := [[1,2],
##            [0,0]],
##
##inhibcons := [[0,0],              
##              [1,0]],
##capacity:= [2,2],
##initial := [[1,0]]
##);
##  </Example>
##  <#/GAPDoc>
##

##  <#GAPDoc Label="GetTransformationOfPetriNetTransition">
##  <ManSection >
##  <Func Arg="petrinet, transition, precond, postcond, ispartial" Name="GetTransformationOfPetriNetTransition" />
##  <Description>
##  Returns the transformation representation of a Petri net transition.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction(GetTransformationOfPetriNetTransition, 
  function(petrinet, transition, precond, postcond,ispartial)
  local i,j,numofplaces, state, counter, maxstate, tlist, transientstate,lookup, inhibited;
  numofplaces := NumberOfPlacesOfPetriNet(petrinet);


#  petrinet.states := CalculateStatesOfPetriNet(petrinet);

  if not ("states" in RecNames(petrinet)) then 
      CalculateStatesOfPetriNet(petrinet,precond,postcond);
  fi;
  maxstate := Size(petrinet.states);


  if (ispartial) then
      tlist:= List([1..maxstate+1], i ->( maxstate+1) );
  else
      tlist:= List([1..maxstate], i -> i );
  fi;

  #first we fill up the lookup Dictionary vectors (states, markings)-> integers 
  lookup := DictionaryOfListIndices(petrinet.states);


  #calculating the state transitions
  for i in [1..maxstate] do
    state := petrinet.states[i];
    #we have the next state 
    transientstate := precond(petrinet, transition, state);
      #when the input conditions are ok (but it might be still inhibited)
      if (not IsEmpty(transientstate) ) then 
	  transientstate := postcond(petrinet, transition, transientstate);
          #when the output conditions are ok (but it might be still inhibited)
	  if (not IsEmpty(transientstate) ) then 
	      #so now everything is fine, but it might be inhibited
	      inhibited := false;
	      for j in [1..Size(state)] do
                  if (petrinet.inhibcons[j][transition] > 0) and (state[j] >= petrinet.inhibcons[j][transition]) then 
                      Print(j, " ", state[j], " ",petrinet.inhibcons[j][transition],"\n" );                      
                      inhibited := true;
                  fi;                  
	      od;
	      if (not inhibited) then
		  #when it is not inhibited
		  tlist[i] := LookupDictionary(lookup, transientstate);
	      else
		  #it is inhibited, so it is the identity
		  tlist[i] := i;
	      fi;
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



##  <#GAPDoc Label="ExecutePetriNetTransition">
##  <ManSection >
##  <Func Arg="petrinet, state, transition, precond, postcond" Name="GetTransformationOfPetriNetTransition" />
##  <Description>
##  Executes a transition of the petri net on the given state. It gives back the original state if it is not enabled.
##  <Example>
##  inputs:= [[1,1,0,0,0],
##          [0,1,1,0,0],
##          [0,0,1,1,0]];
##outputs := [[0,1,0],
##            [0,2,0],
##            [0,0,2],
##            [0,0,0],
##            [1,0,0]];
##t:=GetTransformationOfPetriNetTransition(inputs,outputs,1,3);
##  </Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction(ExecutePetriNetTransition, 
  function(petrinet, transition, state, precond, postcond)
  
  local result,i;

  result := precond(petrinet, transition, state);
  # if precond not satisfied then return the original state
  if (IsEmpty(result)) then
      return state;
  fi;
  result := postcond(petrinet, transition, state);
  # if postcond not satisfied then return the original state
  if (IsEmpty(result)) then
      return state;
  fi;

  #Ok, now we have to do the two phases together.
  result := List([1..Size(state)], i -> 0);
  for i in [1..Size(state)] do
      result[i] := state[i] - petrinet.inputs[i][transition];
      result[i] := result[i] + petrinet.outputs[transition][i];
      if (result[i] > petrinet.capacity[i]) then result[i] := petrinet.capacity[i];fi;

  od;

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

