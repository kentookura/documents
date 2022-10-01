{config}:
pkgs.stdenv.mkDerivation {
  pname = "frontpage";
  src = ./frontpage.sty;
  phases = ["installPhase"];
  installPhase = ''
    mkdir -p $out/tex/${name}
    cp $src $out/tex/${name}
  '';
  tlType = "run";
  a = ''
    \nocite{*}
    \begin{titlingpage}
    	\begin{flushright}
    		\includegraphics[width=8cm]{./Uni_Logo_2016_SW}
    	\end{flushright}

    	\begin{center}

    		\Huge{\textbf{\textsf{\MakeUppercase{
          1. Bachelorarbeit
        }}}}
    		\vspace{2cm}

    		\large{\textsf{  Titel der Bachelorarbeit }}
    		\vspace{.1cm}

    		\LARGE{\textsf{${config.title}}}
    		\vspace{3cm}

    		\large{\textsf{  Verfasser }}
    		\Large{\textsf{ ${config.author}}}
    		\vspace{3cm}

    		\large{\textsf{ angestrebter akademischer Grad  }}
    		\Large{\textsf{  Bachelor of Science (BSc.) }}
    	\end{center}
    	\vspace{2cm}

    	\noindent\textsf{Wien, im Monat September 2022}  % <<<<< ORT, MONAT UND JAHR EINTRAGEN
    	\vfill

    	\noindent\begin{tabular}{@{}ll}
    		\textsf{Studienkennzahl lt.\ Studienblatt:}
    		 &
    		\textsf{${config.degree_code}}
    		\\
    		\textsf{Studienrichtung lt.\ Studienblatt:}
    		 &
    		\textsf{${config.field}}
    		\\
    		% Betreuerin ODER Betreuer:
    		\textsf{Betreuer: }
    		 &
    		\textsf{${config.advisor}}
    	\end{tabular}

      \maketitle
    \end{titlingpage}
  '';
}
