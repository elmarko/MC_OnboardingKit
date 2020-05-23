# MC_OnboardingKit

Create and present an onboarding view controller

## Usage example

To create a onoboarding view simply create an instance of  ```OnboardingControl```, set the delegate to the presenting view controller and call  a setup method, passing in a config appropriate for the onboarding view you want to show. 

There are two types of onboarding: 

• Standard. Standard has a title, a description and a series of bullet views for everything to say

• Simple. Simple has a title, description and supporting image


### Standard example

Create the onboarding config:

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
                                         
and then present the onboarding VC                                

    /// Set up oboarding control
    
    let onboardingControl = OnboardingControl()
    onboardingControl.delegate = self
    
    /// Create and present the onboarding view
    let onboard = onboardingControl.setup(withPresentingVC: self, 
                                          for:"someUserDefaultKey", 
                                          usingConfig:config, 
                                          displayType: .standard)

### Simple example

Create the onboarding config:

    /// Set up the configuration
    let title = "Some title to use"
    let desc = "Some description to use"
    let image = UIImage(named: "someImage")
    let config = OnboardingConfiguration(title: title,
                                         description: desc,
                                         items: [],
                                         image: nil)
                                         
and then present the onboarding VC                                

    /// Set up oboarding control

    let onboardingControl = OnboardingControl()
    onboardingControl.delegate = self

    /// Create and present the onboarding view
    let onboard = onboardingControl.setup(withPresentingVC: self, 
                                          for:"someUserDefaultKey", 
                                          usingConfig:config, 
                                          displayType: .simple)
                                          
## Delegate methods

There are two delegate methods that fire on dismissal. One when the button has first been pressed and one when the view has finished dismissing

    /// fires when the user has pressed a button to dismiss the VC
    func didDismissOnboarding()
    /// fires when the VC has finished animating out and dismissing
    func didFinishDismissing()
