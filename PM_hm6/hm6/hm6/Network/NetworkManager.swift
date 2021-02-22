
import Foundation
import WebKit

//class AccountInfo: Codable {
//
//    var login: String?
//    var id: Int?
//    var name: String?
//}

class NetworkManager {
    
    //
    func authURLConstructor() -> URLRequest {
        
        let uuid = UUID().uuidString
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "github.com"
        urlComponents.path = "/login/oauth/authorize"
        urlComponents.queryItems = [
                    URLQueryItem(name: "client_id=", value: String(ClientConstants.CLIENT_ID)),
                    URLQueryItem(name: "scope", value: String(ClientConstants.SCOPE)),
                    URLQueryItem(name: "redirect_uri", value: String(ClientConstants.REDIRECT_URI)),
                    URLQueryItem(name: "scope", value: String(uuid))
        ]
                var request = URLRequest(url: urlComponents.url!)
                request.httpMethod = "GET"
        
                return request
    }
//    let authURLFull = "https://github.com/login/oauth/authorize?client_id=" + ClientConstants.CLIENT_ID + "&scope=" + ClientConstants.SCOPE + "&redirect_uri=" + ClientConstants.REDIRECT_URI + "&state=" + uuid
    
    //    func createURLForcastRequest(_ lat: Double , _ lon: Double ) -> URLRequest {
    //
    //        var urlComponents = URLComponents()
    //
    //        urlComponents.scheme = "https"
    //        urlComponents.host = "api.openweathermap.org"
    //        urlComponents.path = "/data/2.5/onecall"
    //        urlComponents.queryItems = [
    //            URLQueryItem(name: "lat", value: String(lat)),
    //            URLQueryItem(name: "lon", value: String(lon)),
    //            URLQueryItem(name: "units", value: "metric"),
    //            URLQueryItem(name: "appid", value: "e7fc58f1126ed00b67195097153e0987")]
    //
    //        var request = URLRequest(url: urlComponents.url!)
    //        request.httpMethod = "GET"
    //
    //        return request
    //    }
    
    
    //    var webView = WKWebView()
    //    func githubAuthVC() {
    //        // Create github Auth ViewController
    //        let githubVC = UIViewController()
    //        // Generate random identifier for the authorization
    //        let uuid = UUID().uuidString
    //        // Create WebView
    //        let webView = WKWebView()
    //        webView.navigationDelegate = self
    //        githubVC.view.addSubview(webView)
    //        webView.translatesAutoresizingMaskIntoConstraints = false
    //        NSLayoutConstraint.activate([
    //            webView.topAnchor.constraint(equalTo: githubVC.view.topAnchor),
    //            webView.leadingAnchor.constraint(equalTo: githubVC.view.leadingAnchor),
    //            webView.bottomAnchor.constraint(equalTo: githubVC.view.bottomAnchor),
    //            webView.trailingAnchor.constraint(equalTo: githubVC.view.trailingAnchor)
    //        ])
    //
    //        let authURLFull = "https://github.com/login/oauth/authorize?client_id=" + ClientConstants.CLIENT_ID + "&scope=" + ClientConstants.SCOPE + "&redirect_uri=" + ClientConstants.REDIRECT_URI + "&state=" + uuid
    //
    //        let urlRequest = URLRequest(url: URL(string: authURLFull)!)
    //        webView.load(urlRequest)
    //
    //        // Create Navigation Controller
    //        let navController = UINavigationController(rootViewController: githubVC)
    //        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelAction))
    //        githubVC.navigationItem.leftBarButtonItem = cancelButton
    //        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshAction))
    //        githubVC.navigationItem.rightBarButtonItem = refreshButton
    //        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    //        navController.navigationBar.titleTextAttributes = textAttributes
    //        githubVC.navigationItem.title = "github.com"
    //        navController.navigationBar.isTranslucent = false
    //        navController.navigationBar.tintColor = UIColor.white
    ////        navController.navigationBar.barTintColor = UIColor.colorFromHex("#333333")
    //        navController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
    //        navController.modalTransitionStyle = .coverVertical
    //
    //        self.present(navController, animated: true, completion: nil)
}

//    func createURLRequest() -> URLRequest {
//
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "api.github.com"
//        urlComponents.path = "/users/kvadrot"
//
//        var request = URLRequest(url: urlComponents.url!)
//
//        request.httpMethod = "GET"
//
//        return request
//    }
//
//    func getInfo(_ url: URLRequest, compelition: @escaping (AccountInfo) -> Void) {
//
//        let task = URLSession(configuration: .default)
//        let dataTask: Void = task.dataTask(with: url) { (data, response, error) in
//
//                    guard error == nil else { return print("error gamno") }
//
//                    let decoder = JSONDecoder()
//
//                    guard data != nil else { return print("void in data")}
//
//                    do {
//
//                        let decoderedAccauntInfo: AccountInfo
//                        decoderedAccauntInfo = try decoder.decode(AccountInfo.self, from: data!)
//
//                        compelition(decoderedAccauntInfo)
//                    } catch {
//                        print(error)
//                    }
//                }.resume()
//    }
//}
