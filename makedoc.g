Pn2aDocSourceFiles := ["../PackageInfo.g"];
MakeReadOnlyGVar("Pn2aDocSourceFiles");

Pn2aMakeDoc := function()
  MakeGAPDocDoc(
    Concatenation(PackageInfo("pn2a")[1]!.InstallationPath,"/doc"),
    "main.xml",
    Pn2aDocSourceFiles,
    "pn2a",
    "MathJax",
    "../../..");
end;
