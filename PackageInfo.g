SetPackageInfo( rec(

PackageName := "pn2a",

Subtitle := "Petri Net to Automaton Converter",

Version := "0.2",

Date := "31/10/2014",

ArchiveURL := "http://pn2a.sf.net",

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
    LastName      := "L. Nehaniv",
    FirstNames    := "Chrystopher",
    IsAuthor      := true,
    IsMaintainer  := false,
    Email         := "C.L.Nehaniv@herts.ac.uk",
    WWWHome       := "http://homepages.feis.herts.ac.uk/~comqcln/",
    PostalAddress := Concatenation( [
                       "University of Hertfordshire\n",
                       "STRI\n",
                       "College Lane\n",
                       "AL10 9AB\n",
                       "United Kingdom" ] ),
    Place         := "Hatfield, Herts",
    Institution   := "UH"
  )
],

Status := "dev",

README_URL := "http://pn2a.sf.net",

PackageInfoURL := "http://pn2a.sf.net",


AbstractHTML := 
  "<span class=\"pkgname\">pn2a</span> is  a <span class=\"pkgname\">GAP</span> package \
   for converting Petri nets to transformation semigroups.",

PackageWWWHome := "http://pn2a.sf.net",

PackageDoc := rec(
  BookName  := "pn2a",
  Archive :=  "http://pn2a.sf.net",

  ArchiveURLSubset := ["htm"],
  HTMLStart := "doc/manual.htm",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "Converting Petri Nets to Transformation Semigroups",
  Autoload  := true
),


Dependencies := rec(
 GAP := ">=4.7",
 NeededOtherPackages := [["dust", ">= 0.1"] ],
 #                        ["MONOID", ">= 1.3.1"], #orbit algorithms
 #                        ["orb", ">= 3.4"] #hashtable functionalities
 #                        ],
 SuggestedOtherPackages := [ ],
 ExternalConditions := [["Graphviz","http://www.graphviz.org/"]] #for creating PDF figures                      
),

AvailabilityTest := ReturnTrue,

Autoload := false,

TestFile := "test/test.g",

Keywords := ["Petri Net","automaton","transformation semigroup"]

));


