//
//  FakeResponseData {}.swift
//  RecipleaseV1Tests
//
//  Created by VINCENT BOULANGER on 26/03/2019.
//  Copyright © 2019 VBoulanger. All rights reserved.
//

import Foundation
import Alamofire

class FakeResponseData {
	static let responseOK = HTTPURLResponse(url: URL(string: "https://www.deepl.com/home")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
	static let responseKO = HTTPURLResponse(url: URL(string: "https://www.deepl.com/home")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
	class NetworkError:Error {}
		static let networkError = NetworkError()
	static var correctDataRecipeDetail: Data {
		let bundle = Bundle(for: FakeResponseData.self)
		let url = bundle.url(forResource: "recipeDetail", withExtension: "json")
		let data = try! Data(contentsOf: url!)
		return data
	}
//	static var correctDataRecipeDetail: Data {
//		let bundle = Bundle(for: FakeResponseData.self)
//		let url = bundle.url(forResource: "recipeDetail", withExtension: "json")
//		let data = try! Data(contentsOf: url!)
//		return data
//	}
	static let incorrectData = "error".data(using: .utf8)
}
