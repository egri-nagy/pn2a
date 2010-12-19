#############################################################################
##
#W  petri-net.gd           SgpDec         Attila Egri-Nagy
##
##  Pre and post conditions for transitions. They are actually executing the transition, then they check whether the result is within the boundaries. So they can be used for firing transitions.
##


#Pre and post conditions
DeclareGlobalFunction("StrictFiringPreCondition");
DeclareGlobalFunction("StrictFiringPostCondition");
DeclareGlobalFunction("MaxAllowedFiringPostCondition");


