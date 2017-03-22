//
//  ViewController.swift
//  ASDKShowCase
//
//  Created by Christos Sotiriou on 22/03/2017.
//  Copyright © 2017 Oramind. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class ViewController: ASViewController<ASDisplayNode> {

	convenience init() {
		self.init(node : ASDisplayNode())
	}
	
	override init(node: ASDisplayNode) {
		super.init(node: node)
		self.node.automaticallyManagesSubnodes = true
	}
	
	required convenience init?(coder aDecoder: NSCoder) {
		self.init(node: ASDisplayNode())
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let itemDetailsNode = ItemDetailsHeader()
		
		let outerNode = ASScrollNode()
		outerNode.automaticallyManagesContentSize = true
		outerNode.automaticallyManagesSubnodes = true
		
		outerNode.layoutSpecBlock = { (node, size) -> ASLayoutSpec in
			return ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .center, alignItems: .center, children: [itemDetailsNode])
		}
		
		outerNode.addSubnode(itemDetailsNode)
		
		
		self.node.backgroundColor = UIColor.black
		
		self.node.layoutSpecBlock = { (node, size) -> ASLayoutSpec in
			return ASInsetLayoutSpec.init(insets: .init(top: 10, left: 10, bottom: 10, right: 10), child: outerNode)
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

