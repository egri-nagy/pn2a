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
  return slist[1] + slist[2] + 2 * slist[3] + slist[4] + slist[5] = 6;
end,

places := ["A","B","C","E","X"],  #comment out to get marking vectors as state names
transitions := ["T1", "T2", "T3", "T4", "T5", "T6"],

#initial := [[2,1,2,1,1]]  #2 A, B, 2 C, E, X invariant 9= 2+1+4+1+1
#initial := [[0,1,2,1,1]]  #0 A, B, 2 C, E, 0 X invariant 7= 0+1+4+1+1
#initial := [[0,1,1,1,1],[2,3,0,0,0]] # X invariant 5= 0+1+2+1+1
#initial := [[2,2,0,0,0],[0,0,2,0,0],[1,1,0,1,1]] # invariant 4
#initial := [[0,0,3,0,0]] # invariant 6
# initial := [[2,1,0,0,0], [2,0,2,0,0]]
#initial := [[0,0,0,1,6]] 
initial := []
);

P_clear := ShallowCopy(petrinet);

petrigens := DumpPetriNet(petrinet,"Edelstein",StrictFiringPreCondition,MaxAllowedFiringPostCondition,false);

#SetInfoLevel(SkeletonInfoClass,2);
#SetInfoLevel(HolonomyInfoClass,2);

S := Semigroup(petrigens); #semigroup
#Idempotents(S);
#sk := Skeleton(S);
#DisplayHolonomyComponents(sk);
#SplashList(DotNaturalSubsystems(sk));

#d := DotSubductionEquivalencePoset(sk); Splash(d);

# Produce diagram of automata
Splash(DotSemigroupActionWithNames(S,[1..Size(petrinet.states)],OnPoints, petrinet.statenames,petrinet.transitions));

# Function that computes the average tokens per place for a set of markings
AverageTokens := function(markings)
  if Size(markings) = 0 then
    return [];
  else
    return Float(Iterated(markings, \+) / Size(markings));
  fi;
end;

StateName := function(set,index)
   if set[index] then return  Concatenation(SgpDecStateNames[index],","); 
   else return "";
   fi;
end; 

StateSetName := function(set)
return Concatenation(List([1..Size(BaseSet(skP))],i-> StateName(set,i)));
end;


Print("Average Tokens for All Markings:\n", AverageTokens(petrinet.states));
Print("\nComponents:", Size(petrinet.components),"\n");
# Average markings per component
Print("Average Markings per Component:\n");
for component in petrinet.components do
  Print(AverageTokens(component)," average for component of size ",Size(component),":\n");
  Print(component); Print("\n");
  if Size(component) < 2 then continue; fi;  
    P := ShallowCopy(P_clear);
    P.initial := [ component[1] ];
    Pgens := DumpPetriNet(P,"Edelstein",StrictFiringPreCondition,MaxAllowedFiringPostCondition,false);
    Semi_P := Semigroup(Pgens);
    skP := Skeleton(Semi_P);


#Concatenation(List([1..Size(BaseSet(skP))],i-> StateName(x1,i))); 

SgpDecTransitionNames := P.transitions; 
SgpDecStateNames := P.statenames;
#Print("Set Names\n");
Print("\n",SgpDecStateNames[1],"\n");
#Print(SgpDecTransitionNames[1],"\n");

#if not IsBound(SgpDecTransitionNames) then SgpDecTransitionNames := []; fi;
    DisplayHolonomyComponents(skP);

for dx in [1..DepthOfSkeleton(skP)-1] do
   for  x1 in RepresentativeSetsOnDepth(skP,dx) do
     px1 := PermutatorGroup(skP,x1);
     hx1 := HolonomyGroup@SgpDec(skP,x1); 
     if IsTrivial(px1)  then
         Print("");
       else Print("\n");
            Print("Subduction Class Size ", Size(SubductionClassOfSet(skP,x1)), " taking rep\n");
            Print("Edges from ", StateSetName(x1),"  with permutator group ", StructureDescription(px1)," = ",  px1, " : \n");
            Print("  and holonomy group ", StructureDescription(hx1)," = ",  hx1, " : \n");
            Print("Permutator Generator Words :\n");
              W := NontrivialRoundTripWords(skP,x1);
               for w in W do #print the permutator generator words using named transitions
                  Print(Concatenation(List(w,x->SgpDecTransitionNames[x]))," : ");
                  trans := EvalWordInSkeleton(skP,w);
                  Print(LinearNotation(trans), ", where");
                   for index in [1..Size(BaseSet(skP))] do
                     if (x1[index]) then  Print(" ",index ," is ", SgpDecStateNames[index],"." ); fi;
                    od; 
              Print("\n");
             od;
             Print("\n");
               for dy in [dx+1..DepthOfSkeleton(skP)-1] do
                for Y in RepresentativeSetsOnDepth(skP,dy) do
                 pY:=PermutatorGroup(skP,Y);
           if IsTrivial(pY) then
               Print("");
            else
             wcw := WeakControlWords(skP,x1,Y);
             if not wcw = fail then 
              Print(StateSetName(x1), " down to ", StateSetName(Y), " with permutator group ", StructureDescription(pY)," = ", pY, " : \n");
              Print("via  Weak Control Words: ", Concatenation(List(wcw[1],x->SgpDecTransitionNames[x])), " , ", Concatenation(List(wcw[2],x->SgpDecTransitionNames[x])),"\n\n");
             fi;
           fi;
        od;
     od;
   fi;
  od;
od;



d := DotSubductionEquivalencePoset(skP, rec(states := P.statenames)); Splash(d);

# Produce diagram of automata for component
#d := DotSemigroupActionWithNames(Semi_P,[1..Size(P.states)],OnPoints, P.statenames,P.transitions);
#Splash(d);


    SplashList(DotNaturalSubsystems(skP, rec(states := P.statenames)));
    dot_P := DotSkeleton(skP,rec(states  := P.statenames));
    Splash(dot_P);
od;
