//
//  OnboardingTitleTableViewCell.swift
//  Community Assist
//
//  Created by Mark Cormack on 11/04/2020.
//  Copyright © 2020 Mark Cormack. All rights reserved.
//

import UIKit

class OnboardingTitleTableViewCell: UITableViewCell{
    
    let accessibilityHelper = AccessibilityHelpers()

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var containerViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var containerViewTrailingConstraint: NSLayoutConstraint!
    
    
    let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        handleTableViewMargins()
    }
    override func layoutMarginsDidChange() {
        super.layoutMarginsDidChange()
        handleTableViewMargins()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        handleTableViewMargins()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func handleString(titleString: String, descString: String)->NSAttributedString{
        let font1 = getFont(for:.title)
        let font2 = getFont(for:.desc)
        //font1.adjustsFontForContentSizeCategory = true
        let firstAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: font1
        ]
        let secondAttributes:[NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: font2
        ]
        let firstString = NSMutableAttributedString(string: titleString+"\n", attributes: firstAttributes)
        let secondString = NSAttributedString(string: descString, attributes: secondAttributes)
        let lineBreak = NSAttributedString(string: "\n", attributes: secondAttributes)
        firstString.append(lineBreak)
        firstString.append(secondString)
        return firstString
    }
    
    func handleTableViewMargins(){
        switch deviceIdiom{
        case .pad:
            if !(window?.frame.width == window?.screen.bounds.width){
                if self.traitCollection.horizontalSizeClass == .compact{
                    if self.contentView.frame.width <= 375{
                        containerViewLeadingConstraint.constant = 20
                        containerViewTrailingConstraint.constant = 20
                    }else{
                        containerViewLeadingConstraint.constant = 45
                        containerViewTrailingConstraint.constant = 45
                    }
                }else{
                    containerViewLeadingConstraint.constant = 150
                    containerViewTrailingConstraint.constant = 150
                }
            }else{
                if UIDevice.current.orientation == .landscapeLeft ||
                    UIDevice.current.orientation == .landscapeRight ||
                    UIScreen.main.bounds.width > UIScreen.main.bounds.height{
                    let w = self.contentView.frame.width - 650
                    let x = w / 2
                    containerViewLeadingConstraint.constant = x
                    containerViewTrailingConstraint.constant = x
                }else{
                    containerViewLeadingConstraint.constant = 150
                    containerViewTrailingConstraint.constant = 150
                }
            }
        default:
            if self.contentView.frame.width <= 375{
                containerViewLeadingConstraint.constant = 20
                containerViewTrailingConstraint.constant = 20
            }else{
                containerViewLeadingConstraint.constant = 45
                containerViewTrailingConstraint.constant = 45
            }
        }
        self.contentView.layoutIfNeeded()
        for subview in self.contentView.subviews{
            subview.layoutIfNeeded()
        }
    }
    
    
    enum FontType{
        case title, desc
    }
    
    func getFont(for fontType: FontType)->UIFont{
        switch fontType{
        case .title:
            switch deviceIdiom{
            case .pad:
                return UIFont.preferredFont(for: .largeTitle, weight: .bold)
            default:
                return UIFont.preferredFont(for: .title1, weight: .bold)
            }
        case .desc:
            switch deviceIdiom{
            case .pad:
                return UIFont.preferredFont(for: .title3, weight: .regular, maxSize: 58)
            default:
                return UIFont.preferredFont(for: .body, weight: .regular, maxSize: 58)

            }
        }
    }
    
    
    
    func setupUI(){
        switch deviceIdiom{
        case .phone:
            //self.titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
            self.titleLabel.adjustsFontForContentSizeCategory = true
            //self.textView.font = UIFont.preferredFont(for: .body, weight: .regular)
            //self.textView.adjustsFontForContentSizeCategory = true
        case .pad:
            //self.titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
            self.titleLabel.adjustsFontForContentSizeCategory = true
            //self.textView.font = UIFont.preferredFont(for: .title3, weight: .regular)
            //self.textView.adjustsFontForContentSizeCategory = true
        default:
            break
        }
    }
}
