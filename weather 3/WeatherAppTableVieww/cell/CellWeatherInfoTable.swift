//
//  CellWeatherInfoTable.swift
//  WeatherAppTableVieww
//
//  Created by Родион Ковалевский on 5/7/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import UIKit

class CellWeatherInfoTable: UITableViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var degreeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
