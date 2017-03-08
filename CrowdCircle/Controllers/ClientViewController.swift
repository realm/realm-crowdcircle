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

import Foundation
import UIKit
import RealmSwift

class ClientViewController: UIViewController {

    var circleIndex = 0
    var circleButton: CircleButton = (Bundle.main.loadNibNamed("CircleButton", owner: nil, options: nil)?.first) as! CircleButton

    let realm = try! Realm()
    var circleCountObject: CircleCount?

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        circleButton.circleView?.circleColor = Constants.circleColors[circleIndex]
        circleButton.frame = view.bounds.insetBy(dx: 30, dy: 30)
        circleButton.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        circleButton.buttonTapped = { self.buttonTapped(sender: self.circleButton) }
        view.addSubview(circleButton)
        
        let predicate = NSPredicate(format: "index == %d", (self.circleIndex+1))
        circleCountObject = realm.objects(CircleCount.self).filter(predicate).first
        
        circleCountObject?.addObserver(self, forKeyPath: "count", options: [.new], context: nil)
        circleButton.countLabel?.text = "\(circleCountObject!.count)"
    }
    
    deinit {
        circleCountObject?.removeObserver(self, forKeyPath: "count")
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard keyPath == "count" else {
            return
        }
        
        circleButton.countLabel?.text = "\(circleCountObject!.count)"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        circleButton.playWobbleAnimation()
    }

    func buttonTapped(sender: AnyObject?) {
        try! realm.write {
            circleCountObject!.count += 1
        }
    }
}
