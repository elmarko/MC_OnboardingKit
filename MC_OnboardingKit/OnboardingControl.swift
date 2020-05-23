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
    
    var onboardingDefaultsKey: String?
    
    public enum OnboardingDisplayType{
        case standard
        case simple
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
    public func setup(withPresentingVC vc: UIViewController, for key:String, usingConfig config:OnboardingConfiguration, displayType: OnboardingDisplayType = .standard)->Bool{
        guard !hasSeenOnboarding(for:key) else{return false}
        self.onboardingDefaultsKey = key
        guard let presentedVC = setupViewController(for: displayType) else{return false}
        presentedVC.modalPresentationStyle = .overCurrentContext
        presentedVC.delegate = self
        presentedVC.config = config
        vc.present(presentedVC, animated: false, completion: nil)
        //self.appendConfig(to: presentedVC, for: type, displayType: displayType)
        return true
    }
    
    
    @discardableResult
    public func setup(withPresentingVC vc: UIViewController, usingConfig config:OnboardingConfiguration, displayType: OnboardingDisplayType = .standard)->Bool{
        guard let presentedVC = setupViewController(for: displayType) else{return false}
        vc.present(presentedVC, animated: false, completion: nil)
        presentedVC.config = config
        return true
    }
    
    public func hasSeenOnboarding(for key: String)-> Bool{
        return UserDefaults.standard.bool(forKey: "initialOnboarding")
    }
    
    //MARK: - private functions
    
    
    
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
        guard let key = self.onboardingDefaultsKey else{return}
        UserDefaults.standard.set(true, forKey: key)
    }
    
}
