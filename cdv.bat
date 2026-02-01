@ECHO off
SETLOCAL EnableDelayedExpansion ENABLEEXTENSIONS

@REM ~ABOUT THE COMMAND~
@REM version : V0.1.3
@REM Date    : 31-1-2026
@REM made by : orsnaro - Omar Rashad
@REM system  : win11 - cmd 



@REM ~START OF THE BATCH SCRIPT~




@REM Debug & logging mode ? only on if %3 == -1 ( use 'if defined is_debug'  anywhere before any echo that is used for logging/debugging )
set /A is_debug=1
@REM check if third shell arg -currently only used to enable debug- is not set first to elemenate 'missing operand' msg in console
if [%3] NEQ [] (
	if "%3" NEQ "-1" ( set /A is_debug= ) else ( echo [101m [DEBUG MODE IS ON] [0m && ECHO ON )
)

@REM getting path arg and extra options arg
set  fstPoShellArg=%1

if [%1] NEQ [] (
	set fstPoShellArg=!fstPoShellArg:/=\!
	set fstPoShellArg=!fstPoShellArg:"=!
)

if "!fstPoShellArg!"=="-i" (
	set "toCheckPath=%CD%" && set "command_options=-i" 
) else (
	if "!fstPoShellArg!"=="-1" (
		set "toCheckPath=%CD%" && set "command_options=-1"
	) else ( 
		if "!fstPoShellArg!"=="-d" (
			set "toCheckPath=%CD%" && set "command_options=-d"
		) else (
			if "!fstPoShellArg!"=="-h" (
				set "toCheckPath=%CD%" && set "command_options=-h"
			) else ( 
				if "!fstPoShellArg!"=="-nr" (
					set "toCheckPath=%CD%" && set "command_options=-nr"
				) else (
					if [!fstPoShellArg!]==[] (
						set "toCheckPath=%CD%" && set "command_options=%2"
					) else (
						@REM use the explcitly provided dir path not the current dir stored in %CD%
						set "toCheckPath=!fstPoShellArg!" && set "command_options=%2" 
					)
				)
			)
		)
	)
)

@REM it's safer with quotes! but REMOVE any double quote in the path then append and prepend double quotes to the path just before using normal cd  command at end of the process
set toCheckPath=!toCheckPath:"=!

@REM replace all forward slashes with back slashes 
set toCheckPath=!toCheckPath:/=\!

@REM if it's relative make it always abs path
for %%A in ("%toCheckPath%") do set "toCheckPath=%%~fA"

@REM always make last char to be the backslash "\"
set "lastChar=!toCheckPath:~-1!"
if not "!lastChar!"=="\" ( set "toCheckPath=!toCheckPath!\" )

if "!command_options!"=="-1" (
	@REM disable all cdv effects: only deactivate python venv then  normally change dir via 'cd' to the provided path ( 
	ENDLOCAL
	if defined VIRTUAL_ENV ( call %VIRTUAL_ENV%\Scripts\deactivate )
	goto normal_cd
)

if "!command_options!"=="-h" ( 
	echo.
	echo [93m [93m==============================================================================[0m
	echo [93m =                    [96m      ~ABOUT THE "CDV" COMMAND~                         [93m= [0m
	echo [93m [93m==============================================================================[0m	
	echo [93m version : V0.1.3
	echo [93m Date    : 31-1-2026
	echo [93m made by : orsnaro - Omar Rashad
	echo [93m system  : win10 - win11 - cmd 
	echo.
	echo.
	echo [93m "this 'cdv' command soft modifies 'cd' command by doing this:"
	echo.
	echo [96m 0. [0m "To get `cdv` command help [THIS]  use `cdv -h`"
	echo.
	echo [96m 1. [0m "`cdv` by default uses /d switch of 'cd' command" 
	echo.
	echo [96m 2. [0m "`cdv` checks if path you cdv'ing to has '.is_autoVenv' file if not. It creates it (if this DIR is a git repo it configures '.gitignore' for `cdv`)"
	echo.
	echo [96m 3. [0m "`cdv`checks if there is existing cdv python venv for it: if there is `cdv` activates it, if not `cdv` makes new cdv python venv then activates it"
	echo.
	echo [96m 4. [0m "To use it easly add `cdv.bat` folder path to your path variable in system environmental variables (in release version installer will add it auto and cdv tool files  will be at 'C:\Users\USERNAME\cdv\' )"
	echo.
	echo [96m 5. [0m "If used `cdv -i` or `cdv <path> -i`: initialize '.is_autoVenv' then make new venv for current DIR or provided path then activate the venv"
	echo.
	echo [96m 6. [0m "If used `cdv -1` or `cdv <path> -1`: deacctivates current activated venv"
	echo.
	echo [96m 7. [0m "If used `cdv -nr` or `cdv <path> -nr`: 'non-recursive' disables nested auto-vnevs and recursive searching in parent dirs for auto-venvs i.e.(nearest parent dir that have '.isAutoVenv' if there is will be activated) disabling may make cdv faster and less costy"
	echo.
	echo [96m 8. [0m "All cdv python venvs folders are by default created at: 'C:\Users\USERNAME\py_envs\'"
	echo.
	echo [96m 9. [0m "Naming conventions for venvs is the "proj_folder_name"+"_venv"  (if proj folder name has spaces will be removed first) "
	echo.
	echo [96m 10. [0m "When creating venv for first time you can choose to use machine default global python version or specific version just by providing it's .exe dir path! TODO: cdv it self will searach common python install dirs and list available versions for you to use "
	echo.
	echo [96m finally: [0m "Use `cdv -d` or `cdv <path> -d` to delete the venv and all auto venv configs for this DIR"
	echo.
	echo.
	echo [104m [TODO] [0m "Refactorise code by moving related scripts to a separate goto tag i.e.(function)"
	echo.
	echo [104m [TODO] [0m "find an optimized way to search for nearest parent dir that has'.is_autoVenv' if not found in current\provided dir (this allows for nested venvs!  also better venv activation with out needing to cd first to project base dir that has the '.is_autoVenv')"
	echo.
	echo [104m [INFO] [0m "for more visit: https://github.com/orsnaro/CDV-windows-autoenv-tool "
	echo.
	echo.
	echo [91m ~ [0m
	echo [93m IMPORTANT: [0m "(DON'T USE FOLDER NAMES OR PATHS HAVING WHITE CHARACTERS!)"
	echo.
	echo [0m "the command is mostly used with cd aliases to repoes ( other wise make its default is to disable extra modification and do normal cd unless ^%2 is set to "1")"
	echo.
	echo [93m "[works/tested on windows10 and windows 11 OS. can be used like this: `cdv path_arg <toggle_venv_arg>`]"[0m
	echo [91m ~ [0m
	
	ENDLOCAL
	exit /b 0
)


if exist "!toCheckPath!" ( 

	@REM leaving the backslash at end of path will make it harder to use '~' or get dir name using other methods. so remove it!
	set toCheckPath=!toCheckPath:~0,-1!

	@REM we do recursive search upwards for venvs by default. But you can disable this!
	@REM In batch we can consider any other than 0 to be false
	if "!command_options!"=="-nr" (set "is_recursive_venv_search_disabled=1") 

	@REM lets look for .is_autoVenv in current dir then nearest parent dir and so on until root (this may be costy!)
	
	@REM  entering this cond. means recursive search for venvs is Active!
	set "checked_path=!toCheckPath!"
	if exist "!checked_path!\.is_autoVenv" (goto exit_venv_dirs_loop)
	if defined is_recursive_venv_search_disabled (goto exit_venv_dirs_loop)

	:venv_dirs_loop
	set "prev_path=!checked_path!"

	@REM start traversing upward dir by dir (actually it removes one dir each itteration from the given path) (note: this for is actually a very nice trick!)
	for %%i in ("!checked_path!\.") do set "checked_path=%%~dpi"
	@REM loop stop eating from path when reach root (prev==current)
	if "!checked_path!"=="!prev_path!" (goto exit_venv_dirs_loop)
	if "!checked_path!"=="C:\" (goto exit_venv_dirs_loop)

	@REM remove trailing backslash except root backslash
	if "!checked_path:~-1!"=="\" set "checked_path=!checked_path:~0,-1!"

	echo CHECKING: [!checked_path!]

	if exist "!checked_path!\.is_autoVenv" (goto exit_venv_dirs_loop)


	goto venv_dirs_loop

	:exit_venv_dirs_loop


	if "!command_options!"=="-d" ( 
		
		echo.
		echo Type 'y' if you sure you want to delete the venv of this dir^? choose ^(y / n^)
		echo [93m [96mNOTE: all auto venv configs and python libs inside the venv will be deleted. [0m 
		echo --------------------------------------------------------------------------
		set /p is_confirmed=  || set is_confirmed=n
		
		if /I "!is_confirmed!"=="y" (
			echo.
			echo "deleting (auto venv configs / cdv configs / all venv ) for this dir ..."
			
									
			ENDLOCAL checked_path
			@REM deactivate 
			if defined VIRTUAL_ENV ( call %VIRTUAL_ENV%\Scripts\deactivate.bat )
			
			setlocal EnableDelayedExpansion
			
			set /p venv_name=< !checked_path!\.is_autoVenv
						
			@REM delete venv folder
			if exist "C:\Users\%USERNAME%\py_envs\!venv_name!" ( rd /S C:\Users\%USERNAME%\py_envs\!venv_name!)
					
			@REM delete .is_autoVenv
			if exist "!checked_path!\.is_autoVenv" (rm -f !checked_path!\.is_autoVenv && echo Done.)
						
			@REM clean temp files and temp vars
			set checked_path=
			set venv_name=
			
				
		) else ( ENDLOCAL )
		
		exit /b 0
	)
	if "!command_options!"=="-i" ( 
		type nul > !checked_path!\.is_autoVenv
		@REM if it's a git repo add this file to ignored files
		if exist "!checked_path!\.git\" ( echo .is_autoVenv >> !checked_path!\.gitignore )
		@REM question: where is the rest of init logic? 
		@REM answer: (.is_autoVenv) existense is checked later. IIf it's existing .bat will continue init logic (for new/already existing venvs)
	)

	if exist "!checked_path!\.is_autoVenv" (
		@REM TODO: related to TODO in help: find an optimized way to search for nearest parent dir that has'.is_autoVenv' if not found in current or provided dir (this allows for nested venvs and also better venv activation with out needed to cd first to project base dir that hase the '.is_autoVenv')
		@REM NOTE: <optional> append "_venv" to end of your proj folder name. This is optional step. This would be your venv folder name for this project or repo
		@REM choose any name pattern that will not be repeated or assign same proj folder name to proj venv name...

		for /d %%p in (!checked_path!) do (
			set "dir_name=%%~np" 
			@REM actually ~nx gets the name with extention in case of path was file not dir path.'~n' is an  extractor or slicing operator must work inside for loop
		)

		@REM REMOVE ANY WHITE SPACES FIRST!
		set dir_name=!dir_name: =!
		set  "venv_dir_name=!dir_name!_venv"
		
		@REM if super folder for all venvs of project "py_envs\" not exist. Make it then make venv if not there then activate it!
		if not exist "C:\Users\%USERNAME%\py_envs\" ( mkdir C:\Users\%USERNAME%\py_envs\ )
		if not exist "C:\Users\%USERNAME%\py_envs\!venv_dir_name!\" (
		
			echo.
			echo [93m [93m=================================================================================[0m
			echo [93m [96m NOTE: no python virtual environment found with name: "!venv_dir_name!". [0m
			echo [93m [93m=================================================================================[0m	
			echo.
			
			echo Creating new "!dir_name!" venv ...
			echo.

			echo Chooses a python version for this virtual environment. choose ^(1 / 2^)
			echo 1^) [default] machine's global python
			echo 2^) [custom] specify desired python executable ^path 
			echo ----------------------------------------------------------
			set /p python_setup_type= || set python_setup_type=1

			echo.
			 

			if "!python_setup_type!"=="2" (
				set /p py_path=Enter Python executable folder path ^(no spaces^) || goto exit_error

				@REM replace all forward slashes with back slashes 
				set "!py_path!=!py_path:/=\!"

				@REM always make last char to be the backslash "\"
				set "lastChar=!py_path:~-1!"
				if not "!lastChar!"=="\" ( set "py_path=!py_path!\" )

				call !py_path!python.exe -m venv C:\Users\%USERNAME%\py_envs\!venv_dir_name!\
			) else ( 
				@REM if input is 1 or any else than 2 choice just use the default (TODO: if enters other than 1 or 2 handle it!)
				call python.exe -m venv C:\Users\%USERNAME%\py_envs\!venv_dir_name!\
			)
									
			echo Done creating new venv ~activating ...
		)
				
		@REM save venv name inside '.is_autoVenv' file
		echo !venv_dir_name! > !checked_path!\.is_autoVenv
			
		set final_venv_active_path=C:\Users\%USERNAME%\py_envs\!venv_dir_name!\Scripts\activate
		
		@REM all this variable will vanish after ENDLOCAL is called so save the path to a file instead to be able to use after ENDLOCAL
		type nul > C:\Users\%USERNAME%\final_venv_active_path.txt
		echo !final_venv_active_path! > C:\Users\%USERNAME%\final_venv_active_path.txt
		
		@REM end localisation before running activate.bat so delcared env var inside it remain global scoped
		ENDLOCAL 
		
		set /p final_venv_active_path=<  C:\Users\%USERNAME%\final_venv_active_path.txt
		if defined VIRTUAL_ENV ( call %VIRTUAL_ENV%\Scripts\deactivate.bat )
		call %final_venv_active_path%
		
		
	) else (
		@REM let's check if we still inside project dir or we left (if left deactivate the venv):
		if defined VIRTUAL_ENV (
			@REM -> copy VIRTUAL_ENV var but remove the '_venv' suffix (warning! thus this won't work with any venv dirs created not using cdv or at least not following same naming conv.)

			@REM 1)extract only the project folder name of venv
			for %%A in ("%VIRTUAL_ENV%") do set "project_full_name=%%~nxA"

			@REM 2) remove the suffix '_vnev'
			set "name_without_suffix=!project_full_name:_venv=!"

			@REM 3) now search this name in the current path\path provided as arg for 'cdv' (I think recursive search done before will save tiny amount if used 'checked_path' instead of 'toCheckPath' with findstr cuz shorter path )
			echo !toCheckPath! | findstr /i "\\!name_without_suffix!\\" >nul
			if NOT !errorlevel!==0 (
				@REM PINGO! the path we are in\need to go to is not a one that needs current active venv (or any of its parent dirs)
				ENDLOCAL
				call %VIRTUAL_ENV%\Scripts\deactivate
			) 
		)	
		ENDLOCAL
		set fstPoShellArg=%1
		if [%fstPoShellArg%] NEQ [] set fstPoShellArg=%fstPoShellArg:"=%
		@REM ENDLOCAL
		if [%fstPoShellArg%]==[] (echo %CD%) else ( if not "%fstPoShellArg%"=="-1" ( if not "%fstPoShellArg%"=="-i" ( if not "%fstPoShellArg%"=="-d" (cd /d "%fstPoShellArg%") ) ) )
		@REM cd works after ending localisation  so new dir in %CD% is in global scope not local
		exit /b 0
	)	
) else (
	:exit_error
	echo Error: provided path does not exist.
	echo Note: Use "cdv -h" for help on "cdv" command
	ENDLOCAL
	@REM error val: didn't find resources requested
	exit /b 3 
)


@REM VIRTUAL_ENV check is not reliable(better call python code to detect a used venv!) see pythonV3.14.2 docs: https://docs.python.org/3/library/venv.html#:~:text=VIRTUAL_ENV%20cannot%20be%20relied%20upon%20to%20determine%20whether%20a%20virtual%20environment%20is%20being%20used.
if defined VIRTUAL_ENV ( call %VIRTUAL_ENV%\Scripts\deactivate.bat ) 
if defined final_venv_active_path (call %final_venv_active_path%)
if exist "C:\Users\%USERNAME%\final_venv_active_path.txt" ( rm -f C:\Users\%USERNAME%\final_venv_active_path.txt )

:normal_cd
@REM finally cd to your project folder and exit :)!

@REM ENDLOCAL
set fstPoShellArg=%1
if [%fstPoShellArg%] NEQ [] set fstPoShellArg=%fstPoShellArg:"=%
if [%fstPoShellArg%]==[] (echo %CD%) else ( if not "%fstPoShellArg%"=="-1" ( if not "%fstPoShellArg%"=="-i" ( if not "%fstPoShellArg%"=="-d" (cd /d "%fstPoShellArg%") ) ) )
@REM cd works after ending localisation  so new dir in %CD% is in global scope not local
exit /b 0

@REM ~END OF THE BATCH SCRIPT~