@ECHO off

@REM ~ABOUT THE COMMAND~

@REM version : v0.1.4
@REM Date    : 23-2-2026
@REM coder   : orsnaro - Omar Rashad
@REM system  : win11 - cmd 

@REM This 'cdv' command soft modifies 'cd' command To enable python auto-venv features (not recommended to use PATHS WITH SPACES)
@REM [TODO] refactorise code by moving related scripts to a separate goto tags

@REM ~END ABOUT THE COMMAND~


@REM ~START OF THE BATCH SCRIPT~

@REM This file is UTF-8 encoded, so we need to update the current code page while executing it
@REM get old codpage i.e.(char encoding)
for /f "tokens=2 delims=:." %%a in ('"%SystemRoot%\System32\chcp.com"') do (
    set _OLD_CODEPAGE_=%%a
)
@REM update to new encoding i.e.(UTF-8)
if defined _OLD_CODEPAGE_ (
    "%SystemRoot%\System32\chcp.com" 65001 > nul
)


@REM I don't want to touch python venv variables so copy it
if defined VIRTUAL_ENV (set "CDV_VIRTUAL_ENV=%VIRTUAL_ENV%")



SETLOCAL EnableDelayedExpansion ENABLEEXTENSIONS

@REM getting path arg and extra options arg
set "fstPoShellArg=%~1"
set "CDV_SCRIPTS_PATH=%~dp0"

@REM pre-process the shell arg: remove double quotes and replace forward slash with backslah
if not "%~1" == "" (
	set "fstPoShellArg=%~1"
	set fstPoShellArg=!fstPoShellArg:/=\!
)

if /I "!fstPoShellArg!"=="-i" (
	set "toCheckPath=%CD%" && set "command_options=-i" 
) else (
	if /I "!fstPoShellArg!"=="-q" (
		set "toCheckPath=%CD%" && set "command_options=-q"
	) else ( 
		if /I "!fstPoShellArg!"=="-d" (
			set "toCheckPath=%CD%" && set "command_options=-d"
		) else (
			if /I "!fstPoShellArg!"=="-h" (
				set "toCheckPath=%CD%" && set "command_options=-h"
			) else ( 
				if "!fstPoShellArg!"=="" (
					set "toCheckPath=%CD%" && set "command_options=%2"
				) else (
					set "toCheckPath=!fstPoShellArg!" && set "command_options=%2" 
				)
			)
		)
	)
)

@REM it's safer with quotes! but REMOVE any double quote in the path then append and prepend double quotes 
@REM to the path just before using normal cd  command at end of the process
set toCheckPath=!toCheckPath:"=!

@REM replace all forward slashes with back slashes 
set toCheckPath=!toCheckPath:/=\!

@REM always make last char to be the backslash "\"
set "lastChar=!toCheckPath:~-1!"
if not "!lastChar!"=="\" ( set "toCheckPath=!toCheckPath!\" )


if /I "!command_options!"=="-h" ( 
	@REM call !CDV_SCRIPTS_PATH!help.bat 

	@REM better keep tool all-in-one file (portable)
	goto help_section
	goto normal_exit
)

if /I "!command_options!"=="-q" (
	@REM disable all cdv effects: only deactivate python venv then  normally change dir via 'cd' to the provided path

	set "NEEDS_DEACTIVATION=1"

	goto normal_cd
)



if exist "!toCheckPath!" ( 


	if /I "!command_options!"=="-d" ( 
		
		echo.
		echo  Type 'y' if you are sure you want to delete the auto-venv of this dir^? choose ^(y / n^)
		echo [93m [96mNOTE: all auto-venv configs and python modules/libs inside the venv will be deleted [0m 
		echo --------------------------------------------------------------------------
		set "is_confirmed=n"
		set /p "is_confirmed=S U R E ? (y/n) "
		
		if /I "!is_confirmed!"=="y" (
			
			set /p venv_name=< !toCheckPath!.is_autoVenv


			if not "!venv_name!" == "" ( 
				set "NEEDS_DEACTIVATION_THEN_DELETE=1" 
			) else (
				echo Failed! try going to the project DIR first then use "cdv -d"
				goto exit_error
			)


			goto normal_cd
		) 
		
		goto normal_exit
	)


	if /I "!command_options!"=="-i" ( 
		type nul > !toCheckPath!.is_autoVenv
		@REM if it's a git repo add this file to ignored files
		if exist "!toCheckPath!.git\" ( echo.>> !toCheckPath!.gitignore && echo .is_autoVenv>> !toCheckPath!.gitignore )
		@REM question: where is the rest of init logic? 
		@REM answer: (.is_autoVenv) existense is checked later. 
		@REM If it's existing already! this.bat will continue init logic (for new/already existing venvs)
	)
	
	@REM leaving the backslash at end of path will make 
	@REM it harder to use '~' or get dir name using other methods. so remove it!
	set toCheckPath=!toCheckPath:~0,-1!

	for /d %%p in (!toCheckPath!) do (
		set "dir_name=%%~np" 
		@REM actually ~nx gets the name with extention in case of path was file not dir path.'~n' 
		@REM is an  extractor or slicing operator must work inside for loop
	)

	if exist "!toCheckPath!\.is_autoVenv" (

		@REM NOTE: appending "_venv" to end of your proj dir name.
		@REM This will be your auto-venv dir name for this project or repo

		@REM we need dir_name but REMOVE ANY WHITE SPACES FIRST!
		set dir_name=!dir_name: =!
		set "venv_dir_name=!dir_name!_venv"
		
		@REM if super dir for all venvs of project "py_envs\" not exist. Make it then make venv if not there then activate it!
		if not exist "C:\Users\%USERNAME%\py_envs\" ( mkdir C:\Users\%USERNAME%\py_envs\ )
		if not exist "C:\Users\%USERNAME%\py_envs\!venv_dir_name!\" (
		
			echo.
			echo [93m [93m=================================================================================[0m
			echo [93m [96m NOTE: No python virtual environment found with name: "!venv_dir_name!". [0m
			echo [93m [93m=================================================================================[0m	
			echo.
			
			echo Creating new "!dir_name!" auto-venv ...
			echo.

			echo Chooses a python version for this virtual environment. choose ^(1 / 2^)
			echo 1^) [default] machine's global python
			echo 2^) [custom] specify desired python executable pa'th 
			echo ----------------------------------------------------------
			set "python_setup_type=1"
			set /p "python_setup_type=Choice (1/2) "

			echo.
			 

			if "!python_setup_type!"=="2" (
				echo Searching For Available Pythons on this machine... ^(might be helpfull^):
				where python
				echo.

				set /p py_path=Enter Needed Python executable folder path ^(no spaces^) || goto bad_exit

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
									
			@REM save venv name inside '.is_autoVenv' file
			echo !venv_dir_name!> !toCheckPath!\.is_autoVenv


			echo Done creating new python project virtual environment. 
			echo venv activating ...
		)
				
		
		set "final_venv_active_path=C:\Users\%USERNAME%\py_envs\!venv_dir_name!\Scripts\activate"

		@REM re-activate (what is wrong? venv is already active? yes but not the correct proj venv)
		@REM this handles reacitvate to the correct venv 
		@REM ACTUALLY RE-ACTIVATE IS NOT NEEDED Activate.bat handles the case cleanly
		@REM it carries the original shell variables throught nested Activate.bat so when u use first deactivate.bat you go back clean!
		
		set "NEEDS_ACTIVATION=1"

		goto normal_cd

	) else (
		@REM NOTE: more faster & optimized implementation (but needs to be thought more cuz this was 
		@REM the prev reverted not working commit 'd291ed5') is to check venv dir name 
		@REM(with out _venv suffix) against dir and parent dirs names  
		@REM not search for .is_autoVenv file (searching filese in filled up dirs is costly!)

		set "found_is_autoVenv_file=0"
		set "target_file=.is_autoVenv"

		@REM expand to abs path 
		for %%i in ("!toCheckPath!") do set "toCheckPath=%%~fi"

		@REM now search the .is_autoVenv file in dir that we want to cdv to or its parents (max 12 levels up to root \)
		for /L %%i IN (1, 1, 12) DO (

			@REM loop stops eating from path when reach root or found a .is_autoVenv or traveresed enough levels 
			@REM this matches all drives letters
			if /I "!toCheckPath!"=="!toCheckPath:~0,1!:\" goto loop_exit
			

			@REM remove trailing backslash except root backslash
			if "!toCheckPath:~-1!"=="\" set "toCheckPath=!toCheckPath:~0,-1!"

			where /Q "!toCheckPath!:!target_file!"
			if !ERRORLEVEL! EQU 0 (
				set "found_is_autoVenv_file=1"
				goto loop_exit
			)

			@REM eat one most inner dir (actually it removes one dir from the given path nice trick!) 
			for %%i in ("!toCheckPath!\.") do set "toCheckPath=%%~dpi"
		)	

		:loop_exit
		if "!found_is_autoVenv_file!"=="0" (

			set "NEEDS_DEACTIVATION=1"

			goto normal_cd
		) else ( 
			@REM pingo  there is .is_autoVenv file in parents dir! 
			@REM now if venv is not activated activate the correct one for the parent that we found .is_autoVenv in 
			@REM else check if Current venv is the same as target found one if same do nothing 
			@REM if not same  call activate.bat again

			set /p final_venv_dir_name=< !toCheckPath!\.is_autoVenv

			@REM trim whitespaces
			set final_venv_dir_name=!final_venv_dir_name: =!

			set "final_venv_active_path= C:\Users\%USERNAME%\py_envs\!final_venv_dir_name!\Scripts\Activate"

			@REM activate flag set logic
			if not defined CDV_VIRTUAL_ENV (
				set "PARENT_NEEDS_ACTIVATION=1"
			) else (
				if not "%CDV_VIRTUAL_ENV%" == "C:\Users\%USERNAME%\py_envs\!final_venv_dir_name!" (
					set "PARENT_NEEDS_ACTIVATION=1"
				)
			)
			

			goto normal_cd
		)
	)	
) else (
	:exit_error
	echo Error: provided path does not exist.
	echo Note: Use "cdv -h" for help on "cdv" command
	goto bad_exit
)



:normal_cd


@REM end localisation before running activate.bat/deactivate.bat 
@REM if called activate.bat/deactivate.bat before ending local scope! it will reverte all what activate.bat/deactivate.bat did in local scope
ENDLOCAL & (
	set "NEEDS_DEACTIVATION=%NEEDS_DEACTIVATION%"
	set "NEEDS_ACTIVATION=%NEEDS_ACTIVATION%"
	set "PARENT_NEEDS_ACTIVATION=%PARENT_NEEDS_ACTIVATION%"
	set "final_venv_active_path=%final_venv_active_path%"
	set "NEEDS_DEACTIVATION_THEN_DELETE=%NEEDS_DEACTIVATION_THEN_DELETE%"
	set "venv_name=%venv_name%"
	set "toCheckPath=%toCheckPath%"
)

if "%NEEDS_DEACTIVATION_THEN_DELETE%"=="1" (
	if defined CDV_VIRTUAL_ENV ( call %CDV_VIRTUAL_ENV%\Scripts\deactivate )


	@REM delete auto-venv folder
	echo Confirmed .. Deleting all auto-venv data for this folder... the auto-venv folder name: !venv_name!

	if exist "C:\Users\%USERNAME%\py_envs\%venv_name%" ( attrib -r -s -h "C:\Users\%USERNAME%\py_envs\%venv_name%\*.*" /s /d && rd /Q /S "C:\Users\%USERNAME%\py_envs\%venv_name%")
			
	@REM delete .is_autoVenv file
	if exist "%toCheckPath%.is_autoVenv" ( attrib -r -s -h "%toCheckPath%.is_autoVenv" && del /Q /F "%toCheckPath%.is_autoVenv" && echo DONE Deleting )
)

if "%NEEDS_DEACTIVATION%"=="1" (
	if defined CDV_VIRTUAL_ENV ( call %CDV_VIRTUAL_ENV%\Scripts\deactivate )
)

if "%NEEDS_ACTIVATION%"=="1"  call %final_venv_active_path%

if "%PARENT_NEEDS_ACTIVATION%"=="1" call %final_venv_active_path%

@REM don't wait to clean those global FLAGS later... do it rightaway!
set NEEDS_DEACTIVATION=
set NEEDS_ACTIVATION=
set PARENT_NEEDS_ACTIVATION=
set NEEDS_DEACTIVATION_THEN_DELETE=

@REM finally cd to your project folder and exit :)!
set "fstPoShellArg=%~1"
if "%fstPoShellArg%"=="" (for /f "delims=" %%i in ("%CD%") do echo %%i) else ( if /I not "%fstPoShellArg%"=="-q" ( if /I not "%fstPoShellArg%"=="-i" ( if /I not "%fstPoShellArg%"=="-d" (cd /d "%fstPoShellArg%") ) ) )
@REM cd works after ending localisation  so new dir in %CD% is in global scope not local

:normal_exit
@REM TODO: all temp files will be here
if exist "%ProgramData%\CDV\Temp" ( rd /Q /S "%ProgramData%\CDV\Temp" ) 


@REM clean
set CDV_SCRIPTS_PATH=
set CDV_VIRTUAL_ENV=
set final_venv_active_path=
set venv_dir_name=
set dir_name=
set py_path=
set lastChar=
set python_setup_type=
set toCheckPath=
set fstPoShellArg=
set found_is_autoVenv_file=
set target_file=
set  is_debug=
set is_confirmed=
set venv_name=
set command_options=
set final_venv_dir_name=
set NEEDS_DEACTIVATION=
set NEEDS_ACTIVATION=
set PARENT_NEEDS_ACTIVATION=
set NEEDS_DEACTIVATION_THEN_DELETE=

@REM revert to old default encoding
if defined _OLD_CODEPAGE_ (
    "%SystemRoot%\System32\chcp.com" %_OLD_CODEPAGE_% > nul
    set _OLD_CODEPAGE_=
)

exit /b 0

:bad_exit
@REM TODO: all temp files will be here
if exist "%ProgramData%\CDV\Temp" ( rd /Q /S "%ProgramData%\CDV\Temp" )

ENDLOCAL
@REM clean
set CDV_SCRIPTS_PATH=
set CDV_VIRTUAL_ENV=
set final_venv_active_path=
set venv_dir_name=
set dir_name=
set py_path=
set lastChar=
set python_setup_type=
set toCheckPath=
set fstPoShellArg=
set found_is_autoVenv_file=
set target_file=
set  is_debug=
set is_confirmed=
set venv_name=
set command_options=
set final_venv_dir_name=
set NEEDS_DEACTIVATION=
set NEEDS_ACTIVATION=
set PARENT_NEEDS_ACTIVATION=
set NEEDS_DEACTIVATION_THEN_DELETE=

@REM revert to old default encoding
if defined _OLD_CODEPAGE_ (
    "%SystemRoot%\System32\chcp.com" %_OLD_CODEPAGE_% > nul
    set _OLD_CODEPAGE_=
)

exit /b 1


:help_section
echo.
echo [93m [93m==============================================================================[0m
echo [93m =                    [96m      ~ABOUT THE "CDV" COMMAND~                         [93m= [0m
echo [93m [93m==============================================================================[0m	
echo [93m version : V0.1.4
echo [93m Date    : 23-2-2026
echo [93m made by : orsnaro - Omar Rashad
echo [93m system  : win11 - cmd 
echo.
echo.
echo [93m "This `CDV` command soft Modifies & Enhances 'CD' command by doing this:"
echo.
echo [93m "Can be used like this `CDV <path_arg> <extra_options_arg>` "
echo.
echo [96m 0. [0m "Use `CDV -h` To get `CDV` tool help guide [THIS]"
echo.
echo [96m 1. [0m "Use `CDV -i` or `CDV <path> -i`: to initialize auto-venv for first time" 
echo [96m 1.1. [0m "i.e. `CDV` creates '.is_autoVenv' file then makes new auto-venv folder for current project / repository or provided path then auto activates the venv"
echo.
echo [96m 2. [0m "Use `CDV -d` or `CDV <path> -d` to delete the venv and all auto-venv configs for this DIR / Repository"
echo.
echo [96m 3. [0m "Use `CDV -q` or `CDV <path> -q` to quit and deactivate the venv"
echo.
echo [96m 4. [0m "`CDV` by default uses /d switch of 'CD' command" 
echo.
echo [96m 5. [0m "`CDV` checks if path you CDV'ing to has '.is_autoVenv' file"
echo [96m 5.1. [0m "if not: It creates it (if this DIR is a git repo it configures '.gitignore' for `CDV`)"
echo.
echo [96m 6. [0m "`CDV`checks if there is existing CDV-configured python venv for it"
echo [96m 6.1. [0m "if there is `CDV` activates it, if not `CDV` makes new CDV-configured python venv then activates it"
echo.
echo [96m 7. [0m "To use it easily add `CDV.bat` folder path to your path variable in system environmental variables"
echo [96m 7.1. [0m "(if used release version installer will adds the path for you)"
echo.
echo [96m 8. [0m "All CDV python venvs folders are by default created at: 'C:\Users\USERNAME\py_envs\' "
echo.
echo [96m 9. [0m "Naming conventions for venvs is the 'proj_folder_name'+'_venv' "
echo [96m 9.1. [0m "(if proj folder name has spaces (not-recommended) will be removed first) "
echo.
echo [96m finally: [0m " `CDV` auto deactivates the venv when CDV'ing out of the project dir and auto activates if CDV'ing to a any folder in a project that has CDV auto-venv configured"
echo.
echo.
echo [104m [INFO] [0m "for more visit: https://github.com/orsnaro/CDV-windows-autoenv-tool "
echo.
echo.
echo [91m ~
echo [93m [IMPORTANT] [0m "(NOT RECOMMENDED TO USE PATHS THAT HAS WHITE CHARACTERS/SPACES)"
echo.
echo [93m "[works/tested on windows 10 & windows 11 OS]"[0m
echo [91m ~ [0m

goto normal_exit

@REM ~END OF THE BATCH SCRIPT~
:END