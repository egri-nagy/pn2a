#############################################################################
##
#W  io.gi           GAP library         Attila Egri-Nagy
##
#H  @(#)$Id: io.gi,v 1.5 2003/06/10 11:23:08 sirna Exp $
##
#Y  Copyright (C)  2003, Attila Egri-Nagy, Chrystopher L. Nehaniv
#Y  University of Hertfordshire, Hatfield, UK
##
##  I/O code for reading and writing automata from and to textfiles
##  and formatted display
##


##  <#GAPDoc Label="WriteStringToFile">
##  <ManSection>
##  <Func Arg="filename,string" Name="WriteStringToFile" />
##  <Description>
##  Writes a string to a file (overwriting the previous content.
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
InstallGlobalFunction("WriteStringToFile", 
  function(filename, string)
  local file;

  file := OutputTextFile(filename, false);
  SetPrintFormattingStatus(file,false);
  PrintTo(file,string);
  CloseStream(file);
end);

