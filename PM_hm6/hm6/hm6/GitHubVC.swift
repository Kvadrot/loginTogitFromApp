//
//  gitHubVC.swift
//  hm6
//
//  Created by 1 on 22.02.2021.
//

import UIKit
import WebKit

class GitHubVC: UIViewController, WKNavigationDelegate {

    var network = NetworkManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getToGitHubAuth() {
//
//        // Generate random identifier for the authorization
//        //let authURL = network.authURLConstructor()
//        //webView.load(authURL)
//
//        // Create Navigation Controller
//        let navController = UINavigationController(rootViewController: self)
//        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelAction))
//        self.navigationItem.leftBarButtonItem = cancelButton
//        //let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshAction))
//        //self.navigationItem.rightBarButtonItem = refreshButton
//        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        navController.navigationBar.titleTextAttributes = textAttributes
//        self.navigationItem.title = "github.com"
//        navController.navigationBar.isTranslucent = false
//        navController.navigationBar.tintColor = UIColor.white
//                navController.navigationBar.barTintColor = UIColor.blue
//        navController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
//        navController.modalTransitionStyle = .coverVertical
//        
//        self.present(navController, animated: true, completion: nil)
//    }
//    
//    @objc func cancelAction() {
//        self.dismiss(animated: true, completion: nil)
//    }
    
//    @objc func refreshAction(webView: WKWebView) {
//        self.webView.reload()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
