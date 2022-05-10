//
//  RankingTableViewCell.swift
//  TestBankApp
//
//  Created by Ives Murillo on 3/24/22.
//

import UIKit

class RankingTableViewCell: UITableViewCell {
    
     
    @IBOutlet weak var positionLabel: UILabel!
    
    @IBOutlet weak var namelabel: UILabel!
    
    
    @IBOutlet weak var averageScoreLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
