# Bee virome coverage (workshop demo)

A skeleton research repository, used as the worked example in an EvoGen workshop on
getting your work onto GitHub, giving it a DOI, and putting a website in front of it.

There is nothing to run here. The repository exists to show the shape a research
project takes once it is under version control: code in one place, a small example
of the data, a licence, a citation file, and an explicit list of the things that
must never be committed.

```
scripts/example_script.R      stands in for your real analysis code
data/raw/example_data.csv     a small example table, safe to commit
.gitignore                    the things that must stay out of the repository
CITATION.cff                  how you want to be cited
LICENSE                       what other people are allowed to do with this
```

The example data are simulated and carry no biological meaning.

## The bit that matters

`.gitignore` is the most important file here, and the one people skip. Git is for
text you want to compare between versions. It is not for forty gigabytes of FASTQs,
and it is emphatically not for credentials — once something is pushed, assume it is
public forever, because deleting the commit does not remove it from clones and
forks that already exist.

## Citing

After the first release this repository has a DOI, shown as a badge at the top of
the page on GitHub. Cite the DOI rather than the URL: a URL tells you where
something lives today, a DOI tells you what it was on the day you used it.

## Licence

MIT, see `LICENSE`.
