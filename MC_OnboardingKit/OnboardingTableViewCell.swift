//
//  OnboardingTableViewCell.swift
//  Community Assist
//
//  Created by Mark Cormack on 11/10/2019.
//  Copyright © 2019 Mark Cormack. All rights reserved.
//

import UIKit

class OnboardingTableViewCell: UITableViewCell {

    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var imageDescriptive: UIImageView!
    
    @IBOutlet weak var labelTitle: UILabel!
    
    
    @IBOutlet weak var labelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var labelTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageLeadingConstraint: NSLayoutConstraint!

    
    
    var isAcessibilityText = false
    
    let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupConstraints()
        handleTableViewMargins()
        //setupUI()
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        handleTableViewMargins()
        if deviceIdiom == .pad{
            //contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
        }
        
        setIPadConstraints()
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
                        imageLeadingConstraint.constant = 20
                        labelLeadingConstraint.constant = 140
                        labelTrailingConstraint.constant = 20
                    }else{
                        imageLeadingConstraint.constant = 45
                        labelLeadingConstraint.constant = 160
                        labelTrailingConstraint.constant = 45
                    }
                }else{
                    imageLeadingConstraint.constant = 150
                    labelLeadingConstraint.constant = 320
                    labelTrailingConstraint.constant = 150
                }
            }else{
                if UIDevice.current.orientation == .landscapeLeft ||
                    UIDevice.current.orientation == .landscapeRight ||
                UIScreen.main.bounds.width > UIScreen.main.bounds.height{
                    let w = self.contentView.frame.width - 650
                    let x = w / 2
                    imageLeadingConstraint.constant = x
                    labelLeadingConstraint.constant = x + 170
                    labelTrailingConstraint.constant = x
                }else{
                    imageLeadingConstraint.constant = 150
                    labelLeadingConstraint.constant = 320
                    labelTrailingConstraint.constant = 150
                }
            }
        default:
            if self.contentView.frame.width <= 375{
                imageLeadingConstraint.constant = 20
                labelLeadingConstraint.constant = 140
                labelTrailingConstraint.constant = 20
            }else{
                imageLeadingConstraint.constant = 45
                labelLeadingConstraint.constant = 165
                labelTrailingConstraint.constant = 45
            }
        }
        /*
        self.contentView.layoutIfNeeded()
        for subview in self.contentView.subviews{
            subview.layoutIfNeeded()
        }
 */
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    /*
    func setupUI(){
        switch deviceIdiom{
        case .phone:
            self.labelTitle.font = UIFont.preferredFont(forTextStyle: .headline)
            self.labelTitle.adjustsFontForContentSizeCategory = true
        case .pad:
            self.labelTitle.font = UIFont.preferredFont(for: .title3, weight: .bold)
            self.labelTitle.adjustsFontForContentSizeCategory = true
        default:
            break
        }
    }
 */
    enum FontType{
        case title, desc
    }
    
    func getFont(for fontType: FontType)->UIFont{
        switch fontType{
        case .title:
            switch deviceIdiom{
            case .pad:
                return UIFont.preferredFont(for: .title3, weight: .bold)
            default:
                return UIFont.preferredFont(forTextStyle: .headline)
            }
        case .desc:
            switch deviceIdiom{
            case .pad:
                return UIFont.preferredFont(for: .body, weight: .regular, maxSize: 58)
            default:
                return UIFont.preferredFont(for: .caption1, weight: .regular, maxSize: 58)

            }
        }
    }
    
    func setupConstraints(){
        if isAcessibilityText{
            imageDescriptive.isHidden = true
            for constraint in imageDescriptive.constraints{
                imageDescriptive.removeConstraint(constraint)
            }
            //stackViewToContentViewLeadingConstraint.constant = 0
        }else{
            imageDescriptive.isHidden = false
            let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
            switch deviceIdiom{
            case .phone:
                if setIPhoneConstraints(){
                    self.contentView.setNeedsLayout()
                }
            case .pad:
                if setIPadConstraints(){
                    self.contentView.setNeedsLayout()
                }
            default:
                break
            }
        }
    }
    
    @discardableResult
    func setIPadConstraints()->Bool{
        guard deviceIdiom == .pad else{return false}
        if !(window?.frame.width == window?.screen.bounds.width),
            self.traitCollection.horizontalSizeClass == .compact{
            //stackViewToContentViewLeadingConstraint.constant = 100
            //stackViewCenterYConstraint.isActive = false
        }else{
           // stackViewToContentViewLeadingConstraint.constant = 220
            //stackViewCenterYConstraint.isActive = true
        }
        
        return true
    }
    
    @discardableResult
    func setIPhoneConstraints()->Bool{
        guard deviceIdiom == .phone else{return false}
        return true
    }

}
