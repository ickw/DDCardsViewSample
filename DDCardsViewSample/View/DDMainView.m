//
//  MainView.m
//  DraggableViewSample
//
//  Created by daiki ichikawa on 2016/03/31.
//  Copyright © 2016年 Daiki Ichikawa. All rights reserved.
//

#import "DDMainView.h"
#import "DDDraggableView.h"
#import "DDConstants.h"

@interface DDMainView()
@property (nonatomic, strong) DDDraggableView *draggableView;
@property (nonatomic, retain) NSMutableArray *draggableViewArray;
@end

@implementation DDMainView

- (id)init {
    if (self = [super init])
    {
        self.backgroundColor = [UIColor colorWithRed:192/255.f green:222/255.f blue:237/255.f alpha:1.0];
        self.draggableViewArray = [[NSMutableArray alloc] init];
        //[self loadDraggableView];
        [self loadDraggableViews];
    }
    return self;
}

- (void)loadDraggableView {
    self.draggableView = [DDDraggableView view];
    [self addSubview:self.draggableView];
}

- (void)loadDraggableViews {
    for (int i=0; i<NUM_CARDS; i++) {
        DDDraggableView *v = [DDDraggableView view];
        [self.draggableViewArray addObject:v];
        [self addSubview:v];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];    
    
    if (!self.draggableView.isDragged)
    {
        CGFloat scrnW = [UIScreen mainScreen].bounds.size.width;
        CGFloat scrnH = [UIScreen mainScreen].bounds.size.height;
        int maxX = scrnW - CARD_SIZE/2;
        int maxY = scrnH - CARD_SIZE/2;
        int minX = -CARD_SIZE/2;
        int minY = -CARD_SIZE/2;
        
        int count = 0;
        srand((unsigned)time(NULL));
        for (DDDraggableView *v in self.draggableViewArray) {
            // set random poistion
            CGFloat randX = (random() % ((int)maxX + 1 - minX)) + minX;
            CGFloat randY = (random() % ((int)maxY + 1 - minY)) + minY;
            v.frame = CGRectMake(randX, randY, CARD_SIZE, CARD_SIZE);
            
            // set label text
            v.myLabel.text = [NSString stringWithFormat:@"%d", count];
            
            count++;
        }
    }
}

@end
