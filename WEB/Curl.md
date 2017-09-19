curl is used in command lines or scripts to transfer data.

[文档](https://ec.haxx.se/) [Gitbook](https://www.gitbook.com/book/bagder/everything-curl/details)

```
curl -X POST \
  http://localhost:8080/ \
  -H 'cache-control: no-cache' \
  -H 'content-type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW' \
  -F 'html=@/example'
```
