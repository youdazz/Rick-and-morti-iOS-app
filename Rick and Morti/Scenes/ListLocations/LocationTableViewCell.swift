//
//  LocationTableViewCell.swift
//  Rick and Morti
//
//  Created by Youchen Zhou on 10/2/23.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dimensionLabel: UILabel!
    @IBOutlet weak var residentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDisplayedLocation(displayedLocation: ListLocations.FetchLocations.ViewModel.DisplayedLocation){
        nameLabel.text = "\(displayedLocation.name) (\(displayedLocation.type))"
        dimensionLabel.text = displayedLocation.dimension
        residentLabel.text = "Number of residents: \(displayedLocation.residentsCount)"
    }
    
}
