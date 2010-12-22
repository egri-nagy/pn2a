
####################################################################################################################################
###################################OUTPUTTING, DISPLAYING PETRI NETS################################################################
####################################################################################################################################

##  <#GAPDoc Label="DumpPetriNet">
##  <ManSection >
##  <Func Arg="petrinet, name, precond,postcond, ispartial" Name="DumpPetriNet" />
##  <Description>
##  The comprehensive function for exporting (to GraphViz, JGrasp) Petri nets. It also returns the generators as a list of transformations.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction(DumpPetriNet, 
  function(petrinet,name, precond,postcond, ispartial)

  local i,numoftrans, numofstates, gensfile, strm,symbolfile, statesfile, namelookup, result,t;

  result := [];

  #writing input symbols
  numoftrans := NumberOfTransitionsOfPetriNet(petrinet);
  symbolfile := Concatenation(name,".symbols");
  PrintTo(symbolfile,"");
  for i in [1..numoftrans] do
      AppendTo(symbolfile, Concatenation("t",StringPrint(i),"\n"));
  od;

  PetriNet2GraphViz(petrinet, Concatenation(name,".dot"));

  for i in [1..numoftrans] do
      t := GetTransformationOfPetriNetTransition(petrinet,i,precond,postcond,ispartial);
      Add(result,t);
  od;


  #writing statenames (this relies on the previous calls of GetTransformationOfPetriNetTransition (TODO! remove this dependency)
  statesfile := Concatenation(name,".states");
  PrintTo(statesfile,"");
  if ispartial then
      numofstates := Size(petrinet.states)+1;
  else
      numofstates := Size(petrinet.states);
  fi;
  namelookup := LookupTable4PetriNetMarkings(petrinet, ispartial);
  for i in [1..numofstates] do       
      AppendTo(statesfile, LookupDictionary(namelookup,StringPrint(i)));
      AppendTo(statesfile,"\n");
  od;

  return result;
end);

#For the graphviz part. 
InstallGlobalFunction(PetriNet2GraphViz, 
  function(petrinet, filename)
  local i,j;
  PrintTo(filename,"digraph PetriNet{\n");
  for i in [1..Size(petrinet.inputs)] do
      AppendTo(filename, Concatenation("p", StringPrint(i),"_",StringPrint(petrinet.capacity[i]),"\n"));
  od;
  for j in [1..Size(petrinet.outputs)] do
      AppendTo(filename, Concatenation("t", StringPrint(j)," [shape=box,style=filled,color=\"black\",fontcolor=\"white\"]\n"));
  od;

  for i in [1..Size(petrinet.inputs)] do
      for j in [1..Size(petrinet.outputs)] do 
          if (not (petrinet.inputs[i][j] = 0)) then
	      AppendTo(filename,Concatenation("p",StringPrint(i),"_",StringPrint(petrinet.capacity[i])," -> ", "t",StringPrint(j)," [label=",StringPrint(petrinet.inputs[i][j]),"]\n"));
	  fi;
	  #inhibitory connections
          if (not (petrinet.inhibcons[i][j] = 0)) then
	      AppendTo(filename,Concatenation("p",StringPrint(i),"_",StringPrint(petrinet.capacity[i])," -> ", "t",StringPrint(j)," [arrowhead=dot,label=\"", StringPrint(petrinet.inhibcons[i][j]),"\"]\n"));
	  fi;

          if (not (petrinet.outputs[j][i] = 0)) then
	      AppendTo(filename,Concatenation("t",StringPrint(j)," -> ", "p",StringPrint(i),"_",StringPrint(petrinet.capacity[i])," [label=",StringPrint(petrinet.outputs[j][i]),"]\n"));
	  fi;

      od;
  od;
  AppendTo(filename,"}\n");
end);

#just put there temporarily
ListAsDenseString := function(list)
    local i, s, str;
    str := "";
    for i in [1..Size(list)] do
        str := Concatenation(str,StringPrint(list[i]));
    od;	
    return str;
end;


#lookup table for state names
InstallGlobalFunction(LookupTable4PetriNetMarkings,
    function(petrinet,ispartial)

    local i, state, namelookup, maxstate;
    
    maxstate := Size(petrinet.states);

    namelookup := NewDictionary("1", true);
    
    for i in [1..maxstate] do
      state := petrinet.states[i];
      AddDictionary(namelookup,StringPrint(i), ListAsDenseString(state));
    od;
    if (ispartial) then 
	AddDictionary(namelookup,StringPrint(maxstate+1), "P");
    fi;
    return namelookup;
end);


#probably this can be done in a simpler way
PetriNetStateNames := function(petrinet, ispartial)
    local l, state;
    l := [];
    
    for state in petrinet.states do

      Add(l, ListAsDenseString(state));
    od;
    if (ispartial) then Add(l,"P"); fi;
    return l;
    
end;
