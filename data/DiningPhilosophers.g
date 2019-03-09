# Dining Philosophers by Chrystopher L. Nehaniv, University of Hertfordshire
#  27 November 2010    
#  updated 8 March 2019
#
#  5 places: the philosophers P1 P2 P3 P4 P5 which can each have two chopsticks
#  they are eating if and only they have two, otherwise they are starving/thinking
#  5 places each with at most one chopstick between them
#   C1 C2 C3 C4 C5
#  arranges as C5 P1 C1 P2 C2 P3 C3 P4 C4 P5 C5 (circularly)
#
#  transitions t_i or D_i ("drop"):  Pi drops chopstick to C(i-1) and Ci
#              t_i+5 or T_i ("take"):  C(i-1) and Ci chopsticks go to Pi 
#
petrinet := rec(
inputs:= [ 
          [1,0,0,0,0,0,0,0,0,0],  #p1
          [0,1,0,0,0,0,0,0,0,0],  #p2
          [0,0,1,0,0,0,0,0,0,0],  #p3
          [0,0,0,1,0,0,0,0,0,0],  #p4
          [0,0,0,0,1,0,0,0,0,0],  #p5
          [0,0,0,0,0,1,1,0,0,0],  #c1
          [0,0,0,0,0,0,1,1,0,0],  #c2
          [0,0,0,0,0,0,0,1,1,0],  #c3
          [0,0,0,0,0,0,0,0,1,1],  #c4
          [0,0,0,0,0,1,0,0,0,1]   #c5
          ],

          
outputs := [
            [0,0,0,0,0,1,0,0,0,1], # of t1
            [0,0,0,0,0,1,1,0,0,0], # of t2
            [0,0,0,0,0,0,1,1,0,0], # of t3
            [0,0,0,0,0,0,0,1,1,0], # of t4
            [0,0,0,0,0,0,0,0,1,1], # of t5
            [1,0,0,0,0,0,0,0,0,0], # of t1+5
            [0,1,0,0,0,0,0,0,0,0], # of t2+5
            [0,0,1,0,0,0,0,0,0,0], # of t3+5
            [0,0,0,1,0,0,0,0,0,0], # of t4+5
            [0,0,0,0,1,0,0,0,0,0] # of t5+5
            ],
# NB: a single token at Pi represents the two chopsticks being used to eat by Pi

inhibcons :=  [                   # no inhibition
          [0,0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,0,0,0,0,0],
          [0,0,0,0,0,0,0,0,0,0]
          ],



capacity:=  [1,1,1,1,1,1,1,1,1,1],
initial := [[0,0,0,0,0,1,1,1,1,1]]
, # initial state: 5 chopsticks, no one eating
places:= ["P1","P2","P3","P4","P5","C1","C2","C3","C4","C5"],
transitions := ["D1", "D2", "D3", "D4", "D5", "T1", "T2", "T3", "T4", "T5"]
); #Di = philosopher i drops 2 chop sticks, Ci = Philosopher i takes 2 chopsticks
petrigens := DumpPetriNet(petrinet,"DiningPhilosophers",StrictFiringPreCondition,MaxAllowedFiringPostCondition,false);


DP := Semigroup(petrigens);
hd := HolonomyDecomposition(DP);


#DPstates :=["0000011111", "000001110", "0100000111", "0010010011", "0001011001", "0000111100", "1010000010", "1001001000", "0101000001", "0100100100", "0010110000"];
#0000011111 - 0
#0000111100  P5
#0001011001  P4
#0010010011  P3
#0010110000  P3 P5
#0100000111  P2
#0100100100  P2 P5
#0101000001  P2 P4
#1000001110  P1
#1001001000  P1 P4
#1010000010  P1 P3
DPstates :=["0", "P5", "P4", "P3", "P3 P5", "P2", "P2 P5", "P2 P4", "P1", "P1 P4", "P1 P3"]; # state shows who is eating
if IsBound(petrinet.transitions) then
 DPsymbols := petrinet.transitions;
  else
DPsymbols := ["D1", "D2", "D3", "D4", "D5", "T1", "T2", "T3", "T4", "T5"];
fi;

skel_DP := Skeleton(DP);
dot := DotSkeleton(skel_DP,rec(states:= DPstates,symbols:=DPsymbols));
Splash(dot);   

d:=DotSemigroupActionWithNames(DP,[1..11],OnPoints,DPstates,DPsymbols);  
Splash(d);

DisplayHolonomyComponents(skel_DP);

DPhd :=HolonomyCascadeSemigroup(DP);  

Size(DPhd);

# old command: Splash(hd,rec(statesymbols := DPstates));

#SaveWorkspace("DiningPhilosophers.ws");
