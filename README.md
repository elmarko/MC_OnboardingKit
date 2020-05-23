# MC_OnboardingKit

Create and present an onboarding view controller

## Usage example

To create a onoboarding view simply create an instance of  ```OnboardingControl```, set the delegate to the presenting view controller and call  a setup method, passing in a config appropriate for the onboarding view you want to show. 

There are two types of onboarding: 

• Standard. Standard has a title, a description and a series of bullet views for everything to say

• Simple. Simple has a title, description and supporting image


### Standard example

Create the onboarding config:

    /// Set up a standard configuration
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

    /// Set up a simple configuration
    let title = "Some title to use"
    let desc = "Some description to use"
    let image = UIImage(named: "someImage")
    let config = OnboardingConfiguration(title: title,
                                         description: desc,
                                         items: [],
                                         image: image)
                                         
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
    

## Accessibility

### Dynamic text
Supports dynamic text resizing, once the text size level increases to larger threshold, it drops out the image to give more space for the text

### Voice Over
Supports Voice over, standard view top title and description are concatenated to one label on the cell. Individual points cells concatenate the title and description as a single label on the cell, it does not read accessibility on the image
