//
//  OnboardingVC+tableViewDelegate.swift
//  Community Assist
//
//  Created by Mark Cormack on 11/10/2019.
//  Copyright © 2019 Mark Cormack. All rights reserved.
//

import UIKit

class OnboardingVCtableViewDelegate: NSObject, UITableViewDelegate{
    
    var dataModel: OnboardingVCDataModel?
    var vc: OnboardingViewController?
    init(withModel model: OnboardingVCDataModel){
        self.dataModel = model
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
        switch deviceIdiom{
        case .pad:
            return 400
        default:
            return 300
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
}
