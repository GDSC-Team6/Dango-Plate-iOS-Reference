#  경로는 API 구조체에서 저장하기 

### https 가 되지 않아서 http 로 기본 URL 을 저장했슴다. 

항상 api 요청할때 헤더부분에 

```swift
    let headers: HTTPHeaders = [
        "Authorization": "Bearer \(getATK())"
    ]
```
이거 추가해서 사용하면 될거같아요 
        AF.request("\(API.USER_DATA)", headers: headers).responseJSON
        
요렇게 하면 전달가능
