//
//  NSAttributedString+Extension.m
//  iMessageBubble
//
//  Created by Henry Kim on 19/09/2016.
//  Copyright © 2016 Prateek Grover. All rights reserved.
//

#import "NSAttributedString+Extension.h"

@implementation NSAttributedString (Extension)

+ (NSAttributedString*)attributedStringWithString:(NSString*)string
{
    if (string)
    {
        return [[self alloc] initWithString:string];
    } else {
        return nil;
    }
}
+ (NSAttributedString*)attributedStringWithString:(NSString*)string attributes:(NSDictionary *)attributes
{
    if (string) {
        if (attributes) {
            return [[self alloc] initWithString:string attributes:attributes];
        }
        else {
            return [[self alloc] initWithString:string];
        }
    } else {
        return nil;
    }
}

+ (NSAttributedString*)attributedStringWithAttributedString:(NSAttributedString*)attrStr
{
    if (attrStr)
    {
        return [[self alloc] initWithAttributedString:attrStr];
    } else {
        return nil;
    }
}

@end
