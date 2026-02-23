@ECHO off   

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

exit /b
:END