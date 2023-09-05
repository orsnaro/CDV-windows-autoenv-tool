# windows-autoenv-tool
This batch scripted tool will auto activate your python virtual environment just by using `cdv`. Works like normal `cd`. for more help use `cdv -h`

<br>

> # New Release _V0.1_ ✨
### Install , open terminal and use!  [_Here to download v0.1_](https://github.com/orsnaro/windows-autoenv-tool/releases/tag/V0.1)



<br>
<br>

> # How to Use🚀:

* #### Install latest version via [cdv.msi _(latest)_](https://github.com/orsnaro/windows-autoenv-tool/releases/latest)

* ##### Shows help for the cdv command:
   ```batch
   cdv <optional-path>  -h
   ```
* #####  initialize new auto venv -_only used one time per project_- :
  ```batch
  cdv <optional-path>  -i
  ```

* ##### with out any parameters its just similar to `cd` until you cdv'ed to one of your projects it will auto activate the venv for you!
   ```batch
   cdv path  
   ```              

* ##### complete delete  for the auto venv configs and files:
   ```batch
   cdv <optional-path>  -d
   ```

* ##### to deactivate your venv .. you can also use deactivate:
  ```batch
  cdv <optional-path>  -1
  ```


> # Notes📝:
 * #### if `<optional-path>` parameter wasn't provided will just run `cdv` command on current directory
* #### the folder which holds all venvs is defaulted to `C:\Users\%USERNAME%\py_envs`
* #### virtual environment directoroy names will be same as project name with `_env` appended to it
*  #### please dont delete `.is_autoVenv` file from your proj directory nor edit it _( unless you know what you are doing )_
*  #### command auto ignores it's `.is_autoVenv` file in `.gitignore`. _(this is only if the project is in a git repository folder)_

---
 ##  _for more and config your custom auto venv I recommend reading the batch script itself and raise any issues💙_
