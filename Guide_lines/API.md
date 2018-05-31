# Practice Mobilizer

Sikka Practice Mobilizer is an integrated suite of tools offering full control of your practice on your mobile device.For more details : https://practicemobilizer.com/

## **GET** fee_schedule_optimizer

>https://api.sikkasoft.com/v2/fee_schedule_optimizer?request_key=request_key&practice_id={practice_id}&startdate={startdate}&enddate={enddate}

This API to optimize fees for your practice.

Parameter |   Description | Required?
------- | -------- | ------- 
request_key | Valid 32 characters alpha-numeric request key |   Yes
practice_id|  Practice ID|  Yes
startdate  |  format: yyyy-mm-dd, start date |  Yes
enddate | format: yyyy-mm-dd, end date  |   Yes
zipcode|  Zipcode|  No
fee_name  |   Name of fee schedule  |   No


## 参考

* [interagent/http-api-design](https://github.com/interagent/http-api-design):HTTP API design guide extracted from work on the Heroku Platform API
* [swagger-api/swagger-ui](https://github.com/swagger-api/swagger-ui):Swagger UI is a collection of HTML, Javascript, and CSS assets that dynamically generate beautiful documentation from a Swagger-compliant API. http://swagger.io
* [API网关的作用、方案以及如何选择](http://blog.didispace.com/API%E7%BD%91%E5%85%B3%E7%9A%84%E4%BD%9C%E7%94%A8%E3%80%81%E6%96%B9%E6%A1%88%E4%BB%A5%E5%8F%8A%E5%A6%82%E4%BD%95%E9%80%89%E6%8B%A9/)
* [Introduction to Microservices](https://www.nginx.com/blog/introduction-to-microservices/)
* [Pattern: API Gateway / Backend for Front-End](http://microservices.io/patterns/apigateway.html)
* [json-api/json-api](https://github.com/json-api/json-api):A specification for building JSON APIs http://jsonapi.org
