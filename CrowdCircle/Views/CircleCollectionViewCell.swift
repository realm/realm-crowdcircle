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

class CircleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var circleView: CircleView?
    @IBOutlet weak var countLabel: UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func playWobbleAnimation() {
        circleView?.layer.removeAllAnimations()
    
        circleView?.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 10, options: [], animations: { 
            self.circleView?.transform = CGAffineTransform.identity
        }, completion: { completed in
            self.playLoopingAnimation(timeOffset: Double(arc4random_uniform(5) + 1))
        })
    }

    func playLoopingAnimation(timeOffset: Double) {
        UIView.animate(withDuration: 3.0, delay: timeOffset, options: [.`repeat`, .autoreverse, .curveEaseInOut], animations: { 
            self.circleView?.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }, completion: nil)
    }
    
    func playPulseAnimation() {
        circleView?.layer.removeAllAnimations()
        
        UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
            self.circleView?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: { completed in
            UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: {
                self.circleView?.transform = CGAffineTransform.identity
            }, completion: { completed in
                    self.playLoopingAnimation(timeOffset: 0)
            })
        })
    }
}
