//
//  GameScene.swift
//  SpriteKitElementsExample
//
//  Created by Nicholas Cross on 2/11/2016.
//  Copyright © 2016 Nicholas Cross. All rights reserved.
//

import SpriteKit
import GameplayKit
import SpriteKitElements

class GameScene: SpriteElementScene {
    
    let c = ColorElement()
    let r = RemoveOffScreen()
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let l = t.location(in: self)
            
            for i in 0..<2 {
                let n = Bubble(circleOfRadius: 40)
                n.position = CGPoint(x: l.x + CGFloat(i * 20), y: l.y)
                addChild(n)
                self.attachElement(c, toNode: n)
                self.attachElement(r, toNode: n)
                
                let dx = Int(arc4random_uniform(3)) - 1
                n.physicsBody?.applyImpulse(CGVector(dx: CGFloat(dx) / 4.0, dy: -0.5))
            }
        }
    }

}

class Bubble : SKShapeNode {
 
    deinit {
        print("Bubble removed")
    }
    
}

class RemoveOffScreen: SpriteElement {
    
    let timeInterval = SpriteEssence<TimeInterval>()
    
    func didAttach(toNode node: SKNode, inScene scene: SpriteElementScene) {
        timeInterval[node] = 0
    }
    
    func update(atTime currentTime: TimeInterval, delta: TimeInterval, node: SKNode) {
        if currentTime > timeInterval[node]! + 1 &&  node.position.y < -500 {
            node.removeFromParent()
            timeInterval[node] = currentTime
        }
    }
    
}

class ColorElement : SpriteElement {
    
    let hue = SpriteEssence<CGFloat>()
    
    func createBody() -> SKPhysicsBody {
        let body = SKPhysicsBody(circleOfRadius: 40)
        body.categoryBitMask = 1
        body.contactTestBitMask = 1
        body.collisionBitMask = 1
        body.affectedByGravity = true
        return body;
    }
    
    func didAttach(toNode node: SKNode, inScene scene: SpriteElementScene) {
        hue[node] = 0
        node.physicsBody = createBody()
    }
    
    func didBegin(contact: SKPhysicsContact, node: SKNode) {
        if let shapeNode = node as? SKShapeNode, let h = hue[node] {
            if h > 0.9 {
                hue[node] = 0
            }
            else {
                hue[node] = h + 0.05
            }
            
            shapeNode.strokeColor = UIColor(hue: h, saturation: 1, brightness: 0.9, alpha: 1)
        }
    }

}
