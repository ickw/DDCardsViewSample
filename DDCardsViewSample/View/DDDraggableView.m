//
//  DDDraggableView.m
//  DDDraggableViewSample
//
//  Created by daiki ichikawa on 2016/03/31.
//  Copyright © 2016年 Daiki Ichikawa. All rights reserved.
//

#import "DDDraggableView.h"
#import "DDConstants.h"

@interface DDDraggableView ()
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic) CGAffineTransform concatTransform;
@end

@implementation DDDraggableView

+ (instancetype)view {
    NSString *className = NSStringFromClass([self class]);
    return [[[NSBundle mainBundle] loadNibNamed:className owner:nil options:0] firstObject];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder])
    {
        self.backgroundColor = [UIColor blueColor];
        self.isDragged = NO;
        self.concatTransform = CGAffineTransformMakeTranslation(0, 0);
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    [self initGestureRecognizer];
    [self loadStyle];
}

- (void)initGestureRecognizer {
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragged:)];
    [self addGestureRecognizer:self.panGestureRecognizer];
}

- (void)loadStyle {
    self.layer.cornerRadius = 8;
    
    // Shadow
    /*
    self.layer.shadowOffset = CGSizeMake(3, 3);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.5;
     */
}

- (void)initRotation {
    CGFloat rotationStrength = [self calcRotationStrength];
    CGFloat rotationAngle = (CGFloat) (2*M_PI/16 * rotationStrength);
    CGAffineTransform rotationtransform = CGAffineTransformMakeRotation(rotationAngle);
    self.transform = rotationtransform;
}


// TODO: Add a function to keep views in draggable area
- (void)dragged:(UIPanGestureRecognizer *)gestureRecognizer {
    CGFloat xDistance = [gestureRecognizer translationInView:self].x;
    CGFloat yDistance = [gestureRecognizer translationInView:self].y;
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:{
            self.isDragged = YES;
            self.transform = self.concatTransform;
            break;
        };
        case UIGestureRecognizerStateChanged:{
            
            CGFloat rotationStrength = [self calcRotationStrength];
            CGFloat rotationAngle = (CGFloat) (2*M_PI/16 * rotationStrength);
            CGAffineTransform rotationtransform = CGAffineTransformMakeRotation(rotationAngle);
            CGAffineTransform translateTransform = CGAffineTransformMakeTranslation(xDistance, yDistance);
            CGAffineTransform finalTransform = CGAffineTransformConcat(translateTransform, self.concatTransform);
            finalTransform = CGAffineTransformConcat(finalTransform, rotationtransform);
            self.transform = finalTransform;
            
            break;
        };
        case UIGestureRecognizerStateEnded: {
            CGAffineTransform translateTransform = CGAffineTransformMakeTranslation(xDistance, yDistance);
            self.concatTransform = CGAffineTransformConcat(self.concatTransform, translateTransform);
            
            break;
        };
        case UIGestureRecognizerStatePossible:break;
        case UIGestureRecognizerStateCancelled:break;
        case UIGestureRecognizerStateFailed:break;
    }
}

- (CGFloat)calcRotationStrength {
    CGPoint globalPt = [self convertPoint:self.bounds.origin toView:self.superview];
    CGPoint globalCt = CGPointMake(globalPt.x + CARD_SIZE/2, globalPt.y + CARD_SIZE/2);
    float rotMom = globalCt.x - [UIScreen mainScreen].bounds.size.width/2;
    CGFloat srength = MIN(rotMom/320, 1);
    
    return srength;
}

- (CGPoint)getGlobalCenter {
    CGPoint globalPt = [self convertPoint:self.bounds.origin toView:self.superview];
    CGPoint globalCt = CGPointMake(globalPt.x + CARD_SIZE/2, globalPt.y + CARD_SIZE/2);
    
    //NSLog(@"globalCt %f %f", globalCt.x, globalCt.y);
    
    return globalCt;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // need to call here
    [self initRotation];
}

- (void)dealloc {
    [self removeGestureRecognizer:self.panGestureRecognizer];
}

@end
