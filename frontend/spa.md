# SPA(Single Page Application)

所有畫面都是在前端由 JavaScript 動態產生，那我後端不就永遠都輸出同一個檔案就好？如此一來，使用者看到的其實都是同一個頁面，而我們利用 JavaScript 在這個頁面上做變化

## MVC

* Model   去跟後端 API 拿資料
* View    在前端動態產生畫面
* Controller  呼叫相對應的 Model 並 render 畫面

## 状态管理

## SEO弱点

由於 SPA 是由前端的 JavaScript 動態產生內容，因此如果你對 SPA 的網站按下右鍵 -> 檢視原始碼，只會看到空蕩蕩的一片，只看得到一個 JavaScript 檔案跟一些最基本的 tag。

Google 的爬蟲其實支援執行 JavaScript，依然會 index 你在前端渲染之後的頁面

- 第一個頁面由 Server side render，之後的操作還是由 Client side render

## SSR(Server Side Rendering)

* 只要在第一次渲染的時候把該輸出的資料都輸出就好啦，對使用者來說還是一個 SPA，差別在於使用者接收到 HTML 的時候，就已經有完整的資料了。
* 後端直接回傳整份 HTML，瀏覽器直接顯示就好，因為 response 就是完整的網頁了。
