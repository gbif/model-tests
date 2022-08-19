# BioWide

This contains scripts to convert the raw BioWide data into the unified model structure. This is useful to test if the
concepts can be read from the original publishing view, and to allow the data to be explored as linked evidence.

Running this requires python3 and pip, and uses python environments.

```
# install pip if necessary  
python3 -m pip install --user virtualenv

# create and activate the virtual environment (note python3)
python3 -m venv env
source env/bin/activate

# load the dependencies
pip install -r requirements.txt

# run the transformation (note `python` is now an alias to the one in the environment)
python transform.py 
```