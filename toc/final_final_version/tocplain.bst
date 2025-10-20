% BibTeX bibliography style `tocplain.bst'
% For Theory of Computing Journal publishing

% Version 0.31
%%% NOTE: .bbl file uses latex macros in eprint.sty package

% History
%% Alex   01-17-2012 Changed layout of PhD --> Ph.\,D.\ 
%% Alex   09-09-2010 Removed the period after eprint entries. This involved a change to the function fin.entry.
%% Alex   03-01-2010 Changed "book" entry so that volume data is separated from book title with a period, rather than comma. This changes capitalization of "Volume" in this case.
%%   Version >>> 0.28
%% Alex	  01-10-07
%%   Added the word "smallcaps" to line 305. Version >>> 0.27
%% Alex   09-26-06
%%   I removed the characters "AA," in the code applied when
%%   both eprint and doi entries are nonempty.
%% Murali 10-18-05 18:18 CST
%%   Fixed a bug which is exposed sometimes when DOI 
%%   alone is used. Bibtex distinguished between missing
%%   and empty entries but the eprint code does not.
%%   Added additional variables "doistr" and "eprintstr"
%%   which will be equal to doi and eprint fields, except
%%   when missing they will be empty string.
%% Murali 03-23-05 14:00 CST
%%   The definition of \bibhead uses \providecommand
%%   Now added a PDFBookmark to the bibliography section
%% Murali 03-03-05 13:30 CST
%%   Now archive gets converted to lower case. So 
%%   eprint = {ToC:566/565} is equivalent to eprint={toc:566/565}
%% Murali 02-25-05 14:00 CST
%%   Added "[" and "]" around the doi and eprint entries
%% Murali 02-24-05 20:00 CST
%%   Added DOI field. Works just like eprint but only one DOI per entry
%%   and link goes to dx.doi.org with text DOI
%% Murali 02-20-05 14:00 CST
%%   Simplify format.eprint.single code using splitter
%%   No need for check.eprint.id and get.eprint.id FUNCTIONS
%% Murali 02-19-05 16:00 CST
%%   format.eprint now works for arbitrary number of entries
%%   ensure code does not depend on other fields.
%%     remove it for ccc:. New format for ccc = ccc:year/number
%%   Replaced urlprefixes in Bibtex code with latex macros. This reduces 
%%   the length of \href command, so linebreaks will be less of a problem.
%%   Modified make.href function: "\href {" -> "\href{". Absence of 
%%   space ensures bibtex doesn't break lines there.
%% Murali 02-18-05 18:00 CST
%%   Added support for "ccc"
%% Murali 02-18-05 17:50 CST
%%   Added support for upto two eprint archives,
%%   e.g. eprint = {toc:dsa, eccc:454}
%% Murali 02-17-05 21:00 CST
%%   Remove url and lastchecked support
%%   Simplified code and hardwired choices made
%%   Removed bracket state related code since we dont support url & lastchecked
%% Murali 02-17-05 20:00 CST
%%   Added support for "toc","eccc","sicomp","acm","aps" archives
%%   Removed strings usage (BibTeX has a limit of 20)
%% Murali 02-11-05 16:30 CST:
%%   Run urlbst.pl script on tocplain to obtain support for url, eprint, lastchecked fields
%%   Renamed variables used in eprint code (added a suffix arxiv), since by default
%%   code handles only arxiv references.
%%   Now we expect eprint to be of the format "archive:identifier"
%%   instead of just identifier. If "archive:" is missing then assumed to be arxiv.
%%   This retains compatibility with previous format.
%% Murali 02-01-05:
%%   copy plain.bst to tocplain.bst
%%   Modify code to ensure Author name came in Smallcaps
%%   Modify code to ensure authors were followed by a ":" instead of "."

ENTRY
  { address
    author
    booktitle
    chapter
    edition
    editor
    howpublished
    institution
    journal
    key
    month
    note
    number
    organization
    pages
    publisher
    school
    series
    title
    type
    volume
    year
    doi % Murali
    eprint % urlbst.pl
  }
  {}
  { label }

INTEGERS { output.state before.all mid.sentence after.sentence after.block }


STRINGS { p s t doistr eprintstr }

FUNCTION {init.state.consts}
{
  #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
}


FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block =
    { add.period$ write$
      newline$
      "\newblock " write$
    }
    { output.state before.all =
        'write$
        { add.period$ " " * write$ }
      if$
    }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}

FUNCTION {output.bibitem}
{
   newline$
  "\bibitem{" write$
  cite$ write$
  "}" write$
  "\bibhead{" write$ cite$ write$ "}" write$ % Added for TOC articles
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {fin.entry}
{
  write$
  newline$
}

FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}

FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
    'skip$
    { after.sentence 'output.state := }
      if$
    }
  if$
}

FUNCTION {add.blank}
{  " " * before.all 'output.state :=
}

FUNCTION {add.colon}
{ duplicate$ empty$
    'skip$
    { ":" * add.blank }
  if$
}

FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}

FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}

FUNCTION {new.block.checka}
{ empty$
    'skip$
    'new.block
  if$
}

FUNCTION {new.block.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.block
  if$
}

FUNCTION {new.sentence.checka}
{ empty$
    'skip$
    'new.sentence
  if$
}

FUNCTION {new.sentence.checkb}
{ empty$
  swap$ empty$
  and
    'skip$
    'new.sentence
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "{\em " swap$ * "}" * }
  if$
}

FUNCTION {smallcaps}
{ duplicate$ empty$
    { pop$ "" }
    { "{\sc " swap$ * "}" * }
  if$
}

INTEGERS { nameptr namesleft numnames }

FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{ff~}{vv~}{ll}{, jj}" format.name$ 't :=
      nameptr #1 >
    { namesleft #1 >
        { ", " * t * }
        { numnames #2 >
        { "," * }
        'skip$
          if$
          t "others" =
        { " et~al." * }
        { " and " * t * }
          if$
        }
      if$
    }
    't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.authors}
{ author empty$
    { "" }
    { author format.names smallcaps }
  if$
}

FUNCTION {format.editors}
{ editor empty$
    { "" }
    { editor format.names smallcaps
      editor num.names$ #1 >
    { ", editors" * }
    { ", editor" * }
      if$
    }
  if$
}

FUNCTION {format.title}
{ title empty$
    { "" }
    { title "t" change.case$ }
  if$
}

FUNCTION {n.dashify}
{ 't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
    { t #1 #2 substring$ "--" = not
        { "--" *
          t #2 global.max$ substring$ 't :=
        }
        {   { t #1 #1 substring$ "-" = }
        { "-" *
          t #2 global.max$ substring$ 't :=
        }
          while$
        }
      if$
    }
    { t #1 #1 substring$ *
      t #2 global.max$ substring$ 't :=
    }
      if$
    }
  while$
}

FUNCTION {format.date}
{ year empty$
    { month empty$
    { "" }
    { "there's a month but no year in " cite$ * warning$
      month
    }
      if$
    }
    { month empty$
    'year
    { month " " * year * }
      if$
    }
  if$
}

FUNCTION {format.btitle}
{ title emphasize
}

FUNCTION {tie.or.space.connect}
{ duplicate$ text.length$ #3 <
    { "~" }
    { " " }
  if$
  swap$ * *
}

FUNCTION {either.or.check}
{ empty$
    'pop$
    { "can't use both " swap$ * " fields in " * cite$ * warning$ }
  if$
}

FUNCTION {format.bvolume}
{ volume empty$
    { "" }
    { "volume" volume tie.or.space.connect
      series empty$
    'skip$
    { " of " * series emphasize * }
      if$
      "volume and number" number either.or.check
    }
  if$
}

FUNCTION {format.bvolume.block}
{ volume empty$
    { "" }
    { "Volume" volume tie.or.space.connect
      series empty$
    'skip$
    { " of " * series emphasize * }
      if$
      "volume and number" number either.or.check
    }
  if$
}

FUNCTION {format.number.series}
{ volume empty$
    { number empty$
    { series field.or.null }
    { output.state mid.sentence =
        { "number" }
        { "Number" }
      if$
      number tie.or.space.connect
      series empty$
        { "there's a number but no series in " cite$ * warning$ }
        { " in " * series * }
      if$
    }
      if$
    }
    { "" }
  if$
}

FUNCTION {format.edition}
{ edition empty$
    { "" }
    { output.state mid.sentence =
    { edition "l" change.case$ " edition" * }
    { edition "t" change.case$ " edition" * }
      if$
    }
  if$
}

INTEGERS { multiresult }

FUNCTION {multi.page.check}
{ 't :=
  #0 'multiresult :=
    { multiresult not
      t empty$ not
      and
    }
    { t #1 #1 substring$
      duplicate$ "-" =
      swap$ duplicate$ "," =
      swap$ "+" =
      or or
    { #1 'multiresult := }
    { t #2 global.max$ substring$ 't := }
      if$
    }
  while$
  multiresult
}

FUNCTION {format.pages}
{ pages empty$
    { "" }
    { pages multi.page.check
    { "pp." pages n.dashify tie.or.space.connect }
    { "p." pages tie.or.space.connect }
      if$
    }
  if$
}

FUNCTION {format.vol.num.pages}
{ volume field.or.null
  number empty$
    'skip$
    { "(" number * ")" * *
      volume empty$
    { "there's a number but no volume in " cite$ * warning$ }
    'skip$
      if$
    }
  if$
  pages empty$
    'skip$
    { duplicate$ empty$
    { pop$ format.pages }
    { ":" * pages n.dashify * }
      if$
    }
  if$
}

FUNCTION {format.chapter.pages}
{ chapter empty$
    'format.pages
    { type empty$
    { "chapter" }
    { type "l" change.case$ }
      if$
      chapter tie.or.space.connect
      pages empty$
    'skip$
    { ", " * format.pages * }
      if$
    }
  if$
}

FUNCTION {format.in.ed.booktitle}
{ booktitle empty$
    { "" }
    { editor empty$
    { "In " booktitle emphasize * }
    { "In " format.editors * ", " * booktitle emphasize * }
      if$
    }
  if$
}

FUNCTION {empty.misc.check}
{ author empty$ title empty$ howpublished empty$
  month empty$ year empty$ note empty$
  and and and and and
  key empty$ not and
    { "all relevant fields are empty in " cite$ * warning$ }
    'skip$
  if$
}

FUNCTION {format.thesis.type}
{ type empty$
    'skip$
    { pop$
      type "t" change.case$
    }
  if$
}

FUNCTION {format.tr.number}
{ type empty$
    { "Technical Report" }
    'type
  if$
  number empty$
    { "t" change.case$ }
    { number tie.or.space.connect }
  if$
}

FUNCTION {format.article.crossref}
{ key empty$
    { journal empty$
    { "need key or journal for " cite$ * " to crossref " * crossref *
      warning$
      ""
    }
    { "In {\em " journal * "\/}" * }
      if$
    }
    { "In " key * }
  if$
  " \cite{" * crossref * "}" *
}

FUNCTION {format.crossref.editor}
{ editor #1 "{vv~}{ll}" format.name$
  editor num.names$ duplicate$
  #2 >
    { pop$ " et~al." * }
    { #2 <
    'skip$
    { editor #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
        { " et~al." * }
        { " and " * editor #2 "{vv~}{ll}" format.name$ * }
      if$
    }
      if$
    }
  if$
}

FUNCTION {format.book.crossref}
{ volume empty$
    { "empty volume in " cite$ * "'s crossref of " * crossref * warning$
      "In "
    }
    { "Volume" volume tie.or.space.connect
      " of " *
    }
  if$
  editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
    { series empty$
        { "need editor, key, or series for " cite$ * " to crossref " *
          crossref * warning$
          "" *
        }
        { "{\em " * series * "\/}" * }
      if$
    }
    { key * }
      if$
    }
    { format.crossref.editor * }
  if$
  " \cite{" * crossref * "}" *
}

FUNCTION {format.incoll.inproc.crossref}
{ editor empty$
  editor field.or.null author field.or.null =
  or
    { key empty$
    { booktitle empty$
        { "need editor, key, or booktitle for " cite$ * " to crossref " *
          crossref * warning$
          ""
        }
        { "In {\em " booktitle * "\/}" * }
      if$
    }
    { "In " key * }
      if$
    }
    { "In " format.crossref.editor * }
  if$
  " \cite{" * crossref * "}" *
}

% make hyperref
FUNCTION {make.href}
{
  "\href{" swap$ * "} {" * swap$ * "}" *
}

%%%%%%%%%%%%%%%%%% EPRINT CODE STARTS %%%%%%%%%%%%%%%%%%%

INTEGERS { splitter.ctr splitter.len } % Added by Murali

% For use by splitter & strip which get called all over 
STRINGS {sp ss st sq} 

% Remove initial spaces in string on top of stack
FUNCTION {strip}
{
  'sp :=
  #1 'splitter.ctr :=

  sp empty$
  { "" }
  {
    { sp splitter.ctr #1 substring$ empty$ }
    { splitter.ctr #1 + 'splitter.ctr := }
    while$
    sp splitter.ctr global.max$ substring$
  }
  if$
}

% Expects non-empty string on top of stack, and 
% DELIMITER (one char non-space string)
% Consumes both and produces two strings FIRST and REST
% FIRST is popped first
% FIRST is non-empty string: longest prefix without the DELIMITER
% REST may be empty: suffix of given string so that 
%   GIVEN STRING = FIRST DELIMITER REST
% All initial spaces in FIRST and REST are removed
FUNCTION {splitter}
{
  'sp := % STRING TO BE SPLIT
  'sq := % DELIMITER
  "" 'ss := % FIRST
  "" 'st := % REST
  sp text.length$ 'splitter.len :=
  #1 'splitter.ctr :=
  { splitter.ctr splitter.len > not }
  {
    sp splitter.ctr #1 substring$ sq =
      {
        sp #1 splitter.ctr #1 - substring$ 'ss :=
        sp #1 splitter.ctr + global.max$ substring$ 'st :=
        splitter.len #1 + 'splitter.ctr := % Force end of loop
      }
      { splitter.ctr #1 + 'splitter.ctr := }
    if$
  }
  while$
  % if ss is empty then there were no DELMITERS
  ss empty$
   { sp "" }
   { ss st }
  if$
  % Now strip can use the s* variables
  % Now REST is on top of stack, FIRST is one deeper
  % Clean both of them
  strip swap$ strip
}

% Expects the entry to be on top of stack
% consumes it and replaces with the href entry
% or remove the archive part, if it is an invalid archive
FUNCTION {format.eprint.single}
{ duplicate$ empty$
    { pop$ "" }
    {
      ":" swap$ splitter swap$
      duplicate$ empty$
      { pop$ "arxiv" swap$ } % no archive -> arxiv archive
      { }
      if$

      % At this point top of stack is identifier
      % second in stack is the archive
      swap$ "l" change.case$ 
      "\epfmt{" swap$ * "}{" * swap$ * "}" *
      % Now we have \epfmt{archive}{identifier} on top of stack
    }
  if$
}

% Handle a comma seperated list of eprint entries
FUNCTION {format.eprint}
{
  % Process the first entry
  "," eprintstr splitter format.eprint.single swap$
  % Now top of stack = 2nd and higher entries, next in stack is processed first entry
  % As long there is something to do do it
  { duplicate$ empty$ not }
  {
    swap$ 't := % previous processed answer is now in sp
    "," swap$ splitter format.eprint.single
    % if current answer is not empty add it to previous processed answers
    duplicate$ empty$ not
    { t ", " * swap$ * swap$ }
    { pop$ t swap$ }
    if$
    % Add just now processed to previous answers
  }
  while$
  pop$
}

FUNCTION {format.doi}
{
  doistr empty$ not
   { 
     "\epfmtdoi{" doistr "}" * *
   }
   { "" }
  if$
}

FUNCTION {output.web.refs}
{
  % Missing doi same as empty doi
  doi missing$
  { "" 'doistr := }
  { doi 'doistr := }
  if$

  % Missing eprint same as empty eprint
  eprint missing$
  { "" 'eprintstr := }
  { eprint 'eprintstr := }
  if$

  % Both are non-empty
  doistr empty$ eprintstr empty$ or not
  {
    "both non empty" warning$
    new.block
    "[" format.doi ", " format.eprint "]" * * * * output.nonnull
  }
  { % at least one is non-empty
    doistr empty$ eprintstr empty$ and not
    { new.block 
      "[" format.doi format.eprint "]" * * * output.nonnull 
    }
    { }
    if$
  }
  if$
}

%%%%%%%%%%%%%%%%%% EPRINT CODE ENDS %%%%%%%%%%%%%%%%%%%

FUNCTION {article}
{ output.bibitem
  format.authors "author" output.check add.colon
  new.block
  format.title "title" output.check
  new.block
  crossref missing$
    { journal emphasize "journal" output.check
      format.vol.num.pages output
      format.date "year" output.check
    }
    { format.article.crossref output.nonnull
      format.pages output
    }
  if$
  new.block
  note output
  add.period$
  output.web.refs  % urlbst.pl
  fin.entry
}

FUNCTION {book}
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check }
    { format.authors output.nonnull add.colon
      crossref missing$
    { "author and editor" editor either.or.check }
    'skip$
      if$
    }
  if$
  new.block
  format.btitle "title" output.check
  new.block
  crossref missing$
    { format.bvolume.block output
      new.block
      format.number.series output
      new.sentence
      publisher "publisher" output.check
      address output
    }
    { new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  format.date "year" output.check
  new.block
  note output
  add.period$
  output.web.refs  % urlbst.pl
  fin.entry
}

FUNCTION {booklet}
{ output.bibitem
  format.authors output add.colon
  new.block
  format.title "title" output.check
  howpublished address new.block.checkb
  howpublished output
  address output
  format.date output
  new.block
  note output
  add.period$
  output.web.refs  % urlbst.pl
  fin.entry
}

FUNCTION {inbook}
{ output.bibitem
  author empty$
    { format.editors "author and editor" output.check }
    { format.authors output.nonnull add.colon
      crossref missing$
    { "author and editor" editor either.or.check }
    'skip$
      if$
    }
  if$
  new.block
  format.btitle "title" output.check
  crossref missing$
    { format.bvolume output
      format.chapter.pages "chapter and pages" output.check
      new.block
      format.number.series output
      new.sentence
      publisher "publisher" output.check
      address output
    }
    { format.chapter.pages "chapter and pages" output.check
      new.block
      format.book.crossref output.nonnull
    }
  if$
  format.edition output
  format.date "year" output.check
  new.block
  note output
  add.period$
  output.web.refs  % urlbst.pl
  fin.entry
}

FUNCTION {incollection}
{ output.bibitem
  format.authors "author" output.check add.colon
  new.block
  format.title "title" output.check
  new.block
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.bvolume output
      format.number.series output
      format.chapter.pages output
      new.sentence
      publisher "publisher" output.check
      address output
      format.edition output
      format.date "year" output.check
    }
    { format.incoll.inproc.crossref output.nonnull
      format.chapter.pages output
    }
  if$
  new.block
  note output
  add.period$
  output.web.refs  % urlbst.pl
  fin.entry
}

FUNCTION {inproceedings}
{ output.bibitem
  format.authors "author" output.check add.colon
  new.block
  format.title "title" output.check
  new.block
  crossref missing$
    { format.in.ed.booktitle "booktitle" output.check
      format.bvolume output
      format.number.series output
      format.pages output
      address empty$
    { organization publisher new.sentence.checkb
      organization output
      publisher output
      format.date "year" output.check
    }
    { address output.nonnull
      format.date "year" output.check
      new.sentence
      organization output
      publisher output
    }
      if$
    }
    { format.incoll.inproc.crossref output.nonnull
      format.pages output
    }
  if$
  new.block
  note output
  add.period$
  output.web.refs  % urlbst.pl
  fin.entry
}

FUNCTION {conference} { inproceedings }

FUNCTION {manual}
{ output.bibitem
  author empty$
    { organization empty$
    'skip$
    { organization output.nonnull
      address output
    }
      if$
    }
    { format.authors output.nonnull add.colon }
  if$
  new.block
  format.btitle "title" output.check
  author empty$
    { organization empty$
    { address new.block.checka
      address output
    }
    'skip$
      if$
    }
    { organization address new.block.checkb
      organization output
      address output
    }
  if$
  format.edition output
  format.date output
  new.block
  note output
  add.period$
  output.web.refs  % urlbst.pl
  fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
  format.authors "author" output.check add.colon
  new.block
  format.title "title" output.check
  new.block
  "Master's thesis" format.thesis.type output.nonnull
  school "school" output.check
  address output
  format.date "year" output.check
  new.block
  note output
  add.period$
  output.web.refs  % urlbst.pl
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  format.authors output add.colon
  title howpublished new.block.checkb
  format.title output
  howpublished new.block.checka
  howpublished output
  format.date output
  new.block
  note output
  add.period$
  output.web.refs  % urlbst.pl
  fin.entry
  empty.misc.check
}

FUNCTION {phdthesis}
{ output.bibitem
  format.authors "author" output.check add.colon
  new.block
  format.btitle "title" output.check
  new.block
  "Ph.\,D.\ thesis" format.thesis.type output.nonnull
  school "school" output.check
  address output
  format.date "year" output.check
  new.block
  note output
  add.period$
  output.web.refs  % urlbst.pl
  fin.entry
}

FUNCTION {proceedings}
{ output.bibitem
  editor empty$
    { organization output }
    { format.editors output.nonnull }
  if$
  new.block
  format.btitle "title" output.check
  format.bvolume output
  format.number.series output
  address empty$
    { editor empty$
    { publisher new.sentence.checka }
    { organization publisher new.sentence.checkb
      organization output
    }
      if$
      publisher output
      format.date "year" output.check
    }
    { address output.nonnull
      format.date "year" output.check
      new.sentence
      editor empty$
    'skip$
    { organization output }
      if$
      publisher output
    }
  if$
  new.block
  note output
  add.period$
  output.web.refs  % urlbst.pl
  fin.entry
}

FUNCTION {techreport}
{ output.bibitem
  format.authors "author" output.check add.colon
  new.block
  format.title "title" output.check
  new.block
  format.tr.number output.nonnull
  institution "institution" output.check
  address output
  format.date "year" output.check
  new.block
  note output
  add.period$
  output.web.refs  % urlbst.pl
  fin.entry
}

FUNCTION {unpublished}
{ output.bibitem
  format.authors "author" output.check add.colon
  new.block
  format.title "title" output.check
  new.block
  note "note" output.check
  format.date output
  add.period$
  output.web.refs  % urlbst.pl
  fin.entry
}

FUNCTION {webarticle} { unpublished }

FUNCTION {default.type} { misc }

MACRO {jan} {"January"}

MACRO {feb} {"February"}

MACRO {mar} {"March"}

MACRO {apr} {"April"}

MACRO {may} {"May"}

MACRO {jun} {"June"}

MACRO {jul} {"July"}

MACRO {aug} {"August"}

MACRO {sep} {"September"}

MACRO {oct} {"October"}

MACRO {nov} {"November"}

MACRO {dec} {"December"}

MACRO {acmcs} {"ACM Computing Surveys"}

MACRO {acta} {"Acta Informatica"}

MACRO {cacm} {"Communications of the ACM"}

MACRO {ibmjrd} {"IBM Journal of Research and Development"}

MACRO {ibmsj} {"IBM Systems Journal"}

MACRO {ieeese} {"IEEE Transactions on Software Engineering"}

MACRO {ieeetc} {"IEEE Transactions on Computers"}

MACRO {ieeetcad}
 {"IEEE Transactions on Computer-Aided Design of Integrated Circuits"}

MACRO {ipl} {"Information Processing Letters"}

MACRO {jacm} {"Journal of the ACM"}

MACRO {jcss} {"Journal of Computer and System Sciences"}

MACRO {scp} {"Science of Computer Programming"}

MACRO {sicomp} {"SIAM Journal on Computing"}

MACRO {tocs} {"ACM Transactions on Computer Systems"}

MACRO {tods} {"ACM Transactions on Database Systems"}

MACRO {tog} {"ACM Transactions on Graphics"}

MACRO {toms} {"ACM Transactions on Mathematical Software"}

MACRO {toois} {"ACM Transactions on Office Information Systems"}

MACRO {toplas} {"ACM Transactions on Programming Languages and Systems"}

MACRO {tcs} {"Theoretical Computer Science"}

READ

FUNCTION {sortify}
{ purify$
  "l" change.case$
}

INTEGERS { len }

FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}

FUNCTION {sort.format.names}
{ 's :=
  #1 'nameptr :=
  ""
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { nameptr #1 >
    { "   " * }
    'skip$
      if$
      s nameptr "{vv{ } }{ll{ }}{  ff{ }}{  jj{ }}" format.name$ 't :=
      nameptr numnames = t "others" = and
    { "et al" * }
    { t sortify * }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {sort.format.title}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  sortify
  #1 global.max$ substring$
}

FUNCTION {author.sort}
{ author empty$
    { key empty$
    { "to sort, need author or key in " cite$ * warning$
      ""
    }
    { key sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.editor.sort}
{ author empty$
    { editor empty$
    { key empty$
        { "to sort, need author, editor, or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { editor sort.format.names }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {author.organization.sort}
{ author empty$
    { organization empty$
    { key empty$
        { "to sort, need author, organization, or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { "The " #4 organization chop.word sortify }
      if$
    }
    { author sort.format.names }
  if$
}

FUNCTION {editor.organization.sort}
{ editor empty$
    { organization empty$
    { key empty$
        { "to sort, need editor, organization, or key in " cite$ * warning$
          ""
        }
        { key sortify }
      if$
    }
    { "The " #4 organization chop.word sortify }
      if$
    }
    { editor sort.format.names }
  if$
}

FUNCTION {presort}
{ type$ "book" =
  type$ "inbook" =
  or
    'author.editor.sort
    { type$ "proceedings" =
    'editor.organization.sort
    { type$ "manual" =
        'author.organization.sort
        'author.sort
      if$
    }
      if$
    }
  if$
  "    "
  *
  year field.or.null sortify
  *
  "    "
  *
  title field.or.null
  sort.format.title
  *
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {presort}

SORT

STRINGS { longest.label }

INTEGERS { number.label longest.label.width }

FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  #1 'number.label :=
  #0 'longest.label.width :=
}

FUNCTION {longest.label.pass}
{ number.label int.to.str$ 'label :=
  number.label #1 + 'number.label :=
  label width$ longest.label.width >
    { label 'longest.label :=
      label width$ 'longest.label.width :=
    }
    'skip$
  if$
}

EXECUTE {initialize.longest.label}

ITERATE {longest.label.pass}

FUNCTION {begin.bib}
{ preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "% Define empty bibhead if not already defined" write$ newline$
  "\providecommand{\bibhead}[1]{}" write$ newline$
  "% Define tocrefpdfbookmark if not already defined" write$ newline$
  "\expandafter\ifx\csname pdfbookmark\endcsname\relax%" write$ newline$
  "  \providecommand{\tocrefpdfbookmark}{}" write$ newline$
  "\else\providecommand{\tocrefpdfbookmark}{%" write$ newline$
  "   \hypertarget{tocreferences}{}%" write$ newline$
  "   \pdfbookmark[1]{References}{tocreferences}}%" write$ newline$
  "\fi" write$ newline$
  "" write$ newline$
  "\tocrefpdfbookmark" write$ newline$
  "\begin{thebibliography}{"  longest.label  * "}" * write$ newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}