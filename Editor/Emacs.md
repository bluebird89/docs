# [emacs-mirror/emacs](https://github.com/emacs-mirror/emacs)

## 安装

```sh
# ubuntu
sudo apt-get install emacs

brew install emacs-mac
brew linkapps emacs-mac # 无效
```

## 配置(使用 purcell)

```
sudo rm ~/.emacs.d/
git clone https://github.com/purcell/emacs.d.git ~/.emacs.d
```

### [syl20bnr/spacemacs](https://github.com/syl20bnr/spacemacs)

A community-driven Emacs distribution - The best editor is neither Emacs nor Vim, it's Emacs *and* Vim! http://spacemacs.org

```sh
brew tap d12frosted/emacs-plus
brew install emacs-plus
brew linkapps emacs-plus

emacs --insecure
```

## 快捷键

C代表Ctrl键，M代表Alt键，RET表示Enter键

- C-x n：开n个窗口

<http://blog.csdn.net/redguardtoo/article/details/7222501/> <https://wiki.archlinux.org/index.php/Emacs_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87>) <http://yulongniu.bionutshell.org/blog/2011/08/13/emacs-tips/> <http://www.jianshu.com/p/dc9515c6a33f>

## 框架

* [manateelazycat/emacs-application-framework](https://github.com/manateelazycat/emacs-application-framework):Emacs application framework
