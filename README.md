All request parameters must be sent using the POST method
All methods return operation status (success, fail) and additional data in JSON
Login and Password should be passed at every api request.

 
Example of API request:  http://dizzcloud.com/api/getuploadurl/apitest@dizzcloud.com/testpassword

HTTP CODES
```
200 - Request successful
400 - Bad request (not correct request params)
403 - Authorization required
406 - Not acceptable
```


METHODS

```
getuploadurl ->
    status_code: [success, fail]
    code: [200, 400, 403]
    auth_token: string

    For example:
        request:  curl http://dizzcloud.com/api/getuploadurl/apitest@dizzcloud.com/testpassword
        response: {"status":"success","code":200,"uploadurl":"http://u67.cloudstoreservice.net/upload?cdn_server=...."}

    
```
