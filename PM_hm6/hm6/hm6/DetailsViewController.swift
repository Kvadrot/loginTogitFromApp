//
//  DetailsViewController.swift
//  hm6
//
//  Created by 1 on 22.02.2021.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var networkManager = NetworkManager()
    var allImages: AllImages?
    @IBOutlet weak var tableView: UITableView!

    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager.fetchDataFromRepo(compelition: self.getAllImages)
        tableView.register(MyTableViewCell.nib(), forCellReuseIdentifier: MyTableViewCell.idetifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getAllImages(Images: AllImages?) -> Void {
        DispatchQueue.main.async {
            self.allImages = Images
            self.tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allImages?.images?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.idetifier, for: indexPath) as! MyTableViewCell

        customCell.configure(with: allImages?.images?[indexPath.item].name ?? "error", imageName: allImages?.images?[indexPath.item].download_url ?? "error")
        return customCell
    }

}

    


extension DetailsViewController {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

