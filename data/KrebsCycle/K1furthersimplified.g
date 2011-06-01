# nice example of a group component arising from an inhibitory connection (getting the idea while listening to haydn, I guess...)
petrinet := rec(
inputs:= [
[1,0,0,0,0,0,0,0,0],
[0,1,0,0,0,0,0,0,0],
[0,0,1,0,0,0,0,0,0],
[0,0,0,1,0,0,0,0,0],

[0,0,0,0,0,1,0,0,0],
[0,0,0,0,0,0,1,0,0],
[0,0,0,0,0,0,0,1,0],

[1,0,0,1,0,1,0,0,0],
[1,1,0,1,0,0,1,0,0],
],
          
outputs := [
[0,1,0,0,0,0,0,0,0],
[0,0,1,0,0,0,0,0,0],
[0,0,0,1,0,0,0,0,0],
[0,0,0,0,1,0,0,0,0],

[0,0,0,0,0,0,1,0,0],
[0,0,0,0,0,0,0,1,0],
[0,0,1,0,0,0,0,0,0],

[0,0,0,0,0,0,0,1,0],
[0,0,0,0,0,0,0,0,1],
],

inhibcons := [
[0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0],

[0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0],

[0,0,0,0,0,0,0,0,0],
[0,0,0,0,0,0,0,0,0],
],
capacity:= [1,1,1,1,1,1,1,1,1],
initial := [[1,0,0,0,0,0,0,0,0]]
);


petrigens := DumpPetriNet(petrinet,"K1fs",StrictFiringPreCondition,MaxAllowedFiringPostCondition,false);

SetInfoLevel(SkeletonInfoClass,2);
SetInfoLevel(HolonomyInfoClass,2);

S := Semigroup(petrigens);
hd := HolonomyDecomposition(S);
