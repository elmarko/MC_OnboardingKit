//
//  OnboardingButtonTableViewCell.swift
//  Community Assist
//
//  Created by Mark Cormack on 11/04/2020.
//  Copyright © 2020 Mark Cormack. All rights reserved.
//

import UIKit


class OnboardingButtonTableViewCell: UITableViewCell{
    
    @IBOutlet weak var button: UIButton!

    @IBAction func buttonAction(_ sender: Any) {
        delegate?.viewShouldDismiss()
    }
    
    var delegate: OnboardingViewControllerButtonDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.button.setNeedsLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
