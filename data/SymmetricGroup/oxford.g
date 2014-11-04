#simple 1-parameter family of Petri nets realizing symmetric groups
# symmetric group component arising from  inhibitory connections,
# partial  (getting the idea while fiddling in Oxford...)
OxfordPetriNet := function(capacity)
  local petrinet,tmp;
  petrinet := rec();
  #inputs
  tmp := List([1..capacity], x->0);
  tmp[1] := 1;
  petrinet.inputs := [tmp]; #[1,0,0,...,0]
  #outputs
  tmp := List([1..capacity], x->[x]);
  tmp[1][1] := 0;
  petrinet.outputs := tmp; #[[0],[2],[3],...,[capacity]]
  #inhibitory connections
  tmp := List([1..capacity], x->1);
  tmp[1] := 0;
  petrinet.inhibcons := [tmp]; #[0,1,1,...,1]
  #capacity
  petrinet.capacity:= [capacity];
  #initial markings
  petrinet.initial := [];  
  return petrinet;
end;
