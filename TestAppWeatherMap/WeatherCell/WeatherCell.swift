//
//  WeatherCell.swift
//  TestAppWeatherMap
//
//  Created by pioner on 19.02.2021.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        dateTimeLabel.text = nil
        nameLabel.text = nil
        tempLabel.text = nil
        descriptionLabel.text = nil
        iconImageView.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
