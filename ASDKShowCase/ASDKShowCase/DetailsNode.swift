//
//  DetailsNode.swift
//  ASDKShowCase
//
//  Created by Christos Sotiriou on 22/03/2017.
//  Copyright © 2017 Oramind. All rights reserved.
//

import UIKit
import AsyncDisplayKit

private let kSampleImageUrl = "http://www.olivemagazine.gr/wp-content/uploads/2017/03/ANOIGMA-Tartare-2.jpg"

class CarouselComponent : ASDisplayNode {
	var imageBoxes = [ASNetworkImageNode]()
	
	override init() {
		super.init()
		self.automaticallyManagesSubnodes = true

		for _ in 1...20 {
			let newBox = ASNetworkImageNode()
			newBox.url = URL(string: kSampleImageUrl)
			newBox.backgroundColor = UIColor.red
			newBox.style.preferredSize = CGSize.init(width: 100, height: 100)
			self.imageBoxes.append(newBox)
		}
	}
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		let boxStack = ASStackLayoutSpec.init(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .start, children: imageBoxes)
		return boxStack
	}
}

class ItemDetailsHeader : ASDisplayNode, ASNetworkImageNodeDelegate {
	let smallTitleImageNode = ASNetworkImageNode()
	let titleNode = ASTextNode()
	let descriptionNode = ASTextNode()
	let boatDetailsTitleNode = ASTextNode()
	let bigImageNode = ASNetworkImageNode()
	
	let carouselScrollNode = ASScrollNode()
	let carouselNode = CarouselComponent()
	
	override init() {
		super.init()
		self.backgroundColor = UIColor.green
		self.automaticallyManagesSubnodes = true
		
		smallTitleImageNode.url = URL(string: kSampleImageUrl)
		smallTitleImageNode.clipsToBounds = true
		titleNode.attributedText = NSAttributedString.from(markup: "<title>This is a sample</title> title!")
		
		descriptionNode.attributedText = NSAttributedString.from(markup: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like). ")
		descriptionNode.style.spacingBefore = 20
		descriptionNode.style.spacingAfter = 20
		
		boatDetailsTitleNode.attributedText = NSAttributedString.from(markup: "<title>Item Details</title>")
		boatDetailsTitleNode.style.spacingBefore = 20
		boatDetailsTitleNode.style.spacingAfter = 20
		
		carouselScrollNode.automaticallyManagesContentSize = true
		carouselScrollNode.automaticallyManagesSubnodes = true
		carouselScrollNode.backgroundColor = .blue
		carouselScrollNode.scrollableDirections = ASScrollDirectionHorizontalDirections

		self.bigImageNode.url = URL(string: kSampleImageUrl)
		self.bigImageNode.delegate = self
	}
	
	func imageNode(_ imageNode: ASNetworkImageNode, didLoad image: UIImage) {
		self.setNeedsLayout()
	}
	
	
	override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
		
		carouselScrollNode.layoutSpecBlock = { (node, range) -> ASLayoutSpec in
			let insetLayout = ASInsetLayoutSpec.init(insets: .init(top: 10, left: 10, bottom: 10, right: 10), child: self.carouselNode)
			return insetLayout
		}
		
		var ratio : CGFloat = 0.1
		if let bigImage = self.bigImageNode.image {
			ratio = bigImage.size.height / bigImage.size.width
		}
		
		let imageRatioSpec = ASInsetLayoutSpec.init(insets: .init(top: 10, left: 10, bottom: 10, right: 10), child: ASRatioLayoutSpec(ratio: ratio, child: self.bigImageNode))
		
		
		smallTitleImageNode.style.height = .init(unit: .points, value: 30)
		smallTitleImageNode.style.width = .init(unit: .points, value: 30)
		smallTitleImageNode.style.spacingAfter = 10
		smallTitleImageNode.style.spacingBefore = 10
		
		let titleAndImageStackLayout = ASStackLayoutSpec.horizontal()
		titleAndImageStackLayout.children = [smallTitleImageNode, titleNode]
		
		let descriptionLayout = ASInsetLayoutSpec(insets: .init(top: 10, left: 0, bottom: 10, right: 0), child: ASWrapperLayoutSpec.init(layoutElement: self.descriptionNode))
		
		let verticalStackLayout = ASStackLayoutSpec.vertical()
		verticalStackLayout.children = [titleAndImageStackLayout, descriptionLayout, boatDetailsTitleNode, imageRatioSpec, carouselScrollNode]
		
		let parentLayout = ASWrapperLayoutSpec(layoutElement: smallTitleImageNode)
		parentLayout.style.width = .init(unit: .fraction, value: 1.0)
		parentLayout.style.height = .init(unit: .auto, value: 200)
		parentLayout.child = ASInsetLayoutSpec(insets: .init(top: 10, left: 10, bottom: 10, right: 10), child: verticalStackLayout)
		
		return parentLayout
	}
}
