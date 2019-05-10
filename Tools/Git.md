# [git/git](https://github.com/git/git)

fast, scalable, distributed revision control system. https://git-scm.com/  一个分布式的代码管理容器，本地和远端都保有一份相同的代码。

* 分布式
* 基于时间点的快照：将提交点指向提交时的项目快照
* 分支模型：SVN等版本控制工具将每个分支都要放在不同的目录中, Git可以在同一个目录中切换不同的分支
* 不必将所有的分支都上传到GitHub中去
* 用户可以随时创建、合并、删除分支, 多人实现不同的功能, 可以创建多个分支进行开发, 之后进行分支合并, 这种方式使开发变得快速, 简单, 安全

## 服务

* [GitHub](https://github.com/)
* [Bitbucket](https://bitbucket.org/product)
* [Gitlab](https://gitlab.com/)
  - [gitlabhq/gitlabhq](https://github.com/gitlabhq/gitlabhq):GitLab CE Mirror | Please open new issues in our issue tracker on GitLab.com https://about.gitlab.com/getting-help/
* [码云](https://gitee.com)
* [Coding](https://github.com/)
* [sourceforge](https://sourceforge.net/):The Complete Open-Source Software Platform
* [GitKraken](link)
* [LaunchPad](link)
* [backlog](https://backlog.com/):Online project management tool for developers

## 搭建服务

* [gitlabhq/gitlabhq](https://github.com/gitlabhq/gitlabhq):GitLab CE | Please open new issues in our issue tracker on GitLab.com https://about.gitlab.com/getting-help/
* [gogits/gogs](https://github.com/gogits/gogs):Gogs is a painless self-hosted Git service. https://gogs.io
* [go-gitea/gitea](https://github.com/go-gitea/gitea):Gitea: Git with a cup of tea http://gitea.io

## 安装

```sh
sudo apt-get install git # Ubuntu 18.04 or Debian 9
sudo yum install git # CentOS
sudo dnf install git # Fedora

brew install git
brew install git-flow
brew install git && brew install bash-completion

# Add bash-completion to your ~/.bash_profile or ~/.zshrc
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
```

## 配置

* 全局配置: git config --global -l
  - /etc/gitconfig文件
  - ubuntu:~/.gitconfig
* 系统配置： `git config --system`
* 项目配置：`git local --system` project/.git/config   `git config`
* alias说明
  + prune = fetch --prune - 当在其他人将分支推送到远程仓库时，我也会得到了大量的本地分支。Prune可以删除远端已经删除的任何本地分支。
  + undo = reset --soft HEAD ^ - 如果我在做出提交时犯了一个错误，这个命令会把代码恢复到提交之前的样子。通常我只是在这种情况下修改现有的提交，因为它保留了提交信息。
  + stash-all = stash save --include-untracked - 当你正在开发，有人临时要求你切换分支时，stash 是非常有用的。这个命令确保当你 stash 时，可以记录没有被 git add 的新文件。
  + merge
    + ff = only 确保只有在每一个合并都是 fast-forward 的时候，你才会看到报错。否则只要你配置了这个选项，什么合并提交，什么历史记录，通通都不需要，只是两次提交之间的平滑过渡。你可能会想知道如何完成这项工作。答案是用 git rebase，把一个分支的修改合并到当前分支，它非常有用当我 pull 代码与 master 有冲突的时候，我使用这种方式来处理。当你在本地分支上修改后，同时其他人在 master 上 做了修改，我想这样比你直接 merge 到你本地分支时的 commit 更好。这样你可以避免多出一个 merge 的 commit。如果我打算新建一个merge commit，我可以用明确的 git merge -ff 来创建。
  + commit
    + gpgSign = true 确保您的所有 commit 都由你的 GPG 密钥签名。这通常是一个好主意，因为 .gitconfig 文件中没有验证您的用户信息，这意味着看起来像您这样的提交可能会轻松显示在其他人的提交 信息中。事实上，我曾经用过别人的凭据，因为帐户和机器配置耗时太长。我的提交请求是通过别人的帐号提交的，但内部的所有提交都是我的真实账号。将你的 GPG key 添加到 Github并尝试一次提交，你可能就会解决你现在的疑问，您提交内容将会有一个"已验证"标记。
    + 如果您有多个 GPG 密钥，可以使用 user.signingKey 选项指定要使用的密钥。
    + 上述的配置在 GUI 工具里不会生效，你需要在工具里的设置里找配置项。
    + gpg-agent可以保存口令，让我们更方便。
  + Push
    + default = simple可能是你已经设置的配置项。它可以更轻松地将您的本地分支推送到远程，当二者分支名一样的时候。
    + followTags = true很简单。配置它以后，当你 git push 的时候可以直接将本地的 tags 提交到远程，而不用每次都加参数 --follow-tags。不知道你是不是和我一样，我如果创建了一个tag，我就基本上一定会将它推到远程的。

```sh
git --version
man git # Git User Manual

git config --list --show-origin # 查看配置
git config --local # repository配置
git config -l  # 列举所有配置

git config --global user.name "name"
git config --global user.email "email"
git config --global color.ui "auto"
git config --global core.editor "vim" # 设置编辑器为 vim
git config --global credential.helper osxkeychain
git config --global core.excludesfile ~/.gitignore
echo .DS_Store >> ~/.gitignore

git config --global mergetool.sublime.cmd "subl -w \$MERGED"
git config --global mergetool.sublime.trustExitCode false
git config --global merge.tool sublime | vimdiff
git mergetool -y

git config --global alias.ls 'log --name-status --oneline --graph'
git config --global rebase.autoStash true
git config --global alias.st 'status --porcelain'

git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"

# 配置文件
[user]
email = liboming88@yeah.net
name = Henryli

[alias]  # .gitconfig中添加alias
prune = fetch --prune
# Because I constantly forget how to do this
# https://git-scm.com/docs/git-fetch#git-fetch--p

undo = reset --soft HEAD^
# Not quite as common as an amend, but still common
# https://git-scm.com/docs/git-reset#git-reset-emgitresetemltmodegtltcommitgt

stash-all = stash save --include-untracked
# We wanna grab those pesky un-added files!
# https://git-scm.com/docs/git-stash

glog = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'
# No need for a GUI - a nice, colorful, graphical representation
# https://git-scm.com/docs/git-log
# via https://medium.com/@payload.dd/thanks-for-the-git-st-i-will-use-this-4da5839a21a4

[merge]
ff = only
# I pretty much never mean to do a real merge, since I use a rebase workflow.
# Note: this global option applies to all merges, including those done during a git pull
# https://git-scm.com/docs/git-config#git-config-mergeff

conflictstyle = diff3
# Standard diff is two sets of final changes. This introduces the original text before each side's changes.
# https://git-scm.com/docs/git-config#git-config-mergeconflictStyle

[commit]
gpgSign = true
# "other people can trust that the changes you've made really were made by you"
# https://help.github.com/articles/about-gpg/
# https://git-scm.com/docs/git-config#git-config-commitgpgSign

[push]
default = current
# "push the current branch back to the branch whose changes are usually integrated into the current branch"
# "refuse to push if the upstream branch’s name is different from the local one"
# https://git-scm.com/docs/git-config#git-config-pushdefault

followTags = true
# Because I get sick of telling git to do it manually
# https://git-scm.com/docs/git-config#git-config-pushfollowTags

[status]
showUntrackedFiles = all
# Sometimes a newly-added folder, since it's only one line in git status, can slip under the radar.
# https://git-scm.com/docs/git-config#git-config-statusshowUntrackedFiles

[transfer]
fsckobjects = true
# To combat repository corruption!
# Note: this global option applies during receive and transmit
# https://git-scm.com/docs/git-config#git-config-transferfsckObjects
# via https://groups.google.com/forum/#!topic/binary-transparency/f-BI4o8HZW0

# A nice little github-like colorful, split diff right in the console.
# via http://owen.cymru/github-style-diff-in-terminal-with-icdiff/

[diff]
tool = icdiff

[difftool]
prompt = false

[difftool "icdiff"]
cmd = /usr/local/bin/icdiff --line-numbers $LOCAL $REMOTE

[remote "public"] # 定义远程仓库
 url = git@github.com:aaa/bbb.git
 url = kch@homeserver:ccc/ddd.git
```

* https://github.com/momeni/gittify
* https://github.com/GitAlias/gitalias
* https://gist.github.com/mwhite/6887990

## 传输协议

常见的有三种协议

* SSH:SSH keys的使用需保证remote的源为git方式
* HTTP(S)

### SSH

* 支持使用RSA密钥来鉴权,RSA是一种非对称的加密算法。ssh使用RSA鉴权需要两个部分，一个是公钥，保存在你的环境中，一个是私钥，保存在你的电脑中。公钥负责加密，私钥负责解密
* 生成路径 `~/.ssh/`
* 公钥添加到github账户

```sh
ssh-keygen -t rsa -b 4096 -C "your_email@example.com" -f ~/.ssh/github
ssh-add -K ~/.ssh/github # 如果不是默认密钥 id_rsa ，则需要以下命令注册密钥文件，-K 参数将密钥存入 Mac Keychain
cat ~/.ssh/github.pub 添加公钥到服务器
ssh -T git@github.com  # 验证
ssh -v bluebird89@github.com

ssh-copy-id demo@198.51.100.0
ssh-copy-id -i ~/.ssh/tatu-key-ecdsa user@host

brew install ssh-copy-id

cat ~/.ssh/id_rsa.pub | ssh demo@198.51.100.0 "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >>  ~/.ssh/authorized_keys"

sudo nano /etc/ssh/sshd_config

PermitRootLogin without-password
sudo systemctl reload sshd.service

eval "$(ssh-agent -s)"
ssh-add -K ~/.ssh/id_rsa

# ~/.ssh/config:
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa

# 多个ssh
git:http://01810661@gitlab.smgtech.net

# 配置github.com
Host github.com
    HostName github.com
    IdentityFile C:\Users\Administrator\.ssh\id_rsa
    PreferredAuthentications publickey
    User git

# 配置gitlab.smgtech.net
Host gitlab.smgtech.net
    HostName gitlab.smgtech.net
    IdentityFile C:\Users\Administrator\.ssh\smt
    PreferredAuthentications publickey
    #User 01810661

# 用cmder无效
github
# Couldn't agree a key exchange algorithm (available: curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521)
```

* [图解SSH原理](https://www.jianshu.com/p/33461b619d53)

### GPG

* 为提交内容添加一个"已验证"标记
* 与SSH配合使用，都添加到GitHub中
* bitbucket不支持gpg添加密钥

```sh
sudo apt-get install gnupg # Debian / Ubuntu 环境
yum install gnupg # Fedora 环境
brew install gpg

gpg --help|version

gpg --full-generate-key # 4096
gpg --gen-key # 2048

gpg -K
gpg --list-keys
gpg --list-secret-keys --keyid-format LONG  # list GPG keys for which you have both a public and private key. A private key is required for signing commits or tags.

sec   4096R/3AA5C34371567BD2 2016-03-10 [expires: 2017-03-10] # GPG key ID is 3AA5C34371567BD2
uid                          Hubot # 用户ID Henry Lee <liboming88@yeah.net>
ssb   4096R/42B317FD4BA89E7A 2016-03-10

git config --global user.signingkey 3AA5C34371567BD2 # git配置,commit生效
git config --global commit.gpgsign true

gpg --armor --export 3AA5C34371567BD2 | Hubot  # get the public key,add to github

git commit -S -m your commit message
git tag -s -m "GPG-sign tag"

git log --show-signature # 查看本地commit有签名

gpg --delete-key [用户ID] # 删除密钥

gpg --recipient [用户ID] --output demo.en.txt --encrypt demo.txt
gpg --decrypt demo.en.txt --output demo.de.txt

gpg --sign demo.txt #签名
```

## Git VS SVN

所有的版本控制系统，只能跟踪文本文件的改动，比如txt文件，网页，所有程序的代码等，Git也不列外，版本控制系统可以告诉你每次的改动，但是图片，视频这些二进制文件，虽能也能由版本控制系统管理，但没法跟踪文件的变化，只能把二进制文件每次改动串起来，也就是知道图片从1kb变成2kb，但是到底改了啥，版本控制也不知道。

* SVN是集中式版本控制系统，版本库是集中放在中央服务器的，而干活的时候，用的都是自己的电脑，所以首先要从中央服务器哪里得到最新的版本，然后干活，干完后，需要把自己做完的活推送到中央服务器。集中式版本控制系统是必须联网才能工作
* Git是分布式版本控制系统，那么它就没有中央服务器的，每个人的电脑就是一个完整的版本库

## 原理

Git维护的就是一个commitID树，分别保存着不同状态下的代码。 所以你对代码的任何修改，最终都会反映到 commit 上面去。创建和保存项目的快照及与之后的快照进行对比

* 工作区（Workspace）:进行开发改动的地方，任何对象都是在工作区中诞生和被修改；文件状态：modified:working directory
* 暂存区（Index/Stage）:.git目录下的index文件, 暂存区会索引git add添加文件的相关信息(文件名、大小、timestamp...)，不保存文件实体, 通过id指向每个文件实体。任何修改都是从进入index区才开始被版本控制；文件状态：staged:Stage(Index)
* 版本库|本地仓库（Repository）:.git文件夹。保存了对象被提交过的各个版本，只有把修改提交到本地仓库，该修改才能在仓库中留下痕迹；里还包括git自动创建的master分支，并且将HEAD指针指向master分支。文件状态：committed:History
* 远程仓库(Remote):通常使用clone命令将远程仓库拷贝到本地仓库中，开发后推送到远程仓库中即可；

![Git原理-1](../_static/bg2015120901.png)
![Git原理-2](../_static/git_2.png)
<!-- ![Git原理-3](../_static/git_3.jpg) 图片待修复-->

### 创建工作区 start a working area

```sh
git init --bare # 远程仓库文件构建
git init [project-name] # 初始化git仓库 在当前目录内新建一个Git代码库，会生成.git文件，用于新建空项目文件或者将项目添加git管理，默认URL文件名称，也可以自定义project-name

git clone [url] [project-name] # 下载一个项目和它的整个代码历史,支持多种协议
--recrusive-submodules # init submodule
git clone http[s]://example.com/path/to/repo.git/
git clone ssh://example.com/path/to/repo.git/
git clone [user@]example.com:path/to/repo.git/
git clone git://example.com/path/to/repo.git/
git clone /opt/git/project.git
git clone file:///opt/git/project.git
git clone ftp[s]://example.com/path/to/repo.git/
git clone rsync://example.com/path/to/repo.git/
git clone -o jQuery https://github.com/jquery/jquery.git # 所使用的远程主机自动被Git命名为origin。如果想自定义主机名，需要用git clone命令的-o选项指定
git clone --depth=1 https://github.com/rwv/chinese-dos-games.git

# 从远程仓库中克隆一个特定的分支
git init
git remote add url origin
git checkout
```

#### working tree

writing clear commit messages, you can make it easier for other people to follow along and provide feedback.

* HEAD关键字指的是当前分支最末梢最新的一个提交，也就是版本库中该分支上的最新版本
* git reset -- files 用来撤销最后一次git add files，你也可以用git reset 撤销所有暂存区域文件。
* git checkout -- files 把文件从暂存区域复制到工作目录，用来丢弃本地修改。
* git commit -a git commit files git checkout HEAD -- files 回滚到复制最后一次提交。跳过暂存区域直接从仓库取出文件或者直接提交代码
* 在master分支的祖父节点maint分支进行一次提交.这样，maint分支就不再是master分支的祖父节点。此时，合并 (或者 衍合) 是必须的。
* 如果想更改一次提交，使用 git commit --amend。git会使用与当前提交相同的父节点进行一次新提交，旧的提交会被取消。
* checkout命令用于从历史提交（或者暂存区域）中拷贝文件到工作目录，也可用于切换分支。git checkout HEAD~ foo.c会将提交节点HEAD~(即当前提交节点的父节点)中的foo.c复制到工作目录并且加到暂存区域中。
    - 如果命令中没有指定提交节点，则会从暂存区域中拷贝内容
    - 当不指定文件名，而是给出一个（本地）分支时，那么HEAD标识会移动到那个分支（也就是说，我们“切换”到那个分支了），然后暂存区域和工作目录中的内容会和HEAD对应的提交节点一致。新提交节点（下图中的a47c3）中的所有文件都会被复制（到暂存区域和工作目录中）；只存在于老的提交节点（ed489）中的文件会被删除；不属于上述两者的文件会被忽略，不受影响。
    - 如果既没有指定文件名，也没有指定分支名，而是一个标签、远程分支、SHA-1值或者是像master~3类似的东西，就得到一个匿名分支，称作detached HEAD（被分离的HEAD标识）。这样可以很方便地在历史版本之间互相切换。比如说你想要编译1.6.6.1版本的git，你可以运行git checkout v1.6.6.1（这是一个标签，而非分支名），编译，安装，然后切换回另一个分支，比如说git checkout master。然而，当提交操作涉及到“分离的HEAD”时，其行为会略有不同
        + 当HEAD处于分离状态（不依附于任一分支）时，提交操作可以正常进行，但是不会更新任何已命名的分支.一旦此后你切换到别的分支，比如说master，那么这个提交节点（可能）再也不会被引用到，然后就会被丢弃掉了。注意这个命令之后就不会有东西引用2eecb。如果你想保存这个状态，可以用命令git checkout -b name来创建一个新的分支。
* reset命令把当前分支指向另一个位置，并且有选择的变动工作目录和索引。也用来在从历史仓库中复制文件到索引，而不动工作目录。
    - 如果不给选项，那么当前分支指向到那个提交。如果用--hard选项，那么工作目录也更新，如果用--soft选项，那么都不变。
    - 没有给出提交点的版本号，那么默认用HEAD。这样，分支指向不变，但是索引会回滚到最后一次提交，如果用--hard选项，工作目录也同样。
    - 如果没有给出提交点的版本号，那么默认用HEAD。这样，分支指向不变，但是索引会回滚到最后一次提交，如果用--hard选项，工作目录也同样。
    - 如果给了文件名(或者 -p选项), 那么工作效果和带文件名的checkout差不多，除了索引被更新

|   名称   | HEAD位置 | 索引  | 工作树 |
|----------|----------|----------|----------|
| soft | 修改 |不修改 | 不修改 |
| mixed | 修改 |修改 | 不修改 |
| hard | 修改 |修改 | 修改 |

![Alt text](../_static/conventions.svg "Optional title")
绿色的5位字符表示提交的ID，分别指向父节点。分支用橘色显示，分别指向特定的提交。当前分支由附在其上的HEAD标识。 这张图片里显示最后5次提交，ed489是最新提交。 master分支指向此次提交，另一个maint分支指向祖父提交节点。
![git commit](../_static/commit-master.svg "git commit")
![checkout-branch](../_static/checkout-branch.svg "checkout-branch")
![checkout-after-detached](../_static/checkout-after-detached.svg "checkout-after-detached")
![reset-commit](../_static/reset-commit.svg "reset-commit")
![reset-files](../_static/reset-files.svg "reset-files")
![diff](../_static/diff.svg "diff")

```sh
git stutus -s(short) # 查看本地的代码状态,上次提交更新后的更改或者写入缓存的改动

git add . # add all new and edit file, not include delete file
git add <file1>(<file2> <file3>)|[dir] #（所有文件/单个文件 或通过使用通配符）写入缓存区
git add -p # 添加每个变化前，都会要求确认,对于同一个文件的多处变化，可以实现分次提交
git add -A # 添加所有变化（新增 new、修改 modified、删除 deleted）到暂存区
git add -u # 添加修改(modified)和被删除(deleted)文件，不包括新文件(new)也就是不是被追踪文件（untracked）
git add -p <file> # 添加文件内某些改动到暂存区

git mv [file-original] [file-renamed]  # 改名文件，并且将这个改名放入暂存区

git rm [file1] [file2] ... # 从已跟踪文件和工作区中移除某个文件 并且将这次删除提交暂存区
git rm --cached [file]  # 把文件从暂存区移除但工作区保留
git rm -f <file> # 如果已修改并提交到暂存区

git diff # 显示暂存区和工作区的差异
git diff -- <fileName> # 未缓存的所有或者单个文件的改动
git diff --cached <fileName> # 暂存区和 HEAD 的文件差异
git diff --staged # 暂存区与最新一次提交之间的差别
git diff HEAD # 已缓存的与未缓存的所有改动 HEAD：最后一次提交,HEAD^^:前两次提交 HEAD~3：前三次提交
git diff --stat # 显示摘要而非整个
git diff [first-branch]...[second-branch]  -- fileName # 显示两次提交之间的差异
git diff --shortstat "@{0 day ago}" # 显示今天你写了多少行代码
git diff HEAD@{'2 months ago'}
git diff HEAD@{yesterday}
git diff HEAD@{'2010-01-01 12:00:00'}

git diff branch_1..branch_2 # Find the diff between the tips of the two branches
git diff branch_1...branch_2 # Produce the diff between two branches from common ancestor
git diff branch1:file branch2:file # Comparing files between branches

# Reset the index to match the most recent commit soft(commit)< mixed<(commit + add)< hard(commit+add + local working)
git reset HEAD -- [file] # 撤销文件跟踪，重置暂存区的指定文件，与上一次commit保持一致，但工作区不变,
git reset commit # 重置当前分支的指针为指定commit，同时重置暂存区，但工作区不变 会将提交记录回滚，代码不回滚
git reset --mixed HEAD # 缺省参数，将HEAD变了，文件目录没有变，取消了commit和add的内容
git reset --soft "HEAD~n"  # 取消commit的内容
git commit --amend # 合并 commit
git reset --hard <b14bb52> # 重置暂存区与工作区，与上一次commit保持一致 会将提交记录和代码全部回滚 重置当前分支的HEAD为指定commit，同时重置暂存区和工作区，与指定commit一致
git reset --keep [commit] # 重置当前HEAD为指定commit，但保持暂存区和工作区不变
git reset HEAD~1 # Undo last commit
git reset –hard HEAD^ | HEAD^^ | HEAD~100 # 回退版本
git reset –hard dc5f1d1 # 只要记得版本号就可以穿梭回到现代
git reset . # 已提交至暂存区的文件 此类文件的状态为 Changes to be

git revert [commit]|HEAD # 回退到某个提交，但是不删除commit,会产生新提交

# 移除没有track文件
git clean -f     # remove untracked files
git clean -fd    # remove untracked files/directories
git clean -nfd   # list all files/directories that would be removed

# 冲突
git add <文件名> # # 标记为解决状态加入暂存区
git mergetool <文件名>  # Mac 系统下，运行 默认的是 FileMerge

git checkout . # 提交过版本库，但未提交至暂存区的文件（未执行 git add) 此类文件的状态为 Changes not staged for commit
git checkout -- files # 丢弃 1.工作区中未提交暂存区修改（与版本库一致） 2.已提交暂存区新的修改（与暂存区一致）
git checkout [file]  # 使用HEAD中的最新内容替换工作区中的文件，以添加到暂存区改动与新文件不受到影响，会删除该文件没有暂存和提交的改动，不可逆
git checkout [commit] [file] # 恢复某个commit的指定文件到暂存区和工作区
git checkout origin/master -- path/to/file # 丢弃工作区的修改
git checkout  branchname/ remotes/origin/branchname  / 158e4ef8409a7f115250309e1234567a44341404 / HEAD
```

#### 暂存区

* commit:生成上次提交的状态与当前状态的差异记录（也被称为revision）,系统会根据修改的内容计算出没有重复的40位英文及数字来给提交命名
* stash:还未提交的修改内容以及新添加的文件，留在索引区域或工作树的情况下切换到其他的分支时，修改内容会从原来的分支移动到目标分支.如果在checkout的目标分支中相同的文件也有修改，checkout会失败的。这时要么先提交修改内容，要么用stash暂时保存修改内容后再checkout
* merge 命令把不同分支合并起来。合并前，索引必须和当前提交相同。
    - 如果另一个分支是当前提交的祖父节点，那么合并命令将什么也不做。
    - 如果当前提交是另一个分支的祖父节点，就导致fast-forward合并。指向只是简单的移动，并生成一个新的提交。
    - 一次真正的合并。默认把当前提交(ed489 如下所示)和另一个提交(33104)以及他们的共同祖父节点(b325c)进行一次三方合并。结果是先保存当前目录和索引，然后和父节点33104一起做一次新提交。
    - merge的特殊选项squash：选项指定分支的合并，就可以把所有汇合的提交添加到分支上
* cherry-pick：从其他分支复制指定的提交，然后导入到现在的分支
* 衍合是合并命令的另一种选择。合并把两个父分支合并进行一次提交，提交历史不是线性的。衍合在当前分支上重演另一个分支的历史，提交历史是线性的。 本质上，这是线性化的自动的 cherry-pick
* 上面的命令都在topic分支中进行，而不是master分支，在master分支上重演，并且把分支指向新的节点。注意旧提交没有被引用，将被回收。


```sh
# 每个 commit 都是一份完整的代码状态，用一个 commitID 来唯一标志.进行一次包含最后一次提交加上工作目录中文件快照的提交
git commit -m "commit message" # 将缓存区内容添加到仓库中,在命令行中添加提交注释
git commit [file1] [file2] ... -m [message]
git commit -a # 把unstaged文件变成staged(不包括新建文件)，然后commit
git commit –am[-a -m] "message" # git add . + git commit -m 'message' 合并使用,只提交修改
git commit -v # 提交时显示所有diff信息
git commit --amend [file1] [file2] ... # 修改上一次提交日志 使用一次新的commit，替代上一次提交,如果代码没有任何新变化，则用来改写上一次commit的提交信息

# message 格式
# 第1行：提交修改内容的摘要
# 第2行：空行
# 第3行以后：修改的理由

# 在开发中的时候尽量保持一个较高频率的代码提交，这样可以避免不小心代码丢失。但是真正合并代码的时候，我们并不希望有太多冗余的提交记录.压缩日志之后不经能让 commit 记录非常整洁，同时也便于使用 rebase 合并代码。
git log -p <file> # 跟踪查看某个文件的历史修改记录 每一次提交是一个快照，会计算每次提交的diff，作为一个patch显示
git log [branchname]
--oneline #  --pretty only show the commit id and comment per-commit
--graph # gives you that visual representation The * indicates that there is a commit on the line
--decorate # 显示tag信息
--reverse # 逆向显示
--all
--author="Linus"
--oneline
--since="yesterday"
--before={3.weeks.ago}
--after={2010-04-18}
--grep="day of week" # 根据commit过滤log，与其它选项是or的关系，如果and关系 --all-match的选项
--stat # 查看改动的相对信息
-G "chef-client" # Regex on Commits
--no-merges # 显示当前分支的版本历史
--abbrev-commit  # （仅展示commit信息的图形化分支）
-S[keyword]  # 搜索提交历史，根据关键词 git log -Smethodname
--name-status

git log -n3 # 查看最近的三次提交
git log branch1 ^branch2 # 查看在分支1不在分支2的log

git log [tag] HEAD --pretty=format:%s   # 显示某个commit之后的所有变动，每个commit占据一行
git log [tag] HEAD --grep feature  # 显示某个commit之后的所有变动，其"提交说明"必须符合搜索条件
git log --follow [file]  # 显示某个文件的版本历史，包括文件改名
git log --name-status --oneline

#  使用 git reset --hard commitID 把本地开发代码回滚到了一个之前的版本，而且还没有推到远端，怎么才能找回丢失的代码呢？
#  你如果使用 git log 查看提交日志，并不能找回丢弃的那些 commitID。
#  git reflog 却详细的记录了你每个操作的 commitID，可以轻易的让你复原当时的操作并且找回丢失的代码。
#   git relog 在你将变化提交之前，可以帮助你回到任何修改之前，包括 git reset。但是 reflog 只是保存在本地，而且不是永久保存，有一个可以配置的过期时间。
git reflog # 用来记录引用变化的一种机制,比如记录分支的变化或者是HEAD引用的变化，git会将变化记录到HEAD对应的reflog文件中，其路径为 .git/logs/HEAD， 分支的reflog文件都放在 .git/logs/refs 目录下的子目录中

git whatchanged [file]  # 显示某个文件的版本历史，包括文件改名
git shortlog -sn  # 显示所有提交过的用户，按提交次数排序

git show [commit] # 显示某次提交的元数据和内容变化
git show --name-only [commit] # 显示某次提交发生变化的文件
git show [commit]:[filename] # 显示某次提交时，某个文件的内容

git blame filename # 文件每行修改的 commit 的哈希标签、作者和提交日期

git stash # 将当前目录和index中的所有改动(但不包括未track的文件)临时存放在 stash 队列中,注意：未提交到版本库的文件会自动忽略，只要不运行 git clean -fd . 就不会丢失
git stash save "stash name"
git stash save --keep-index    # stash only unstaged files
git stash list # 查看 stash 队列中已暂存了多少 WIP

git stash apply # 恢复stash中上一个（stash@{0}）内容到工作区，但是并不删除stash中的内容
git stash apply stash@{num} # 恢复指定编号的 WIP，但不从队列中移除
git stash drop # 删除stash中上一个

git stash pop # 恢复上一次的 WIP 状态，并从队列中移除
git stash pop stash@{num} # 恢复指定编号的 WIP，同时从队列中移除

git stash clear # 删除所有
```

![merge](../_static/merge.svg "merge")
![cherry-pick](../_static/cherry-pick.svg "cherry-pick")
![rebase](../_static/rebase.svg "rebase"):

#### 分支

* 远程：多人共享而建立
* 本地：
* merge:保持修改内容的历史记录，但是历史记录会很复杂
  - fast-forward:bugfix分支的历史记录包含master分支所有的历史记录，所以通过把master分支的位置移动到bugfix的最新分支上，Git 就会合并
* rebase:历史记录简单，是在原有提交的基础上将差异内容反映进去。因此，可能导致原本的提交内容无法正常运行
  - 待合并分支rebase主分支
  - 主分钟merge待合并分支
* 流程
  - 在topic分支中更新merge分支的最新代码，请使用rebase。
  - 向merge分支导入topic分支的话，先使用rebase，再使用merge
* branch name should be descriptive

```sh
git branch [-r]|[-a] # 列出所有远程/所有分支，不带参数时列出本地分支
git branch -av # 查看所有分支（包括远程分支）和最后一次提交日志

git branch <new-branch> <old-branch>|[commit] # 新建分支，不带old-branch为默认在当前分支上建立新分支 但依然停留在当前分支
git branch --track [branch] [remote-branch] # 新建一个分支，与指定的远程分支建立追踪关系
git branch repair remotes/origin/master
git checkout -b newBrach origin/master|[tag] # 在origin/master的基础上，创建一个新分支，并切换到new分支
git checkout dev # 切换
git checkout - # 切换到上一个分支

git branch -m new # Rename current branch
git branch -m old new  # Rename branch locally

git branch -d [branch-name] # 删除已合并分支
git branch -D branchName # 删除分支

# 通过二分搜索的方式来帮助你定位到引入 bug 的 commit。
git bisect start
git bisect good
git bisect bad # Find bug in commit history in a binary search tree style

git cherry-pick [commit] # 选择一个commit，合并进当前分支
git cherry-pick hash_commit_A hash_commit_B

git --git-dir=/.git format-patch -k -1 --stdout  | git am -3 -k # 将另一个不相关的本地仓库的提交补丁应用到当前仓库

git filter-branch --prune-empty --subdirectory-filter  master # 将Git仓库中某个特定的目录转换为一个全新的仓库

git rm filename # 从 HEAD 中删除文件
```

#### 远程分支

* pull:远程数据库的内容就会自动合并，=fetch+merge
* fetch:取得远程数据库的最新历史记录到本地
* merge 处理冲突更直接
* rebase 合并分支，重写历史
  * 合并分支，但是不合并提交记录（commit）
  * rebase合并如果有冲突则一个一个文件的去合并解决冲突,能够保证清晰的 commit 记录。
  - 变基会通过在原来的分支中为每次提交创建全新提交来重写项目历史。变基的主要好处在于你会得到一个更加整洁的项目历史
  - rebase 先找出共同的祖先节点
  - 从祖先节点把功能分支的提交记录摘下来，然后 rebase 到 master 分支
  - rebase 之后的 commitID 其实已经发生了变化

![rebase vs merge](../_staic/mergevsrebase.jpeg "rebase vs merge")

```sh
git config get --remote.origin.url
git remote [-v] # 列出所有的仓库地址
git remote show [remote] # 显示某个远程仓库的信息

git remote add origin git@github.com:han1202012/TabHost_Test.git # 本地git仓库关联GitHub仓库
git remote set-url origin git@github.com:whuhacker/Unblock-Youku-Firefox.git # 修改远程仓库地址
git remote rm <主机名> # 删除 origin 仓库信息
git remote rename <原主机名> <新主机名> # 用于远程主机的改名
git remote prune origin # removes tracking branches whose remote branches are removed

git remote update wilson # 更新源代码信息

git branch --set-upstream  v1.0 origin/v1.0
git branch --set-upstream-to|track v1.0 origin/v1.0
git branch --set-upstream-to=origin/master master # 建立追踪关系，在现有分支与指定的远程分支之间 --set-upstream 已废弃

git fetch # 拉取所有分支的变化
git fetch origin master # 从远程更新代码到本地但不合并 拉取指定分支的变化 只想取回特定分支的更新,所取回的更新，在本地主机上要用"远程主机名/分支名"的形式读取
git fetch -p # 拉取所有分支的变化，并且将远端不存在的分支同步移除

# 合并 commit 冲突 记为解决状态加入暂存区
# <<<HEAD是指主分支修改的内容，>>>>>fenzhi1 是指fenzhi1上修改的内容
# 合并分支时，git一般使用”Fast forward”模式，在这种模式下，删除分支后，会丢掉分支信息，现在我们来使用带参数 –no-ff来禁用”Fast forward”模式。
git merge 　--squash origin/master  # 抓取远程仓库更新  将远程主分支合并到本地当前分支 等同于git pull
git merge new # 合并指定分支到当前分支，新增一个 commit 追加
git merge --no-ff master
git merge 　--squash  # 压缩分支的提交
git mergetool # 使用配置的合并工具来解决冲突

git checkout --ours <文件名> # 使用当前分支 HEAD 版本
git checkout --theirs <文件名> # # 使用合并分支版本，通常是源冲突文件的

# rebase:将本次修改起始的远程仓库节点之后的修改内容优先合并到本地修改分支上
# conflict：git rebase出现冲突，
#   修改冲突文件，每次修改,只修改自己添加的内容，git add . 不需commit
#   git rebase --continue 
#   git push 提交到远程仓库
git rebase someFeature # 将someFeature分支上的commit记录追加到主分支上 合并分支，但是不合并提交记录（commit），rebase合并如果有冲突则一个一个文件的去合并解决冲突
git rebase origin/master # 在本地分支上合并远程分支
git rebase source destiantion # 将source压缩到destiantion
git rebase --continue|skip|abort # 如果出错的话
git rebase --onto master server client # 取出 client 分支，找出处于 client 分支和 server 分支的共同祖先之后的修改，然后把它们在 master 分支上重放一遍

git rebase -i parantCommitId  #　通过交互式的 rebase 调到修改信息开始的地方
# pick:保留
# reword:修改消息
# edit: 修改提交
# squash: 合并之前的提交 
git rebase -i start_commit_hash end_commit_hash # combine to one commit

git pull <远程主机名> <远程分支名>:<本地分支名> #  取回远程仓库的变化，并与本地分支合并;远程分支是与当前分支合并，则冒号后面的部分可以省略;等同于先做git fetch，再做git merge.如果当前分支与远程分支存在追踪关系，`git pull`就可以省略远程分支名
git pull # 执行的是 git merge
git pull <remote> <branch>    # 抓取远程仓库所有分支更新并合并到本地
git pull -r[--rebase] origin master # 执行的是git pull origin master git rebase 取回远程主机某个分支的更新，再与本地的指定分支合并
git pull origin master --allow-unrelated-histories # 合并两个不同的项目
git pull --no-ff                 # 抓取远程仓库所有分支更新并合并到本地，不要快进合并
for((i=1;i<=10000;i+=1)); do sleep X && git pull; done # 每隔X秒运行一次git pull

# merge 其它的 分支或文件
git pull -X theirs
git checkout --theirs path/to/file

# Git会首先在你试图push的分支上运行git log,检查它的历史中是否能看到server上的branch现在的tip,如果本地历史中不能看到server的tip,说明本地的代码不是最新的,Git会拒绝你的push.要求先在本地做git pull合并差异，然后再推送到远程主机
git push   # push所有分支
git push <remote name> <local branch name>:<remote branch name> # 上传本地指定分支到远程仓库. git push origin my:master
git push [-u] origin branch-name        # 将本地主分支推到远程(如无远程主分支则创建，用于初始化远程仓库) 设置本地分支与远程分支保持同步，在第一次 git push 的时候带上 -u 参数即可  上传本地指定分支到远程仓库. git push origin my:master,远程存在则更新，不存在则新建
git push origin qixiu/feature  # 新建本地分支，然后更新到远端的方式来新增一个远端分支
git push [remote] --all # 不管是否存在对应的远程分支，将本地的所有分支都推送到远程主机
git push --force origin  # 如果远程主机的版本比本地版本更新，推送时Git会报错，。强行推送当前分支到远程仓库，即使有冲突
git push --set-upstream origin new   # Push the new branch, set local branch to track the new remote

git push origin -d qixiu/feaure # 删除远程分支
git push origin :<remote_branch>  # 省略本地分支名，则表示删除指定的远程分支，因为这等同于推送一个空的本地分支到远程分支
git branch -dr [remote/branch] # 删除远程分支
git push origin --delete dev # 删除远程分支
```

deploy your changes to verify them in production.If your branch causes issues, you can roll it back by deploying the existing master into production.

### Pull Request

A common best practice is to consider anything on the master branch as being deployable for others to use at any time.

Pull Request:useful for contributing to open source projects and for managing changes to shared repositories.
code review:project guidelines,unit tests

* Fork repository to remote-user
* clone local repository
* git checkout -b new-branch
* new-branch develop and commit

```sh
Update Local Repository update with origin
  - git remote add upstream https://github.com/original-owner-username/original-repository.git
  - git fetch upstream
  - git merge upstream/master
Rebase and Update a Pull Request
  - git rebase -i HEAD~x # -i refers to the rebase being interactive, and HEAD refers to the latest commit from the master branch. The x will be the number of commits you have made to your branch since you initially fetched it.
  - git merge-base new-branch master # out key
  - git rebase -i 66e506853b0366c87f4834bb6b39d341cd094fe9 # pick commit
  - git rebase upstream/master
git push --set-upstream origin new-branch

# Create Pull Request # why you are making the pull request through your commit messages, so it is best to be as precise and clear as possible.

git checkout master
git pull --rebase upstream master
git push -f origin master
git branch -d new-branch
git push origin --delete new-branch
```

#### Tag

```sh
git tag # 列出所有tag
git tag -l|-n
git show [tag]  # 查看tag信息

git tag -a v2.1 -m 'first version' # -a 创建一个带注释的标签，不带-a的话，不会记录时间 作者 以及注释
git tag -am v2.2 "连猴子都懂的Git"
git tag -a tagName commitId # 追加tag在指定commit
git tag -s tagname -m "messsage" # PGP签名标签

git tag new old # Rename tag
git tag -d TAG1 TAG2 TAG3 # 删除本地tag

git push [remote] [tagname]  # 提交指定tag
git push origin v2.1
git push [remote] --tags  # 提交所有tag
git push origin --tags

git push origin --delete v1.0.0
git push origin :refs/tags/old # 删除远程指定tag
# delete remove tag
git push REMOTE --delete TAG1 TAG2 TAG3

git tag -fa tagname
```

#### archive

```sh
git archive

tar cJf .tar.xz / --exclude-vcs
```

## cherry-pick

可以选择某一个分支中的一个或几个commit(s)来进行操作,当执行完 cherry-pick 以后，将会 生成一个新的提交；这个新的提交的哈希值和原来的不同，但标识名 一样
从develop分支新开的分支fromdevelop-01，然后commit两次，这时候develop分支只需要第二次提交的信息，步骤：

* git checkout develop
* git cherry-pick 第二次commitID
* resolving the conflicts
* add ,commit

## 仓库元数据

* config* 配置文件
* description 描述，仅供 Git Web 程序使用
* HEAD  当前被检出的分支
* index 暂存区信息
* hooks/  客户端或服务端的钩子脚本（hook scripts）
* info/ 全局性排除（global exclude）文件，不希望被记录在 .gitignore 文件中的忽略模式（ignored patterns）
* objects/  所有数据内容
* refs/ 数据（分支）的提交对象的指针

## .gitignore

* 过滤目录 : /bin/ 就是将bin目录过滤, 该文件下的所有目录和文件都不被提交;
* 过滤某个类型文件 : *.zip *.class 就是过滤zip 和 class 后缀的文件, 这些文件不被提交;
* 过滤指定文件 : /gen/R.java, 过滤该文件, 该文件不被提交;
* 可以递归忽略.gitignore文件内容

```sh
git update-index --assume-unchanged # 永久性地告诉Git不要管某个本地文件
```

* [github/gitignore](https://github.com/github/gitignore):A collection of useful .gitignore templates
* [gitignore.io](Create useful .gitignore files for your project)

### 搭建git私有服务器

```sh
groupadd git
adduser git -g git

mkdir -p ~/.ssh  # 创建证书
chmod 700 .ssh
touch .ssh/authorized_keys
chmod 600 .ssh/authorized_keys

# 将客户端的id_rsa.pub文件，把导入到服务器端
/home/git/.ssh/authorized_keys

# 新建仓库
mkdir /home/testgit
cd /home/testgit
git init --bare /path/to/repo.git
sudo chown -R git:git sample.git
# 禁止git用户登录shell:修改/etc/passwd 为
git:x:1001:1001:,,,:/home/git:/usr/bin/git-shell //可以正常通过ssh使用git，但无法登录shell
git clone git@server:/path/to/repo.git
git clone git@115.159.146.94:/home/testgit/sample.git lsgogit
```

### hook

Hook是Git系统的本地机制，用于在诸如代码提交（Commit）和合并(Merge)之类的操作之前或之后触发的定制化脚本，可以把它们看作是Git的插件系统。

* 脚本路径：.git/hooks/
* 分类
  - 客户端Hooks
  - 服务端Hooks:检查代码是否符合某些条件，防止开发人员随意将代码推送到master
  - Pre-：在某些特定的Git操作之前被调用，检查推送过来的提交是否合法
  - Post-：
* pre-commit的时候我们可以做 eslint
* post-commit的时候，我们可以做利用 jenkins 类似的工具做持续集成
* 功能
  - 验证你在提交消息中包含了关联的JIRA密钥
  - 在代码合并前，确保满足先决条件
  - 发送通知给你开发团队的聊天室
  - 在切换到不同的工作分支后，设置你自己的工作区

```sh
cd /home/testgit/sample.git
cd hooks
# 这里我们创建post-receive文件
vim post-receive
# 在该文件里输入以下内容,自动同步到站点目录（www）
#!/bin/bash
git --work-tree=/home/www checkout -f
# 保存退出后，将该文件用户及用户组都设置成git
chown git:git post-receive
# 由于该文件其实就是一个shell文件，我们还应该为其设置可执行权限
chmod +x post-receive
```

* [post-checkout-build-status](https://bitbucket.org/tpettersen/post-checkout-build-status/src/master/)
* [git-ci-hooks](https://bitbucket.org/tpettersen/git-ci-hooks/src/master/)
* [templates](https://github.com/git/git/tree/master/templates)
* [Git hooks](https://githooks.com)

### 基于功能分支的开发流程

* 分支命名：ownerName/featureName
* 较多频次的提交代码到本地仓库，以便能够更灵活的保存或撤销修改。
* 为了保证提交日志的清晰，建议备注清楚的注释。
* 功能开发完成，可以发起一个CodeReview流程
* 代码测试通过，合并到 master:合并到本地master分支还是功能分支
* 不要在公共的分支上使用 rebase
* 团队用merge
* pull request:方便CodeReview

```sh
git checkout master
git pull -r origin master
git checkout qixiu/newFeature
git rebase master # 处理冲突
git checkout master
git merge qixiu/newFeature
git push origin master// 精简版 合并到 master

git checkout qixiu/newFeature
git pull -r origin master # 将master的代码更新下来，并且rebase处理冲突
git push origin master # 将本地代码更新到远端
```

### 习惯

* 在开始修改代码前先 git pull 一下；
* 将业务代码进行划分，尽量不要多个人在同一时间段修改同一文件；
* 通过 Gitflow 工作流 也可以提升 git 流程效率，减少发生冲突的可能性。
* git pull --rebase 可以让分支的代码和 origin 仓库的代码保持兼容，同时还不会破坏线上代码的可靠性。

```sh
git pull --rebase # 将当前分支的版本追加到从远程 pull 回来的节点之后
git rebase --continue # 若发生冲突，则按以上其他方法进行解决，解决后继续
git push origin # 直到所有冲突得以解决，待项目最后上线前再执行
git rebase --skip # 若多次提交修改了同一文件，可能需要直接跳过后续提交，按提示操作即可
git pull --rebase --autostash
```

### [nvie/gitflow](https://github.com/nvie/gitflow)

Git extensions to provide high-level repository operations for Vincent Driessen's branching model.

* 版本号使用x.x.x进行定义，第一个x代表大版本只有在项目有重大变更时更新 第二个x代表常规版本有新需求会更新 第三个x代表紧急BUG修正 一个常见的版本号类似于：0.11.10
* 分支的名字是一种共识，更重要的是它承担的责任。
* 主分支用于组织与软件开发、部署相关的活动；所有开发活动的核心分支。所有的开发活动产生的输出物最终都会反映到主分支的代码中。主分支分为
  - master分支:存放的应该是随时可供在生产环境中部署的代码，它承担的责任就是：仅在发布新的可供部署的代码时才更新到master分支上的代码。当开发活动告一段落，产生了一份新的可供部署的代码时，master分支上的代码会被更新。同时，每一次更新，最好添加对应的版本号标签（TAG）。
  - development分支:保存当前最新开发成果的分支，它承担的责任就是功能开发完毕等待最后QA的验收，通常这个分支上的代码也是可进行每日夜间发布的代码。当代码已经足够稳定时，就可以将所有的开发成果合并回master分支了。用于生成提测分支release，始终保持最新；
* 辅助分支组织为了解决特定的问题而进行的各种开发活动。它的生存周期伴随着它的功能完成而消失.完成它的使命之后在merge到主分支之后，也将被删除。
  - hotfix是紧急分支，从master生成，bug修正后自动合并到master和develop并且生成tag；
  - feature是私有分支，用于开发新需求和需要较长时间的BUG修改
  - release是提测分支也即常规分支，测试并且bug修改结束后生成该版本tag，后续可以使用git show tagname来查看版本信息或者回滚

![Git Flow](../_static/git_flow_1.png "Optional title")

```sh
git flow init

# 开发工作流程
git flow feature start xxxxx # （开始新需求） 在feature/xxxxx分支下进行开发
git flow feature finish xxxxx # （开发完成后等待研发经理确认可以完成时执行） merge to branch develop, delete branch feature/xxxxx, checkout to develop
git push origin develop #（发布develop分支） 每天工程师都需要git pull origin develop来更新develop分支，然后将develop分支合并到你正在开发得feature/xxxxx分支上来保持代码最新
# 切记不能直接在develop上进行开发

# 常规分支debug流程 由研发经理通知相关工程师release版本x.x
git fetch
git checkout -b release/x.x origin/release/x.x #（拉回release版本）
git pull release/x.x #（更新该分支） 修改测试中发现的BUG
git push origin release/vx.x #（修改完后提交分支）

# 紧急debug流程 由研发经理通知相关工程师hotfix分支名称x.x.x
git fetch
git checkout -b hotfix/x.x.x origin/hotfix/x.x.x #（拉回hotfix分支）
git pull hfx.x #（更新hotfix分支）在热修复分支下修改bug
git push origin hfx.x # （修改完成，提交分支） 在日常工作中不能修改master分支下得代码
# 开发和DEBUG流程同工程师流程 常规分支debug流程
git pull origin develop # 更新develop分支为最新）
git checkout develop # 切换到develop分支）

# release
git flow release start x.x # 生成一个release分支）通知测试和相关得工程师分支名称
git pull origin release/x.x # 最终测试完成后拉回分支最新代码）
git flow release finish x.x # 最终修改和测试完成后，结束release版本以供发布）
git push origin develop # (发布最新的develop)
git push origin master # 发布最终得master分支）

# hotfix
git pull origin master # 更新master分支为最新）
git checkout master # 切换到master分支）
git flow hotfix start x.x.x # 生成一个hotfix分支）通知相关得工程师和测试人员hotfix分支名称
git pull origin hotfix/x.x.x # 最终测试完成后拉回分支最新代码）
git flow hot fix finish x.x.x # 最终修改和测试完成后，结束hot fix以供发布）
git push origin master # 发布最终得master分支）

# 工程师必须维护自己的feature分支保证代码最新，减少合并时的冲突。
# 研发经理必须维护release分支，将最新的hotfix都合并进去，保证代码最新，减少合并时的冲突。
# 在提交代码时还要注意判断对代码的修改是否是自己的，多用diff工具，多查看log，防止代码回溯。
```

## 工作流

- **1.集中式工作流**：维护一个master分支，开发者提交自己功能修改到中央库前，需要先fetch在中央库的新增提交，rebase自己提交到中央库提交历史之上.

  ```
   git pull --rebase origin master
  ```

- **2.功能性分支**：所有的功能开发应该在一个专门的分支，而不是在master分支上。功能开发隔离也让pull requests工作流成功可能， pull requests工作流能为每个分支发起一个讨论，在分支合入正式项目之前，给其它开发者有表示赞同的机会。

  - 开发者每次在开始新功能前先创建一个新分支。 功能分支应该有个有描述性的名字，比如animated-menu-items或issue-#1061，隔离功能的开发。 `git checkout -b animated-menu-items master`
  - 功能分支也可以（且应该）push到中央仓库中 `git push -u origin animated-menu-items`
  - 合并：push到中央仓库的功能分支上并发起一个Pull Request请求去合并修改到master。Code Review

    ```shell
      git checkout master
      git pull
      git pull origin animated-menu-items(合并分支)
      git push
    ```

- **3.Gitflow工作流**：通过为功能开发、发布准备和维护分配独立的分支，让发布迭代过程更流畅。![](https://github.com/xirong/my-git/raw/master/images/git-workflow-release-cycle-4maintenance.png)

  - 分支：

    - develop分支作为功能的集成分支，包含了项目的全部历史。用于整合 Feature 分支。

      ```shell
        git branch develop
        git push -u origin develop
      ```

    - 功能分支（feature）：使用develop分支作为父分支。当新功能完成时，合并回develop分支。不直接和 Master 分支交互。

      ```shell
        git checkout -b some-feature develop
        git pull origin develop
        git checkout develop
        git merge some-feature
        git push
        git branch -d some-feature
      ```

    - 发布分支（release）：清理发布、执行所有测试、更新文档和其它为下个发布做准备操作的地方，像是一个专门用于改善发布的功能分支。只要创建这个分支并push到中央仓库，这个发布就是功能冻结的。任何不在develop分支中的新功能都推到下个发布循环中（自动化脚本执行）。通常对应一个迭代。将一个版本的功能全部合并到 Develop 分支之后，从 Develop 切出一个 Release 分支。这个分支不在追加新需求，可以完成 bug 修复、完善文档等工作。务必记住，代码发布后，需要将其合并到 Master 分支，同时也要合并到 Develop 分支。

      ```sh
        git checkout -b release-0.1 develop
      ```

    - master分支存储了正式发布的历史：合并修改到master分支和develop分支上，删除发布分支。用于存放线上版本代码，可以方便的给代码打版本号。

      ```sh
        git checkout master（功能回归分支）
        git merge release-0.1
        git push
        git checkout develop
        git merge release-0.1
        git push
        git branch -d release-0.1
        git tag -a 0.1 -m "Initial public release" master（打好Tag以方便跟踪）
        git push --tags
      ```

    - Hotfix维护分支：生成快速给产品发布版本（production releases）打补丁，这是唯一可以直接从master分支fork出来的分支。 修复完成，修改应该马上合并回master分支和develop分支（当前的发布分支），master分支应该用新的版本号打好Tag。

      ```sh
        git checkout -b issue-#001 master
        # Fix the bug
        git checkout master
        git merge issue-#001
        git push
        git checkout develop（重要修改需要包含到develop分支）
        git merge issue-#001
        git push
        git branch -d issue-#001
      ```

  - 流程：develop分支上有了做一次发布（或者说快到了既定的发布日）的足够功能，就从develop分支上checkout一个发布分支。 新建的分支用于开始发布循环，所以从这个时间点开始之后新的功能不能再加到这个分支上---- 这个分支只应该做Bug修复、文档生成和其它面向发布任务。 一旦对外发布的工作都完成了，发布分支合并到master分支并分配一个版本号打好Tag。 另外，这些从新建发布分支以来的做的修改要合并回develop分支
  - 利用Git有提供各种勾子（hook），即仓库有事件发生时触发执行的脚本。 可以配置一个勾子，在你push中央仓库的master分支时，自动构建好对外发布。

- **4.Forking工作流**

让各个开发者都有一个服务端仓库。这意味着各个代码贡献者有2个Git仓库而不是1个：一个本地私有的（fork，其它开发者不允许push到这个仓库，但可以pull到修改。为了方便和其它的开发者共享分支。 各个开发者应该用分支隔离各个功能，就像在功能分支工作流和Gitflow工作流一样。），另一个服务端公开的（公开的正式仓库存储在服务器上，**让正式仓库之所以正式的唯一原因是它是项目维护者的公开仓库**）

- 优点：贡献的代码可以被集成，而不需要所有人都能push代码到仅有的中央仓库中。 开发者push到自己的服务端仓库，而只有项目维护者才能push到正式仓库。 这样项目维护者可以接受任何开发者的提交，但无需给他正式代码库的写权限。
- fork操作基本上就只是一个服务端的克隆，clone到本地
- 需要2个远程别名 —— 一个指向正式仓库，另一个指向开发者自己的服务端仓库。别名的名字可以任意命名，常见的约定是使用origin作为远程克隆的仓库的别名 （这个别名会在运行git clone自动创建），upstream（上游）作为正式仓库的别名。
- 功能修改提交到自己仓库中，跟随正式仓库，pull快进合并
- 项目维护者：第一种,直接在pull request中查看代码；第二种，pull代码到他自己的本地仓库，再手动合并。
- 解析Pull Request：当要发起一个Pull Request，你所要做的就是请求（Request）另一个开发者（比如项目的维护者） 来pull你仓库中一个分支到他的仓库中。这意味着你要提供4个信息以发起Pull Request： 源仓库、源分支、目的仓库、目的分支。
- Code Review

```shell
git remote add upstream https://user@bitbucket.org/maintainer/repo.git

git checkout -b some-feature
# Edit some code
git commit -a -m "Add first draft of some feature"
git pull upstream master（开发者和正式仓库做同步）
git push origin feature-branch
# pull requests（简单的通知，而是为讨论提交的功能的一个专门论坛)

git fetch https://bitbucket.org/user/repo feature-branch
# 查看变更
git checkout master
git merge FETCH_HEAD
```

* 测试环境
  - 开发者的feature分支开发、自测验收通过后，merge到测试环境的develop分支，（QA）部署到测试环境，等待QA验收。
  - QA提bug issue，开发者从develop切分支修正再次合并、部署、验收。
* 预发布环境
  - 测试环境验收通过之后，合并到预发布环境的master，部署预发布环境
  - QA全面回归，发现问题提bug issue，开发者从master切分支修正再次合并、部署、验收。
  - 回归完毕打tag，准备上线
* 生产环境
  - 上线验收通过的tag
  - 回归测试，发现问题开发者从master切分支hotfix修正。

### 实际场景

使用 Git 作为版本控制软件最看重的还是结合公司自己搭建的 Gitlab，将 Code Review 加入打包部署持续集成的流程中，这样，代码开发完成，提交测试前，便可以对开发人员提交的代码进行 Review，发现潜在的问题，及时指导，对于新人来讲，也能更快更好的学习。

* 能支持日常迭代开发、紧急线上bug修复、多功能并行开发
* 大概50人左右的团队，平日迭代项目较多，且周期短（1~2周一个迭代）
* 能够通过tag重建整个系统
* 支持code review
* 所有上线的代码必须都是经过测试保证，且能自动同步到下一次的迭代中
* 能和公司的项目管理/持续集成系统整合

下面为团队在日常开发中总结出来的适合企业开发的模式，下面进行简单的介绍，方便大家学习了解（本模式适合敏捷开发流程，小迭代上线，传统的瀑布开发模型并没有进行测试）![](https://github.com/xirong/my-git/raw/master/images/branch_module.png)

* 迭代需求会、冲刺会后确定本次迭代的目标后，将迭代内容视为一个项目，在 Gitlab 上创建一个 Repository，初始化工程代码结构，根据上线日期，比如20150730上线，开出分支 release20150730、dev20150730 两个分支，dev 分支作为日常开发主干分支，release 分支作为提测打包、Code Review 的分支。 -
* 迭代开始，日常开发进行中，开发人员在 dev 分支上进行 Commit、Push 代码，并且解决掉日常协同开发中的冲突等问题，等到达到提测条件的时候，提测者，首先 Merge Master 分支上的最新代码 git merge --no-ff origin/master ，使得 Master 分支上的变更更新到迭代开发分支dev上面，之后，在 Gitlab 上面发起 pull request 请求，并指定 Code Review 人，请求的分支选择本次上线的 release 分支，即 release20150730。
* 被指定 Code Review 的人，对发起者的代码 Review 后，决定是否可以提交测试，若有问题，评论注释代码后，提交者对代码进行进行修改，重复步骤2，直到代码 Review 者认为 Ok。之后便可以借助自己公司的打包部署，对这些代码发布到测试环境验证。
* 步骤2-3重复多次后，就会达到一个稳定可发布的版本，即上线版本，上线后，将 release 版本上面最后的提交（图中0.2.4上线对应处）合并到 Master 分支上面，并打 Tag0.3。至此，一次完整的迭代开发完成。
* 若此次上线后，不久发现生产环境有 Bug 需要修复，则从 Tag 处新开分支 release_bugfix_20150731、dev_bugfix_20150731 ，开发人员从 dev_bugfix_20150731分支上进行开发，提测code review在 release_bugfix_20150731 分支上，具体步骤参考2-3，测试环境验证通过后，发布到线上，验证OK，合并到 Master 分支，并打 Tag0.2.3，此次 Bug 修复完毕，专为解 Bug 而生的这两个分支可以退伍了，删除release_bugfix_20150731、dev_bugfix_20150731两分支即可。（所有的历史 Commit 信息均已经提交到了 Master 分支上，不用担心丢失）
* master：master永远是线上代码，最稳定的分支，存放的是随时可供在生产环境中部署的代码，当开发活动告一段落，产生了一份新的可供部署的代码时，发布成功之后，代码才会由 aone2 提交到 master，master 分支上的代码会被更新。应用上 aone2 后禁掉所有人的 master的写权限
* develop：保存当前最新开发成果的分支。通常这个分支上的代码也是可进行每日夜间发布的代码，只对开发负责人开放develop权限。 -
* feature: 功能特性分支，每个功能特性一个 feature/ 分支，开发完成自测通过后合并入 develop 分支。可以从 master 或者develop 中拉出来。 - hotfix: 紧急bug分支修复分支。修复上线后，可以直接合并入master。

#### Git-Develop 分支模式

是基于 Git 代码库设计的一种需要严格控制发布质量和发布节奏的开发模式。develop 作为固定的持续集成和发布分支，并且分支上的代码必须经过 CodeReview 后才可以提交到 Develop 分支。它的基本流程如下：

![](https://github.com/xirong/my-git/raw/master/_image/2016-09-22-20-57-27.jpg)

* 每一个需求/变更都单独从Master上创建一条Branch分支；
* 用户在这个Branch分支上进行Codeing活动；
* 代码达到发布准入条件后aone上提交Codereview，Codereview通过后代码自动合并到- Develop分支；
* 待所有计划发布的变更分支代码都合并到Develop后，系统再 rebase master 代码到Develop 分支，然后自行构建，打包，部署等动作。
* 应用发布成功后Aone会基于Develop分支的发布版本打一个"当前线上版本Tag"基线；
* 应用发布成功后Aone会自动把Develop分支的发布版本合并回master；

## GitHub

围绕Git 构建 SaaS 服务

* GitHub集成其他功能：`repository > Settings > Integrations & services`
* give user private repositories

![Git 使用规范流程](..\_static\bg2015080501.png)

```shell
# 获取主干最新代码
git checkout master
git pull

# 新建一个开发分支myfeature
git checkout -b myfeature

# 提交分支commit
git add --all
git status
git commit --verbose

commit # 第一行是不超过50个字的提要，然后空一行，罗列出改动原因、主要变动、以及需要注意的问题。最后，提供对应的网址（比如Bug ticket）。
Present-tense summary under 50 characters

* More information about commit (under 72 characters).
* More information about commit (under 72 characters).

http://project.management-system.com/ticket/123

# 同步主干
git fetch origin
git rebase origin/master

# 多个commit合并，进入交互模式
git rebase -i origin/master

# 推送到远程仓库，因为rebase以后，分支历史改变了，跟远程分支不一定兼容，有可能要强行推送
git push --force origin myfeature
```

* [awesome-actions](https://github.com/sdras/awesome-actions):A curated list of awesome actions to use on GitHub
* [gitalk/gitalk](https://github.com/gitalk/gitalk):Gitalk is a modern comment component based on Github Issue and Preact. https://gitalk.github.io
* [desktop/desktop](https://github.com/desktop/desktop):Simple collaboration from your desktop https://desktop.github.com
* [OctoLinker/OctoLinker](https://github.com/OctoLinker/OctoLinker):OctoLinker – Available on Chrome, Firefox and Opera https://octolinker.github.iow
* [devhubapp/devhub](https://github.com/devhubapp/devhub):DevHub: TweetDeck for GitHub - Android, iOS and Web 👉 https://devhubapp.com/
* [unbug/codelf](https://github.com/unbug/codelf):Best GitHub stars, repositories tagger and organizer. Search over projects from Github, Bitbucket, Google Code, Codeplex, Sourceforge, Fedora Project, GitLab to find real-world usage variable names https://unbug.github.io/codelf/
* [pomber/git-history](https://github.com/pomber/git-history):Quickly browse the history of a file from any git repository https://githistory.xyz/
* [Tutorial](https://lab.github.com/courses)

### 合并commit选项

* pick：正常选中
* reword：选中，并且修改提交信息；
* edit：选中，rebase时会暂停，允许你修改这个commit（参考这里）
* squash：选中，会将当前commit与上一个commit合并，会有多个commit信息
* fixup：与squash相同，但不会保存当前commit的提交信息，会舍去commit信息
* exec：执行其他shell命令

### github pages:必须使用master作为分支

- hexo：添加文章后现hexo g（生成） hexo d（部署）
- jekyll：直接push到master就好

### 使用

```
init
feature
release
hotfix
suport
version
```

### Version Control Best Practices

* Commit Related Changes:A commit should be a wrapper for related changes. For example, fixing two different bugs should produce two separate commits. Small commits make it easier for other team members to understand the changes and roll them back if something went wrong. With tools like the staging area and the ability to stage only parts of a file, Git makes it easy to create very granular commits.
* Commit Often:Committing often keeps your commits small and, again, helps you commit only related changes. Moreover, it allows you to share your code more frequently with others. That way it’s easier for everyone to integrate changes regularly and avoid having merge conflicts. Having few large commits and sharing them rarely, in contrast, makes it hard both to solve conflicts and to comprehend what happened.
* Don’t Commit Half-Done Work:You should only commit code when it’s completed. This doesn’t mean you have to complete a whole, large feature before committing. Quite the contrary: split the feature’s implementation into logical chunks and remember to commit early and often. But don’t commit just to have something in the repository before leaving the office at the end of the day. If you’re tempted to commit just because you need a clean working copy (to check out a branch, pull in changes, etc.) consider using Git’s “Stash” feature instead.
* Test Before You Commit:Resist the temptation to commit something that you “think” is completed. Test it thoroughly to make sure it really is completed and has no side effects (as far as one can tell). While committing half-baked things in your local repository only requires you to forgive yourself, having your code tested is even more important when it comes to pushing / sharing your code with others.
* Write Good Commit Messages:Begin your message with a short summary of your changes (up to 50 characters as a guideline). Separate it from the following body by including a blank line. The body of your message should provide detailed answers to the following questions: What was the motivation for the change? How does it differ from the previous implementation? Use the imperative, present tense („change“, not „changed“ or „changes“) to be consistent with generated messages from commands like git merge.
* Version Control is not a Backup System:Having your files backed up on a remote server is a nice side effect of having a version control system. But you should not use your VCS like it was a backup system. When doing version control, you should pay attention to committing semantically (see “related changes”) – you shouldn’t just cram in files.
* Use Branches:Branching is one of Git’s most powerful features – and this is not by accident: quick and easy branching was a central requirement from day one. Branches are the perfect tool to help you avoid mixing up different lines of development. You should use branches extensively in your development workflows: for new features, bug fixes, experiments, ideas…
* Agree on a Workflow:Git lets you pick from a lot of different workflows: long-running branches, topic branches, merge or rebase, git-flow… Which one you choose depends on a couple of factors: your project, your overall development and deployment workflows and (maybe most importantly) on your and your teammates’ personal preferences. However you choose to work, just make sure to agree on a common workflow that everyone follows.

## 语法

### 格式化输出

```
git log --graph --pretty=format:'%C(yellow)%h%Creset -%C(cyan)%d%Creset %s %Cgreen(%an, %cr)' --abbrev-commit
git config --global alias.ll "log --graph --pretty=format:'%C(yellow)%h%Creset -%C(cyan)%d%Creset %s %Cgreen(%an, %cr)' --abbrev-commit"
%H  commit hash
%h  commit short hash
%T  tree hash
%t  tree short hash
%P  parent hash
%p  parent short hash
%an 作者名字
%aN .mailmap 中对应的作者名字
%ae 作者邮箱
%aE .mailmap 中对应的作者邮箱
%ad –date=制定的日期格式
%aD RFC2822 日期格式
%ar 日期格式，例如：1 day ago
%at UNIX timestamp 日期格式
%ai ISO 8601 日期格式
%cn 提交者名字
%cN .mailmap 对应的提交的名字
%ce 提交者邮箱
%cE .mailmap 对应的提交者的邮箱
%cd –data=制定的提交日期的格式
%cD RFC2822 提交日期的格式
%cr 提交日期的格式，例如：1day ago
%ct UNIX timestamp 提交日期的格式
%ci ISO 8601 提交日期的格式
%d  ref 名称
%e  encoding
%s  commit 信息标题
%f  过滤 commit 信息的标题使之可以作为文件名
%b  commit 信息内容
%N  commit notes
%gD reflog selector, e.g., refs/stash@{1}
%gd shortened reflog selector, e.g., stash@{1}
%gs reflog subject
%Cred   切换至红色
%Cgreen 切换至绿色
%Cblue  切换至蓝色
%Creset 重设颜色
%C(color)   制定颜色，as described in color.branch.* config option
%m  left right or boundary mark
%n  换行
%%  a raw %
%x00    print a byte from a hex code
%w([[,[,]]])    switch line wrapping, like the -w option of git-shortlog(1).
```

### submodule

git submodule 主要用来管理一些单向更新的公共模块或底层逻辑。

* 它允许你的项目模块化成为每一个 Repository，最终汇聚成一个完整的项目
* Git Submodule 可以别人的 Repo 挂到你自己的 Repo 中的任何位置，成为的 Repo 的一部分。
* 在你的项目 Repository 下产生一个 .gitmodules 文件，来记录你的 Submodule 信息，同时 another_project项目也clone下来.
* 远程库更新后，本地还要重复删除、更新操作

```sh
# 会添加一个.gitmodules文件在repository的根目录里
git submodule add git@domain.com:another_project.git file_path/another_project

# 更新 repo 下所有的 submodules
git submodule foreach git pull origin master # 出错后会停止更新后面

# clone后初始化
git submodule init
git submodule update submodule
git submodule update --recrusive --init
git submodule deinit submodule # delete config

# 删除 首先删除.gitsubmodule中的项目配置
git rm --cached another_project # 删除项目
vim .git/config # ...remove another_project...

# git status contain commit-dirty: regarded as dirty if they have any modified files or untracked files
git status --ignore-submodules=dirty

git reset HEAD .
git checkout --  .
```

### subtree

git subtree 对于部分需要双向更新的可复用逻辑来说，特别适合管理.比如一些需要复用的业务组件代码。在我之前的实践中，我也曾用subtree来管理构建系统逻辑。

Merge subtrees together and split repository into subtrees

[文档](https://github.com/git/git/blob/master/contrib/subtree/git-subtree.txt)

```sh
git clone git@github.com:Ihavee/dotfiles.git
cd dotfiles

git remote add bash git@github.com:Ihavee/bash.git        # 可以理解为远程仓库的别名
git subtree add pull -P home/.bash bash master --squash   # 拉取远程仓库 bash 到本地仓库的home/.bash 目录。

...... edit home/.bash/file......
git commit -a -m 'update some'
git subtree push -P home/.bash bash master
git push origin master                                    # 顺便主项目也 push

git subtree pull -P home/.bash bash master --squash

对 git-subtree 下子项目有修改需求的，请先 git subtree pull

git subtree add --prefix=client <https://github.com/example/project-client.git> master # 建立主项目里子树
```

### [git-lfs/git-lfs](https://github.com/git-lfs/git-lfs)

Git extension for versioning large files https://git-lfs.github.com

```sh
git lfs install
git lfs track "*.zip"
git add .gitattributes
git add my.zip
git commit -m "add zip"
git lfs ls-files
git push origin master
```

### [kennethreitz/legit](https://github.com/kennethreitz/legit)

Git for Humans, Inspired by GitHub for Mac™. http://www.git-legit.org/

```python
pip3 install legit

switch <branch>
Switches to specified branch. Defaults to current branch. Automatically stashes and unstashes any changes. (alias: sw)
sync [<branch>]
Synchronizes the given branch. Defaults to current branch. Stash, Fetch, Auto-Merge/Rebase, Push, and Unstash. You can only sync published branches. (alias: sy)
publish [<branch>]
Publishes specified branch to the remote. (alias: pub)
unpublish <branch>
Removes specified branch from the remote. (alias: unp)
undo
Un-does the last commit in git history. (alias: un)
branches
```

### [so-fancy/diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)

Good-lookin' diffs. Actually… nah… The best-lookin' diffs. tada git diff 格式化显示工具

```sh
#  install
npm install -g diff-so-fancy
yarn install -g diff-so-fancy

#Arch Linux下面工作，更简单：
sudo pacman -S diff-so-fancy

## config
git config --global color.ui true

git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"

git config --global color.diff.meta       "yellow"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"

git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --bool --global diff-so-fancy.markEmptyLines false
git config --bool --global diff-so-fancy.changeHunkIndicators false
git config --bool --global diff-so-fancy.stripLeadingSymbols false
git config --bool --global diff-so-fancy.useUnicodeRuler false

git config --global alias.dsf '!f() { [ -z "$GIT_PREFIX" ] || cd "$GIT_PREFIX" '\
'&& git diff --color "$@" | diff-so-fancy  | less --tabs=4 -RFX; }; f'
```

### Commit Message

* type: commit 的类型
  - feat: 新特性
  - fix: 修改问题
  - refactor: 代码重构
  - docs: 文档修改
  - style: 代码格式修改, 注意不是 css 修改
  - test: 测试用例修改
  - chore: 其他修改, 比如构建流程, 依赖管理.
* scope: commit 影响的范围, 比如: route, component, utils, build...
* subject: commit 的概述, 建议符合  50/72 formatting
* body: commit 具体修改内容, 可以分为多行, 建议符合 50/72 formatting
* footer: 一些备注, 通常是 BREAKING CHANGE 或修复的 bug 的链接.

```
<type>(<scope>): <subject>
<BLANK LINE>
<body>
<BLANK LINE>
<footer>
```

### [arzzen/git-quick-stats](https://github.com/arzzen/git-quick-stats)

Git quick statistics is a simple and efficient way to access various statistics in git repository.

```sh
brew install git-quick-stats

git quick-stats
# or
git-quick-stats
```

### Aliases

| Alias                | Command                                                                                                                                 |
| :------------------- | :-------------------------------------------------------------------------------------------------------------------------------------- |
| g                    | git                                                                                                                                     |
| ga                   | git add                                                                                                                                 |
| gaa                  | git add --all                                                                                                                           |
| gapa                 | git add --patch                                                                                                                         |
| gb                   | git branch                                                                                                                              |
| gba                  | git branch -a                                                                                                                           |
| gbda                 | git branch --merged \| command grep -vE "^(\*\|\s*master\s*$)" \| command xargs -n 1 git branch -d                                      |
| gbl                  | git blame -b -w                                                                                                                         |
| gbnm                 | git branch --no-merged                                                                                                                  |
| gbr                  | git branch --remote                                                                                                                     |
| gbs                  | git bisect                                                                                                                              |
| gbsb                 | git bisect bad                                                                                                                          |
| gbsg                 | git bisect good                                                                                                                         |
| gbsr                 | git bisect reset                                                                                                                        |
| gbss                 | git bisect start                                                                                                                        |
| gc                   | git commit -v                                                                                                                           |
| gc!                  | git commit -v --amend                                                                                                                   |
| gca                  | git commit -v -a                                                                                                                        |
| gcam                 | git commit -a -m                                                                                                                        |
| gca!                 | git commit -v -a --amend                                                                                                                |
| gcan!                | git commit -v -a -s --no-edit --amend                                                                                                   |
| gcb                  | git checkout -b                                                                                                                         |
| gcf                  | git config --list                                                                                                                       |
| gcl                  | git clone --recursive                                                                                                                   |
| gclean               | git clean -df                                                                                                                           |
| gcm                  | git checkout master                                                                                                                     |
| gcd                  | git checkout develop                                                                                                                    |
| gcmsg                | git commit -m                                                                                                                           |
| gco                  | git checkout                                                                                                                            |
| gcount               | git shortlog -sn                                                                                                                        |
| gcp                  | git cherry-pick                                                                                                                         |
| gcpa                 | git cherry-pick --abort                                                                                                                 |
| gcpc                 | git cherry-pick --continue                                                                                                              |
| gcs                  | git commit -S                                                                                                                           |
| gd                   | git diff                                                                                                                                |
| gdca                 | git diff --cached                                                                                                                       |
| gdt                  | git diff-tree --no-commit-id --name-only -r                                                                                             |
| gdw                  | git diff --word-diff                                                                                                                    |
| gf                   | git fetch                                                                                                                               |
| gfa                  | git fetch --all --prune                                                                                                                 |
| gfo                  | git fetch origin                                                                                                                        |
| gg                   | git gui citool                                                                                                                          |
| gga                  | git gui citool --amend                                                                                                                  |
| ggf                  | git push --force origin $(current_branch)                                                                                               |
| ghh                  | git help                                                                                                                                |
| ggpull               | ggl                                                                                                                                     |
| ggpur                | ggu                                                                                                                                     |
| ggpush               | ggp                                                                                                                                     |
| ggsup                | git branch --set-upstream-to = origin/$(current_branch)                                                                                 |
| gpsup                | git push --set-upstream origin $(current_branch)                                                                                        |
| gignore              | git update-index --assume-unchanged                                                                                                     |
| gignored             | git ls-files -v \| grep "^[[:lower:]]"                                                                                                  |
| git-svn-dcommit-push | git svn dcommit && git push github master:svntrunk                                                                                      |
| gk                   | \gitk --all --branches                                                                                                                  |
| gke                  | \gitk --all $(git log -g --pretty = format:%h)                                                                                          |
| gl                   | git pull                                                                                                                                |
| glg                  | git log --stat --color                                                                                                                  |
| glgg                 | git log --graph --color                                                                                                                 |
| glgga                | git log --graph --decorate --all                                                                                                        |
| glgm                 | git log --graph --max-count = 10                                                                                                        |
| glgp                 | git log --stat --color -p                                                                                                               |
| glo                  | git log --oneline --decorate --color                                                                                                    |
| glog                 | git log --oneline --decorate --color --graph                                                                                            |
| glol                 | git log --graph --pretty = format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit       |
| glola                | git log --graph --pretty = format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all |
| glp                  | _git_log_prettily                                                                                                                       |
| gm                   | git merge                                                                                                                               |
| gmom                 | git merge origin/master                                                                                                                 |
| gmt                  | git mergetool --no-prompt                                                                                                               |
| gmtvim               | git mergetool --no-prompt --tool = vimdiff                                                                                              |
| gmum                 | git merge upstream/master                                                                                                               |
| gp                   | git push                                                                                                                                |
| gpd                  | git push --dry-run                                                                                                                      |
| gpoat                | git push origin --all && git push origin --tags                                                                                         |
| gpristine            | git reset --hard && git clean -dfx                                                                                                      |
| gpu                  | git push upstream                                                                                                                       |
| gpv                  | git push -v                                                                                                                             |
| gr                   | git remote                                                                                                                              |
| gra                  | git remote add                                                                                                                          |
| grb                  | git rebase                                                                                                                              |
| grba                 | git rebase --abort                                                                                                                      |
| grbc                 | git rebase --continue                                                                                                                   |
| grbi                 | git rebase -i                                                                                                                           |
| grbm                 | git rebase master                                                                                                                       |
| grbs                 | git rebase --skip                                                                                                                       |
| grh                  | git reset HEAD                                                                                                                          |
| grhh                 | git reset HEAD --hard                                                                                                                   |
| grmv                 | git remote rename                                                                                                                       |
| grrm                 | git remote remove                                                                                                                       |
| grset                | git remote set-url                                                                                                                      |
| grt                  | cd $(git rev-parse --show-toplevel \|\| echo ".")                                                                                       |
| gru                  | git reset --                                                                                                                            |
| grup                 | git remote update                                                                                                                       |
| grv                  | git remote -v                                                                                                                           |
| gsb                  | git status -sb                                                                                                                          |
| gsd                  | git svn dcommit                                                                                                                         |
| gsi                  | git submodule init                                                                                                                      |
| gsps                 | git show --pretty = short --show-signature                                                                                              |
| gsr                  | git svn rebase                                                                                                                          |
| gss                  | git status -s                                                                                                                           |
| gst                  | git status                                                                                                                              |
| gsta                 | git stash save                                                                                                                          |
| gstaa                | git stash apply                                                                                                                         |
| gstd                 | git stash drop                                                                                                                          |
| gstl                 | git stash list                                                                                                                          |
| gstp                 | git stash pop                                                                                                                           |
| gstc                 | git stash clear                                                                                                                         |
| gsts                 | git stash show --text                                                                                                                   |
| gsu                  | git submodule update                                                                                                                    |
| gts                  | git tag -s                                                                                                                              |
| gunignore            | git update-index --no-assume-unchanged                                                                                                  |
| gunwip               | git log -n 1 \| grep -q -c "\-\-wip\-\-" && git reset HEAD~1                                                                            |
| gup                  | git pull --rebase                                                                                                                       |
| gupv                 | git pull --rebase -v                                                                                                                    |
| glum                 | git pull upstream master                                                                                                                |
| gvt                  | git verify-tag                                                                                                                          |
| gwch                 | git whatchanged -p --abbrev-commit --pretty = medium                                                                                    |
| gwip                 | git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit -m "--wip--"                                                      |

## Functions

### Current

| Command                | Description                             |
| :--------------------- | :-------------------------------------- |
| current_branch         | Return the name of the current branch   |
| current_repository     | Return the names of the current remotes |
| git_current_user_name  | Returns the `user.name` config value    |
| git_current_user_email | Returns the `user.email` config value   |

### WiP

These features allow to pause a branch development and switch to another one (_"Work in Progress"_,  or wip). When you want to go back to work, just unwip it.

| Command          | Description                                     |
| :--------------- | :---------------------------------------------- |
| work_in_progress | Echoes a warning if the current branch is a wip |
| gwip             | Commit wip branch                               |
| gunwip           | Uncommit wip branch                             |

## contributions

* [firstcontributions/first-contributions](https://github.com/firstcontributions/first-contributions):🚀✨ Help beginners to contribute to open source projects https://firstcontributions.github.io

## 客户端

* msysgit
* sourcetree
* [GitHawkApp/GitHawk](https://github.com/GitHawkApp/GitHawk):A GitHub project manager app for iOS. http://githawk.com
* Linux
  - SmartGit
  - GitKraken
  - Git Cola

## 问题

> error: insufficient permission for adding an object to repository database .git/objects

chown -R henry:henry .git/objects

## 文档

* [文档](https://git-scm.com/docs)
* [tiimgreen/github-cheat-sheet](https://github.com/tiimgreen/github-cheat-sheet):A list of cool features of Git and GitHub. http://git.io/sheet
* [atlassian](https://www.atlassian.com/git)
* [progit/progit](https://github.com/progit/progit):Pro Git 2nd Edition
* [geeeeeeeeek/git-recipes](https://github.com/geeeeeeeeek/git-recipes):Git recipes in Chinese. 高质量的Git中文教程.
* [GitHub规范](https://guides.github.com/)
* [xirong/my-git](https://github.com/xirong/my-git):Individual collecting material of learning git（有关 git 的学习资料） https://github.com/xirong/my-git
* [github/gitignore](https://github.com/github/gitignore):A collection of useful .gitignore templates
* [A successful Git branching model](http://nvie.com/posts/a-successful-git-branching-model/)
* [Git权威指南](http://www.worldhello.net/):GotGitHub
* [MarkLodato/visual-git-guide](https://github.com/MarkLodato/visual-git-guide):A visual guide to git.http://marklodato.github.io/visual-git-guide/index-en.html
* [练习沙盒](https://try.github.io)
* [git-tips/tips](https://github.com/git-tips/tips):Most commonly used git tips and tricks. http://git.io/git-tips
* [521xueweihan/HelloGitHub](https://github.com/521xueweihan/HelloGitHub): :octocat:分享 GitHub 上好玩、容易上手的项目，帮你找到编程的乐趣。欢迎推荐、自荐项目，让更多人知道你的项目star
* [susam/gitpr](https://github.com/susam/gitpr#with-merge-commit):A quick reference guide on fork and pull request workflow
* [git-flight-rules](https://github.com/k88hudson/git-flight-rules):Flight rules for git
* [Git Immersion](http://gitimmersion.com/):The surest path to mastering Git is to immerse oneself in its utilities and operations, to experience it first-hand
* [Atlassian Git Tutorial](https://www.atlassian.com/git/tutorials)
* [git-tutorial](https://www.learnenough.com/git-tutorial)
* [GitHub Helps](https://help.github.com/)
* [k88hudson/git-flight-rules](https://github.com/k88hudson/git-flight-rules):Flight rules for git
* [pcottle/learnGitBranching](https://github.com/pcottle/learnGitBranching):An interactive git visualization to challenge and educate!
* Progit2，最好的深入学习 Git 的教材，而且是开源的https://github.com/progit/progit2
* Magit，Git 在 Emacs 上的打开方式：https://magit.vc/
* Vim-fugitive，Git 在 Vim 上的打开方式：https://github.com/tpope/vim-fugitive
* Git 相关的 shell 提示： https://github.com/magicmonty/bash-git-prompt

## 工具

* [github/hub](https://github.com/github/hub)hub helps you win at git. http://hub.github.com/
* [donnemartin/gitsome](https://github.com/donnemartin/gitsome):A supercharged Git/GitHub command line interface (CLI). An official integration for GitHub and GitHub Enterprise: https://github.com/works-with/category/desktop-tools
* [tj/git-extras](https://github.com/tj/git-extras):GIT utilities -- repo summary, repl, changelog population, author commit percentages and more
* [jonas/tig](https://github.com/jonas/tig):text-mode interface for git
* [cloudson/gitql](https://github.com/cloudson/gitql):A git query language
* [kennethreitz/legit](https://github.com/kennethreitz/legit):Git for Humans, Inspired by GitHub for Mac™. http://www.git-legit.org/
* [jayphelps/git-blame-someone-else](https://github.com/jayphelps/git-blame-someone-else):Blame someone else for your bad code.
* [kamranahmedse/git-standup](https://github.com/kamranahmedse/git-standup):Recall what you did on the last working day. Psst! or be nosy and find what someone else in your team did ;-)
* [typicode/husky](https://github.com/typicode/husky):🐶 Git hooks made easy
* [conventional-changelog/conventional-changelog](https://github.com/conventional-changelog/conventional-changelog):Generate a changelog from git metadata.
* [pstadler/keybase-gpg-github](https://github.com/pstadler/keybase-gpg-github):Step-by-step guide on how to create a GPG key on keybase.io, adding it to a local GPG setup and use it with Git and GitHub.
* [jesseduffield/lazygit](https://github.com/jesseduffield/lazygit):simple terminal UI for git commands
* [isomorphic-git/isomorphic-git](https://github.com/isomorphic-git/isomorphic-git):A pure JavaScript implementation of git for node and browsers! https://isomorphic-git.org/
* [Fakerr/git-recall](https://github.com/Fakerr/git-recall):An interactive way to peruse your git history from the terminal
* [rgburke/grv](https://github.com/rgburke/grv):GRV is a terminal interface for viewing git repositories
* [magit/magit](https://github.com/magit/magit):It's Magit! A Git porcelain inside Emacs. https://magit.vc
* [carloscuesta/gitmoji](https://github.com/carloscuesta/gitmoji):An emoji guide for your commit messages. 😜 https://gitmoji.carloscuesta.me
* [magit/magit](https://github.com/magit/magit):It's Magit! A Git porcelain inside Emacs. https://magit.vc
* [zenhub](https://app.zenhub.com)：Agile project management integrated with GitHub
* [commitizen/cz-cli](https://github.com/commitizen/cz-cli):The commitizen command line utility. http://commitizen.github.io/cz-cli/
* [imsun/gitment](https://github.com/imsun/gitment):A comment system based on GitHub Issues. https://imsun.github.io/gitment/
* [rtyley/bfg-repo-cleaner](https://github.com/rtyley/bfg-repo-cleaner):Removes large or troublesome blobs like git-filter-branch does, but faster. And written in Scala
* [sdg-mit/gitless](https://github.com/sdg-mit/gitless):A version control system built on top of Git http://gitless.com
* [sobolevn/git-secret](https://github.com/sobolevn/git-secret):👥 A bash-tool to store your private data inside a git repository. http://git-secret.io
* [scmmanager](https://www.scm-manager.org/):The easiest way to share and manage your Git, Mercurial and Subversion repositories over http
* [marionebl/commitlint](https://github.com/marionebl/commitlint):📓 Lint commit messages https://marionebl.github.io/commitlint/

## 参考

* attributes   Defining attributes per path
* everyday     Everyday Git With 20 Commands Or So
* glossary     A Git glossary
* ignore       Specifies intentionally untracked files to ignore
* modules      Defining submodule properties
* revisions    Specifying revisions and ranges for Git
* tutorial     A tutorial introduction to Git (for version 1.5.1 or newer)
* workflows    An overview of recommended workflows with Git
* [alias](https://github.com/robbyrussell/oh-my-zsh/wiki/Plugin:git):oh my zsh 中的 alias
* [Conventional Commits](https://conventionalcommits.org/)
* [git-commit-guidelines](https://github.com/angular/angular.js/blob/master/DEVELOPERS.md#-git-commit-guidelines)
* [Git 工作流](https://juejin.im/post/5a014d5f518825295f5d56c7)
