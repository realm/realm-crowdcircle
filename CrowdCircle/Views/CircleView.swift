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
import QuartzCore

@IBDesignable
class CircleView: UIView {
    
    var circleColor: UIColor = UIColor.red {
        didSet {
            (layer as! CAShapeLayer).fillColor = circleColor.cgColor
        }
    }

    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        guard superview != nil else {
            return
        }
        
        let shapeLayer = (self.layer as! CAShapeLayer)
        shapeLayer.fillColor = circleColor.cgColor
        
        clipsToBounds = false
        layer.masksToBounds = false
    }
    
    override func layoutSubviews() {
        updateShapeLayerFrame()
    }

    func updateShapeLayerFrame() {
        let squareSize = min(frame.size.width, frame.size.height)
        var rect = CGRect(origin: CGPoint.zero, size: CGSize(width: squareSize, height: squareSize))
        rect.origin.x = floor((frame.size.width - squareSize) * 0.5)
        rect.origin.y = floor((frame.size.height - squareSize) * 0.5)
        let path = UIBezierPath(ovalIn: rect)
        (self.layer as! CAShapeLayer).path = path.cgPath
    }
}
