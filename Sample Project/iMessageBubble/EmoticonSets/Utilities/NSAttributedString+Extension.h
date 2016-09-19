//
//  NSAttributedString+Extension.h
//  iMessageBubble
//
//  Created by Henry Kim on 19/09/2016.
//  Copyright © 2016 Prateek Grover. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (Extension)

+ (NSAttributedString*)attributedStringWithString:(NSString*)string;
+ (NSAttributedString*)attributedStringWithString:(NSString*)string attributes:(NSDictionary *)attributes;
+ (NSAttributedString*)attributedStringWithAttributedString:(NSAttributedString*)attrStr;

@end
