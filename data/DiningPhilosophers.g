# Dining Philosophers by Chrystopher L. Nehaniv, University of Hertfordshire
#  27 November 2010 
#
#  5 places: the philosophers P1 P2 P3 P4 P5 which can each have two chopsticks
#  they are eating if and only they have two, otherwise they are starving/thinking
#  5 places each with at most one chopstick between them
#   C1 C2 C3 C4 C5
#  arranges as C5 P1 C1 P2 C2 P3 C3 P4 C4 P5 C5 (circularly)
#
#  transitions t_i:  Pi drops chopstick to C(i-1) and Ci
#              t_i+5:  C(i-1) and Ci chopsticks go to Pi 
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
initial := [[0,0,0,0,0,1,1,1,1,1]] # initial state: 5 chopsticks, no one eating
);
petrigens := DumpPetriNet(petrinet,"DiningPhilosophers",StrictFiringPreCondition,MaxAllowedFiringPostCondition,false);

SetInfoLevel(SkeletonInfoClass,2);
SetInfoLevel(HolonomyInfoClass,2);

DP := Semigroup(petrigens);
hd := HolonomyDecomposition(DP);


#DPstates :=["0000011111", "1000001110", "0100000111", "0010010011", "0001011001", "0000111100", "1010000010", "1001001000", "0101000001", "0100100100", "0010110000"];
DPstates :=["0", "1", "2", "3", "4", "5", "13", "14", "24", "25", "35"]; # state shows who is eating

Splash(hd,rec(statesymbols := DPstates));

#SaveWorkspace("DiningPhilosophers.ws");
