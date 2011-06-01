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

SetInfoLevel(SkeletonInfoClass,2);
SetInfoLevel(HolonomyInfoClass,2);

S := Semigroup(K1mingens);
hd := HolonomyDecomposition(S);
