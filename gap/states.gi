##  <#GAPDoc Label="CalculateStatesOfPetriNet">
##  <ManSection >
##  <Func Arg="petrinet" Name="CalculateStatesOfPetriNet" />
##  <Description>
##  It calculates the global markings of a Petri net. If list of initial states is not empty, then it calculates the reachable states from the initial states.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
InstallGlobalFunction(CalculateStatesOfPetriNet, 
  function(petrinet,precond,postcond)
  if IsEmpty(petrinet.initial) then
      petrinet.states := AllGlobalMarkingsOfPetriNet(petrinet);
  else
      petrinet.states := ReachableMarkingsOfPetriNet(petrinet,precond,postcond);
  fi;
  return petrinet;
end);

##  <#GAPDoc Label="AllGlobalMarkingsOfPetriNet">
##  <ManSection >
##  <Func Arg="petrinet" Name="AllGlobalMarkingsOfPetriNet" />
##  <Description>
##  It calculates all the global markings of a Petri net and puts the result back into the petrinet record as a 'states' field.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
InstallGlobalFunction(AllGlobalMarkingsOfPetriNet, 
  function(petrinet)
  local numofplaces, maxstate, state,i,result;

  numofplaces := NumberOfPlacesOfPetriNet(petrinet);
  maxstate := GetNumberOfStatesOfPetriNets(petrinet);

  result := [];

  state := List([1..numofplaces], i -> (petrinet.capacity[i]));#trick for the loop!! we start with the next one which is 0,0,0,...
  for i in [1..maxstate] do
     state := NextPetriNetStateInOrder(petrinet, state);
     Add(result,state);
  od;
  return result;
end);

##  <#GAPDoc Label="ReachableMarkingsOfPetriNet">
##  <ManSection >
##  <Func Arg="petrinet, precond, postcond" Name="ReachableMarkingsOfPetriNet" />
##  <Description>
##  It calculates all the global markings of a Petri net reachable from the specified initial states
## and puts the result back into the petrinet record as a 'states' field.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
InstallGlobalFunction(ReachableMarkingsOfPetriNet, 
  function(petrinet,precond,postcond)
  local resultset, base,nbase, numoftransitions,i,j,nelem;
  
  numoftransitions := NumberOfTransitionsOfPetriNet(petrinet);

  resultset := [];#NewDictionary(petrinet.initial[1],false);#,Domain(petrinet.initial[1]));
  base := [];
  Append(base,petrinet.initial);

  #AddAllToDictionary(resultset,petrinet.initial);
                      Append(resultset, petrinet.initial);
    
    while Size(base)<>0 do
        nbase:= [];
        for i in [1..numoftransitions] do 
            for j in Iterator(base)	do
                #here are the new elements generated
	        nelem := ExecutePetriNetTransition(petrinet,i,j,precond,postcond);
                if not (nelem in resultset) then #KnowsDictionary(resultset,nelem) then
                    Add(resultset,nelem);#AddDictionary(resultset, nelem);
                    Add(nbase,nelem);
                fi;
            od;
        od;
        base := nbase;
    od;
    return resultset;#Dictionary2List(resultset);	


end);


#A technical function needed for AllGlobalMarkingsOfPetriNet. Given a state it constructs the next state in alphabetical order.
InstallGlobalFunction(NextPetriNetStateInOrder, 
  function(petrinet,state)
  local i,result, size, carry;

  result := [];
  carry := 0;
  size := Size(state);
  #adding it to the least significant bit
  if (state[size] < (petrinet.capacity[size]))  then
      result[size] := state[size] + 1;
  else
      result[size] := 0;
      carry := 1;
  fi;


  for  i in Reversed(Flat([1..(size-1)])) do #CRAZY, would be nice to have range like 3..1
    if (carry = 1) then 
	if (state[i] < (petrinet.capacity[i]))  then
	    result[i] := state[i] + 1;
	    carry := 0;
	else
	    result[i] := 0;
	    carry := 1;
	fi;
    else
	result[i] := state[i];
    fi;
  od;
  return result;
end);


##  <#GAPDoc Label="GetNumberOfStatesOfPetriNets">
##  <ManSection >
##  <Func Arg="capacity" Name="GetNumberOfStatesOfPetriNets" />
##  <Description>
##  Calculates the number of markings of the Petri net, given a vector containing values of how many tokens the places (in order) can accomodate.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction(GetNumberOfStatesOfPetriNets, 
function(petrinet)
  return Product(List([1..Size(petrinet.capacity)],
                 x->petrinet.capacity[x]+1)); #+1 for empty place
end);
