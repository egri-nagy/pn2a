# Minimized model of the Krebs cycle (in respect to two coenzymes NAD and Coash)
petrinet := rec(
inputs:= [
[1,0,0,0,0,0,0],
[0,1,0,0,0,0,0],
[0,0,1,0,0,0,0],
[0,0,0,1,0,0,0],
[0,0,0,0,1,0,0],

[1,0,1,1,0,0,0],
[1,1,1,0,1,0,0],

],
          
outputs := [
[0,1,0,0,0,0,0],
[0,0,1,0,0,0,0],
[0,0,0,1,0,0,0],
[0,0,0,0,1,0,0],
[0,0,1,0,0,0,0],

[0,0,0,0,0,1,0],
[0,0,0,0,0,0,1],
],

inhibcons := [
[0,0,0,0,0,0,0],
[0,0,0,0,0,0,0],
[0,0,0,0,0,0,0],
[0,0,0,0,0,0,0],

[0,0,0,0,0,0,0],
[0,0,0,0,0,0,0],
[0,0,0,0,0,0,0],
[0,0,0,0,0,0,0],

],
capacity:= [1,1,1,1,1,1,1],
initial := [[1,0,0,0,0,0,0]]
);
K1mingens := DumpPetriNet(petrinet,"K1min",StrictFiringPreCondition,MaxAllowedFiringPostCondition,false);
K1mingens;

for i in [1..Size(K1mingens)]do
    rgens := ReduceByIdempotent(K1mingens,i);
    filename := "K1min";
    filename := Concatenation(filename, StringPrint(i));
    filename := Concatenation(filename, ".gens");
    WriteStringToFile(filename,AsJGRASPGenerators(rgens));
od;
