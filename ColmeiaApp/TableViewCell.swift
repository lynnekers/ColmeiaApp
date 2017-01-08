//
//  TableViewCell.swift
//  ColmeiaApp
//
//  Created by Lynneker Souza on 1/8/17.
//  Copyright © 2017 Lynneker Souza. All rights reserved.
//

import UIKit
import Cosmos

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var hatingFrame: CosmosView!
    
    var professor: Professor!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        picture.layer.cornerRadius = ((picture.frame.size.width)/2);
        picture.layer.masksToBounds = true;
        hatingFrame.settings.updateOnTouch = false
        hatingFrame.settings.fillMode = .precise
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateLabels(){
        
        let numberFormater = NumberFormatter()
        numberFormater.minimumFractionDigits = 1
        
        nameLabel.text = professor.name
        subjectLabel.text = professor.subject
        picture.image = professor.picture
        gradeLabel.text = numberFormater.string(from: professor.grade as NSNumber)
        hatingFrame.rating = professor.grade
        
    }

}
