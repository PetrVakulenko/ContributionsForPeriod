## Get contributions from list of repos for last [n] days

System is automatically searching your contributions in the list of repos (including different branches)

- [Requirements](#requirements)
- [Getting application](#getting-application)
- [Application dependencies](#application-dependencies)
    - [ENV params](#env-params)
    - [Creating repositories list](#creating-repositories-list)
- [Build](#build)
- [Clear](#clear)

### Requirements

* bash core utils
* git util

### Getting application
Clone repository to the common place:
```bash
git clone git@github.com:PetrVakulenko/ContributionsForPeriod.git ~/code/ContributionsForPeriod/
```

### Application dependencies
1. Move to the application dir
```bash
cd ~/code/ContributionsForPeriod/
```
2. Create .env from .env.dist
```bash
make .env
```
3. Create repos.config from repos.config.dist
```bash
make repos.config
```

### ENV params
Configuration of the .env file:
* `AUTHOR` - string, your login at the github account (for example `PetrVakulenko`)
* `AUTHOR_EMAIL` - string, your email at the github account (for example `vakulenkopetya@gmail.com`)
* `DAYS` - number, count of days, which you need to get contributions (for example `7`)
* `REPOS_PATH` - path for clonning repos from repos.config. Has default value `./tmp/repos`
* `OUTPUT` - text file file saving result of script. Has default value `./tmp/output.txt`

### Creating repositories list
Fill repos config for your repos. Each line - one row. One row should consist:
* first param - repository
* second param optionally - default branch (if not set, default branch will be master)
* example of one line: `git@github.com:PetrVakulenko/ContributionsForPeriod.git test-branch`

### Build
Running the script:
```bash
make build
```

### Clear
clearing default repositories path.
```bash
make clear
``` 
