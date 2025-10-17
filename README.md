# How to setup editable git dependency demo projects
## Disclaimer
- This project works in tandem with the other repo [uv-sample-editable-lib](https://github.com/systematicguy/uv-sample-editable-lib)
- The commands described on this page are an outline of steps taken to create the demo projects.
Some less important details, intermediate steps are omitted.
- Consult the git history to see the full details.
- Feel free to contact me for help or discussion.

## Parent folder
```shell
# parent folder for the editable git dependency demo
$ mkdir ~/uv-editable-git-dependency
```

## Setup editable lib project
```shell
$ cd ~/uv-editable-git-dependency/

$ mkdir uv-sample-editable-lib
$ cd uv-sample-editable-lib/

# bare root project
$ uv init --bare
Initialized project `uv-sample-editable-lib`
```

### Business logic lib
```shell
$ cd ~/uv-editable-git-dependency/uv-sample-editable-lib/
$ mkdir packages
$ cd packages/
$ uv init --lib funlib
Adding `funlib` as member of workspace `~/uv-editable-git-dependency/uv-sample-editable-lib`
Initialized project `funlib` at `~/uv-editable-git-dependency/uv-sample-editable-lib/packages/funlib`

$ uv init --bare funlib-devclone
Adding `funlib-devclone` as member of workspace `~/uv-editable-git-dependency/uv-sample-editable-lib`                                                                                                                   
Initialized project `funlib-devclone` at `~/uv-editable-git-dependency/uv-sample-editable-lib/packages/funlib-devclone`
```

### Bump the lib version
```shell
$ cd ~/uv-editable-git-dependency/uv-sample-editable-lib/
$ uv version --package funlib --bump patch
Resolved 3 packages in 49ms
   Building funlib @ file:///C:/Users/david/devp/experiments/uv-editable-git-dependency/uv-sample-editable-lib/packages/fun
      Built funlib @ file:///C:/Users/david/devp/experiments/uv-editable-git-dependency/uv-sample-editable-lib/packages/funlib
   ⠙ Preparing packages... (0/1)                                                                                           Prepared 1 package in 67ms
Installed 1 package in 37ms
 + funlib==0.1.1 (from file:///C:/Users/david/devp/experiments/uv-editable-git-dependency/uv-sample-editable-lib/packages/funlib)
```

### Workspace setup
```shell
$ cd ~/uv-editable-git-dependency/uv-sample-editable-lib/
$ uv add packages/funlib
Resolved 3 packages in 13ms
   Building funlib @ file:///C:/Users/david/devp/experiments/uv-editable-git-dependency/uv-sample-editable-lib/packages/fun
      Built funlib @ file:///C:/Users/david/devp/experiments/uv-editable-git-dependency/uv-sample-editable-lib/packages/funlib
   ⠙ Preparing packages... (0/1)                                                                                           Prepared 1 package in 23ms
Uninstalled 1 package in 2ms
Installed 1 package in 8ms
 ~ funlib==0.1.1 (from file:///C:/Users/david/devp/experiments/uv-editable-git-dependency/uv-sample-editable-lib/packages/funlib)
```

### Publish lib's version to make it available for git dependency
```shell
$ cd ~/uv-editable-git-dependency/uv-sample-editable-lib/
$ echo ".venv/" >> .gitignore
$ git add .
$ git tag 0.1.1
$ git push --atomic origin HEAD 0.1.1
```

## Setup consumer app project
```shell
$ cd ~/uv-editable-git-dependency/
$ mkdir uv-sample-editable-app1

$ uv init --package
```

## Add exact git dependency
```shell
$ cd ~/uv-editable-git-dependency/uv-sample-editable-app1/

$ uv add --group exact git+https://github.com/systematicguy/uv-sample-editable-lib.git#subdirectory=packages/funlib --tag 0.1.1                                  
    Updated https://github.com/systematicguy/uv-sample-editable-lib.git (8f8f5ff742d8a716855739bef4c9846e6761b024)
Resolved 2 packages in 231ms
      Built uv-sample-editable-app1 @ file:///C:/Users/david/devp/experiments/uv-editable-git-dependency/uv-sample-editable-app
      Built funlib @ git+https://github.com/systematicguy/uv-sample-editable-lib.git@8f8f5ff742d8a716855739bef4c9846e6761b024#s
Prepared 2 packages in 287ms
Installed 2 packages in 21ms
 + funlib==0.1.1 (from git+https://github.com/systematicguy/uv-sample-editable-lib.git@8f8f5ff742d8a716855739bef4c9846e6761b024#subdirectory=packages/funlib)
 + uv-sample-editable-app1==0.1.0 (from file:///C:/Users/david/devp/experiments/uv-editable-git-dependency/uv-sample-editable-app1)
```

## Add editable path dependency
```shell
$ cd ~/uv-editable-git-dependency/uv-sample-editable-app1/

$ uv add --group devclone --editable ../uv-sample-editable-lib/packages/funlib-devclone                                                                          
Resolved 3 packages in 253ms
      Built uv-sample-editable-app1 @ file:///C:/Users/david/devp/experiments/uv-editable-git-dependency/uv-sample-editable-app
      Built funlib-devclone @ file:///C:/Users/david/devp/experiments/uv-editable-git-dependency/uv-sample-editable-lib/package
Prepared 2 packages in 5.79s
Uninstalled 1 package in 4ms
Installed 2 packages in 45ms
 + funlib-devclone==0.0.0 (from file:///C:/Users/david/devp/experiments/uv-editable-git-dependency/uv-sample-editable-lib/packages/funlib-devclone)
 ~ uv-sample-editable-app1==0.1.0 (from file:///C:/Users/david/devp/experiments/uv-editable-git-dependency/uv-sample-editable-app1)
```
