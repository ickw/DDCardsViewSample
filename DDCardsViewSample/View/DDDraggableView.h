//
//  DraggableView.h
//  DraggableViewSample
//
//  Created by daiki ichikawa on 2016/03/31.
//  Copyright © 2016年 Daiki Ichikawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDDraggableView : UIView
@property (nonatomic, weak) IBOutlet UIImageView *myImageView;
@property (nonatomic, weak) IBOutlet UILabel *myLabel;
@property (nonatomic) BOOL isDragged;
+ (instancetype)view;
@end
