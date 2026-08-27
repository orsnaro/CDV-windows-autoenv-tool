# ![alt text](./cdv.ico) The Windows Auto-venv Tool ![alt text](./cdv.ico)


> This batch scripted tool will auto activates/deactivates/inits your python virtual environment just by using `CDV`!  Works like normal `CD`. for help use `cdv -h`

<br>

> # New Release _V0.1.5_ ✨!
### Install , open terminal and use it! `CDV` Rightaway!  [_Here to download v0.1.5_](https://github.com/orsnaro/windows-autoenv-tool/releases/tag/V0.1.5)
<details>
<summary> <h3>Release Notes:</h3> </summary>
    
  - **Fix** parent venv discovery when `cdv` into subdir – replace `where` with `if exist` stdlib, fix `%%i` loop collision that broke parent climb (e.g., `repo_petrol_wells_web\frontend` now activates).
  - **Fix** leading space in `final_venv_active_path` (`C:\Users\...\py_envs\`) causing `'C:\Users\OmarPc\py_envs\' is not recognized` screenshot error.
  - **Fix** empty `.is_autoVenv` handling – guard empty venv name, avoid calling `C:\Users\...\py_envs\` when file is 0 bytes, gracefully `cd` without activation.
  - **Fix** sync `cmder\bin\cdv.bat` (was stale `v0.1.4` broken copy).
  - **Previous v0.1.4:** auto deactivation outside parent, subdir activation, spaces handling, encoding, scoping fixes, `-D` delete, `%PROGRAMDATA%\CDV\Temp`, help enhanced, `case-insensitive` switches.
  - **Full Changelog**: https://github.com/orsnaro/CDV-windows-autoenv-tool/compare/V0.1.4...V0.1.5

 </details> 




<br>
<br>

> # How to Use🚀:

* #### First Install latest version via [cdv.msi <sub>(latest)</sub> ](https://github.com/orsnaro/windows-autoenv-tool/releases/latest/download/cdv_simple.msi) or clone and set PATH: `git clone https://github.com/orsnaro/windows-autoenv-tool.git` and add its folder to your `PATH` env

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
> # Upcoming updates 🆙: 

- TODO: Auto detect `pyproject.toml` or `requirements.txt` to  auto suggest creating a new venv instead of using `CDV -i` when creating new venv for  first time
- TODO: Instead of linking project to its corresponding venv using the `.is_autoVenv` file content  or `_venv` suffix it'll use simple .yaml or sqlite map to determine which proj is for which venv
- TODO: Refactor into labels
- TODO: write a powershell version

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
