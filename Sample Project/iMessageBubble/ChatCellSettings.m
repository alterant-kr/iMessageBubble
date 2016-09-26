//
//  ChatCellSettings.m
//  iFlyChatChatView
//
//  Created by iFlyLabs on 27/08/15.
//  Copyright (c) 2015 iFlyLabs. All rights reserved.
//

#import "ChatCellSettings.h"
#import "NSAttributedString+Extension.h"

@interface UIColor(HexString)

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length;

@end


@implementation UIColor(HexString)

+ (UIColor *) colorWithHexString: (NSString *) hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return (CGFloat)hexComponent/255.0f;
}

@end


@implementation ChatCellSettings

UIColor *senderBubbleColor;

UIColor *receiverBubbleColor;

BOOL senderBubbleTail;
BOOL receiverBubbleTail;

UIColor *senderBubbleNameTextColor;

UIColor *receiverBubbleNameTextColor;

UIColor *senderBubbleMessageTextColor;

UIColor *receiverBubbleMessageTextColor;

UIColor *senderBubbleTimeTextColor;

UIColor *receiverBubbleTimeTextColor;

UIFont *senderBubbleNameFontWithSize;
UIFont *senderBubbleMessageFontWithSize;
UIFont *senderBubbleTimeFontWithSize;

UIFont *receiverBubbleNameFontWithSize;
UIFont *receiverBubbleMessageFontWithSize;
UIFont *receiverBubbleTimeFontWithSize;

CGFloat senderChatMessageLabelWidth;
CGFloat receiverChatMessageLabelWidth;

NSDictionary *senderAttributes;
NSDictionary *receiverAttributes;

BOOL useSendingBubbleEffect;

//Singleton instance
static ChatCellSettings *instance = nil;


+(ChatCellSettings *)getInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
        senderBubbleColor = [UIColor colorWithRed:(74.0f/255.0f) green:(99.0/255.0f) blue:(159.0f/255.0f) alpha:1.0f];
        
        receiverBubbleColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
        
        senderBubbleNameTextColor = [UIColor colorWithRed:(255.0f/255.0f) green:(255.0f/255.0f) blue:(255.0f/255.0f) alpha:1.0f];
        
        receiverBubbleNameTextColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0f];
        
        senderBubbleMessageTextColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
        
        receiverBubbleMessageTextColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0f];
        
        senderBubbleTimeTextColor = [UIColor colorWithRed:(126.0f/255.0f) green:(126.0f/255.0f) blue:(126.0f/255.0f) alpha:1.0f];
        
        receiverBubbleTimeTextColor = [UIColor colorWithRed:(126.0f/255.0f) green:(126.0f/255.0f) blue:(126.0f/255.0f) alpha:1.0f];
        
        senderBubbleNameFontWithSize = [UIFont boldSystemFontOfSize:11];
        senderBubbleMessageFontWithSize = [UIFont systemFontOfSize:14];
        senderBubbleTimeFontWithSize = [UIFont systemFontOfSize:11];
        
        receiverBubbleNameFontWithSize = [UIFont boldSystemFontOfSize:11];
        receiverBubbleMessageFontWithSize = [UIFont systemFontOfSize:20];
        receiverBubbleTimeFontWithSize = [UIFont systemFontOfSize:11];
        
        senderBubbleTail = YES;
        
        receiverBubbleTail = YES;
                
        senderChatMessageLabelWidth = 190.0f;
        receiverChatMessageLabelWidth = 165.0f;
        
        NSMutableParagraphStyle *paragraphStyle = [NSParagraphStyle.defaultParagraphStyle mutableCopy];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        senderAttributes = @{NSForegroundColorAttributeName: senderBubbleMessageTextColor,
                                     NSFontAttributeName: senderBubbleMessageFontWithSize,
                                     NSParagraphStyleAttributeName : paragraphStyle};

        receiverAttributes = @{NSForegroundColorAttributeName: receiverBubbleMessageTextColor,
                             NSFontAttributeName: receiverBubbleMessageFontWithSize,
                             NSParagraphStyleAttributeName : paragraphStyle};
        
        useSendingBubbleEffect = YES;
    });
    
    return instance;
}

-(void) setSenderBubbleColor:(UIColor *)color
{
    senderBubbleColor = color;
}

-(void) setReceiverBubbleColor:(UIColor *)color
{
    receiverBubbleColor = color;
}

-(void) setSenderBubbleNameTextColor:(UIColor *)color
{
    senderBubbleNameTextColor = color;
}

-(void) setReceiverBubbleNameTextColor:(UIColor *)color
{
    receiverBubbleNameTextColor = color;
}

-(void) setSenderBubbleMessageTextColor:(UIColor *)color
{
    senderBubbleMessageTextColor = color;
}

-(void) setReceiverBubbleMessageTextColor:(UIColor *)color
{
    receiverBubbleMessageTextColor = color;
}

-(void) setSenderBubbleTimeTextColor:(UIColor *)color
{
    senderBubbleTimeTextColor = color;
}

-(void) setReceiverBubbleTimeTextColor:(UIColor *)color
{
    receiverBubbleTimeTextColor = color;
}

-(void) setSenderBubbleColorHex:(NSString *)HexColor
{
    [self setSenderBubbleColor:[UIColor colorWithHexString:HexColor]];
}

-(void) setReceiverBubbleColorHex:(NSString *)HexColor
{
    [self setReceiverBubbleColor:[UIColor colorWithHexString:HexColor]];
}

-(void) setSenderBubbleNameTextColorHex:(NSString *)HexColor
{
    [self setSenderBubbleNameTextColor:[UIColor colorWithHexString:HexColor]];
}

-(void) setReceiverBubbleNameTextColorHex:(NSString *)HexColor
{
    [self setReceiverBubbleNameTextColor:[UIColor colorWithHexString:HexColor]];
}

-(void) setSenderBubbleMessageTextColorHex:(NSString *)HexColor
{
    [self setSenderBubbleMessageTextColor:[UIColor colorWithHexString:HexColor]];
}

-(void) setReceiverBubbleMessageTextColorHex:(NSString *)HexColor
{
    [self setReceiverBubbleMessageTextColor:[UIColor colorWithHexString:HexColor]];
}

-(void) setSenderBubbleTimeTextColorHex:(NSString *)HexColor
{
    [self setSenderBubbleTimeTextColor:[UIColor colorWithHexString:HexColor]];
}

-(void) setReceiverBubbleTimeTextColorHex:(NSString *)HexColor
{
    [self setReceiverBubbleTimeTextColor:[UIColor colorWithHexString:HexColor]];
}

-(void) setSenderBubbleFontWithSizeForName:(UIFont *)nameFont
{
    senderBubbleNameFontWithSize = nameFont;
}

-(void) setReceiverBubbleFontWithSizeForName:(UIFont *)nameFont
{
    receiverBubbleNameFontWithSize = nameFont;
}

-(void) setSenderBubbleFontWithSizeForMessage:(UIFont *)messageFont
{
    senderBubbleMessageFontWithSize = messageFont;
}

-(void) setReceiverBubbleFontWithSizeForMessage:(UIFont *)messageFont
{
    receiverBubbleMessageFontWithSize = messageFont;
}

-(void) setSenderBubbleFontWithSizeForTime:(UIFont *)timeFont
{
    senderBubbleTimeFontWithSize = timeFont;
}

-(void) setReceiverBubbleFontWithSizeForTime:(UIFont *)timeFont
{
    receiverBubbleTimeFontWithSize = timeFont;
}

-(void) senderBubbleTailRequired:(BOOL)isRequiredOrNot
{
    senderBubbleTail = isRequiredOrNot;
}

-(void) receiverBubbleTailRequired:(BOOL)isRequiredOrNot
{
    receiverBubbleTail = isRequiredOrNot;
}

-(UIColor *) getSenderBubbleColor
{
    return senderBubbleColor;
}

-(UIColor *) getReceiverBubbleColor
{
    return receiverBubbleColor;
}

-(NSArray *) getSenderBubbleTextColor
{
    return @[senderBubbleNameTextColor,senderBubbleMessageTextColor,senderBubbleTimeTextColor];
}

-(NSArray *) getReceiverBubbleTextColor
{
    return @[receiverBubbleNameTextColor,receiverBubbleMessageTextColor,receiverBubbleTimeTextColor];
}

-(NSArray *) getSenderBubbleFontWithSize
{
    return @[senderBubbleNameFontWithSize,senderBubbleMessageFontWithSize,senderBubbleTimeFontWithSize];
}

-(NSArray *) getReceiverBubbleFontWithSize
{
    return @[receiverBubbleNameFontWithSize,receiverBubbleMessageFontWithSize,receiverBubbleTimeFontWithSize];
}

-(BOOL) getSenderBubbleTail
{
    return senderBubbleTail;
}

-(BOOL) getReceiverBubbleTail
{
    return receiverBubbleTail;
}

#pragma mark - More customized method
/*!
 * More customizes
 */
- (CGFloat)getSenderChatMessageLabelWidth
{
    return senderChatMessageLabelWidth;
}
- (void)setSenderChatMessageLabelWidth:(CGFloat)width
{
    senderChatMessageLabelWidth = width;
}
- (CGFloat)getReceiverChatMessageLabelWidth
{
    return receiverChatMessageLabelWidth;
}
- (void)setReceiverChatMessageLabelWidth:(CGFloat)width
{
    receiverChatMessageLabelWidth = width;
}
- (NSDictionary *)getSenderAttributes
{
    return senderAttributes;
}
- (void)setSenderAttributes:(NSDictionary *)attributes
{
    senderAttributes = attributes;
}
- (NSDictionary *)getReceiverAttributes
{
    return receiverAttributes;
}
- (void)setReceiverAttributes:(NSDictionary *)attributes
{
    receiverAttributes = attributes;
}
- (BOOL)getUseSendingBubbleEffect
{
    return useSendingBubbleEffect;
}

#pragma mark - Read Emoticon Set
/*!
 * Read Emoticon Set from Plists
 * @param filename NSString
 * @return id (NSArray | NSDictionary)
 */
- (id)readEmoticonSetFromPlist:(NSString *)filename
{
    NSString *setPath = [[NSBundle mainBundle] pathForResource:@"BasicSet" ofType:@"plist"];
    
    if (filename) {
        if ([filename hasPrefix:@"plist"]) {
            setPath = [[NSBundle mainBundle] pathForResource:[filename stringByDeletingPathExtension] ofType:filename.pathExtension];
        }
        else {
            setPath = [[NSBundle mainBundle] pathForResource:[filename stringByDeletingPathExtension] ofType:@"plist"];
        }
        
    }
    
    if (setPath) {
        id aSet = [NSArray arrayWithContentsOfFile:setPath];
        
        if ([aSet isKindOfClass:[NSDictionary class]]) {
            return [NSDictionary dictionaryWithContentsOfFile:setPath];
        }
        else {
            return aSet;
        }
    }
    
    return nil;
}

/*!
 * Read Emoticon Set from Memory
 * @param forcefully (YES | NO), if YES read from disk forcefully
 * @return emoticonList NSArray
 */
- (NSArray *)getEmoticonListRefreshForcefully:(BOOL)forcefully
{
    if (!forcefully && self.emoticonList && self.emoticonList.count > 0) {
        return self.emoticonList;
    }
    
    self.emoticonList = [NSArray arrayWithArray:[self readEmoticonSetFromPlist:nil]];
    
    return self.emoticonList;
}
/*!
 *
 *
 */
- (NSString *)getImageNameOfEmoticonName:(NSString *)title
{
    for (NSDictionary *obj in [self getEmoticonListRefreshForcefully:NO]) {
        if ([obj[@"keyword"] isEqualToString:title]) {
            return obj[@"imageName"];
        }
        
    }
    
    return nil;
}

/*!
 * Replace Emoticon Text with Image
 * @param sourceString NSString
 * @return resultAttrString NSAttributedString
 */
- (NSAttributedString *)replaceEmoticonTextToImageWithString:(NSString *)sourceString
{
    return [self replaceEmoticonTextToImageWithString:sourceString withAttributes:nil];
}
- (NSAttributedString *)replaceEmoticonTextToImageWithString:(NSString *)sourceString withAttributes:(NSDictionary *)attributes
{
    if (attributes) {
        return [self replaceEmoticonTextToImageWithAttributedString:[[NSAttributedString alloc] initWithString:sourceString attributes:attributes] withAttributes:attributes];
    }
    else {
        return [self replaceEmoticonTextToImageWithAttributedString:[[NSAttributedString alloc] initWithString:sourceString] withAttributes:attributes];
    }
}
- (NSAttributedString *)replaceEmoticonTextToImageWithAttributedString:(NSAttributedString *)sourceString withAttributes:(NSDictionary *)attributes
{
    NSUInteger location = 0;
    NSUInteger length = 1;
    BOOL isDetected = NO;
    NSMutableString *inputText = [NSMutableString stringWithString:sourceString.string];
    
    NSMutableAttributedString *resultAttrString = [[NSMutableAttributedString alloc] init];
    
    for (NSUInteger i = location; i < inputText.length && inputText.length > 0; i++) {
        
        NSString *searchString = [inputText substringWithRange:NSMakeRange(i, 1)];
        if (isDetected == NO && [searchString isEqualToString:@"("] == YES && inputText.length != i+1) {
            location = i;
            length = 1;
            isDetected = YES;
        }
        
        if (isDetected) {
            if ([searchString isEqualToString:@")"] == YES || i == inputText.length-1) {
                
                NSString *emoticonString = [inputText substringWithRange:NSMakeRange(location, length)];
                NSString *emoticonImageName = [self getImageNameOfEmoticonName:emoticonString];
                
                if (emoticonImageName != nil) {
                    
                    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
                    [attachment setBounds:[self getEmoticonRectWithFontPointSize:((UIFont *)attributes[NSFontAttributeName]).pointSize]];
                    UIImage *emoticonImage = [UIImage imageNamed:emoticonImageName];
                    attachment.image = emoticonImage;
                    
                    
                    NSTextAttachment *spaceAttachment = [[NSTextAttachment alloc] init];
                    [spaceAttachment setBounds:CGRectMake(0, -3, 1, 1)];
                    
                    NSAttributedString *spaceAttrString = [NSAttributedString attributedStringWithAttachment:spaceAttachment];
                    NSAttributedString *imageAttrString = [NSAttributedString attributedStringWithAttachment:attachment];
                    
                    [resultAttrString appendAttributedString:spaceAttrString];
                    [resultAttrString appendAttributedString:imageAttrString];
                    [resultAttrString appendAttributedString:spaceAttrString];
                    
                } else {
                    
                    if (i == inputText.length-1 && [searchString isEqualToString:@"("] == YES) {
                        NSString *subString = [inputText substringWithRange:NSMakeRange(location, length)];
                        [resultAttrString appendAttributedString:[NSAttributedString attributedStringWithString:subString attributes:attributes]];
                        
                    } else {
                        [resultAttrString appendAttributedString:[NSAttributedString attributedStringWithString:emoticonString attributes:attributes]];
                    }
                }
                
                isDetected = NO;
                continue;
            }
            
            length++;
            
        } else {
            [resultAttrString appendAttributedString:[NSAttributedString attributedStringWithString:searchString attributes:attributes]];
        }
    }
    
    return resultAttrString;
}


#pragma mark - Private methods
- (CGRect)getEmoticonRect
{
    CGFloat fontPointSize = MAX(((UIFont *)[self getSenderBubbleFontWithSize][1]).pointSize, ((UIFont *)[self getReceiverBubbleFontWithSize][1]).pointSize);
    return [self getEmoticonRectWithFontPointSize:fontPointSize];
}
- (CGRect)getEmoticonRectWithFontPointSize:(CGFloat)pointSize
{
    if (pointSize < ((UIFont *)[self getSenderBubbleFontWithSize][1]).pointSize) {
        pointSize = MAX(((UIFont *)[self getSenderBubbleFontWithSize][1]).pointSize, ((UIFont *)[self getReceiverBubbleFontWithSize][1]).pointSize);
    }
    
    return CGRectMake(0.0f, -3.0f, pointSize+2.0f, pointSize+2.0f);
}

@end
