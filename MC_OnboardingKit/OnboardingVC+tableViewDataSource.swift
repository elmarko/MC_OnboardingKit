//
//  OnboardingVC+tableViewDataSource.swift
//  Community Assist
//
//  Created by Mark Cormack on 11/10/2019.
//  Copyright © 2019 Mark Cormack. All rights reserved.
//

import UIKit

class OnboardingVCtableViewDatasource: NSObject, UITableViewDataSource{

    var dataModel: OnboardingVCDataModel?
    
    var isAcessibilityText = false
    /// Set by VC, used by button cell to fire delegate method to dismiss the vc
    weak var buttonDelegate: OnboardingViewControllerButtonDelegate?
    
    init(withModel model: OnboardingVCDataModel){
        self.dataModel = model
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /// Add one to start off with to account for the button
        var count = 1
        if dataModel?.config.items.count != 0{
            count += dataModel?.config.items.count ?? 0
        }else{
            return 0
        }
        if dataModel?.config.title != nil, dataModel?.config.description != nil{
           count += 1
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dataModel?.config.title != nil, dataModel?.config.description != nil, indexPath.row == 0{
            return createTitleCell(tableView, indexPath: indexPath)
        }else if dataModel?.config.title != nil, dataModel?.config.description != nil,
            let mCount = dataModel?.config.items.count,
            indexPath.row == (mCount + 1){
                return createButtonCell(tableView, indexPath: indexPath)
        }else{
            return createInfoCell(tableView, indexPath: indexPath)
        }
    }
    
    func createButtonCell(_ tableView: UITableView, indexPath: IndexPath)->OnboardingButtonTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "onboardingButtonTableViewCell", for: indexPath) as! OnboardingButtonTableViewCell
        cell.delegate = self.buttonDelegate
        return cell
    }
    
    func createTitleCell(_ tableView: UITableView, indexPath: IndexPath)->OnboardingTitleTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "onboardingTitleTableViewCell", for: indexPath) as! OnboardingTitleTableViewCell
        if let title = dataModel?.config.title, let desc = dataModel?.config.description{
            let string = cell.handleString(titleString: title, descString: desc)
            cell.titleLabel.attributedText = string
        }
        return cell
    }
    
    func createInfoCell(_ tableView: UITableView, indexPath: IndexPath)->OnboardingTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "onboardingTableViewCell", for: indexPath) as! OnboardingTableViewCell
        if let modelItem = dataModel?.config.items[indexPath.row - 1]{
            let string = cell.handleString(titleString: modelItem.title, descString: modelItem.description)
            cell.labelTitle.attributedText = string
            cell.imageDescriptive.image = modelItem.image
            cell.accessibilityLabel = modelItem.title + ". " + modelItem.description
            cell.isAcessibilityText = isAcessibilityText
        }
        cell.setupConstraints()

        return cell
    }
}
