//
//  PostCell.swift
//  SwiftMVVM
//
//  Created by Sandeep Kolankar on 13/01/22.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var userIDLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var bodyLbl: UILabel!
    @IBOutlet weak var favoriteImageview: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        favoriteImageview.highlightedImage = UIImage(systemName: "suit.heart.fill")
        favoriteImageview.image = UIImage(systemName: "heart")
    }
    
    var cellViewModel: PostCellViewModel? {
        didSet {
            idLbl.text = cellViewModel?.id
            userIDLbl.text = cellViewModel?.userId
            titleLbl.text = cellViewModel?.title
            bodyLbl.text = cellViewModel?.body
            favoriteImageview.isHighlighted = ((cellViewModel?.isFavorite) == true)
        }
    }
}
