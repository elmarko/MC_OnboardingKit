//
//  OnboardingControl.swift
//  Community Assist
//
//  Created by Mark Cormack on 11/10/2019.
//  Copyright © 2019 Mark Cormack. All rights reserved.
//

import UIKit

protocol OnboardingControlDelegate:class {
    func didDismiss()
    func didFinishDismissing()
}


public protocol OnboardingControlPresentingVCDelegate:class {
    /// fires when the user has pressed a button to dismiss the VC
    func didDismissOnboarding()
    /// fires when the VC has finished animating out and dismissing
    func didFinishDismissing()
}

extension OnboardingControl:OnboardingControlDelegate{
    func didDismiss(){
        self.seenOnboarding()
        delegate?.didDismissOnboarding()
    }
    
    func didFinishDismissing() {
        delegate?.didFinishDismissing()
    }
}

public class OnboardingControl{
    
    var onboardingType: OnboardingType!
    
    public enum OnboardingDisplayType{
        case standard
        case simple
    }
    
    public enum OnboardingType{
        case initial
        case pinaAssistanceTab
        case communityAssistanceTab
        case communityTab
        case settingsTab
    }
    
    public weak var delegate: OnboardingControlPresentingVCDelegate?
    
    //MARK: Localised Strings
       
    let onboardingTitle = NSLocalizedString("OnboardingInitialTitle", comment: "title")
    let onboardingDescription = NSLocalizedString("OnboardingInitialDescription", comment: "description")
    let onboardingItem1Title = NSLocalizedString("OnboardingInitialItem1Title", comment: "title")
    let onboardingItem1Description = NSLocalizedString("OnboardingInitialItem1Description", comment: "description")
    let onboardingItem2Title = NSLocalizedString("OnboardingInitialItem2Title", comment: "title")
    let onboardingItem2Description = NSLocalizedString("OnboardingInitialItem2Description", comment: "description")
    let onboardingItem3Title = NSLocalizedString("OnboardingInitialItem3Title", comment: "title")
    let onboardingItem3Description = NSLocalizedString("OnboardingInitialItem3Description", comment: "description")
    
    let pinaAssistanceTabOnboardingTitle = NSLocalizedString("pinaAssistanceTabOnboardingTitle", comment: "title")
    let pinaAssistanceTabOnboardingDescription = NSLocalizedString("pinaAssistanceTabOnboardingDescription", comment: "description")
    let pinaAssistanceTabOnboardingItem1Title = NSLocalizedString("pinaAssistanceTabOnboardingItem1Title", comment: "title")
    let pinaAssistanceTabOnboardingItem1Description = NSLocalizedString("pinaAssistanceTabOnboardingItem1Description", comment: "description")
    let pinaAssistanceTabOnboardingItem2Title = NSLocalizedString("pinaAssistanceTabOnboardingItem2Title", comment: "title")
    let pinaAssistanceTabOnboardingItem2Description = NSLocalizedString("pinaAssistanceTabOnboardingItem2Description", comment: "description")
    let pinaAssistanceTabOnboardingItem3Title = NSLocalizedString("pinaAssistanceTabOnboardingItem3Title", comment: "title")
    let pinaAssistanceTabOnboardingItem3Description = NSLocalizedString("pinaAssistanceTabOnboardingItem3Description", comment: "description")
    
    let communityAssistanceTabOnboardingTitle = NSLocalizedString("communityAssistanceTabOnboardingTitle", comment: "title")
    let communityAssistanceTabOnboardingDescription = NSLocalizedString("communityAssistanceTabOnboardingDescription", comment: "description")
    let communityAssistanceTabOnboardingItem1Title = NSLocalizedString("communityAssistanceTabOnboardingItem1Title", comment: "title")
    let communityAssistanceTabOnboardingItem1Description = NSLocalizedString("communityAssistanceTabOnboardingItem1Description", comment: "description")
    let communityAssistanceTabOnboardingItem2Title = NSLocalizedString("communityAssistanceTabOnboardingItem2Title", comment: "title")
    let communityAssistanceTabOnboardingItem2Description = NSLocalizedString("communityAssistanceTabOnboardingItem2Description", comment: "description")
    let communityAssistanceTabOnboardingItem3Title = NSLocalizedString("communityAssistanceTabOnboardingItem3Title", comment: "title")
    let communityAssistanceTabOnboardingItem3Description = NSLocalizedString("communityAssistanceTabOnboardingItem3Description", comment: "description")
    
    
    let communitySimpleTabOnboardingTitle = NSLocalizedString("communityTabSimpleOnboardingTitle", comment: "title")
    let communitySimpleTabOnboardingDescription = NSLocalizedString("communityTabSimpleOnboardingDescription", comment: "description")
    let communityTabOnboardingTitle = NSLocalizedString("communityTabOnboardingTitle", comment: "title")
    let communityTabOnboardingDescription = NSLocalizedString("communityTabOnboardingDescription", comment: "description")
    let communityTabOnboardingItem1Title = NSLocalizedString("communityTabOnboardingItem1Title", comment: "title")
    let communityTabOnboardingItem1Description = NSLocalizedString("communityTabOnboardingItem1Description", comment: "description")
    let communityTabOnboardingItem2Title = NSLocalizedString("communityTabOnboardingItem2Title", comment: "title")
    let communityTabOnboardingItem2Description = NSLocalizedString("communityTabOnboardingItem2Description", comment: "description")
    let communityTabOnboardingItem3Title = NSLocalizedString("communityTabOnboardingItem3Title", comment: "title")
    let communityTabOnboardingItem3Description = NSLocalizedString("communityTabOnboardingItem3Description", comment: "description")
    
    let settingsSimpleTabOnboardingTitle = NSLocalizedString("settingsTabSimpleOnboardingTitle", comment: "title")
    let settingsSimpleTabOnboardingDescription = NSLocalizedString("settingsTabSimpleOnboardingDescription", comment: "description")
    let settingsTabOnboardingTitle = NSLocalizedString("settingsTabOnboardingTitle", comment: "title")
    let settingsTabOnboardingDescription = NSLocalizedString("settingsTabOnboardingDescription", comment: "description")
    let settingsTabOnboardingItem1Title = NSLocalizedString("settingsTabOnboardingItem1Title", comment: "title")
    let settingsTabOnboardingItem1Description = NSLocalizedString("settingsTabOnboardingItem1Description", comment: "description")
    let settingsTabOnboardingItem2Title = NSLocalizedString("settingsTabOnboardingItem2Title", comment: "title")
    let settingsTabOnboardingItem2Description = NSLocalizedString("settingsTabOnboardingItem2Description", comment: "description")
    let settingsTabOnboardingItem3Title = NSLocalizedString("settingsTabOnboardingItem3Title", comment: "title")
    let settingsTabOnboardingItem3Description = NSLocalizedString("settingsTabOnboardingItem3Description", comment: "description")
    
    
    //MARK: - Init
    
    
    public init(){
      
    }
    
    
    //MARK: - Public functions
    
    /**
    
     Setup and present an onboarding VC if it hasn't already been seen by the user
    
    - Parameter vc: the  view controller to present the onboarding over
    
    - Parameter type: the type we want to show i.e. initial or pina assistance tab or carer assistance tab
    
    - Parameter displayType: Whether to show a simple or onboarding screen or one with multiple points
         
    - returns: False if the user has already seen the onboarding and this won't be displayed
        
    */
    @discardableResult
    public func setup(withPresentingVC vc: UIViewController, for type:OnboardingType, displayType: OnboardingDisplayType = .standard)->Bool{
        guard !hasSeenOnboarding(for:type) else{return false}
        self.onboardingType = type
        guard let presentedVC = setupViewController(for: displayType) else{return false}
        presentedVC.modalPresentationStyle = .overCurrentContext
        presentedVC.delegate = self
        vc.present(presentedVC, animated: false, completion: nil)
        self.appendConfig(to: presentedVC, for: type, displayType: displayType)
        return true
    }
    
    
    @discardableResult
    public func setup(withPresentingVC vc: UIViewController, usingConfig config:OnboardingConfiguration, displayType: OnboardingDisplayType = .standard)->Bool{
        guard let presentedVC = setupViewController(for: displayType) else{return false}
        vc.present(presentedVC, animated: false, completion: nil)
        presentedVC.config = config
        return true
    }
    
    public func hasSeenOnboarding(for type: OnboardingType)-> Bool{
        switch type{
        case .initial:
            return UserDefaults.standard.bool(forKey: "initialOnboarding")
        case .pinaAssistanceTab:
            return UserDefaults.standard.bool(forKey: "pinaAssistanceTabOnboarding")
        case .communityAssistanceTab:
            return UserDefaults.standard.bool(forKey: "communityAssistanceTabOnboarding")
        case .communityTab:
            return UserDefaults.standard.bool(forKey: "communityTabOnboarding")
        case .settingsTab:
            return UserDefaults.standard.bool(forKey: "settingsTabOnboarding")
        }
    }
    
    //MARK: - private functions
    
    private func appendConfig(to vc: OnboardViewController, for type:OnboardingType, displayType: OnboardingDisplayType){
        switch type{
        case .initial:
            vc.config = createOnboardingConfig()
        case .pinaAssistanceTab:
            vc.config = createPinaAssistanceTabConfig()
        case .communityAssistanceTab:
            vc.config = createCommunityAssistanceTabConfig()
        case .communityTab:
            switch displayType {
            case .standard:
                vc.config = createCommunityTabConfig()
            case .simple:
                vc.config = createSimpleCommunityTabConfig()
            }
        case .settingsTab:
            switch displayType {
            case .standard:
                vc.config = createSettingsTabConfig()
            case .simple:
                vc.config = createSimpleSettingsTabConfig()
            }
        }
    }
    
    private func setupViewController(for type: OnboardingDisplayType)->OnboardViewController?{
        switch type{
        case .standard:
            return createStandardleViewController()
        case .simple:
            return createSimpleViewController()
        }
    }
    
    func createStandardleViewController()->OnboardingViewController?{
        let frameworkBundle = Bundle(identifier: "uk.co.markcormack.MC-OnboardingKit")
        let storyBoard = UIStoryboard(name: "OnboardingScreen", bundle: frameworkBundle)
        guard let presentedVC = storyBoard.instantiateViewController(withIdentifier: "onboardingViewController") as? OnboardingViewController else{return nil}
        return presentedVC
    }
    
    func createSimpleViewController()->OnboardingSimpleViewController?{
        let frameworkBundle = Bundle(identifier: "uk.co.markcormack.MC-OnboardingKit")
        let storyBoard = UIStoryboard(name: "OnboardingScreen", bundle: frameworkBundle)
        guard let presentedVC = storyBoard.instantiateViewController(withIdentifier: "onboardingSimpleViewController") as? OnboardingSimpleViewController else{return nil}
        return presentedVC
    }
    
    
    private func seenOnboarding(){
        print("seenOnboarding: firing")
        let key:String
        switch self.onboardingType{
        case .initial:
            key = "initialOnboarding"
        case .pinaAssistanceTab:
            key = "pinaAssistanceTabOnboarding"
        case .communityAssistanceTab:
            key = "communityAssistanceTabOnboarding"
        case .communityTab:
            key = "communityTabOnboarding"
        case .settingsTab:
            key = "settingsTabOnboarding"
        case .none:
            return
        }
        UserDefaults.standard.set(true, forKey: key)
    }
    
    //MARK: Create configs
    
    private func createOnboardingConfig()->OnboardingConfiguration{
        let title = onboardingTitle
        let desc = onboardingDescription
        let items:[OnboardingConfigItem] = [
            OnboardingConfigItem(title: onboardingItem1Title,
                                 description: onboardingItem1Description,
                                 image: UIImage(named: "communitySquare")),
            OnboardingConfigItem(title: onboardingItem2Title,
                                 description: onboardingItem2Description,
                                 image: UIImage(named:"pinaOnPhone")),
            OnboardingConfigItem(title: onboardingItem3Title,
                                 description: onboardingItem3Description,
                                 image: UIImage(named: "communityMemberOnPhone"))
        ]
        let config = OnboardingConfiguration(title: title,
                                             description: desc,
                                             items: items,
                                             image: nil)
        return config
    }
    
    private func createPinaAssistanceTabConfig()->OnboardingConfiguration{
        let title = pinaAssistanceTabOnboardingTitle
        let desc = pinaAssistanceTabOnboardingDescription
        let items:[OnboardingConfigItem] = [
            OnboardingConfigItem(title: pinaAssistanceTabOnboardingItem1Title,
                                 description: pinaAssistanceTabOnboardingItem1Description,
                                 image: UIImage(named:"pinaAssistanceBlueButton")),
            OnboardingConfigItem(title: pinaAssistanceTabOnboardingItem2Title,
                                 description: pinaAssistanceTabOnboardingItem2Description,
                                 image: UIImage(named: "pinaAssistanceRedButton")),
            OnboardingConfigItem(title: pinaAssistanceTabOnboardingItem3Title,
                                 description: pinaAssistanceTabOnboardingItem3Description,
                                 image: UIImage(named: "pinaOnPhone"))
        ]
        let config = OnboardingConfiguration(title: title,
                                             description: desc,
                                             items: items,
                                             image: nil)
        return config
    }
    
    private func createCommunityAssistanceTabConfig()->OnboardingConfiguration{
        let title = communityAssistanceTabOnboardingTitle
        let desc = communityAssistanceTabOnboardingDescription
        let items:[OnboardingConfigItem] = [
            OnboardingConfigItem(title: communityAssistanceTabOnboardingItem1Title,
                                 description: communityAssistanceTabOnboardingItem1Description,
                                 image: UIImage(named:"pinaOnPhone")),
            OnboardingConfigItem(title: communityAssistanceTabOnboardingItem2Title,
                                 description: communityAssistanceTabOnboardingItem2Description,
                                 image: UIImage(named:"communityMemberOnPhone")),
            OnboardingConfigItem(title: communityAssistanceTabOnboardingItem3Title,
                                 description: communityAssistanceTabOnboardingItem3Description,
                                 image: UIImage(named: "communityMemberAssistanceAvailability"))
        ]
        let config = OnboardingConfiguration(title: title,
                                             description: desc,
                                             items: items,
                                             image: nil)
        return config
    }
    
    private func createCommunityTabConfig()->OnboardingConfiguration{
        let title = communityTabOnboardingTitle
        let desc = communityTabOnboardingDescription
        let items:[OnboardingConfigItem] = [
            OnboardingConfigItem(title: communityTabOnboardingItem1Title,
                                 description: communityTabOnboardingItem1Description,
                                 image: UIImage(named:"communityMemberEasyContact")),
            OnboardingConfigItem(title: communityTabOnboardingItem2Title,
                                 description: communityTabOnboardingItem2Description,
                                 image: UIImage(named:"communitySquare")),
            OnboardingConfigItem(title: communityTabOnboardingItem3Title,
                                 description: communityTabOnboardingItem3Description,
                                 image: UIImage(named:"verifyCommunityMember"))
        ]
        let config = OnboardingConfiguration(title: title,
                                             description: desc,
                                             items: items,
                                             image: nil)
        return config
    }
    
    private func createSimpleCommunityTabConfig()->OnboardingConfiguration{
        let title = communitySimpleTabOnboardingTitle
        let desc = communitySimpleTabOnboardingDescription
        let config = OnboardingConfiguration(title: title,
                                             description: desc,
                                             items: [],
                                             image: UIImage(named: "onboardingCommunitySingle"))
        return config
    }
    
    private func createSettingsTabConfig()->OnboardingConfiguration{
        let title = settingsTabOnboardingTitle
        let desc = settingsTabOnboardingDescription
        let items:[OnboardingConfigItem] = [
            OnboardingConfigItem(title: settingsTabOnboardingItem1Title,
                                 description: settingsTabOnboardingItem1Description,
                                 image: UIImage()),
            OnboardingConfigItem(title: communityTabOnboardingItem2Title,
                                 description: settingsTabOnboardingItem2Description,
                                 image: UIImage()),
            OnboardingConfigItem(title: communityTabOnboardingItem3Title,
                                 description: settingsTabOnboardingItem3Description,
                                 image: UIImage())
        ]
        let config = OnboardingConfiguration(title: title,
                                             description: desc,
                                             items: items,
                                             image: nil)
        return config
    }
    
    private func createSimpleSettingsTabConfig()->OnboardingConfiguration{
        let title = settingsSimpleTabOnboardingTitle
        let desc = settingsSimpleTabOnboardingDescription
        let config = OnboardingConfiguration(title: title,
                                             description: desc,
                                             items: [],
                                             image: UIImage(named: "onboardingSettingsSingle"))
        return config
    }
}
