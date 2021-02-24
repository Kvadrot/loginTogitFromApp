

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
    
    func createWebWiev() {
        
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

extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {

        networkManager.RequestForCallbackURL(request: navigationAction.request, completion: {
            let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "DetailsViewController")
                        self.present(vc, animated: true)
        })
        decisionHandler(.allow)
    }
}
