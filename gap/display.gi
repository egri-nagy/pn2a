###OUTPUTTING, DISPLAYING PETRI NETS############################################

InstallGlobalFunction(DumpPetriNet, 
function(petrinet,name, precond,postcond, ispartial)
  local i,numoftrans, numofstates, gensfile, strm,symbolfile, statesfile, namelookup, result,t,statelistfile,symbollistfile;

  result := [];
  #writing input symbols
  numoftrans := NumberOfTransitionsOfPetriNet(petrinet);
  symbolfile := Concatenation(name,".symbols");
  PrintTo(symbolfile,"");
  for i in [1..numoftrans] do
    AppendTo(symbolfile, Concatenation("t",StringPrint(i),"\n"));
  od;
  #writing input symbols
  symbollistfile := Concatenation(name,"symbols.g");
  PrintTo(symbollistfile,"");
  AppendTo(symbollistfile, Concatenation(name, "symbols := ["));
  for i in [1..numoftrans] do
      AppendTo(symbollistfile, Concatenation("\"t",StringPrint(i),"\""));
      if i < numoftrans then AppendTo(symbollistfile,","); fi;
  od;
  AppendTo(symbollistfile, "];\n");
 if IsBound( petrinet.places ) then
      PetriNet2GraphVizWithNames(petrinet, Concatenation( name, "WithNames", ".dot" ), petrinet.places, petrinet.transitions );
    else
     PetriNet2GraphViz(petrinet, Concatenation( name, ".dot" ) );
 fi;
 

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
      AppendTo(statesfile, namelookup[StringPrint(i)]);
      AppendTo(statesfile,"\n");
  od;
  statelistfile := Concatenation(name,"states.g");
  PrintTo(statelistfile,name,"states := [");
  if ispartial then
      numofstates := Size(petrinet.states)+1;
  else
      numofstates := Size(petrinet.states);
  fi;
  namelookup := LookupTable4PetriNetMarkings(petrinet, ispartial);
  for i in [1..numofstates] do       
      AppendTo(statelistfile, "\"",namelookup[StringPrint(i)],"\"");
      if i < numofstates then AppendTo(statelistfile,","); fi;
  od;
  AppendTo(statelistfile,"];\n");
  return result;
end);

#For the graphviz part. 
InstallGlobalFunction(PetriNet2GraphViz, 
  function(petrinet, filename)
  local i,j;
  PrintTo(filename,"digraph PetriNet{\n");
  for i in [1..Size(petrinet.inputs)] do
    AppendTo(filename, Concatenation("p", StringPrint(i),"_",
            StringPrint(petrinet.capacity[i]),"\n"));
  od;
  for j in [1..Size(petrinet.outputs)] do
    AppendTo(filename, Concatenation("t", StringPrint(j),
            " [shape=box,style=filled,color=\"black\",fontcolor=\"white\"]\n"));
  od;

  for i in [1..Size(petrinet.inputs)] do
      for j in [1..Size(petrinet.outputs)] do 
          if (not (petrinet.inputs[i][j] = 0)) then
            AppendTo(filename,Concatenation("p",StringPrint(i),"_",
                    StringPrint(petrinet.capacity[i])," -> ", "t",StringPrint(j),
                    " [label=",StringPrint(petrinet.inputs[i][j]),"]\n"));
	  fi;
	  #inhibitory connections
          if (not (petrinet.inhibcons[i][j] = 0)) then
            AppendTo(filename,Concatenation("p",StringPrint(i),"_",
                    StringPrint(petrinet.capacity[i])," -> ", "t",
                    StringPrint(j)," [arrowhead=dot,label=\"",
                    StringPrint(petrinet.inhibcons[i][j]),"\"]\n"));
	  fi;
          if (not (petrinet.outputs[j][i] = 0)) then
            AppendTo(filename,Concatenation("t",StringPrint(j)," -> ", "p",
                    StringPrint(i),"_",StringPrint(petrinet.capacity[i]),
                    " [label=",StringPrint(petrinet.outputs[j][i]),"]\n"));
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

#For the graphviz part with Names
InstallGlobalFunction(PetriNet2GraphVizWithNames, 
  function(petrinet, filename, places, transitions)
  local i,j;
  PrintTo(filename,"digraph PetriNet{\n");
  for i in [1..Size(petrinet.inputs)] do
    AppendTo(filename, Concatenation(places[i],"_",
            StringPrint(petrinet.capacity[i]),"\n"));
  od;
  for j in [1..Size(petrinet.outputs)] do
    AppendTo(filename, Concatenation(transitions[j],
            " [shape=box,style=filled,color=\"black\",fontcolor=\"white\"]\n"));
  od;

  for i in [1..Size(petrinet.inputs)] do
      for j in [1..Size(petrinet.outputs)] do 
          if (not (petrinet.inputs[i][j] = 0)) then
            AppendTo(filename,Concatenation(places[i],"_",
                    StringPrint(petrinet.capacity[i])," -> ", transitions[j],
                    " [label=",StringPrint(petrinet.inputs[i][j]),"]\n"));
	  fi;
	  #inhibitory connections
          if (not (petrinet.inhibcons[i][j] = 0)) then
            AppendTo(filename,Concatenation(places[i],"_",
                    StringPrint(petrinet.capacity[i])," -> ",
                    transitions[j]," [arrowhead=dot,label=\"",
                    StringPrint(petrinet.inhibcons[i][j]),"\"]\n"));
	  fi;
          if (not (petrinet.outputs[j][i] = 0)) then
            AppendTo(filename,Concatenation(transitions[j]," -> ", 
                    places[i],"_",StringPrint(petrinet.capacity[i]),
                    " [label=",StringPrint(petrinet.outputs[j][i]),"]\n"));
	  fi;
      od;
  od;
  AppendTo(filename,"}\n");
end);



#lookup table for state names
InstallGlobalFunction(LookupTable4PetriNetMarkings,
function(petrinet,ispartial)
  local i, state, namelookup, maxstate;
    
  maxstate := Size(petrinet.states);
  namelookup := AssociativeList();#NewDictionary("1", true);
  for i in [1..maxstate] do
    state := petrinet.states[i];
    Assign(namelookup,StringPrint(i), ListAsDenseString(state));
  od;
  if (ispartial) then 
    Assign(namelookup,StringPrint(maxstate+1), "P");
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
