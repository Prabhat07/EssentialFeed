//
//  CacheFeedUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by Prabhat Tiwari on 10/05/21.
//

import XCTest
import EssentialFeed

class LocalFeedLoader {
    private let store: FeedStore
    
    init(store: FeedStore) {
        self.store = store
    }
    
    func save(_ items: [FeedItem]) {
        store.deleteCacheFeed()
    }
}

class FeedStore {
    var deleteCacheCallCount = 0
    var insertCallCount = 0
    
    func deleteCacheFeed() {
        deleteCacheCallCount += 1
    }
    
    func completionDeletion(with error: NSError, at index: Int = 0) {
        
    }
}

class CacheFeedUseCaseTests: XCTestCase {

    func test_init_doseNotDeleteCache() {
        let (_, store) = makeSut()
        
        XCTAssertEqual(store.deleteCacheCallCount, 0)
    }

    func test_save_requestCacheDeletion() {
        let (sut, store) = makeSut()
        
        let items = [uniqueItem(), uniqueItem()]
        
        sut.save(items)
        
        XCTAssertEqual(store.deleteCacheCallCount, 1)
    }
    
    func test_save_doseNotRequestCacheInsertionOnDeletionError() {
        let (sut, store) = makeSut()
        
        let items = [uniqueItem(), uniqueItem()]
        let deletionError = anyNSError()
        sut.save(items)
        
        store.completionDeletion(with : deletionError)
        
        XCTAssertEqual(store.insertCallCount, 0)
    }
    
    
    // MARKS: - Helpers
    
    private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> (sut: LocalFeedLoader, store: FeedStore) {
        let store = FeedStore()
        let sut = LocalFeedLoader(store: store)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, store)
    }
    
    private func anyUrl() -> URL {
        return URL(string: "https//:any-url/.com")!
    }
    
    private func anyNSError() -> NSError {
        return NSError(domain: "Any Error", code: 0)
    }
    
    private func uniqueItem() -> FeedItem {
        FeedItem(id: UUID(), description: "any", location: "any", imageUrl: anyUrl())
    }
    
    
}
