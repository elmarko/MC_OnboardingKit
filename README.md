# MC_OnboardingKit


## Usage example

    /// Set up oboarding control
    
    let onboardingControl = OnboardingControl()
    onboardingControl.delegate = self
    
    /// Set up the configuration
    let title = "Some title to use"
    let desc = "Some description to use"
    let items:[OnboardingConfigItem] = [
        OnboardingConfigItem(title: "Some secondary title to use",
                             description: "Some secondary description to use",
                             image: UIImage(named:"someImage")),
        OnboardingConfigItem(title: "Some secondary title to use",
                            description: "Some secondary description to use",
                             image: UIImage(named: "someImage")),
        OnboardingConfigItem(title: "Some secondary title to use",
                            description: "Some secondary description to use",
                            image: UIImage(named: "someImage"))
    ]
    let config = OnboardingConfiguration(title: title,
                                         description: desc,
                                         items: items,
                                         image: nil)
                                         
    /// Create and present the onboarding view
    let onboard = onboardingControl.setup(withPresentingVC: self, for:"someUserDefaultKey", usingConfig:config, displayType: .standard)
