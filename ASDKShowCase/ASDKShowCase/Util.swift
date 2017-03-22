//
//  Util.swift
//  ASDKShowCase
//
//  Created by Christos Sotiriou on 22/03/2017.
//  Copyright © 2017 Oramind. All rights reserved.
//

import Foundation
import Atributika

extension NSAttributedString {
	static func from(markup : String) -> NSAttributedString {
		let b = Style("title").font(.boldSystemFont(ofSize: 20))
		return markup.style(tags: [b]).styleAll(Style.font(.systemFont(ofSize: 16))).attributedString
	}
}
