# AJAX


```js
# send credentials along with cross-domain posts:using credentials such as cookies, authorization headers or TLS client certificates.
$.ajaxSetup({
    type: "POST",
    data: {},
    dataType: 'json',
    xhrFields: {
       withCredentials: true
    },
    crossDomain: true
});

$.ajax({
    url: 'http://bar.other',
    data: { whatever:'cool' },
    type: 'GET',
    beforeSend: function(xhr){
       xhr.withCredentials = true;
    }
});
```

## 参考
* <https://juejin.im/post/58c883ecb123db005311861a>
* [Ajax 知识体系大梳理](https://juejin.im/post/58c883ecb123db005311861a)
