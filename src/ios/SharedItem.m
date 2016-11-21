//
//  SharedItem.m
//  xingjiang
//
//  Created by 吴德明 on 16/7/14.
//  Copyright © 2016年 吴德明. All rights reserved.
//

#import "SharedItem.h"

@implementation SharedItem

-(instancetype)initWithData:(UIImage *)img andFile:(NSURL *)file
{
    self = [super init];
    if (self) {
        _img = img;
        _path = file;
    }
    return self;
}

-(instancetype)init
{
    //不期望这种初始化方式，所以返回nil了。
    return nil;
}

#pragma mark - UIActivityItemSource
-(id)activityViewControllerPlaceholderItem:(UIActivityViewController *)activityViewController
{
    return _img;
}

-(id)activityViewController:(UIActivityViewController *)activityViewController itemForActivityType:(NSString *)activityType
{
    return _path;
}

-(NSString*)activityViewController:(UIActivityViewController *)activityViewController subjectForActivityType:(NSString *)activityType
{
    // 这里对我这分享图好像没啥用....   是的 没啥用....
    return @"";
}


@end
