# using primes only, does not produce symmetric groups , partial 
petrinet := rec(
inputs:= [[1,0,0,0]],
          
outputs := [[0],[2],[3],[5]],

inhibcons := [[0,1,1,1]],
capacity:= [5],
initial := []
);
DumpPetriNet(petrinet,"primesC5P",StrictFiringPreCondition,MaxAllowedFiringPostCondition,true);
