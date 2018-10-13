# SVN


## install

### Ubuntu

```sh
sudo apt install subversion

sc create svnd binPath= "E:/code/tool/svn/server/bin/svnserve.exe -r D:/tools/svn/app  --service"  start= manual

sc create svnd binPath= "D:/tools/svn/server/bin/svnserve.exe -r D:/tools/svn/app  --service"  start= manual
```

svn+ssh
