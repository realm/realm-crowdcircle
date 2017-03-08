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
import Eureka
import SwiftSpinner

class SettingsViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Crowd Circle"
        
        form = Section()
            <<< TextRow(){ row in
                row.title = "Host Name"
                row.placeholder = "localhost"
                row.value = Constants.productionIPAddress
            }
            
        +++ Section("ROLE")
            <<< CheckRow("HostTag"){
                $0.title = "Host"
                $0.value = true
                $0.cell.imageView?.image = UIImage(named: "HostIcon")
            }.onCellSelection { cell, row in
                self.updateCheckRows(sender: row)
            }
            <<< CheckRow(){
                $0.title = "Client 1"
                $0.cell.imageView?.image = UIImage(named: "Circle1Icon")
            }.onCellSelection { cell, row in
                self.updateCheckRows(sender: row)
            }
            <<< CheckRow(){
                $0.title = "Client 2"
                $0.cell.imageView?.image = UIImage(named: "Circle2Icon")
            }.onCellSelection { cell, row in
                self.updateCheckRows(sender: row)
            }
            <<< CheckRow(){
                $0.title = "Client 3"
                $0.cell.imageView?.image = UIImage(named: "Circle3Icon")
            }.onCellSelection { cell, row in
                self.updateCheckRows(sender: row)
            }
            <<< CheckRow(){
                $0.title = "Client 4"
                $0.cell.imageView?.image = UIImage(named: "Circle4Icon")
            }.onCellSelection { cell, row in
                self.updateCheckRows(sender: row)
            }
            <<< CheckRow(){
                $0.title = "Client 5"
                $0.cell.imageView?.image = UIImage(named: "Circle5Icon")
            }.onCellSelection { cell, row in
                self.updateCheckRows(sender: row)
            }
            <<< CheckRow(){
                $0.title = "Client 6"
                $0.cell.imageView?.image = UIImage(named: "Circle6Icon")
            }.onCellSelection { cell, row in
                self.updateCheckRows(sender: row)
            }
        +++ Section()
            <<< ButtonRow() {
                $0.title = "Connect"
            }.onCellSelection { cell, row in
                self.connectButtonTapped()
            }
    }
    
    //Ensure only one check row is checked at a time
    func updateCheckRows(sender: Row<CheckCell>) {
        let checkSection = form.allSections[1]
        
        for row in checkSection {
            let checkRow = (row as! CheckRow)
            checkRow.value = (row == sender)
            row.updateCell()
        }
    }
    
    func connectButtonTapped() {
        SwiftSpinner.show("Connecting...")
        
        let hostNameRow = form.allSections[0][0] as! TextRow
        login(hostName: hostNameRow.value!, callback: { error in
            SwiftSpinner.hide()
            
            if let error = error {
                let alertController = UIAlertController(title: "An Error Occurred:", message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alertController, animated: true)
                return
            }
            
            self.presentCirecleViewController()
        })
    }
    
    func presentCirecleViewController() {
        let hostRow = form.allSections[1][0] as! CheckRow
        let hostRowSelected = (hostRow.value == true)
        
        // Push the host view controller
        if hostRowSelected {
            let hostViewController = HostViewController()
            navigationController?.pushViewController(hostViewController, animated: true)
        }
        else {
            //Work out which client row was selected
            var selectedIndex = 1
            for row in form.allSections[1] {
                if (row as! CheckRow).value == true {
                    break
                }
                
                selectedIndex += 1
            }
            
            let clientViewController = ClientViewController()
            clientViewController.circleIndex = (selectedIndex - 2)
            navigationController?.pushViewController(clientViewController, animated: true)
        }
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

