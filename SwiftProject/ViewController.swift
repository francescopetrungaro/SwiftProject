/*
Copyright (c) 2015 Francesco Petrungaro. All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY Francesco Petrungaro `AS IS' AND ANY EXPRESS OR
IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
EVENT SHALL Francesco Petrungaro OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import UIKit
import MyFramework

class ViewController: UIViewController {

    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.labelTemperature.text = "Loading Temperature.."
        
        //labelDescription uses APUtils objective-c pod exposed by 'MyFramework'
        self.labelDescription.text = "Weather.. \n\n\(NSDate().formattedDate())"
        
        logger.debug("The 'logger' is a swift pod exposes from the embedded framework 'MyFramework'")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        weak var weakSelf : ViewController? = self
        
        NetworkManager.sharedInstance.fetchTemperature { (currentTemperature, description) -> Void in
            
            if let strongSelf = weakSelf {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    strongSelf.labelTemperature.attributedText = Utilities.formattedTemperature(currentTemperature)
                    strongSelf.labelDescription.text = Utilities.formattedDescription(description)
                })
            }
        }
    }
}

