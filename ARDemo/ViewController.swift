//
//  ViewController.swift
//  ARDemo
//
//  Created by Maxim Bekmetov on 23.02.2021.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController{

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.autoenablesDefaultLighting = true
        
        let scene = SCNScene()
        
//        let boxGeometry = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0)
//        let material = SCNMaterial()
//        material.diffuse.contents = UIColor.brown
//
//        let boxNode = SCNNode(geometry: boxGeometry)
//        boxNode.geometry?.materials = [material]
//
//        boxNode.position = SCNVector3(0, 0, -1.0)
//
//        scene.rootNode.addChildNode(boxNode)
//
//        let textGeometry = SCNText(string: "This is the cube", extrusionDepth: 2.0)
//        let textMaterial = SCNMaterial()
//        textMaterial.diffuse.contents = UIColor.red
//
//        //textGeometry.firstMaterial?.diffuse.contents
//
//        let textNode = SCNNode(geometry: textGeometry)
//        textNode.scale = SCNVector3(0.005, 0.005, 0.005)
//        textNode.geometry?.materials = [textMaterial]
//
//        textNode.position = SCNVector3(0, 0.2, -1.0)
//        scene.rootNode.addChildNode(textNode)
        
//        ///////////////////////////////////////////
//        let sphereGeometry = SCNSphere(radius: 0.1)
//        let sphereMaterial = SCNMaterial()
//
//        sphereMaterial.diffuse.contents = UIImage(named: "")
//        sphereMaterial.diffuse.contentsTransform = SCNMatrix4MakeScale(2, 2, 2)
//        let sphereNode = SCNNode(geometry: sphereGeometry)
//        sphereNode.geometry?.materials = [sphereMaterial]
//        sphereNode.position = SCNVector3(0, 0, -1)
//
//        scene.rootNode.addChildNode(sphereNode)
        ///////////////////////////////////////////
        
        
       // createFigures(in: scene)
        createBox(in: scene)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(boxTapped(touch:)))
        self.sceneView.addGestureRecognizer(gestureRecognizer)
        
        sceneView.scene = scene
    }
    
//    private func createFigures(in scene: SCNScene) {
//        let array: [SCNGeometry] = [SCNPlane(), SCNSphere(), SCNBox(), SCNPyramid(), SCNTube(), SCNCone(), SCNTorus(), SCNCylinder(), SCNCapsule()]
//        var xCoordinate: Double = 1
//        sceneView.autoenablesDefaultLighting = true
//
//        for geometryShape in array {
//            let node = SCNNode(geometry: geometryShape)
//
//            let material = SCNMaterial()
//            material.diffuse.contents = UIColor.red
//
//            node.geometry?.materials = [material]
//            node.scale = SCNVector3(0.1, 0.1, 0.1)
//
//            node.position = SCNVector3(xCoordinate, 0, -1)
//            xCoordinate -= 0.2
//
//            scene.rootNode.addChildNode(node)
//
//        }
//    }
    
    @objc func boxTapped(touch: UITapGestureRecognizer) {
        let sceneView = touch.view as! SCNView
        let touchLocation = touch.location(in: sceneView)
        let touchResults = sceneView.hitTest(touchLocation, options: [:])
        
        guard !touchResults.isEmpty, let node = touchResults.first?.node else { return }
        let boxNaterial = SCNMaterial()
        boxNaterial.diffuse.contents = UIColor.blue
        boxNaterial.specular.contents = UIColor.red
        node.geometry?.materials[0] = boxNaterial
    }
    
    private func createBox(in scene: SCNScene) {
        let box = SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0)
        let boxMaterial = SCNMaterial()
        
        boxMaterial.diffuse.contents = UIColor.red
        boxMaterial.specular.contents = UIColor.yellow
        
        let boxNode = SCNNode(geometry: box)
        boxNode.geometry?.materials = [boxMaterial]
        boxNode.position = SCNVector3(0.0, 0.0, -1.0)
        scene.rootNode.addChildNode(boxNode)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

}
