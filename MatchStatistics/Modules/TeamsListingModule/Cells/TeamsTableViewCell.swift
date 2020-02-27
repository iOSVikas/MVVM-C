//
//  TeamsTableViewCell.swift
//  MatchStatistics
//
//  Created by Vikas Karambalkar on 11/02/2020.
//  Copyright © 2020 Vikas Karambalkar. All rights reserved.
//

import UIKit
import Kingfisher

class TeamsTableViewCell: UITableViewCell {

    static let identifire = "TeamsTableViewCell"
    
    @IBOutlet weak var teamFlagImage: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func configure(team: Team) {
        teamName.text = team.name
        setImage(image: team.image)
    }
    
    private func setImage(image: String) {
        self.teamFlagImage.kf.indicatorType = .activity
        self.teamFlagImage.kf.setImage(with: URL(string: image))
    }
}
