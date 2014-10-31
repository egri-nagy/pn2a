###############################################FIRING CONDITIONS####################################################################

##  <#GAPDoc Label="StrictFiringPreCondition">
##  <ManSection >
##  <Func Arg="petrinet, transition, state" Name="StrictFiringPreCondition" />
##  <Description>
##  The strictest possible condition: there should be enough tokens available. This is sort of the only sensible pre-condition.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction(StrictFiringPreCondition, 
function(petrinet, transition, state)
#  local result,i;
#  result := List([1..Size(state)], i -> 0);
#  for i in [1..Size(state)] do
#    result[i] := state[i] - petrinet.inputs[i][transition];
#Print(result);
#      if (result[i] < 0) then return [];fi;
#  od;
#  return result;
  return ForAll([1..Size(state)], x-> (state[x]-petrinet.inputs[x][transition]) >= 0);  
end);

##  <#GAPDoc Label="StrictFiringPostCondition">
##  <ManSection >
##  <Func Arg="petrinet, transition, state" Name="StrictFiringPostCondition" />
##  <Description>
##  The strictest possible condition: there should be enough spaces available at the destination places, No overflow is allowed. That is whay we need the extra parameter of capacity. 
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction(StrictFiringPostCondition, 
  function(petrinet, transition, state)
#  local result,i;
#  result := List([1..Size(state)], i -> 0);
#  for i in [1..Size(state)] do
#      result[i] := state[i] + petrinet.outputs[transition][i];
#      if (result[i] > petrinet.capacity[i]) then return false;fi;
#  od;
  return ForAll([1..Size(state)],
                x->(state[x]+petrinet.outputs[transition][x])
                    <= petrinet.capacity[x]);
end);

##  <#GAPDoc Label="MaxAllowedFiringPostCondition">
##  <ManSection >
##  <Func Arg="petrinet, transition, state" Name="MaxAllowedFiringPostCondition" />
##  <Description>
##  Overflow of tokens are allowed at places after a transition. Basically it is always firable.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction(MaxAllowedFiringPostCondition, 
function(petrinet, transition, state)
#  local result,i;
#  result := List([1..Size(state)], i -> 0);
#  for i in [1..Size(state)] do
#      result[i] := state[i] + petrinet.outputs[transition][i];
#      if (result[i] > petrinet.capacity[i]) then result[i] := petrinet.capacity[i];fi;
#  od;
#Print(result);
  return true;
end);

