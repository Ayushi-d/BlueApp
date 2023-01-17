import Foundation


enum RequestMethod: String{
    case get
    case post
    case delete
    case put
}

struct URLDataProvider
{
    func hitAPI<T:Codable>(requestUrl: URL, httpMethod: RequestMethod, requestBody: Data?, resultType: T.Type?, completionHandler:@escaping(_ result: T?, _ statusCode: Int, _ isSuccess: Bool, _ error: Error?)-> Void)
    {
        ProgressHUD.show()
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpBody = requestBody
        urlRequest.allHTTPHeaderFields = sendheaders()
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
            guard let httpResponse = httpUrlResponse as? HTTPURLResponse else {return}
            let statusCode = httpResponse.statusCode
                do {
                    let response = try JSONDecoder().decode(T.self, from: data!)
                    print(response)
                    if (200...299).contains(statusCode){
                        _=completionHandler(response,statusCode,true,nil)
                    }else{
                        _=completionHandler(response,statusCode,false,error)
                    }
                    ProgressHUD.hide()
                }
                catch let error {
                    ProgressHUD.hide()
                    _=completionHandler(nil,statusCode,false,error)
                    debugPrint(error)
                }
        }.resume()
    }

    func hitAPI(requestUrl: URL, httpMethod: RequestMethod, requestBody: Data?, completionHandler:@escaping(_ result:[String:Any] , _ statusCode: Int, _ isSuccess: Bool, _ error: Error?)-> Void)
    {
        ProgressHUD.show()
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpBody = requestBody
        urlRequest.allHTTPHeaderFields = sendheaders()
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
            guard let httpResponse = httpUrlResponse as? HTTPURLResponse else {return}
            let statusCode = httpResponse.statusCode
            guard let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any] else {return}
            if (200...299).contains(statusCode){
                ProgressHUD.hide()
                _=completionHandler(jsonData,statusCode,true,error)
            }else{
                ProgressHUD.hide()
                _=completionHandler(jsonData,statusCode,false,error)
            }

        }.resume()

    }
    
    func hitAPIwithHeaders(requestUrl: URL, httpMethod: RequestMethod, requestBody: Data?, headers: [ String:String]?, completionHandler:@escaping(_ result:[String:Any] , _ statusCode: Int, _ isSuccess: Bool, _ error: Error?)-> Void)
    {
        ProgressHUD.show()
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpBody = requestBody
        urlRequest.allHTTPHeaderFields = headers
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
            guard let httpResponse = httpUrlResponse as? HTTPURLResponse else {return}
            let statusCode = httpResponse.statusCode
            guard let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String: Any] else {return}
            if (200...299).contains(statusCode){
                ProgressHUD.hide()
                _=completionHandler(jsonData,statusCode,true,error)
            }else{
                ProgressHUD.hide()
                _=completionHandler(jsonData,statusCode,false,error)
            }

        }.resume()

    }

    

    func sendheaders() -> [String:String]{

        var headers: [String: String] {
            if let userAuthToken = UserManager.shared.authToken {
                return ["Accept": "application/json",
                        "Authorization": "Bearer \(userAuthToken)"]
            }
            return ["Content-Type": "application/json"] // + aDictMetaData
        }
        return headers
    }

}
