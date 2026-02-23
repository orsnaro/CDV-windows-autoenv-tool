# ![alt text](./cdv.ico) The Windows Auto-venv Tool ![alt text](./cdv.ico)


> This batch scripted tool will auto activates/deactivates/inits your python virtual environment just by using `CDV`!  Works like normal `CD`. for help use `cdv -h`

<br>

> # New Release _V0.1.4_ ✨!
### Install , open terminal and use it! `CDV` Rightaway!  [_Here to download v0.1.4_](https://github.com/orsnaro/windows-autoenv-tool/releases/tag/V0.1.4)
<details>
<summary> <h3>Release Notes:</h3> </summary>
    
  -	**Feature:** now the tool auto deactivates the venv if you go outside parent DIR!  
  -	**Feature:** no need to `CDV` to parent project dir first to activate the venv anymore! `CDV` into any sub dirs in your repo/project and the venv will start rightaway!
  -	**Feature:** now `CDV` can use paths with spaces just like `CD` though it's not recommended (`CDV` doesn't anymore crash from using paths with whitechars!)
  - **Fix** paths/shell args with spaces/whitecharacters known bugs.
  - **Fix** shell prompt redundent prints. and multiple uneeded `CD` calls. and uneeded extra venv deactivations/activations.
  - **Fix** file encoding is not same as configured pagecode.
  - **Fix** all known bugs caused by misusing of local scoping endlocal,setlocal and vanishing vars valuables.
  - **Fix** now almost all vars processes is gaurded with double quotes now.
  - **Fix** critical hidden bug when using -D flag to delete auto-venv config and venv DIR due to scoping/ACLs issues
  - **Quality** used `%PROGRAMDATA%\CDV\Temp` dir to be used for any temp files instead of using `C:\Users\%USERNAME%\` dir.
  - **Quality** help is enhanced: there is a separate help label and `help.bat` if needed
  - **Quality** better cleaning of temp vars.
  - **Quality** made sure to use win batch native commands like `del` instead of `rm` etc...
  - **Quality** now tool switches/shell args are case-insensetive which is more coherent with other shell tools approach
  - **Quality** some internal commands is now turned silent /Q
  - long awaited branch and commit 'd291ed5' is now ready , + refactoring and more ...
  - **Full Changelog**: https://github.com/orsnaro/CDV-windows-autoenv-tool/compare/V0.1.3...V0.1.4

 </details> 




<br>
<br>

> # How to Use🚀:

* #### First Install latest version via [cdv.msi <sub>(latest)</sub> ](https://github.com/orsnaro/windows-autoenv-tool/releases/latest/download/cdv_simple.msi)

* #### if using [***cmder***](https://cmder.app/) console and you want to totally override `cd` by cdv _( you can re-tract the override any time )_
   ```batch
	alias cd=cdv $*
  ```
   _now `cd` has all `cdv` features!_
  
  * to re-tract
  ```batch
  unalias cd
  ```

* ##### Shows help for the cdv command:
   ```batch
   cdv -h
   ```
* #####  initialize & configure new auto venv -_only used one time per project_- :
  ```batch
  cdv <optional-path>  -i
  ```

* ##### with out any parameters its just similar to `cd` until you cdv'ed to one of your configured projects it will auto activate the venv for you!
   ```batch
   cdv path  
   ```          
	* to activate current project venv
	```batch
	cdv 
	```

* ##### complete delete  for the auto venv configs and files:
   ```batch
   cdv <optional-path>  -d
   ```

* ##### to deactivate your venv .. you can also use `deactivate` command:
  ```batch
  cdv <optional-path>  -q
  ```


> # Notes📝:
 * #### _(in testing)_ no need to download the [installer](https://github.com/orsnaro/windows-autoenv-tool/releases/latest) for every new version _( just reinstall and it will update to latest release )_
 * #### if `<optional-path>` parameter wasn't provided will just run `cdv` command on current directory
* #### the folder which holds all venvs is defaulted to `C:\Users\%USERNAME%\py_envs`
* #### virtual environment directoroy names will be same as project name with `_venv` appended to it
*  #### please dont delete `.is_autoVenv` file from your proj/repo directory nor edit it _( unless you know what you are doing )_
*  #### command auto ignores it's `.is_autoVenv` file in `.gitignore` if . _(this is only if the project/repo already has .gitignore file)_

---
 ##  _would appreciate reading/trying/using the CDV tool  and raise any issues💙_

> ##  For more scripts that could be usefull visit: [bin](https://github.com/orsnaro/My-Configs-Cmder/tree/main/cmder/bin)
