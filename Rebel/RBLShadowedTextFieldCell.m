//
//  RBLShadowedTextFieldCell.m
//  Rebel
//
//  Created by Danny Greg on 18/02/2013.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "RBLShadowedTextFieldCell.h"

#import "NSColor+RBLCGColorAdditions.h"

NSInteger const RBLShadowedTextFieldAllBackgroundStyles = 0xFFFFFFFF;

@interface RBLShadowedTextFieldCell ()

@property (nonatomic, readonly, strong) NSMutableDictionary *backgroundStylesToShadows;

@end

@implementation RBLShadowedTextFieldCell

#pragma mark - Lifecycle

- (void)commonInit {
	_backgroundStylesToShadows = [NSMutableDictionary dictionary];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self == nil) return nil;
	
	[self commonInit];
	
	return self;
}

- (instancetype)initTextCell:(NSString *)aString {
	self = [super initTextCell:aString];
	if (self == nil) return nil;
	
	[self commonInit];
	
	return self;
}

#pragma mark - Drawing

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
	[NSGraphicsContext saveGraphicsState];
	NSShadow *shadow = self.backgroundStylesToShadows[@(self.backgroundStyle)];
	if (shadow == nil) {
		shadow = self.backgroundStylesToShadows[@(RBLShadowedTextFieldAllBackgroundStyles)];
	}
	
	if (shadow != nil) {
		CGContextSetShadowWithColor(NSGraphicsContext.currentContext.graphicsPort, shadow.shadowOffset, shadow.shadowBlurRadius, shadow.shadowColor.rbl_CGColor);
	}
	
	[super drawWithFrame:cellFrame inView:controlView];
	
	[NSGraphicsContext restoreGraphicsState];
}

#pragma mark - API

- (void)setShadow:(NSShadow *)shadow forBackgroundStyle:(NSBackgroundStyle)backgroundStyle {
	if (shadow == nil) {
		[self.backgroundStylesToShadows removeObjectForKey:@(backgroundStyle)];
		return;
	}
	
	self.backgroundStylesToShadows[@(backgroundStyle)] = shadow;
}

@end
