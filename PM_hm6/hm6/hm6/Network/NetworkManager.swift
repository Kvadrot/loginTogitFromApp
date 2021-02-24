
import Foundation
import WebKit


class NetworkManager {
    
    //
    func authURLConstructor() -> URLRequest {
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "github.com"
        urlComponents.path = "/login/oauth/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: String(ClientConstants.CLIENT_ID)),
            URLQueryItem(name: "scope", value: String(ClientConstants.SCOPE)),
            URLQueryItem(name: "redirect_uri", value: String(ClientConstants.REDIRECT_URI)),
        ]
        
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        
        return request
    }
    
    func RequestForCallbackURL(request: URLRequest, completion: () -> Void) {
        //MARK: get the authorization code string after the ?code=

        let queryCode = URLComponents.init(url: request.url!, resolvingAgainstBaseURL: true)?.queryItems
        guard let gamno = queryCode?[0] else { return }
        
        postParameteresConstructor(String(gamno.value!))
        completion()
    }
    
    func postParameteresConstructor(_ authCode: String) {
        
        let myTokenPath = "/login/oauth/access_token"
        
        //MARK: url for POST request
        var urlComponentsForPOST = URLComponents()
        urlComponentsForPOST.scheme = "https"
        urlComponentsForPOST.host = "github.com"
        urlComponentsForPOST.path = myTokenPath
        let request = URLRequest(url: urlComponentsForPOST.url!)
        
        //MARK: setting request.httpBody
        var urlComponentsHttpBody = URLComponents()
        urlComponentsHttpBody.queryItems = [
            URLQueryItem(name: "client_id", value: String(ClientConstants.CLIENT_ID)),
            URLQueryItem(name: "client_secret", value: String(ClientConstants.CLIENT_SECRET)),
            URLQueryItem(name: "code", value: authCode),
        ]
        var postElements = URLRequest(url: urlComponentsHttpBody.url!)
        
        postElements.httpMethod = "POST"
        postElements.addValue("application/json", forHTTPHeaderField: "Accept")
        postElements.httpBody = urlComponentsHttpBody.percentEncodedQuery?.data(using: .utf8)
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, _) -> Void in
            let statusCode = (response as! HTTPURLResponse).statusCode
            
            if statusCode == 200 {
                let results = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [AnyHashable: Any]
                let accessToken = results?["access_token"] as! String
                // Get user's id, display name, email, profile pic url
                print(accessToken)
                //self.fetchGitHubUserProfile(accessToken: accessToken)
            }
        }
        task.resume()
        fetchDataFromRepo()
    }
    
    func fetchDataFromRepo() {
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.github.com"
        urlComponents.path = "/repos/kvadrot/HomeWork6/contents"
        urlComponents.queryItems = [
        ]
        
        var requestReposData = URLRequest(url: urlComponents.url!)
        requestReposData.httpMethod = "GET"
        
        let task = URLSession(configuration: .default)
        let dataTask: Void = task.dataTask(with: requestReposData) { (data, response, error) in
            
            guard error == nil else { return print("error gamno") }
            
            let decoder = JSONDecoder()
            
            guard data != nil else { return print("void in data")}
            
            do {

                var decoderedAllImages: AllImages = .init()//AllImages
                decoderedAllImages.images = try decoder.decode([ImageForFetchingDetails].self, from: data!)
                //compelition(decoderedAllImages)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func closeWebView(comlition: () -> Void) {
        comlition()
    }
}
