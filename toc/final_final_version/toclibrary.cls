%% toclibrary.cls Version 2.41 2018-05-23 ToC library style file

% Filename: toclibrary.cls
%
% This documentclass is intended for typesetting articles for the
%
%                        Theory of Computing Library.
%
% See http://theoryofcomputing.org for further details.
%
% Search for ``%%% PART'' to find the main parts of this class file.

%% Version 2.26 moves seriesdoi into options.
%%
%% Version 2.27 removes toc@seriesabbrev command and all references to
%%     it. WARNING: This has visible effect on the style, removing, e.g.,
%%     TCGS from the banner and footer of our graduate surveys series.
%%     Additionally, 2.27 fixes the way that we call amsmath.
%%
%% Version 2.3 changes selection of series type from an option to the
%% class to a switch in the tocdetails command.
%%
%% Version 2.4 Adapts tocdetails command for Version 4.4 of tocbase.
%%
%% Version 2.41 Compatibility with tocbase 4.44 \bannerhook command.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Declare class and load external packages
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Need this version of LaTeX atleast (for ClassWarning commands)
\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{toclibrary}[2018/05/23 v2.41 Theory of Computing Library]

\RequirePackage{amsmath}

\newcommand{\toc@seriesname}{Series}
\newcommand{\toc@seriesdoi}{10.4086/toc}

% Pass all options along to tocbase:
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{tocbase}}
\PassOptionsToClass{tocmacros}{tocbase}

\ProcessOptions\relax
% Now load article class and handle options.
\LoadClass{tocbase}

% Setup name, address, &c.

\renewcommand{\toc@journalname}{Theory of Computing Library}
\renewcommand\toc@journaldoi{10.4086/toc}
\renewcommand{\toc@journaldoiaddress}{\toc@doiderefaddress\toc@journaldoi} 
\newcommand{\toc@seriesdoiaddress}{\toc@doiderefaddress\toc@seriesdoi} 

% Set up the tocdetail hook for the series types

\define@key{pubdet}{gradsurvey}[true]{%
  \renewcommand{\toc@seriesname}{Graduate Surveys}%
  \renewcommand{\toc@seriesdoi}{10.4086/toc.gs}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Title page components
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand{\toc@bannerjournalname}%
           {\fontsize{11}{13}\usefont{OT1}{ptm}{m}{sc}
            \selectfont{\href{\toc@journaldoiaddress}{\toc@journalname}}}

\newcommand{\toc@bannerseriesname}%
           {\fontsize{11}{13}\usefont{OT1}{ptm}{m}{sc}
            \selectfont{\href{\toc@seriesdoiaddress}{\toc@seriesname}}}

\newcommand{\toc@bannerpubdata}%
           {\fontsize{11}{13}\usefont{OT1}{ptm}{m}{n}\selectfont
            {\ \toc@number\ (\toc@year), 
              pp. \toc@firstpage--\toc@lastpage}}

\renewcommand\toc@bannertexta%
{\toc@bannerjournalname}
 
\renewcommand\toc@bannertextb%
{\ifex\toc@number\@empty
  \toc@bannerseriesname
 \else
  \toc@bannerseriesname\toc@bannerpubdata
 \fi}

\newcommand\toc@bannertextc
           {\fontsize{11}{13}\usefont{OT1}{ptm}{m}{it}
            \selectfont{\toc@journaladdress}}

\setlength{\toc@bannerwidth}{\textwidth}
\addtolength{\toc@bannerwidth}{-2cm}
\renewcommand{\toc@banner}{\toc@bannerhook%
  \begin{minipage}{\toc@bannerwidth}%
    \centering \toc@bannertexta\\ \toc@bannertextb\\ \toc@bannertextc\\
    \vspace{2mm} \hrule\vspace{1pt}\hrule
  \end{minipage}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Header and footer initialization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand\toc@runningcitation%
{\ifex\toc@number\@empty
  {\textsc{\href{\toc@journaldoiaddress}{\toc@journalname}, \href{\toc@seriesdoiaddress}{\toc@seriesname}}}
 \else
  \textsc{\href{\toc@journaldoiaddress}{\toc@journalname}}, \href{\toc@seriesdoiaddress}{\textsc{\toc@seriesname}}~\toc@number\ (\toc@year),
    pp. \toc@firstpage--\toc@lastpage
 \fi
}
%% These should be identical, save the references.
\newcommand\toc@runningcitation@noref%
{\ifex\toc@number\@empty
  {\textsc{\toc@journalname, \toc@seriesname}}
 \else
  \textsc{\toc@journalname}, \textsc{\toc@seriesname}~\toc@number\ (\toc@year),
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
\settoheight\toc@footerheight{\toc@footerlayout{\toc@runningcitation@noref}}

%% Determine titlepage text area.
\setlength\toc@titlepagecorrection\toc@crboxheight
\addtolength\toc@titlepagecorrection{-\toc@footerheight}

% Define the default page style to be headings.
\pagestyle{headings}
\pagenumbering{arabic}

% Set equation numbering to be of form Section.Number.
\numberwithin{equation}{section}

