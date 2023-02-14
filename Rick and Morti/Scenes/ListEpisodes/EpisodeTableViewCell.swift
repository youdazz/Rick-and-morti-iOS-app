//
//  EpisodeTableViewCell.swift
//  Rick and Morti
//
//  Created by Youchen Zhou on 10/2/23.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var episodeLabel: UILabel!
    @IBOutlet weak var airDateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setEpisode(episode: ListEpisodes.FetchEpisodes.ViewModel.DisplayedEpisode){
        episodeLabel.text = episode.episode
        airDateLabel.text = episode.air_date
        nameLabel.text = episode.name
    }
    
}
