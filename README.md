# windows-autoenv-tool
This batch scripted tool will auto activate your python virtual environment just by using `cvd` command just like `cd` for more help use `cvd -h`

> # its very easy! just install and use ( or clone and add path to system path environmental virable and you're ready to go! )



> # Options:

* ### `cdv <optional-path>  -h`  (Shows help for the cdv command)

* ### `cdv <optional-path>  -i`  (initialize new auto venv -__only used one time per project__-)

* ### `cdv <path>`               (with out any parameters its just similar to `cd` until you cdv'ed to one of your projects it will auto activate the venv for you!)

* ### `cdv <optional-path>  -d`  (complete delete  for the auto venv configs and files)

* ### `cdv <optional-path>  -1`  (to deactivate your venv .. you can also use deactivate)



* ### if `<optional-path>` parameter wasn't provided will just run `cdv` command on current directory
* ### the folder which holds all venvs is defaulted to `C:\Users\%USERNAME%\py_envs`
* ### virtual environment directoroy names will be same as project name with `_env` appended to it
* ### please dont delete `.is_autoVenv` file from your proj directory nor edit it ( unless you know what you are doing )
* ### command auto ignores it's `.is_autoVenv` file in `.gitignore`. (this is only if the project is in a git repository folder)


* ##  _for more and to edit to your custom configs I recommend reading the batch script itself and raise any issues💙_
