//
//  SearchResultsTVCell.swift
//  Open Movie Database
//
//  Created by Chandresh Kachariya on 03/06/21.
//

import UIKit

class SearchResultsTVCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupdata(objInfo: Search) {
        self.lblTitle.text = objInfo.title
        
        self.imgView.getImage(url: objInfo.poster ?? "", placeholderImage: nil) { (success) in
        } failer: { (failed) in
        }
    }
    
}
