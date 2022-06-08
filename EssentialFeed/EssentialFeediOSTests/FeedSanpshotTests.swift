//
//  FeedSanpshotTests.swift
//  EssentialFeediOSTests
//
//  Created by Prabhat Tiwari on 08/06/22.
//

import XCTest
import EssentialFeediOS

class FeedSanpshotTests: XCTestCase {

    func test_emptyFeed() {
        let sut = makeSUT()
        
        sut.dispaly(emptyFeed())
        
        record(snapshot: sut.snapshot(), named: "EMPTY_FEED")
    }
    
    // MARK: - Helpers
    
    func makeSUT(fiel: StaticString = #file, line: UInt = #line) -> FeedViewController {
        
        let bundel = Bundle(for: FeedViewController.self)
        let storyBoard = UIStoryboard(name: "Feed", bundle: bundel)
        let controller = storyBoard.instantiateInitialViewController() as! FeedViewController
        controller.loadViewIfNeeded()
        return controller
    }
    
    private func emptyFeed() -> [FeedImageCellController] {
        return []
    }
               
    func record(snapshot: UIImage, named name: String, file: StaticString = #file, line: UInt = #line) {
        guard let snapshotData = snapshot.pngData() else {
            XCTFail("Fail to create PNG data representtio from snaeshot", file: file, line: line)
            return
        }
        
        let snapshotURL = URL(fileURLWithPath: String(describing: file))
            .deletingLastPathComponent()
            .appendingPathComponent("snapshots")
            .appendingPathComponent("\(name).png")
        
        do {
            try FileManager.default.createDirectory(at: snapshotURL.deletingLastPathComponent(), withIntermediateDirectories: true)
            try snapshotData.write(to: snapshotURL)
        } catch {
            XCTFail("Failed to reord snapshot with \(error)", file: file, line: line)
        }
        
    }

}

extension UIViewController {
    
    func snapshot() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
        return renderer.image { action in
            view.layer.render(in: action.cgContext)
        }
    }
    
}
