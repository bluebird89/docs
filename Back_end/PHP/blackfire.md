# [balckfire](https://blackfire.io)

```sh
brew tap blackfireio/homebrew-blackfire
brew install blackfire-agent
sudo blackfire-agent --register --server-id=78f47cdd-d565-429b-93dd-03456936c410 --server-token=2adb1d6f8cfd80355ddd8cff2f9e2b0dfbffb38bfd05f8902e33090dc84493a3
brew services start blackfire-agent
brew services restart blackfire-agent
/usr/local/var/log/blackfire/agent.log
brew install blackfire-php74
extension=blackfire.so
blackfire config --client-id=1fc30f1c-4590-4328-a9d0-724fc09950e9 --client-token=65f2bedd1d4c68e6693eed6b8c2861c59452119291bf7493250c3d06f7f3340d
```

## 参考

* [docs](https://blackfire.io/docs/introduction)
