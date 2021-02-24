//
//  DetailsViewController.swift
//  hm6
//
//  Created by 1 on 22.02.2021.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!

    


    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(MyTableViewCell.nib(), forCellReuseIdentifier: MyTableViewCell.idetifier)
        tableView.delegate = self
        tableView.dataSource = self

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.idetifier, for: indexPath) as! MyTableViewCell
        customCell.configure(with: "customCell", imageName: "gear")
        return customCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

}

