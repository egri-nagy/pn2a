Read("parrondored.g");
ag := ActionGraph(FiniteSet([1..27]),petrigens);  
PrintTo("search27","");
AppendTo("search27",PermutatorGroup(NodesOf(ag)[34]!.point,petrigens)); 
