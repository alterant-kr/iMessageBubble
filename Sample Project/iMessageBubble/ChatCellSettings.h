//
//  ChatCellSettings.h
//  iFlyChatChatView
//
//  Created by iFlyLabs on 27/08/15.
//  Copyright (c) 2015 iFlyLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ChatCellSettings : NSObject

+(ChatCellSettings *)getInstance;

-(void) setSenderBubbleColor:(UIColor *)color;
-(void) setReceiverBubbleColor:(UIColor *)color;
-(void) setSenderBubbleNameTextColor:(UIColor *)color;
-(void) setReceiverBubbleNameTextColor:(UIColor *)color;
-(void) setSenderBubbleMessageTextColor:(UIColor *)color;
-(void) setReceiverBubbleMessageTextColor:(UIColor *)color;
-(void) setSenderBubbleTimeTextColor:(UIColor *)color;
-(void) setReceiverBubbleTimeTextColor:(UIColor *)color;
-(void) setSenderBubbleColorHex:(NSString *)HexColor;
-(void) setReceiverBubbleColorHex:(NSString *)HexColor;
-(void) setSenderBubbleNameTextColorHex:(NSString *)HexColor;
-(void) setReceiverBubbleNameTextColorHex:(NSString *)HexColor;
-(void) setSenderBubbleMessageTextColorHex:(NSString *)HexColor;
-(void) setReceiverBubbleMessageTextColorHex:(NSString *)HexColor;
-(void) setSenderBubbleTimeTextColorHex:(NSString *)HexColor;
-(void) setReceiverBubbleTimeTextColorHex:(NSString *)HexColor;
-(void) setSenderBubbleFontWithSizeForName:(UIFont *)nameFont;
-(void) setReceiverBubbleFontWithSizeForName:(UIFont *)nameFont;
-(void) setSenderBubbleFontWithSizeForMessage:(UIFont *)messageFont;
-(void) setReceiverBubbleFontWithSizeForMessage:(UIFont *)messageFont;
-(void) setSenderBubbleFontWithSizeForTime:(UIFont *)timeFont;
-(void) setReceiverBubbleFontWithSizeForTime:(UIFont *)timeFont;
-(void) senderBubbleTailRequired:(BOOL)isRequiredOrNot;
-(void) receiverBubbleTailRequired:(BOOL)isRequiredOrNot;
-(UIColor *) getSenderBubbleColor;
-(UIColor *) getReceiverBubbleColor;
-(NSArray *) getSenderBubbleTextColor;
-(NSArray *) getReceiverBubbleTextColor;
-(NSArray *) getSenderBubbleFontWithSize;
-(NSArray *) getReceiverBubbleFontWithSize;
-(BOOL) getSenderBubbleTail;
-(BOOL) getReceiverBubbleTail;

#pragma mark - More customized method
/*!
 * More customizes by neoroman
 */
- (CGFloat)getSenderChatMessageLabelWidth;
- (void)setSenderChatMessageLabelWidth:(CGFloat)width;
- (CGFloat)getReceiverChatMessageLabelWidth;
- (void)setReceiverChatMessageLabelWidth:(CGFloat)width;
- (NSDictionary *)getSenderAttributes;
- (void)setSenderAttributes:(NSDictionary *)attributes;
- (NSDictionary *)getReceiverAttributes;
- (void)setReceiverAttributes:(NSDictionary *)attributes;
- (BOOL)getUseSendingBubbleEffect;

#pragma mark - Read Emoticon Set
/*!
 * Emoticon Array
 */
@property (nonatomic, strong) NSArray *emoticonList;

/*!
 * Read Emoticon Set from Plists
 * @param filename NSString
 * @return id (NSArray | NSDictionary)
 */
- (id)readEmoticonSetFromPlist:(NSString *)filename;

/*!
 * Read Emoticon Set from Memory
 * @param forcefully (YES | NO), if YES read from disk forcefully
 * @return emoticonList NSArray
 */
- (NSArray *)getEmoticonListRefreshForcefully:(BOOL)forcefully;

/*!
 * Replace Emoticon Text with Image
 * @param sourceString NSString
 * @param numOfEmoticon callByReference(* int)
 * @return resultAttrString NSAttributedString
 */
- (NSAttributedString *)replaceEmoticonTextToImageWithString:(NSString *)sourceString;
- (NSAttributedString *)replaceEmoticonTextToImageWithString:(NSString *)sourceString withAttributes:(NSDictionary *)attributes;
- (NSAttributedString *)replaceEmoticonTextToImageWithAttributedString:(NSAttributedString *)sourceString withAttributes:(NSDictionary *)attributes;

@end
