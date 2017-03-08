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

struct Constants {
    static let productionIPAddress = "127.0.0.1"
    static let productionUserName = "crowdcircle@realm.io"
    static let productionPassword = "password"

    static let numberOfCircles = 6

    static let circleColors: [UIColor] = [
        UIColor(red: 247.0/255.0, green: 124.0/255.0, blue: 135.0/255.0, alpha: 1.0),
        UIColor(red: 242.0/255.0, green: 81.0/255.0, blue: 145.0/255.0, alpha: 1.0),
        UIColor(red: 211.0/255.0, green: 75.0/255.0, blue: 163.0/255.0, alpha: 1.0),
        UIColor(red: 154.0/255.0, green: 80.0/255.0, blue: 164.0/255.0, alpha: 1.0),
        UIColor(red: 88.0/255.0, green: 86.0/255.0, blue: 157.0/255.0, alpha: 1.0),
        UIColor(red: 56.0/255.0, green: 71.0/255.0, blue: 126.0/255.0, alpha: 1.0)
    ]
}
