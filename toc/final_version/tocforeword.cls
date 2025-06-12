%% tocforeword.cls 0.971  2018-05-23    ToC style file
%%   updated from
%% tocforeword.cls 0.97   2018-05-23    ToC style file
%%  only change: {} added to last line
%------------------------------------------------------------------
% Filename: tocforeword.cls
%
% This documentclass is intended for typesetting articles for the
%
%                        Theory of Computing.
%
% See http://theoryofcomputing.org for further details.
%
% Search for ``%%% PART'' to find the main parts of this class file.

%% Version 0.97 updates \tocbannerhook for tocbase 4.44.
%%
%% Version 0.96 adds reference to tocspecial.tex, which contains all
%% special issue banner data.
%%
%% Version 0.95. Adapts details command, options for tocbase 4.4.
%%
%% Version 0.94 fixes first peage header so that it is consistent with
%% our article style.
%%
%% Version 0.93 fixes versioning information only
%%
%% Version 0.92 adds codes for three new "Predefined special issues"
%%
%% Version 0.91 removes conditional classification command, this is
%% now handled in tocbase version 4.11.
%%
%% Version 0.9. First release version, based on toc.cls.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Declare class, load external packages, set up metadata
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Need this version of LaTeX atleast (for ClassWarning commands)
\NeedsTeXFormat{LaTeX2e}[1994/06/01] 
\ProvidesClass{tocforeword}[2018/05/23 v0.97 Theory of Computing Foreword]
 
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

%% We just set the date to be the published date, in which case
%% tocbase will lay it out without the "published:" string.
\define@key{pubdet}{published}{\date{#1}}

\newcommand{\toc@editortitlesingular}{GUEST EDITOR}
\newcommand{\toc@editortitleplural}{GUEST EDITORS}

\newcommand{\editortitlesingular}[1]{\renewcommand{\toc@editortitlesingular}{#1}}
\newcommand{\editortitleplural}[1]{\renewcommand{\toc@editortitleplural}{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%% Title page components
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\newcommand\toc@bannermodifier{\relax}
\newcommand\toc@bannerspecialissue{\relax}

\newcommand\toc@specialissuelayout[1]{\fontsize{14}{16}\usefont{OT1}{ptm}{m}{sc}\selectfont{#1}}
\newcommand\toc@subbannerlayout[1]{\fontsize{16}{18}\usefont{OT1}{phv}{m}{n}\selectfont{#1}}

\newcommand{\toc@bannerpubdata}
{\fontsize{11}{13}\usefont{OT1}{ptm}{m}{n}\selectfont
  {,\ Volume \toc@volume\,(\toc@number), \toc@year, pp. \toc@firstpage--\toc@lastpage}}

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

\renewcommand{\toc@amsclassification}{\@empty}
\renewcommand{\toc@acmclassification}{\@empty}
\renewcommand{\toc@keywords}{\@empty}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%% Header and footer initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

\renewcommand\toc@runningcitation%
{\ifex\toc@volume\@empty
  \href{\toc@journaldoiaddress}{\textsc{\toc@journalname}}
  \else
  \href{\toc@journaldoiaddress}{\textsc{\toc@journalname}}, Volume \toc@volume\ (\toc@year),
  pp. \toc@firstpage--\toc@lastpage
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


\renewenvironment{tocauthors}{ % Beginning of environment

                     % Initialise an empty tocabout command
\newcommand{\tocabout}{\@empty}  

% Define tocinfo environment
 \newenvironment{tocinfo}[1][\@empty]{%
  \begin{verse}
  % Redefine \tocabout command for the author if nickname given
  \ifx##1\@empty
     \renewcommand{\tocabout}{\@empty}
  \else
     \renewcommand{\tocabout}%
                  {\hyperlink{author.about.##1}%
                  {\small [About the author]}}
  \fi
  \ifx##1\@empty\relax\else\hypertarget{author.info.##1}{}\fi
 }{% End of environment
\end{verse} \filbreak
} % End of tocinfo

\filbreak % Prefer a page break here rather than later
\bigskip\noindent
\ifnum \value{toc@numauthors}>1
   \textsf{\toc@editortitleplural}
\else
   \textsf{\toc@editortitlesingular}
\fi
}{%
\let\tocinfo\relax % Undefine tocinfo
\let\tocabout\relax
}
%  end tocauthors environment

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%% Predefined special issues
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

\IfFileExists{tocspecial.tex}{\input{tocspecial.tex}}{}
