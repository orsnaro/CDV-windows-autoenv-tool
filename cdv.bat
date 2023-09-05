@ECHO off
SETLOCAL EnableDelayedExpansion ENABLEEXTENSIONS

REM ~ABOUT THE COMMAND~

rem version : V0.1.1
rem Date    : 5-9-2023
rem made by : orsnaro - Omar Rashad
rem system  : win10 - cmd 

rem this 'cdv' command soft modifies 'cd' command by doing this: (DONT USE FOLDER NAMES OR PATHS WITH SPACES!)


rem 0. To get `cdv` command help [THIS]  use `cdv -h`
rem 1. always using /d switch of 'cd' command 
rem 2. checks if path you cdv'ing to has '.is_autoVenv' file if not make it and add it to '.gitignore' if this dir is a git repo
rem 3. check if there is exist python venv for it : if there is activate it , if not make the it then activate it
rem 4. to use it easly add `cdv.bat` folder path to your path variable in system environmental variables (in release version installer will add it auto and tool path will be at C:\Users\%USERNAME%\cdv\ )
rem 5. if used `cdv -i` or `cdv <path> -i` : initialize .is_autoVenv then make new venv for current dir or provided path then activate the venv
rem 6. all venv folrders are in: C:\Users\%USERNAME%\py_envs\
rem 7. naming conventions for venvs is the "proj_folder_name"+"_venv"
rem 8. use `cdv -d` or `cdv <path> -d` to delete the venv and all auto venv configs for this dir!


rem [TODO] refactorise code by moving related scipts to a separate goto tag i.e.(function)

rem ~
rem IMPORTANT: the command mostly used inside aliases of cd to repoes ( other wise make its default to disable extra modification and do normal cd unless %2 is set to "1")
rem ~

REM ~END ABOUT THE COMMAND~


REM ~START OF THE BATCH SCRIPT~
if "%1"=="-i" (
	set "toCheckPath=%CD%" && set "toggleVenv=-i" 
) else (
	if "%1"=="-1" (
		set "toCheckPath=%CD%" && set "toggleVenv=-1"
	) else ( 
		if "%1"=="-d" (
			set "toCheckPath=%CD%" && set "toggleVenv=-d"
		) else (
			if "%1"=="-h" (
				set "toCheckPath=%CD%" && set "toggleVenv=-h"
			) else ( 
				if [%1]==[] (
					set "toCheckPath=%CD%" && set "toggleVenv=%2"
				) else (
					set "toCheckPath=%1" && set "toggleVenv=%2" 
				)
			)
		)
	) 
)

if "!toggleVenv!"=="-1" (
	rem disable all cdv effects only deactivate python venv then  normally change dir via 'cd' to the provided path ( 
	ENDLOCAL
	if defined VIRTUAL_ENV ( call %VIRTUAL_ENV%\Scripts\deactivate )
	goto normal_cd
)

if "!toggleVenv!"=="-h" ( 
	echo.
	echo [93m [93m==============================================================================[0m
	echo [93m =                    [96m      ~ABOUT THE "CDV" COMMAND~                         [93m= [0m
	echo [93m [93m==============================================================================[0m	
	echo [93m version : V0.1.1
	echo [93m Date    : 5-9-2023
	echo [93m made by : orsnaro - Omar Rashad
	echo [93m system  : win10 - cmd 
	echo.
	echo.
	echo [93m "this 'cdv' command soft modifies 'cd' command by doing this:"
	echo.
	echo [96m 0. [0m "To get `cdv` command help [THIS]  use `cdv -h`"
	echo.
	echo [96m 1. [0m "always using /d switch of 'cd' command" 
	echo.
	echo [96m 2. [0m "checks if path you cdv'ing to has '.is_autoVenv' file if not make it and add it to '.gitignore' if this dir is a git repo"
	echo.
	echo [96m 3. [0m "check if there is exist python venv for it : if there is activate it , if not make the it then activate it"
	echo.
	echo [96m 4. [0m "to use it easly add `cdv.bat` folder path to your path variable in system environmental variables (in release version installer will add it auto and tool path will be at C:\Users\USERNAME\cdv\ )"
	echo.
	echo [96m 5. [0m "if used `cdv -i` or `cdv <path> -i` : initialize .is_autoVenv then make new venv for current dir or provided path then activate the venv"
	echo.
	echo [96m 6. [0m "all venv folrders are in: C:\Users\USERNAME\py_envs\"
	echo.
	echo [96m 7. [0m "naming conventions for venvs is the "proj_folder_name"+"_venv"  "
	echo.
	echo [96m finally: [0m "use `cdv -d` or `cdv <path> -d` to delete the venv and all auto venv configs for this dir"
	echo.
	echo.
	echo [104m [TODO] [0m "refactorise code by moving related scipts to a separate goto tag i.e.(function)"
	echo.
	echo.
	echo [91m ~
	echo [93m IMPORTANT: [0m "(DONT USE FOLDER NAMES OR PATHS WITH SPACES!)"
	echo.
	echo [0m "the command mostly used inside aliases of cd to repoes ( other wise make its default to disable extra modification and do normal cd unless ^%2 is set to "1")"
	echo.
	echo [93m "[works/tested on windows10 OS. can be used like this: `cdv path_arg <toggle_venv_arg>`]"[0m
	echo [91m ~ [0m
	
	ENDLOCAL
	exit /b 0
)

set "dquote=""
rem safer to get all strings in double quotes but for our script will take all quotes out
if "!toCheckPath:~0,1!"=="!dquote!" ( set toCheckPath=!toCheckPath:~1,-1! )
rem remove any white spaces
set toCheckPath=!toCheckPath: =!

set "lastChar=!toCheckPath:~-1!"
if not "!lastChar!"=="\" ( set "toCheckPath=!toCheckPath!\" )

if exist "!toCheckPath!" ( 

	if "!toggleVenv!"=="-d" ( 
	
		set /p is_confirmed=type 'y' if you sure to delete the venv of this dir^? all auto venv configs and python libs inside the venv will be deleted. choose (y / n^)  || set is_confirmed=n
		
		if "!is_confirmed!"=="y" (
			echo.
			echo "deleting (auto venv configs / cdv configs / all venv ) for this dir ..."
			
									
			ENDLOCAL toCheckPath
			rem deactivate 
			if defined VIRTUAL_ENV ( call %VIRTUAL_ENV%\Scripts\deactivate.bat )
			
			setlocal EnableDelayedExpansion
			
			set /p venv_name=< !toCheckPath!.is_autoVenv
						
			rem delete venv folder
			if exist "C:\Users\%USERNAME%\py_envs\!venv_name!" ( rd /S C:\Users\%USERNAME%\py_envs\!venv_name!)
					
			rem delete .is_autoVenv
			if exist "!toCheckPath!.is_autoVenv" (rm -f !toCheckPath!.is_autoVenv && echo Done.)
						
			rem clean temp files and temp vars
			set toCheckPath=
			set venv_name=
			
				
		) else ( ENDLOCAL )
		
		exit /b 0
	)
	if "!toggleVenv!"=="-i" ( 
		type nul > !toCheckPath!.is_autoVenv
			rem if it's a git repo add this file to ignored files
		if exist "!toCheckPath!.git\" ( echo .is_autovEnv >> !toCheckPath!.gitignore )
	)
	
	rem leaving the backslash at end of path will make it harder to use '~' or get dir name using other methods. so remove it!
	set toCheckPath=!toCheckPath:~0,-1!

	for /d %%p in (!toCheckPath!) do (
		set "dir_name=%%~np" 
		rem actually ~nx gets the name with extention in case of path was file not dir path '~' is extractor or slicing operator must work inside for loop
	)
	
	if exist "!toCheckPath!\.is_autoVenv" (
		rem NOTE: <optional> append "_venv" to end of your proj folder name. This is optional step. This would be your venv folder name for this project or repo
		rem choose any name pattern that will not be repeated or assign same proj folder name to proj venv name...
		set  "venv_dir_name=!dir_name!_venv"
		
		rem if super folder for all venvs of project "py_envs\" not exist. Make it then make venv if not there then activate it!
		if not exist "C:\Users\%USERNAME%\py_envs\" ( mkdir C:\Users\%USERNAME%\py_envs\ )
		if not exist "C:\Users\%USERNAME%\py_envs\!venv_dir_name!\" (
		
			echo.
			echo [93m [93m=================================================================================[0m
			echo [93m [96m NOTE: no python virtual environment found with name: "!venv_dir_name!". [0m
			echo [93m [93m=================================================================================[0m	
			echo.
			
			echo Creating new "!dir_name!" venv ...
			call python -m venv C:\Users\%USERNAME%\py_envs\!venv_dir_name!\ 
									
			echo Done creating new venv ~activating ...
		)
				
		rem save venv name inside '.is_autoVenv' file
		echo !venv_dir_name! > !toCheckPath!\.is_autoVenv
			
		set final_venv_active_path=C:\Users\%USERNAME%\py_envs\!venv_dir_name!\Scripts\activate
		
		rem all this variable will vanish after ENDLOCAL is called so save the path to a file instead to be able to use after ENDLOCAL
		type nul > C:\Users\%USERNAME%\final_venv_active_path.txt
		echo !final_venv_active_path! > C:\Users\%USERNAME%\final_venv_active_path.txt
		
		rem end localisation before running activate.bat so delcared env var inside it remain global scoped
		ENDLOCAL 
		
		set /p final_venv_active_path=<  C:\Users\%USERNAME%\final_venv_active_path.txt
		if defined VIRTUAL_ENV ( call %VIRTUAL_ENV%\Scripts\deactivate.bat )
		call %final_venv_active_path%
		
		
	) else (
		ENDLOCAL
		rem ENDLOCAL
		if not "%1"=="-1" ( if not "%1"=="-i" ( if not "%1"=="-d" (cd /d %1)  )  )
		rem cd works after ending localisation  so new dir in %CD% is in global scope not local
		exit /b 0
	)	
) else (
	echo Error: provided path does not exist.
	echo Note: Use "cdv -h" for help on "cdv" command
	ENDLOCAL
	rem error val: didn't find resources requested
	exit /b 3 
)


if defined VIRTUAL_ENV ( call %VIRTUAL_ENV%\Scripts\deactivate.bat )
if defined final_venv_active_path (call %final_venv_active_path%)
if exist "C:\Users\%USERNAME%\final_venv_active_path.txt" ( rm -f C:\Users\%USERNAME%\final_venv_active_path.txt )

:normal_cd
rem finally cd to your project folder and exit :)!

rem ENDLOCAL
if not "%1"=="-1" ( if not "%1"=="-i" ( if not "%1"=="-d" (cd /d %1) ) ) 
rem cd works after ending localisation  so new dir in %CD% is in global scope not local
exit /b 0

REM ~END OF THE BATCH SCRIPT~