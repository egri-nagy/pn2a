##  <#GAPDoc Label="PKGVERSIONDATA">
##  <!ENTITY VERSION "0.2.4">
##  <#/GAPDoc>

SetPackageInfo( rec(

PackageName := "pn2a",

Subtitle := "Petri Net to Automaton Converter",

Version := "0.2.5",

Date := "09/03/2023",

ArchiveURL := "https://github.com/egri-nagy/pn2a",

ArchiveFormats := ".tar.gz",

Persons := [
  rec(
    LastName      := "Egri-Nagy",
    FirstNames    := "Attila",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "attila@egri-nagy.hu",
    WWWHome       := "http://www.egri-nagy.hu",
    PostalAddress := Concatenation( [
                       "University of Hertfordshire\n",
                       "STRI\n",
                       "College Lane\n",
                       "AL10 9AB\n",
                       "United Kingdom" ] ),
    Place         := "Hatfield, Herts",
    Institution   := "UH"
  ),
  rec( 
    LastName      := "Nehaniv",
    FirstNames    := "Chrystopher L.",
    IsAuthor      := true,
    IsMaintainer  := true,
    Email         := "chrystopher.nehaniv@uwaterloo.ca",
    WWWHome       := "https://uwaterloo.ca/systems-design-engineering/profile/cnehaniv",
    PostalAddress := Concatenation( [
                       "Waterloo Algebraic Intelligence and Computation Lab\n",
                       "Systems Design Engineering Dept.\n",
                       "University of Waterloo\n",
                       "200 University Avenue West\n",
                       "Waterloo, Ontario N2L 3G1, Canada\n" ] ),
    Place         := "Waterloo, Ontario",
    Institution   := "UW"
  )
],

Status := "dev",

README_URL := "https://github.com/egri-nagy/pn2a",

PackageInfoURL := "https://github.com/egri-nagy/pn2a",


AbstractHTML := 
  "<span class=\"pkgname\">pn2a</span> is  a <span class=\"pkgname\">GAP</span> package \
   for converting Petri nets to transformation semigroups.",

PackageWWWHome := "https://github.com/egri-nagy/pn2a",

PackageDoc := rec(
  BookName  := "pn2a",
  Archive :=  "https://github.com/egri-nagy/pn2a",

  ArchiveURLSubset := ["htm"],
  HTMLStart := "doc/manual.htm",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Converting Petri Nets to Transformation Semigroups",
  Autoload  := true
),


Dependencies := rec(
 GAP := ">=4.7",
 NeededOtherPackages := [],
 SuggestedOtherPackages := [["SgpDec", ">= 0.7.29"]],
 ExternalConditions := [["Graphviz","http://www.graphviz.org/"]] #for creating PDF figures                      
),

AvailabilityTest := ReturnTrue,

Autoload := false,

TestFile := "test/test.g",

Keywords := ["Petri Net","automaton","transformation semigroup","discrete event dynamical system"]

));


