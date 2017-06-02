# Project Me

---

A simple project to help generate different formats of my resume.

The `resume.json` is an extension of the [Json Resume Schema](https://jsonresume.org/)

## To use

In the project root run one of the following rake commands

### Generate Resume

Generates resume files based on given types and bundles it into a `resume.package`

```
rake resume:generate

# Options are --
# -t, --type [txt|readme]   Specifies to build only a txt or readme version of the resume. Default is all
# -o, --output [DIRECTORY]  Specifies the location to output the generated resume.package. Default output/
# -i, --input [DIRECTORY]   Specifies the resume.json file to use for input. Default resume.json
# -r, --readme [FILE_PATH]  Specifies the location of the readme erb file. Default tasks/resume_readme.erb
# -x, --txt [FILE_PATH]     Specifies the location of the txt erb file. Default tasks/resume_txt.erb
# -n, --name [RESUME_NAME]  Specifies the name of the resume output file. Default is <First Name>_<Last_Name>_<Year>

```

### Assets

Bundles all the assets in the `assets/` directory.

```
rake assets:bundle # By default bundles assets to 'output/' directory

# Options are --
# -o, --output [DIRECTORY]  Specifies the output directory for the assets

```
