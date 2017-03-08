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

public func login(hostName: String, callback: ((Error?) ->())?) {
    let username = Constants.productionUserName
    let password = Constants.productionPassword
    let url = URL(string: "http://\(hostName):9080")
    
    let credential = SyncCredentials.usernamePassword(username: username, password: password, register: false)
    SyncUser.logIn(with: credential, server: url!) { user, error in
        if let error = error {
            callback?(error)
            return
        }

        DispatchQueue.main.async {
            let realmSyncURL = URL(string: "realm://\(hostName):9080/~/crowdcircle")
            var configuration = Realm.Configuration.defaultConfiguration
            configuration.syncConfiguration = SyncConfiguration(user: user!, realmURL: realmSyncURL!)
            Realm.Configuration.defaultConfiguration = configuration
            
            let realm = try! Realm()
            if realm.isEmpty {
                try! realm.write {
                    for index in 1...Constants.numberOfCircles {
                        let circleCount = CircleCount()
                        circleCount.index = index
                        circleCount.count = 0
                        realm.add(circleCount)
                    }
                }
            }
            
            callback?(nil)
        }
    }
}
