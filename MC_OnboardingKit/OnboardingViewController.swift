//
//  OnboardingViewController.swift
//  Community Assist
//
//  Created by Mark Cormack on 11/10/2019.
//  Copyright © 2019 Mark Cormack. All rights reserved.
//

import UIKit

protocol OnboardingViewControllerButtonDelegate:class{
    func viewShouldDismiss()
}

extension OnboardingViewController: OnboardingViewControllerButtonDelegate{
    func viewShouldDismiss(){
        delegate?.didDismiss()
        self.dismiss(animated: true, completion: {
            self.delegate?.didFinishDismissing()
        })
    }
}


class OnboardingViewController: OnboardViewController {

    let accessibilityHelper = AccessibilityHelpers()
        
    @IBOutlet var tableViewYConstraint: NSLayoutConstraint!
    @IBOutlet var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
        
    var tvDataSource: OnboardingVCtableViewDatasource?
    var tvDelegate: OnboardingVCtableViewDelegate?
    var dataModel: OnboardingVCDataModel?
    
    let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
    
    override var config: OnboardingConfiguration?{
        didSet{
            
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTableView()
        //setupUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(layoutCellsForRotationChanges), name: UIDevice.orientationDidChangeNotification, object: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForUITesting()
    }
    
    @objc func layoutCellsForRotationChanges(){
        guard deviceIdiom == .pad,
            tableView != nil else{return}
        tableView.reloadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard deviceIdiom == .pad, tableView != nil else{return}
        //tableView.reloadData()
        tableView.invalidateIntrinsicContentSize()
        tableView.layoutIfNeeded()
        //self.tableView.setNeedsLayout()
        //self.tableView.heightAnchor.constraint(equalToConstant: self.tableView.contentSize.height).isActive = true
        var viewH = self.view.frame.height
        if let tH = self.tabBarController?.tabBar.frame.height{
            viewH = viewH - tH
        }
        if self.tableView.contentSize.height < self.view.frame.height{
           self.tableView.isScrollEnabled = false
           if !self.tableViewYConstraint.isActive{
               self.tableViewYConstraint.isActive = true
           }
            
           let x  = (viewH - self.tableView.contentSize.height) / 2
           self.tableViewTopConstraint.constant = x - 20
           self.tableViewBottomConstraint.constant = x - 20
           /*
           if !self.tableViewTopConstraint.isActive{
               self.tableViewTopConstraint.isActive = true
           }
           if !self.tableViewBottomConstraint.isActive{
               self.tableViewBottomConstraint.isActive = true
           }
            */
        }else{
           self.tableView.isScrollEnabled = true
           self.tableViewTopConstraint.constant = 0
           self.tableViewBottomConstraint.constant = 0
           /*
           if self.tableViewYConstraint.isActive{
               self.tableViewYConstraint.isActive = false
           }
           if self.tableViewTopConstraint.isActive{
               self.tableViewTopConstraint.isActive = false
           }
           if self.tableViewBottomConstraint.isActive{
               self.tableViewBottomConstraint.isActive = false
           }
            */
        }
        isHandlingTableView = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // you need this in the onnboarding VC's otherwise apps with tab bar lose backing view
        // when another tab is pressed, then user returns to tab and selects continue
        self.dismiss(animated: false, completion: nil)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.tableView.reloadData()
    }
    
    //MARK: Rotation
    
    var isHandlingTableView = false
    
    func handleTableView(){
        guard !isHandlingTableView else{return}
        guard self.deviceIdiom == .pad, self.tableView != nil else{return}
        isHandlingTableView = true
        self.tableView.invalidateIntrinsicContentSize()
        self.tableView.setNeedsLayout()
        
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute:{
            self.tableView.reloadData()
        })
    }
    
    
    
    /**
    
    Fired on ViewDidLoad sets up if we are UITesting
     
     Console shits its pant when accessibilityIdentifier is on so only add it when testing
    
    */
    func setupForUITesting(){
        
        view.accessibilityIdentifier = "onboardingView"
    }
    
    
    
    /*
    func setupUI(){
        guard let c = config else{return}
        self.labelTitle.text = c.title
        self.textViewDescription.text = c.description
        if accessibilityHelper.isAccessibleLayout(for: self){
            self.tvDataSource?.isAcessibilityText = true
            self.button.titleLabel?.numberOfLines = 0
        }
        switch deviceIdiom{
        case .phone:
            self.labelTitle.font = UIFont.preferredFont(forTextStyle: .largeTitle)
            self.labelTitle.adjustsFontForContentSizeCategory = true
            self.textViewDescription.font = UIFont.preferredFont(for: .body, weight: .regular)
            self.textViewDescription.adjustsFontForContentSizeCategory = true
        case .pad:
            self.labelTitle.font = UIFont.preferredFont(forTextStyle: .largeTitle)
            self.labelTitle.adjustsFontForContentSizeCategory = true
            self.textViewDescription.font = UIFont.preferredFont(for: .title3, weight: .regular)
            self.textViewDescription.adjustsFontForContentSizeCategory = true
        default:
            break
        }
    }
    */
  
    
    
    func setupTableView(){
        guard let c = config else{return}
        self.dataModel = OnboardingVCDataModel(with: c)
        guard let m = dataModel else{return}
        self.tvDataSource = OnboardingVCtableViewDatasource(withModel: m)
        self.tvDataSource?.buttonDelegate = self
        self.tvDelegate = OnboardingVCtableViewDelegate(withModel: m)
        self.tvDelegate?.vc = self
        self.tableView.dataSource = self.tvDataSource
        self.tableView.delegate = self.tvDelegate
        tableView.tableFooterView = UIView()
        tableView.tableFooterView?.isHidden = true
    }
}
