%% toc.cls 3.35   2020-08-13    ToC style file
%%  supports "research exposition"
%% toc.cls 3.341  2019-10-05    ToC style file
%%  updated from
%% toc.cls 3.34   2018-08-28    ToC style file
%%  only change: {} added to last line
%------------------------------------------------------------------
% Filename: toc.cls
%
% This documentclass is intended for typesetting articles for the
%
%                        Theory of Computing.
%
% See http://theoryofcomputing.org for further details.
%
% Search for ``%%% PART'' to find the main parts of this class file.

%% Version 2.26 fixes compilation advertisements.
%%
%% Version 2.27 adds support for ToC NOTE and establishes
%% \numberwithin{equation}{section} only for regular (long-form)
%% submissions; equation numbering for comments, notes is
%% linear. Reinstated backreferencing in the bibliography, as it now
%% points to page numbers.
%%
%% Version 3.0 adds support for banner treatment of special
%% issues. Special issue information is passed through the tocdetails
%% command. Additionally, notes and comments are now handled
%% differently, these alterations to the style are invoked by passing
%% "note" or "comment" to the tocdetails command.
%%
%% Version 3.1 adds support for the RESEARCH SURVEY article type,
%% activated by the keyword "survey" in the tocdetails
%% command. Surveys are treated as regular long-form articles with a
%% extra banner reading "RESEARCH SURVEY."
%%
%% Version 3.2 changes bibliographic layout for the article to include
%% the number, in parentheses, after the volume.
%%
%% Version 3.21 adds a small space between volume and number in banner and footer.
%% Version 3.22 adds codes for three new "Predefined special issues"
%% Version 3.23 fixed versioning information only.
%%
%% Version 3.3 revises tocdetails hooks and options to be consistent
%% with new tocbase class.
%%
%% Version 3.31 adds definitions for current special issues.
%%
%% Version 3.32 adds reference to tocspecial.tex, which contains all
%% special issue banner data.
%%
%% Version 3.33 updates name of \toc@titlepagehook -> \toc@bannerhook
%% (for compatibility with tocbase 4.44)
%%
%% Version 3.34 adds dummy hooks in pubdet for other revision
%% data. Additionally, firstpage now defaults to 1.
%%
%% Version 3.35 adds support for the RESEARCH EXPOSITION article type,
%% activated by the keyword "exposition" in the tocdetails
%% command. Surveys are treated as regular long-form articles with a
%% extra banner reading "RESEARCH EXPOSITION".

%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Declare class, load external packages, setup metadata.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Need this version of LaTeX atleast (for ClassWarning commands)
\NeedsTeXFormat{LaTeX2e}[1994/06/01] 
\ProvidesClass{toc}[2018/08/28 v3.34 Theory of Computing]
 
% Pass all options along to tocbase:
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{tocbase}}
\PassOptionsToClass{tocmacros}{tocbase}

\newcommand{\toc@shortformarticle}{\@empty}

\ProcessOptions\relax
% Now load article class and handle options.
\LoadClass{tocbase}

\newcommand{\toc@commentsetup}{%
  \renewcommand{\toc@shortformarticle}{comment}
  \renewcommand\toc@bannermodifier{%
    \vspace{1em}{\toc@subbannerlayout{COMMENT}}%
    \par \vspace{1em} \hrule \vspace{1pt} \hrule}%
  \renewenvironment{tocaboutauthors}{%
    \ClassWarning{toc}{Use of ABOUT THE AUTHORS discouraged in ToC Comments}\begin{internal@tocaboutauthors}}%
    {\end{internal@tocaboutauthors}}%
}

\newcommand{\toc@notesetup}{%
  \renewcommand{\toc@shortformarticle}{note}
  \renewcommand\toc@bannermodifier{%
    \vspace{1em}{\toc@subbannerlayout{NOTE}}%
    \par \vspace{1em} \hrule \vspace{1pt} \hrule}%
}

\newcommand{\toc@surveysetup}{%
 \renewcommand\toc@bannermodifier{%
    \vspace{1em}{\toc@subbannerlayout{RESEARCH SURVEY}}%
    \par \vspace{1em} \hrule \vspace{1pt} \hrule}%
}

\newcommand{\toc@expositionsetup}{%
 \renewcommand\toc@bannermodifier{%
    \vspace{1em}{\toc@subbannerlayout{RESEARCH EXPOSITION}}%
    \par \vspace{1em} \hrule \vspace{1pt} \hrule}%
}

\newcommand\toc@specialissuesetup{%
  \newcommand{\toc@specialissuebannertext}{\toc@specialissue}%
  \renewcommand\toc@bannerspecialissue{%
    \vspace{1em}{\toc@specialissuelayout{\toc@specialissue}\par}}
}

%% Setup tocdetails defaults
\newcommand{\toc@specialissue}{\@empty}

%% tocdetails hooks:
\define@key{pubdet}{specissue}{\renewcommand{\toc@specialissue}{#1}%
  \toc@specialissuesetup}
\define@key{pubdet}{article}[true]{}
\define@key{pubdet}{note}[true]{\toc@notesetup}
\define@key{pubdet}{comment}[true]{\toc@commentsetup}
\define@key{pubdet}{survey}[true]{\toc@surveysetup}
\define@key{pubdet}{exposition}[true]{\toc@expositionsetup}

\renewcommand{\toc@declaredfirstpage}{1}

%% Dummy hooks to allow this data to appear in tocdetails without complaint.
\define@key{pubdet}{number_of_pages}{}
\define@key{pubdet}{number_of_bibitems}{}
\define@key{pubdet}{number_of_figures}{}
\define@key{pubdet}{conference_version}{}
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Title page components
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand\toc@bannermodifier{\relax}
\newcommand\toc@bannerspecialissue{\relax}

\newcommand\toc@specialissuelayout[1]{\fontsize{14}{16}\usefont{OT1}{ptm}{m}{sc}\selectfont{#1}}
\newcommand\toc@subbannerlayout[1]{\fontsize{16}{18}\usefont{OT1}{phv}{m}{n}\selectfont{#1}}

\newcommand{\toc@bannerpubdata}
{\fontsize{11}{13}\usefont{OT1}{ptm}{m}{n}\selectfont
  {,\ Volume \toc@volume\,(\toc@number), \toc@year, 
    pp. \toc@firstpage--\toc@lastpage}}

\renewcommand\toc@bannertexta%
{\ifex\toc@volume\@empty
  \toc@bannerjournalname
  \else
  \toc@bannerjournalname\toc@bannerpubdata
  \fi}

\setlength{\toc@bannerwidth}{\textwidth}
\addtolength{\toc@bannerwidth}{-2cm}
\renewcommand{\toc@banner}{\toc@bannerhook%
  \begin{minipage}{\toc@bannerwidth}%
    \centering \toc@bannertexta\\ \toc@bannertextb\\
    \vspace{2mm} \hrule\vspace{1pt}\hrule%
    \toc@bannermodifier%
    \toc@bannerspecialissue%
  \end{minipage}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Header and footer initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand\toc@runningcitation%
{\ifex\toc@volume\@empty
  \href{\toc@journaldoiaddress}{\textsc{\toc@journalname}}
  \else
  \href{\toc@journaldoiaddress}{\textsc{\toc@journalname}}\toc@bannerpubdata
  \fi
}
%% These two must be identical, save for the hyperlinks.
\renewcommand\toc@runningcitation@nolink%
{\ifex\toc@volume\@empty
  \textsc{\toc@journalname}
  \else
  \textsc{\toc@journalname}, Volume \toc@volume\ (\toc@year),
  pp. \toc@firstpage--\toc@lastpage
  \fi
}

% Set up the 2ff. page style.
\renewcommand{\ps@headings}{%
  \renewcommand{\@oddhead}
  {\hfil\toc@headerlayout{\toc@runningtitle}\hfil}%    
  \renewcommand{\@evenhead}
  {\hfil\toc@headerlayout{\toc@runningauthor}\hfil}%
  \renewcommand{\@oddfoot}
  {\hfil\toc@footerlayout{\toc@runningcitation}\hfil
    \normalfont\thepage}%
  \renewcommand{\@evenfoot}
  {\hfil\toc@footerlayout{\toc@runningcitation}\hfil
    \normalfont\thepage}%
}

%% Determine actual footer height.
\settoheight\toc@footerheight{\toc@footerlayout{\toc@runningcitation@nolink}}

%% Determine titlepage text area.
\setlength\toc@titlepagecorrection\toc@crboxheight
\addtolength\toc@titlepagecorrection{-\toc@footerheight}

% Define the default page style to be headings.
\pagestyle{headings}
\pagenumbering{arabic}


\AtBeginDocument{%
  {\ifex{\toc@shortformarticle}{\@empty}{%
      \numberwithin{equation}{section}}
    \else{}\fi}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%% Predefined special issues
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\IfFileExists{tocspecial.tex}{\input{tocspecial.tex}}{}
