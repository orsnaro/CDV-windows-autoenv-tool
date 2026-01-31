# windows-autoenv-tool
> ##  for more scripts that could be usefull ! visit this [bin](https://github.com/orsnaro/My-Configs-Cmder/tree/main/cmder/bin)

This batch scripted tool will auto activate your python virtual environment just by using `cdv`. Works like normal `cd`. for more help use `cdv -h`

<br>

> # New Release _V0.1.3_ ✨!
### Install , open terminal and use it Rightaway!  [_Here to download v0.1.2_](https://github.com/orsnaro/windows-autoenv-tool/releases/tag/v0.1.3)
<details>
<summary> <h3>Release Notes:</h3> </summary>
    
  -	**Feature:** NOW `cdv` can  assign different python versions for each virtual environment easily just via using `cdv` !  
  - **Fix** typeo error was leading to ignore the wrong files.
  - **Enhance** prompts quality.

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
  cdv <optional-path>  -1
  ```


> # Notes📝:
 * #### _(in testing)_ no need to download the [installer](https://github.com/orsnaro/windows-autoenv-tool/releases/latest) for every new version _( just reinstall and it will update to latest release )_
 * #### if `<optional-path>` parameter wasn't provided will just run `cdv` command on current directory
* #### the folder which holds all venvs is defaulted to `C:\Users\%USERNAME%\py_envs`
* #### virtual environment directoroy names will be same as project name with `_env` appended to it
*  #### please dont delete `.is_autoVenv` file from your proj directory nor edit it _( unless you know what you are doing )_
*  #### command auto ignores it's `.is_autoVenv` file in `.gitignore`. _(this is only if the project is in a git repository folder)_

---
 ##  _for more/config your custom auto venv I recommend reading the batch script itself and raise any issues💙_
