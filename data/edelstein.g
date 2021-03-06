#  Edelstein Petrinet by Catherine St-Pierre and Chrystopher L. Nehaniv
#  University of Waterloo
#  March 2019
#
# Abstract chemical system with multistabilty and hystereis
# Petri net derived from model in Barry B. Edelstein, "Biochemical model with multiple steady states and hysteresis",
# Journal of Theoretical Biology (1970), 29:57-62.
#
#  A + X -> 2X
#  X + E -> C
#  C -> X + E
#  2X -> A +X
#  C -> E + B
#  E + B -> C
#
#  The value of #A + #B + 2* #C + #E + #X is preserved under all transitions

LoadPackage("pn2a");

petrinet := rec(
inputs:= [  [1,0,0,0,0,0],  # A
            [0,0,0,0,0,1],  # B
            [0,0,1,0,1,0],  # C
            [0,1,0,0,0,1],  # E
            [1,1,0,2,0,0]], # X
         

outputs := [[0,0,0,0,2], # 2X output in t1
            [0,0,1,0,0], # C output of t2
            [0,0,0,1,1], # E and X output of t3
            [1,0,0,0,1], # A and X output of t4
            [0,1,0,1,0], # B and E output t5
            [0,0,1,0,0]  # C output of t6
                       ],

inhibcons := [[0,0,0,0,0,0],
              [0,0,0,0,0,0],
              [0,0,0,0,0,0],
              [0,0,0,0,0,0],
              [0,0,0,0,0,0]],

capacity := [10,10,5,10,10],

# This will generate all markings with invariant value 3
condition := function(slist)
  return slist[1] + slist[2] + 2 * slist[3] + slist[4] + slist[5] = 3;
end,

places := ["A","B","C","E","X"],  #comment out to get marking vectors as state names
transitions := ["T1", "T2", "T3", "T4", "T5", "T6"],

#initial := [[2,1,2,1,1]]  #2 A, B, 2 C, E, X invariant 9= 2+1+4+1+1
#initial := [[0,1,2,1,1]]  #0 A, B, 2 C, E, 0 X invariant 7= 0+1+4+1+1
#initial := [[0,1,1,1,1],[2,3,0,0,0]] # X invariant 5= 0+1+2+1+1
#initial := [[2,2,0,0,0],[0,0,2,0,0],[1,1,0,1,1]] # invariant 4
#initial := [[0,0,3,0,0]] # invariant 6
# initial := [[2,1,0,0,0], [2,0,2,0,0]]
initial := []
);

petrigens := DumpPetriNet(petrinet,"Edelstein",StrictFiringPreCondition,MaxAllowedFiringPostCondition,false);

SetInfoLevel(SkeletonInfoClass,2);
SetInfoLevel(HolonomyInfoClass,2);

S := Semigroup(petrigens); #semigroup
#Idempotents(S);
sk := Skeleton(S);
DisplayHolonomyComponents(sk);
SplashList(DotNaturalSubsystems(sk));

d := DotSubductionEquivalencePoset(sk); Splash(d);

# Produce diagram of automata
d := DotSemigroupActionWithNames(S,[1..Size(petrinet.states)],OnPoints,
                                 petrinet.statenames,petrinet.transitions);  
Splash(d);

# Function that computes the average tokens per place for a set of markings
AverageTokens := function(markings)
  if Size(markings) = 0 then
    return [];
  else
    return Float(Iterated(markings, \+) / Size(markings));
  fi;
end;

# Average markings per component
for component in petrinet.components do
  Print(AverageTokens(component));
od;
