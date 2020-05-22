//
//  OnboardingVC+DataModel.swift
//  Community Assist
//
//  Created by Mark Cormack on 11/10/2019.
//  Copyright © 2019 Mark Cormack. All rights reserved.
//

import UIKit

public struct OnboardingConfiguration {
    let title:String
    let description: String
    let items: [OnboardingConfigItem]
    let image: UIImage?
}

public struct OnboardingConfigItem{
    let title: String
    let description: String
    let image: UIImage?
}

class OnboardingVCDataModel{
    
    
    
    public let config: OnboardingConfiguration
    
    init(with configuration: OnboardingConfiguration){
        self.config = configuration
    }
}
