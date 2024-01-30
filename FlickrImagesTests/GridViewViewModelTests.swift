//
//  GridViewViewModelTests.swift
//  FlickrImagesTests
//
//  Created by Andrea Martin  on 1/29/24.
//

import Combine
import XCTest
@testable import FlickrImages

final class GridViewViewModelTests: XCTestCase {
    
    var mockNetwork: MockNetworking!
    var sut: GridViewViewModel!
    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockNetwork = MockNetworking()
        sut = GridViewViewModel(network: mockNetwork)
    }
    
    func testFetchData() async throws {
        let testItem = ImageDataModel(title: "test title", media: MediaDataModel(thumbnail: "test thumbnail"), link: "test link", author: "test author")
        let testResult = ImagesData(items: [testItem])
        let expectation = expectation(description: "Data Expectation")
        sut.$searchResults.dropFirst().sink { item in
            if let first = item.first, first.link == testItem.link {
                expectation.fulfill()
            }
        }.store(in: &cancellables)
        let testItemData = try JSONEncoder().encode(testResult)
        mockNetwork.fetchAndDecodeReturnData.append(testItemData)
        await sut.fetchData(text: "test")
        
        await fulfillment(of: [expectation], timeout: 1.0)
        
    }
}
