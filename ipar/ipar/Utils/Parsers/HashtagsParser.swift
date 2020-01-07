//
//  HashtagsParser.swift
//  ipar
//
//  Created by Vitaly on 04/01/2020.
//  Copyright © 2020 banda. All rights reserved.
//

import Foundation

func parseHashTags(hashtagString: String) -> [String]{
    if hashtagString.prefix(1) != "#" {
        return []
    }
    var hashtags: [String] = []
    for hashtag in hashtagString.split(separator: "#") {
        hashtags.append(String(hashtag).trimmingCharacters(in: .whitespacesAndNewlines))
    }
    return hashtags
}
