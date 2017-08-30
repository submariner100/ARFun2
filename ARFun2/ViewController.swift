//
//  ViewController.swift
//  ARFun2
//
//  Created by Macbook on 30/08/2017.
//  Copyright © 2017 Chappy-App. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
	
	for node in sceneView.scene.rootNode.childNodes {
		
		let moveShip = SCNAction.moveBy(x: 0, y: 0, z: 0, duration: 1)
		let fadeOut = SCNAction.fadeOpacity(to: 0.5, duration: 1)
		let fadeIn = SCNAction.fadeOpacity(to: 1.0, duration: 1)
		let shipRotate = SCNAction.rotateTo(x: 0, y: 1.0, z: 1.0, duration: 5)
		let routine = SCNAction.sequence([shipRotate, fadeOut, fadeIn, moveShip])
		let foreverRoutine = SCNAction.repeatForever(routine)
		
		
		node.runAction(foreverRoutine)
	}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
	
	   configuration.planeDetection = .horizontal
	
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
	func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
		
		if let plane = anchor as? ARPlaneAnchor {
			print("X: \(plane.extent.x)m Z: \(plane.extent.z)m")
		}
	}
	
	func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
		
		if let plane = anchor as? ARPlaneAnchor {
			print("X: \(plane.extent.x)m Z: \(plane.extent.z)m")
		}
	}
	
}
