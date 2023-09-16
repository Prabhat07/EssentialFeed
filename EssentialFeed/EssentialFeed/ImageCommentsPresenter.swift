//
//  ImageCommentsPresenter.swift
//  EssentialFeed
//
//  Created by Prabhat Tiwari on 15/09/23.
//

import Foundation

public struct ImageCommnetsViewModel {
    public let comments: [ImageCommnetViewModel]
}

public struct ImageCommnetViewModel: Equatable {
    public let message: String
    public let date: String
    public let userName: String
    
    public init(message: String, date: String, userName: String) {
        self.message = message
        self.date = date
        self.userName = userName
    }
}

public class ImageCommentsPresenter {
   
    public static var title: String {
        let bundle = Bundle(for: Self.self)
        return NSLocalizedString("IMAGE_COMMENTS_VIEW_TITLE",
                                 tableName: "ImageComments",
                                 bundle: bundle,
                                 comment: "Title for image comments view")
    }
    
    public static func map(_ comments: [ImageComment]) -> ImageCommnetsViewModel {
        
        let fromatter = RelativeDateTimeFormatter()
        
        return ImageCommnetsViewModel(comments: comments.map( { comment in
            ImageCommnetViewModel(message: comment.message,
                                  date: fromatter.localizedString(for: comment.createdAt, relativeTo: Date()),
                                  userName: comment.username)
        }))
    }
    
}
