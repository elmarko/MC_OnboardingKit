//
//  OnboardingSimpleViewController.swift
//  Community Assist
//
//  Created by Mark Cormack on 12/10/2019.
//  Copyright © 2019 Mark Cormack. All rights reserved.
//

import UIKit

class OnboardingSimpleViewController: OnboardViewController {

    let accessibilityHelper = AccessibilityHelpers()

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIStackView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func buttonAction(_ sender: Any) {
        delegate?.didDismiss()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var buttonToStackViewAccessibilityConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageViewAspectHeightConstraint: NSLayoutConstraint!
    @IBOutlet var containerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet var containerViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet var containerViewCenterYConstrain: NSLayoutConstraint!
    
    @IBOutlet weak var containerViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewWidthConstraint: NSLayoutConstraint!
    
    override var config: OnboardingConfiguration?{
        didSet{
            
        }
    }
    
    let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForUITesting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let containerHeight = self.containerView.frame.height
        let screenHeight = self.view.frame.height
        if containerHeight < screenHeight{
            let constant = (screenHeight - containerHeight) / 2
            print("is smaller, containerHeight: \(containerHeight)")
            print("is smaller, screenHeight: \(screenHeight)")
            print("is smaller, constant: \(constant)")
            containerViewTopConstraint.isActive = false
            containerViewBottomConstraint.isActive = false
            containerViewCenterYConstrain.isActive = true
        }else{
            containerViewTopConstraint.isActive = true
            containerViewBottomConstraint.isActive = true
            containerViewCenterYConstrain.isActive = false
        }
    }


    override func viewWillDisappear(_ animated: Bool) {
        // you need this in the onnboarding VC's otherwise apps with tab bar lose backing view
        // when another tab is pressed, then user returns to tab and selects continue
        self.dismiss(animated: false, completion: nil)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.scrollView.invalidateIntrinsicContentSize()
        self.containerView.layoutIfNeeded()
        
    }
    
    //MARK: Rotation
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.scrollView.invalidateIntrinsicContentSize()
        self.containerView.layoutIfNeeded()
    }
    
    
    /**
     Fired on ViewDidLoad sets up if we are UITesting
     
     Console shits its pant when accessibilityIdentifier is on so only add it when testing

    */
    func setupForUITesting(){
       view.accessibilityIdentifier = "onboardingView"
    }
    
    
    func setupUI(){
        guard let c = config else{return}
        self.labelTitle.attributedText = handleString(titleString: c.title, descString: c.description)
        self.imageView.image = c.image
        if accessibilityHelper.isAccessibleLayout(for: self){
            self.imageView.isHidden = true
            buttonToStackViewAccessibilityConstraint.constant = 0
            buttonToStackViewAccessibilityConstraint.isActive = true
            for v in self.view.subviews{
                v.setNeedsUpdateConstraints()
            }
        }
        switch deviceIdiom{
        case .pad:
            labelTitle.textAlignment = .center
            guard let image = c.image else{return}
            let ratio = image.size.width / image.size.height
            let newHeight = imageView.frame.width / ratio
            let heightConstraint = imageView.heightAnchor.constraint(equalToConstant: newHeight)
            imageViewAspectHeightConstraint.isActive = false
            imageView.addConstraint(heightConstraint)
            let containerHeight = self.containerView.frame.height
            let screenHeight = self.view.frame.height
            if containerHeight < screenHeight{
                let constant = (screenHeight - containerHeight) / 2
                print("is smaller, containerHeight: \(containerHeight)")
                print("is smaller, screenHeight: \(screenHeight)")
                print("is smaller, constant: \(constant)")
                containerViewTopConstraint.constant = 20
                containerViewBottomConstraint.constant = 20
                containerViewCenterYConstrain.isActive = true
            }else{
                containerViewTopConstraint.constant = 30
                containerViewBottomConstraint.constant = 20
                containerViewCenterYConstrain.isActive = true
            }
            self.view.layoutIfNeeded()
        default:
            break
        }
    
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
                return UIFont.preferredFont(forTextStyle: .largeTitle)
            }
        case .desc:
            switch deviceIdiom{
            case .pad:
                return UIFont.preferredFont(for: .body, weight: .regular, maxSize: 58)
            default:
                return UIFont.preferredFont(for: .title3, weight: .regular, maxSize: 58)

            }
        }
    }
}

