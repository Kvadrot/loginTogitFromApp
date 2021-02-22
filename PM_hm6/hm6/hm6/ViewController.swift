

import UIKit
import WebKit


class ViewController: UIViewController {
    
    let networkManager = NetworkManager()

    @IBOutlet weak var loginButton: UIButton!

    @IBAction func loginButton(_ sender: Any) {
        self.createWebWiev()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButton.layer.cornerRadius = 20.0
    }

    func createWebWiev(){
        let webView = WKWebView()
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: self.view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        let authURL = networkManager.authURLConstructor()
        webView.load(authURL)
    }

}


    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "detailseg" {
    //            let DestView = segue.destination as! DetailsViewController
    //            DestView.githubId = self.githubId
    //            DestView.githubDisplayName = self.githubDisplayName
    //            DestView.githubEmail = self.githubEmail
    //            DestView.githubAvatarURL = self.githubAvatarURL
    //            DestView.githubAccessToken = self.githubAccessToken
    //        }
    //    }


extension ViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        self.RequestForCallbackURL(request: navigationAction.request)
        decisionHandler(.allow)
    }
    
    func RequestForCallbackURL(request: URLRequest) {
        // Get the authorization code string after the '?code=' and before '&state='
        let requestURLString = (request.url?.absoluteString)! as String
        print(requestURLString)
        if requestURLString.hasPrefix(ClientConstants.REDIRECT_URI) {
            if requestURLString.contains("code=") {
                if let range = requestURLString.range(of: "=") {
                    let githubCode = requestURLString[range.upperBound...]
                    if let range = githubCode.range(of: "&state=") {
                        let githubCodeFinal = githubCode[..<range.lowerBound]
                        githubRequestForAccessToken(authCode: String(githubCodeFinal))
                        
                        // Close GitHub Auth ViewController after getting Authorization Code
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func githubRequestForAccessToken(authCode: String) {
        let grantType = "authorization_code"
        
        // Set the POST parameters.
        let postParams = "grant_type=" + grantType + "&code=" + authCode + "&client_id=" + ClientConstants.CLIENT_ID + "&client_secret=" + ClientConstants.CLIENT_SECRET
        let postData = postParams.data(using: String.Encoding.utf8)
        let request = NSMutableURLRequest(url: URL(string: ClientConstants.TOKENURL)!)
        request.httpMethod = "POST"
        request.httpBody = postData
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest) { (data, response, _) -> Void in
            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == 200 {
                let results = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [AnyHashable: Any]
                let accessToken = results?["access_token"] as! String
                // Get user's id, display name, email, profile pic url
                self.fetchGitHubUserProfile(accessToken: accessToken)
            }
        }
        task.resume()
    }
    
    func fetchGitHubUserProfile(accessToken: String) {
        let tokenURLFull = "https://api.github.com/user"
        let verify: NSURL = NSURL(string: tokenURLFull)!
        let request: NSMutableURLRequest = NSMutableURLRequest(url: verify as URL)
        request.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, _, error in
            if error == nil {
                let result = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [AnyHashable: Any]
                // AccessToken
                //                print("GitHub Access Token: \(accessToken)")
                //                self.githubAccessToken = accessToken
                //                // GitHub Id
                //                let githubId: Int! = (result?["id"] as! Int)
                //                print("GitHub Id: \(githubId ?? 0)")
                //                self.githubId = githubId
                //                // GitHub Display Name
                //                let githubDisplayName: String! = (result?["login"] as! String)
                //                print("GitHub Display Name: \(githubDisplayName ?? "")")
                //                self.githubDisplayName = githubDisplayName
                //                 GitHub Email
                //                let githubEmail: String! = (result?["email"] as! String)
                //                print("GitHub Email: \(githubEmail ?? "")")
                //                self.githubEmail = githubEmail
                //                 GitHub Profile Avatar URL
                //                let githubAvatarURL: String! = (result?["avatar_url"] as! String)
                //                print("Github Profile Avatar URL: \(githubAvatarURL ?? "")")
                //                self.githubAvatarURL = githubAvatarURL
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "detailseg", sender: self)
                }
            }
        }
        task.resume()
    }
}


//-----------------------------------------------------------
//-----------------------------------------------------------

//func fetchGitHubUserProfile(accessToken: String) {
//    let tokenURLFull = "https://api.github.com/user"
//    let verify: NSURL = NSURL(string: tokenURLFull)!
//    let request: NSMutableURLRequest = NSMutableURLRequest(url: verify as URL)
//    request.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
//    let task = URLSession.shared.dataTask(with: request as URLRequest) { data, _, error in
//        if error == nil {
//            let result = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [AnyHashable: Any]
//            // AccessToken
//            print("GitHub Access Token: \(accessToken)")
//            self.githubAccessToken = accessToken
//            // GitHub Id
//            let githubId: Int! = (result?["id"] as! Int)
//            print("GitHub Id: \(githubId ?? 0)")
//            self.githubId = githubId
//            // GitHub Display Name
//            let githubDisplayName: String! = (result?["login"] as! String)
//            print("GitHub Display Name: \(githubDisplayName ?? "")")
//            self.githubDisplayName = githubDisplayName
//             GitHub Email
//            let githubEmail: String! = (result?["email"] as! String)
//            print("GitHub Email: \(githubEmail ?? "")")
//            self.githubEmail = githubEmail
//             GitHub Profile Avatar URL
//            let githubAvatarURL: String! = (result?["avatar_url"] as! String)
//            print("Github Profile Avatar URL: \(githubAvatarURL ?? "")")
//            self.githubAvatarURL = githubAvatarURL
//            DispatchQueue.main.async {
//                self.performSegue(withIdentifier: "detailseg", sender: self)
//            }
//        }
//    }
//    task.resume()
//}
