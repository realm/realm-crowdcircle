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
import RealmSwift

class HostViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    let collectionView: UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    let numberOfItemsPerRow = 3

    let circleCounts = try! Realm().objects(CircleCount.self)
    var notificationToken: NotificationToken?

    var timer: Timer?

    // MARK: View Management

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        collectionView.frame = view.bounds
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(UINib(nibName: "CircleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CircleCell")
        view.addSubview(collectionView)
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        notificationToken = circleCounts.addNotificationBlock { changes in
            switch (changes) {
            case .initial:
                self.collectionView.reloadData()
            case .update(_, _, _, let modifications):
                guard modifications.count > 0 else { break }
                for index in modifications {
                    let cell = self.collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as! CircleCollectionViewCell
                    cell.countLabel?.text = "\(self.circleCounts[index].count)"
                    cell.playWobbleAnimation()
                }
            default: break
            }
        }
        
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let realm = try! Realm()
        let counts = realm.objects(CircleCount.self)
        try! realm.write {
            for count in counts {
                count.count = 0
            }
        }
        
        let visibleCells = collectionView.visibleCells
        for cell in visibleCells as! [CircleCollectionViewCell] {
            cell.playWobbleAnimation()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let visibleCells = collectionView.visibleCells
        for cell in visibleCells as! [CircleCollectionViewCell] {
            cell.playWobbleAnimation()
        }
    }

    // MARK: Timer Management
    func timerFired() {
        let realm = try! Realm()
        let visibleCells = collectionView.visibleCells
        
        realm.beginWrite()
        
        var hasChanges = false
        for i in 0..<circleCounts.count {
            let circleCount = circleCounts[i]
            if circleCount.count > 0 {
                circleCount.count -= 1
            
                let cell = visibleCells[i] as! CircleCollectionViewCell
                cell.playPulseAnimation()
                hasChanges = true
            }
        }
        
        if hasChanges {
           try! realm.commitWrite()
        }
        else {
            realm.cancelWrite()
        }
    }

    // MARK: Collection View Data Source
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.circleColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfItemsPerRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfItemsPerRow))
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var insets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        insets.top = 40
        return insets
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let identifier = "CircleCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CircleCollectionViewCell
        cell.circleView?.circleColor = Constants.circleColors[indexPath.row]
        return cell
    }
}
