////////////////////////////////////////////////////////////////////////////
//
// Copyright 2016-2017 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

import UIKit

@IBDesignable
class CircleButton: UIView {

    @IBOutlet weak var countLabel: UILabel?
    @IBOutlet weak var instructionsLabel: UILabel?
    @IBOutlet weak var circleView: CircleView?
    
    var buttonTapped: (() -> ())?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func playWobbleAnimation() {
        circleView?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 5.0, options: [.allowUserInteraction], animations: {
            self.circleView?.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func playZoomAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 2.0, options: [.allowUserInteraction], animations: {
            self.circleView?.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        playZoomAnimation()
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        playWobbleAnimation()
        buttonTapped?()
        super.touchesEnded(touches, with: event)
    }
}
