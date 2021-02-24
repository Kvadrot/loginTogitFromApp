//
//  MyTableViewCell.swift
//  hm6
//
//  Created by 1 on 24.02.2021.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    static let idetifier = "MyTableViewCell"

    static func nib() -> UINib {
        return UINib(nibName: "MyTableViewCell", bundle: nil)
    }
    
    public func configure(with title: String, imageName: String){
        
        myLabel.text = title
        myImageView.image = UIImage(systemName: imageName )
    }
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
