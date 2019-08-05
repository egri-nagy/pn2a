#############################################################################
##
#W  petri-net.gd           SgpDec         Attila Egri-Nagy
##
##  Functions for enumerating the states of the petri net. Two methods: the full state set, or the reachable states if some initial markings are given.
##

#This should be the only function used outside this module.
DeclareGlobalFunction("CalculateStatesOfPetriNet");

DeclareGlobalFunction("NextPetriNetStateInOrder");

DeclareGlobalFunction("GetNumberOfStatesOfPetriNets");

DeclareGlobalFunction("GetComponentsOfPetriNetStates");



#enumerating markings of a petri net
DeclareGlobalFunction("AllGlobalMarkingsOfPetriNet");
DeclareGlobalFunction("ReachableMarkingsOfPetriNet");


