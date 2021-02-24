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


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *cellIdentifier = @"venue";
//    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
//
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
//    }
//
//    Venue *venue = ((Venue * )self.venues[indexPath.row]);
//    if (venue.userImage) {
//        cell.imageView.image = venue.image;
//    } else {
//        // set default user image while image is being downloaded
//        cell.imageView.image = [UIImage imageNamed:@"batman.png"];
//
//        // download the image asynchronously
//        [self downloadImageWithURL:venue.url completionBlock:^(BOOL succeeded, UIImage *image) {
//            if (succeeded) {
//                // change the image in the cell
//                cell.imageView.image = image;
//
//                // cache the image for use later (when scrolling up)
//                venue.image = image;
//            }
//        }];
//    }
//}
