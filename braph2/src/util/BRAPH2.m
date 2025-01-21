classdef BRAPH2
    %BRAPH2 constants.
    % BRAPH2 is a static class that contains the constants used by BRAPH2.
    %
    % Properties (Constant) - BRAPH2 ID Card:
    %  NAME             - BRAPH2 full name
    %  STR              - BRAPH2 short string
    %  VERSION          - BRAPH2 version
    %  BUILD            - BRAPH2 build number
    %  RELEASE          - BRAPH2 release date
    %  AUTHORS          - BRAPH2 authors
    %  COPYRIGHT        - BRAPH2 copyright
    %  WEB              - BRAPH2 website
    %  GITHUB           - BRAPH2 GitHub repository
    %  BLUESKY          - BRAPH2 bluesky handle
    %  MATLAB_VERSION   - Minimal MatLab version (9.12)
    %  MATLAB_RELEASE   - Minimal MatLab release (2022a)
    %
    % Properties (Constant) - BRAPH2 extensions
    %  EXT_ELEMENT      - BRAPH2 element extension (*.b2)
    %  EXT_PIPELINE     - BRAPH2 pipeline extension (*.braph2)
    %
    % Properties (Constant) - BRAPH2 check
    %  CHECKED          - BRAPH2 check global switch
    %
    % Properties (Constant) - BRAPH2 error codes:
    %  WRONG_VER        - wrong MatLab or addon version
    %  MISS_ADDON       - addon not installed
    %  FAIL_GEN         - failed genesis
    %  FAIL_TEST        - failed unit testing
    %  WRONG_INPUT      - wrong input value or format in a function
    %  CANCEL_IO        - cancelled loading/saving files by user
    %  ERR_IO           - error while loading/saving files
    %  ERR_FUNC         - error in a function (wrong behavior)
    %  ERR_COPY         - error while deep-copying an object
    %  ERR_CLONE        - error while cloning an object
    %  ERR_JSON         - error in JSON encoding/deconding
    %  ERR_TRY          - error in the handling of errors
    %  ERR_IOLAYOUT     - error in loading/saving layout
    % 
    % Properties (Customizable) - BRAPH2 GUI customizable constants:
    %  FONTSIZE         - basic size of the font in pixels
    %  S                - scaling factor of the graphical components
    %  COL              - official BRAPH2 color
    %  COL_BKG          - standard figure background color
    %  COL_C            - standard constant prop background color
    %  COL_M            - standard metadata prop background color
    %  COL_P            - standard parameter prop background color
    %  COL_D            - standard data prop background color
    %  COL_R            - standard result prop background color
    %  COL_Q            - standard query prop background color
    %  COL_E            - standard evanescent prop background color
    %  COL_F            - standard figure prop background color
    %  COL_G            - standard gui prop background color
    %  COL_FDR          - standard FDR color
    %
    % Methods (Static) - BRAPH2 information:
    %  credits          - provides information about the authors of BRAPH2
    %  license          - provides information about the license of BRAPH2
    %  web              - opens the BRAPH2 website
    %  forum            - opens the BRAPH2 forum
    %  bluesky          - opens the BRAPH2 Bluesky
    %  add_menu_about   - adds the about menu to a uifigure
    %  add_tool_about   - adds the about tools to a uitoolbar
    %
    % Methods (Static) - BRAPH2 checks:
    %  checkMatLab      - checks whether the MatLab version is sufficiently new/error
    %  installed        - returns whether an addon is installed/error
    
    properties (Constant) % BRAPH2 ID Card
        NAME = 'BRAPH 2.0' % BRAPH2 full name
        STR = 'BRAPH2' % BRAPH2 short string
        VERSION = '2.0.0' % BRAPH2 version % % % ON RELEASE: Ensure correct VERSION
        BUILD = 6 % BRAPH2 build number % % % ON RELEASE: Ensure correct BUILD
        RELEASE = '2025-01-12' % BRAPH2 release date % % % ON RELEASE: Ensure correct RELEASE date
        AUTHORS = 'Giovanni Volpe, Emiliano Gomez Ruiz, Anna Canal Garcia, Yu-Wei Chang, Mite Mijalkov, Joana Braga Pereira, Ehsan Kakaei, Eric Westman, et al.'
        COPYRIGHT = ['Copyright 2014-' datestr(now,'yyyy')]
        WEB = 'braph.org' % BRAPH2 website
        GITHUB = 'github.com/braph-software/BRAPH-2' % GitHub repository
        BLUESKY = 'braph2software.bsky.social' % BRAPH2 Bluesky handle
        MATLAB_VERSION = '9.12' % Minimal MatLab version (9.12)
        MATLAB_RELEASE = '(2022a)' % Minimal MatLab release (2022a)
    end
    properties (Constant) % BRAPH2 extensions
        EXT_ELEMENT = {'*.b2'} % BRAPH2 element extension
        EXT_PIPELINE = {'*.braph2'} % BRAPH2 pipeline extension
    end
    properties (Constant) % BRAPH2 check
        CHECKED = true % BRAPH2 check global switch
    end
	properties (Constant) % BRAPH2 error codes
        WRONG_VER = 'WrongVersion' % wrong MatLab or addon version
        MISS_ADDON = 'MissingAddOn' % addon not installed
        FAIL_GEN = 'FailedGenesis' % failed genesis
        FAIL_TEST = 'FailedUnitTest' % failed unit testing
        WRONG_INPUT = 'WrongInput' % wrong input value or format in a function
        CANCEL_IO = 'CancelIO' % cancelled loading/saving files by user
        ERR_IO = 'ErrorIO' % error while loading/saving files
        ERR_FUNC = 'ErrorFunc' % error in a function (wrong behavior)
        ERR_COPY = 'ErrorCopy' % error while deep-copying an object
        ERR_CLONE = 'ErrorClone' % error while cloning an object
        ERR_JSON = 'ErrorJSON' % error in JSON encoding/deconding
        ERR_TRY = 'ErrorTryCatch' % error in the handling of errors
        ERR_IOLAYOUT = 'ErrorIOLayout' % error in loading/saving layout
	end
    properties (Constant) % BRAPH2 GUI customizable constants
        FONTSIZE = 12 % basic size of the font in pixels
        S = 1 % scaling factor of the graphical components
        COL = [.9 .4 .1] % official BRAPH2 color
        COL_BKG = [1 .9725 .929] % standard figure background color
        COL_C = [.5 .5 .5] % standard metadata prop background color
        COL_M = [.2 .5 .8] % standard metadata prop background color
        COL_P = [.4 .5 .6] % standard parameter prop background color
        COL_D = [.6 .5 .4] % standard data prop background color
        COL_R = [.8 .5 .2] % standard result prop background color
        COL_Q = [.9 .5 .1] % standard query prop background color
        COL_E = [.6 .6 .6] % standard evanescent prop background color
        COL_F = [.7 .7 .7] % standard figure prop background color
        COL_G = [.8 .8 .8] % standard gui prop background color
        COL_FDR = [.5 .7 .2] % standard FDR color
    end
    methods (Static) % BRAPH2 information
        function credits()
            %CREDITS provides information about the authors of BRAPH2.
            %
            % See also license, braph2msgbox.
            
            title = ['About ' BRAPH2.STR];
            
            message = [{''
                ['{\bf\color{orange}' BRAPH2.STR '}']
                ['{\color{gray}version ' BRAPH2.VERSION '}']
                ['{\color{gray}build ' int2str(BRAPH2.BUILD) '}']
                ''}; ...
                strsplit(BRAPH2.AUTHORS, ', ')'; ...
                {''
                ['{\color{gray}' BRAPH2.WEB '}']
                ''
                ['{\color{gray}' BRAPH2.COPYRIGHT '}']
                ''
                ''}];
            
            braph2msgbox(title, message)
        end
        function license()
            %LICENSE provides information about the license of BRAPH2.
            %
            % See also about, braph2msgbox.
            
            title = [BRAPH2.STR ' License'];
            
            message = {''
                ['{\bf\color{orange}' BRAPH2.STR '}']
                ['{\color{gray}version ' BRAPH2.VERSION '}']
                ['{\color{gray}build ' int2str(BRAPH2.BUILD) '}']
                ''
                'The license is available in the file {\bfbraph2license.rtf} '
                'on the main directory of BRAPH2.'
                ''
                'In brief, BRAPH2 is provided as is '
                'and is free to use for research.'
                ''
                ['{\color{gray}' BRAPH2.WEB '}']
                ''
                ['{\color{gray}' BRAPH2.COPYRIGHT '}']
                ''
                ''};
            
            braph2msgbox(title, message)
        end
        function web()
            %WEB opens the BRAPH2 website.
            %
            % See also forum, bluesky.
            
            url = ['http://' BRAPH2.WEB];
            web(url);
        end
        function forum()
            %FORUM opens the BRAPH2 forums.
            %
            % See also web, bluesky.
            
            url = ['http://' BRAPH2.WEB '/forums/'];
            web(url);
        end
        function bluesky()
            %BLUESKY opens the BRAPH2 Bluesky Feed.
            %
            % See also web, forum.
            
            url = ['https://bsky.app/profile/' BRAPH2.BLUESKY];
            web(url);
        end
    end
    methods (Static) % BRAPH2 checks
        function check_out = checkMatLab(ewm)
            %CHECKMATLAB checks whether the MatLab version is sufficiently new/error.
            %
            % CHECK = CHECKMATLAB() checks whether the MatLab version is sufficiently new.
            %
            % CHECKMATLAB('error') throws an error if the MatLab version is sufficiently new.
            %  Error id: BRAPH2:BRAPH2:WrongVersion.
            %
            % CHECKMATLAB('warning') throws a warning if the MatLab version is sufficiently new.
            %  Warning id: BRAPH2:BRAPH2.
            %
            % CHECKMATLAB('msgbox') opens a message box if the MatLab version is sufficiently new.
            
            persistent check %CET
            if isempty(check)
                check = ~verLessThan('MatLab', BRAPH2.MATLAB_VERSION);
            end
            
            if ((nargin == 0 && nargout == 0) || (nargin > 0 && strcmpi(ewm, 'error'))) && ~check
                error( ...
                    [BRAPH2.STR ':BRAPH2:' BRAPH2.WRONG_VER], ...
                    [BRAPH2.STR ':BRAPH2:' BRAPH2.WRONG_VER '\n' ...
                    'The minimal required MatLab version is ' BRAPH2.MATLAB_VERSION ' ' BRAPH2.MATLAB_RELEASE ', ' ...
                    'while the installed one is ' ver('MATLAB').Version ' ' ver('MATLAB').Release '.' ...
                    'Some BRAPH2 functionalities might not be available, ' ...
                    'or they might not function correctly.'] ...
                    )
            elseif nargin > 0 && strcmpi(ewm, 'warning') && ~check
                warning( ...
                    [BRAPH2.STR ':BRAPH2'], ...
                    [BRAPH2.STR ':BRAPH2 \n' ...
                    'The minimal required MatLab version is ' BRAPH2.MATLAB_VERSION ' ' BRAPH2.MATLAB_RELEASE ', ' ...
                    'while the installed one is ' ver('MATLAB').Version ' ' ver('MATLAB').Release '. ' ...
                    'Some BRAPH2 functionalities might not be available, ' ...
                    'or they might not function correctly.'])
            elseif nargin > 0 && strcmpi(ewm, 'msgbox') && ~check
                title = [BRAPH2.STR ' MatLab version warning'];

                message = {''
                    ['{\bf\color{orange}' BRAPH2.STR '}']
                    ['{\color{gray}version ' BRAPH2.VERSION '}']
                    ['{\color{gray}build ' int2str(BRAPH2.BUILD) '}']
                    ''
                    '{\bf{WARNING} - Wrong MatLab version}'
                    ''
                    ['MatLab ' BRAPH2.MATLAB_VERSION ' ' BRAPH2.MATLAB_RELEASE ' is required, ']
                    ['while MatLab ' ver('MATLAB').Version ' ' ver('MATLAB').Release ' is installed.']
                    ''
                    'Some BRAPH2 functionalities might not be available, '
                    'or they might not function correctly.'
                    ''
                    ''};

                braph2msgbox(title, message)
            end

            if nargout == 1
                check_out = check;
            end            
        end
        function check_out = installed(addon, ewm)
            %INSTALLED returns whether an addon is installed/error.
            %
            % CHECK = INSTALLED(ADDON) returns whether ADDON is installed.
            %  ADDON can be either the addon name or identifier.
            %
            % INSTALLED(ADDON, 'error') throws an error if ADDON is not installed.
            %  Error id: [BRAPH2:BRAPH2:MissingAddOn].
            %
            % INSTALLED(ADDON, 'warning') throws a warning if ADDON is not installed.
            %  Warning id: [BRAPH2:BRAPH2].
            %
            % INSTALLED(ADDON, 'msgbox') opens a message box if ADDON is not installed.
            %
            % BRAPH2 uses the following addons:
            %  - ST: "Statistics and Machine Learning Toolbox"
            %  - DM: "Parallel Computing Toolbox"
            %  - NN: "Deep Learning Toolbox"
            %
            % Some BRAPH2 functionalities might not be available if these addons are
            %  not installed.
            % 
            % A list of all installed addon can be obtained using
            %  <a href="matlab:matlab.addons.installedAddons">matlab.addons.installedAddons</a>

            persistent addonsNameIdentifiers %CET
            if isempty(addonsNameIdentifiers)
                addons = matlab.addons.installedAddons;
                addonsNameIdentifiers = [addons.Name; addons.Identifier];
            end
            check = ismember(addon, addonsNameIdentifiers);

            if ((nargin == 1 && nargout == 0 && ~check) || (nargin > 1 && strcmpi(ewm, 'error'))) && ~check
                error( ...
                    [BRAPH2.STR ':BRAPH2:' BRAPH2.MISS_ADDON], ...
                    [BRAPH2.STR ':BRAPH2:' BRAPH2.MISS_ADDON '\n' ...
                    'The addon ' addon ' is not installed. ' ...
                    'Some BRAPH2 functionalities might not be available, ' ...
                    'or they might not function correctly.'] ...
                    )
            elseif nargin > 1 && strcmpi(ewm, 'warning') && ~check
                warning( ...
                    [BRAPH2.STR ':BRAPH2'], ...
                    [BRAPH2.STR ':BRAPH2 \n' ...
                    'The addon ' addon ' is not installed. ' ...
                    'Some BRAPH2 functionalities might not be available, ' ...
                    'or they might not function correctly.'])    
            elseif nargin > 1 && strcmpi(ewm, 'msgbox') && ~check
                title = [BRAPH2.STR ' MatLab AddOn warning'];

                message = {''
                    ['{\bf\color{orange}' BRAPH2.STR '}']
                    ['{\color{gray}version ' BRAPH2.VERSION '}']
                    ['{\color{gray}build ' int2str(BRAPH2.BUILD) '}']
                    ''
                    '{\bf{WARNING} - Missing MatLab AddOn}'
                    ''
                    ['The addon ' addon ' is not installed. ']
                    'Some BRAPH2 functionalities might not be available, '
                    'or they might not function correctly.'
                    ''
                    ''};

                braph2msgbox(title, message)
            end

            if nargout == 1
                check_out = check;
            end
        end        
    end
end
