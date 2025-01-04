function generate_readme(tex_file, readme_file)

[tex_file_dir, tex_file_name] = fileparts(tex_file);

if nargin < 2
    readme_file = [tex_file_dir filesep 'readme.md'];
end

tex = fileread(tex_file);
 
%% Analysis

% title
title = regexp(tex, '\\title(?:(.*?))?{([^{}]*)}', 'tokens', 'once');
title = strtrim(title{1});

% document
document = regexp(tex, '\\begin{document}(.*)\\end{document}', 'tokens', 'once');
document = document{1};
document = regexprep(document, '\\maketitle', '');
document = regexprep(document, '\\noindent', '');
document = regexprep(document, '\\clearpage', '');
document = regexprep(document, '\\begin\{abstract\}', '');
document = regexprep(document, '\\end\{abstract\}', '');

% parentesi graffe (1)
document = regexprep(document, '\\{', '¡!parentesi graffa aperta!¡');
document = regexprep(document, '\\}', '¡!parentesi graffa chiusa!¡');

% basic reformatting
document = regexprep(document, 'BRAPH~2', 'BRAPH 2');
document = regexprep(document, '---', '-');  % ---
document = regexprep(document, '\\\\\n', '\n\n');  % \\
document = regexprep(document, '\\fn{([^{}]*)}', '"$1"');  % \fn
document = regexprep(document, '\\code{([^{}]*)}', '`$1`');  % \code
document = regexprep(document, '\\url{([^{}]*)}', '[$1]($1)');  % \url{link}
document = regexprep(document, '\\href{([^{}]*)}{([^{}]*)}', '[$2]($1)');  % \href{link}{text}
document = regexprep(document, '``([^`'']*)''''', '"$1"');  % ``text''
document = regexprep(document, '\\emph{([^{}]*)}', '*$1*');  % \emph{...}
document = regexprep(document, '\\textbf{([^{}]*)}', '**$1**');  % \textbf{...}
document = regexprep(document, '\\texttt{([^{}]*)}', '`$1`');  % \texttt{...}
document = regexprep(document, '\\lstinline{([^{}]*)}', '`$1`');  % \lstinline{...}
document = regexprep(document, '\\&', '&');  % \&
document = regexprep(document, '\\_', '_');  % \_
document = regexprep(document, '¥€¥', '€');  % ¥€¥
document = regexprep(document, '¤...¤', '. . . . .');  % ¤...¤
document = regexprep(document, '¤', '');  % ¤
document = regexprep(document, '{\\bf ([^{}]*)}', '**$1**');  % {\bf ...}
document = regexprep(document, '\\footnote{([^{}]*)}', ' ($1)');  % \footnote{...}
document = regexprep(document, '\\begin{fullwidth}', '');  % \begin{fullwidth}
document = regexprep(document, '\\end{fullwidth}', '');  % \end{fullwidth}
document = regexprep(document, '\\begin{quote}', '');  % \begin{fullwidth}
document = regexprep(document, '\\end{quote}', '');  % \end{quote}
document = regexprep(document, [newline() '{%TEX[^{}]*}%TEX\s*' newline()], '');  % {%TEX ... }%TEX
document = regexprep(document, [newline() '{%¡TEX[^¡]*}%¡TEX\s*' newline()], '');  % {%¡TEX ... }%¡TEX
document = regexprep(document, ['\\newcommand{[^' newline() ']*}{[^' newline() ']*}' newline()], '');  % \newcommand{...}{...}
document = regexprep(document, ['\\newcolumntype{[^' newline() ']*}{[^' newline() ']*}' newline()], '');  % \newcolumntype{...}{...}

% table of contents
sections = regexp(document, '\\(sub)?(sub)?section\{([^{}]*)\}', 'tokens', 'all');
toc = '## Table of Contents';
for i = 1:1:length(sections)
    section = sections{i};
    
    section_title = section{3};
    
    if section{2}  % subsubsection
        level = 3;
    elseif section{1}  % subsection
        level = 2;
    else  % section
        level = 1;
    end

    toc = [toc newline() repmat('>', 1, level) ' [' section_title '](#' regexprep(regexprep(section_title, '[^a-zA-Z0-9"\s]', ''), ' ', '-') ')' newline() repmat('>', 1, level)]; %#ok<AGROW> 
end
document = regexprep(document, '\\tableofcontents', toc);

% (sub)section
arrow_up_icon = char(11014);
document = regexprep(document, '\\section{([^{}]*)}', ['<a id="$1"></a>' newline() '## $1  [' arrow_up_icon '](#Table-of-Contents)']);
document = regexprep(document, '\\subsection{([^{}]*)}',  ['<a id="$1"></a>' newline() '### $1  [' arrow_up_icon '](#Table-of-Contents)']);
document = regexprep(document, '\\subsubsection{([^{}]*)}',  ['<a id="$1"></a>' newline() '#### $1  [' arrow_up_icon '](#Table-of-Contents)']);

a_start = regexp(document, '<a id="', 'end', 'all');
a_end = regexp(document, '"></a>', 'start', 'all');
for i = length(a_start):-1:1
    section_title = regexprep(document(a_start(i):a_end(i)), '[^a-zA-Z0-9"\s]', '');
    document = [document(1:a_start(i) - 1) strrep(section_title, ' ', '-') document(a_end(i) + 1:end)];
end

% itemize
document = regexprep(document, '\\begin{itemize}', '');
document = regexprep(document, '\\item ', '- ');
document = regexprep(document, '\\end{itemize}', '');

% enumerate
document = regexprep(document, '\\begin{enumerate}', '');
document = regexprep(document, '\\item{} ', '1. ');
document = regexprep(document, '\\end{enumerate}', '');

% description
document = regexprep(document, '\\begin{description}', '');
document = regexprep(document, '\\item\[([^\]]*)\] ', '- **$1** ');
document = regexprep(document, '\\end{description}', '');

% figures
figures = regexp(document, '\\fig{(marginfigure|figure|figure\*)}\s*{([^{}]*)}\s*{[^{}]*\\includegraphics{([^{}]*)}[^{}]*}\s*{([^{}]*)}\s*{([^{}]*)}', 'tokens', 'all');
document = regexprep(document, '\\fig{(marginfigure|figure|figure\*)}\s*{([^{}]*)}\s*{[^{}]*\\includegraphics{([^{}]*)}[^{}]*}\s*{([^{}]*)}\s*{([^{}]*)}', '');

figs = regexp(document, '(%! ?FIG\d*) ?(\w*) ?!%', 'tokens', 'all');
assert(length(figures) == length(figs), 'The number of figures and %!FIGxx!% should be equal!')

for i = length(figures):-1:1
    figure = figures{i};
    figure_file = strtrim(figure{3});
    figure_title = strtrim(figure{4});
    figure_caption = strtrim(figure{5});

    if figs{i}{2}
        fig_img = ['<img src="' figure_file '" alt="' figure_title '" height="' figs{i}{2} '">'];
    else
        fig_img = ['<img src="' figure_file '" alt="' figure_title '">'];
    end
    document = regexprep(document, [figs{i}{1} '[ \w]*!%'], [fig_img newline() strrep([newline() '**Figure ' int2str(i) '. ' figure_title '**' newline() figure_caption], newline(), [newline() '> '])]);

    figure_ref = strtrim(figure{2});
    document = regexprep(document, ['\\Figref{' figure_ref '}'], ['Figure ' int2str(i)]);
    document = regexprep(document, ['\\Figsref{' figure_ref '}'], ['Figures ' int2str(i)]);
end

% codes
document = regexprep(document, '\\expand{([^{}]*)}', 'This code modifies Code ¡!parentesi graffa aperta!¡$1¡!parentesi graffa chiusa!¡.');  % \epxand{cd:xxx} (1)

codes_start = regexp(document, '\\begin{lstlisting}', 'end', 'all');
codes_end = regexp(document, '\\end{lstlisting}', 'start', 'all');
assert(length(codes_start) == length(codes_end), 'The number of start and end codes should be equal!')

code_labels = {};
for i = length(codes_start):-1:1
    code = regexp(document(codes_start(i) + 1:codes_end(i) - 1), '\[\s*label=([^,]*),\s*caption={\s*([^{}]*)\s*}\s*\]\s*(.*)', 'tokens', 'all');
    code_labels{i} = strtrim(code{1}{1});
    code_caption = strtrim(code{1}{2});
    code_code = strtrim(regexprep(code{1}{3}, '\t', '    '));

    code_notes = regexp(code_code, '¥\\circled{\d*}\\circlednote{(\d*)}{([^¥]*)}¥', 'tokens', 'all');
    code_code = regexprep(code_code, '¥\\circled{(\d*)}[^¥]*¥', ' ¡!$1!¡');
    code_notes_txt = '';
    for j = 1:1:length(code_notes)
        code_notes_txt = [code_notes_txt newline() '¡!' code_notes{j}{1} '!¡' code_notes{j}{2} newline()]; %#ok<AGROW> 
    end
    code_notes_txt = regexprep(code_notes_txt, '\\circled{(\d*)}', '¡!$1!¡');

    document = [document(1:codes_start(i) - length('\begin{lstlisting}')) ...
        strrep([ newline() ...
            '**Code ' int2str(i) '.** ' code_caption newline() ...
            '````matlab' newline() code_code newline() '````' newline() ...
            code_notes_txt ...
            ], newline(), [newline() '> ']) ...
        document(codes_end(i) + length('\end{lstlisting}'):end)];
end

for i = 1:1:length(code_labels)
    document = regexprep(document, ['\\Coderef{' code_labels{i} '}'], ['Code ' int2str(i)]);
    document = regexprep(document, ['Code ¡!parentesi graffa aperta!¡' code_labels{i} '¡!parentesi graffa chiusa!¡'], ['Code ' int2str(i)]);  % \epxand{cd:xxx} (2)
    document = regexprep(document, ['\\Codesref{' code_labels{i} '}'], ['Codes ' int2str(i)]);    
end

for i = 1:1:20
    document = regexprep(document, ['¡!' int2str(i) '!¡'], char(9311 + i));
end
for i = 21:1:50
    document = regexprep(document, ['¡!' int2str(i) '!¡'], char(12860 + i));
end

% colorboxes
cb_start = regexp(document, '\\begin{tcolorbox}', 'end', 'all');
cb_end = regexp(document, '\\end{tcolorbox}', 'start', 'all');
assert(length(cb_start) == length(cb_end), 'The number of start and end colorboxes should be equal!')

for i = length(cb_start):-1:1
    cb = regexp(document(cb_start(i) + 1:cb_end(i) - 1), '\[\s*title=([^\[\]]*)\s*\]\s*(.*)', 'tokens', 'all');
    cb_title = strtrim(cb{1}{1});
    cb_content = strtrim(cb{1}{2});
    
    document = [document(1:cb_start(i) - length('\begin{tcolorbox}')) ...
        strrep([newline() '**' cb_title '**' newline() cb_content], newline(), [newline() '> ']) ...
        document(cb_end(i) + length('\end{tcolorbox}'):end)];
end

% parentesi graffe (1)
document = regexprep(document, '¡!parentesi graffa aperta!¡', '{');
document = regexprep(document, '¡!parentesi graffa chiusa!¡', '}');

% includegraphics
document = regexprep(document, '\\includegraphics\[[^{}]*\]{([^{}]*)}', '![$1]($1)');

%% Generate README file
readme = [
    '# ' title newline() ...
    newline() ...
    '[![Tutorial ' title '](https://img.shields.io/badge/PDF-Download-red?style=flat-square&logo=adobe-acrobat-reader)](' tex_file_name '.pdf)' newline() ...
    newline() ...
    strtrim(document)
    ];


%% Save readme
writelines(readme, readme_file)