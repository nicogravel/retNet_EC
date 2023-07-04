# Docs

Put your docs here. If you'd like to generate sphinx docs, `cd` into this directory and run:

```
pip install sphinx
sphinx-quickstart
make html
```


conda create --name lamidec python=3.8
conda activate lamidec
conda install numpy scipy statsmodels matplotlib pandas seaborn tqdm
conda env export > environment.

### Recreate Conda environment from another computer:
conda env create --name recoveredenv --file environment.yml

## Initialize Github

echo "# MWlamprop" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/nicogravel/MWlamprop.git
git push -u origin main

git push -f -u origin master
git fetch
git rebase https://github.com/nicogravel/MWlamprop.git


### Parse Markdown

cd /Users/nicogravel/Documents/Gandalf/MWlamprop/docs/source
ls
myst-docutils-html5 --stylesheet= intro.md
myst-docutils-html5 --stylesheet= methods.md
myst-docutils-html5 --stylesheet= analysis_1.md
myst-docutils-html5 --stylesheet= analysis_2.md
myst-docutils-html5 --stylesheet= literature_review.md
myst-docutils-html5 --stylesheet= supplementaries.md

### Make Sphynx documentation

cd /Users/nicogravel/Documents/Gandalf/MWlamprop/docs/
make html

### Update Repo
git add .
git commit -m "updated figures"
git push -u origin main



pip install sphinx-autodoc-typehints

conda activate lamidec

make clean

make html

sshpass -p AQFir1T5Og rsync -avu /Users/nicogravel/Documents/Gandalf/MWlamprop/docs graveln@esi-svhpc1.esi.local:/home/graveln/Documents/MWlamprop/

sshpass -p AQFir1T5Og rsync -avu graveln@esi-svhpc1.esi.local:/home/graveln/Documents/MWlamprop/lamidec /Users/nicogravel/Documents/Gandalf/MWlamprop/
