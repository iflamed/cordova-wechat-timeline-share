/********* WechatTimelineShare.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "WechatTimelineShareViewController.h"
#import "SharedItem.h"

@interface WechatTimelineShare : CDVPlugin {
  // Member variables go here.
}

- (void)shareTimeline:(CDVInvokedUrlCommand*)command;
- (WechatTimelineShareViewController*) getTopMostViewController;
- (void) shareWX:(NSArray *)array_photo;
@end

@implementation WechatTimelineShare

- (void)shareTimeline:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSDictionary* options = [command.arguments objectAtIndex:0];
    if (options != nil && [options objectForKey:@"urls"] && [options[@"urls"] count] > 0) {
        NSLog(@"urls: %@",options[@"urls"]);
        [self shareWX:options[@"urls"]];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"success"];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

/** 分享到微信 以九宫格的方式*/
-(void)shareWX:(NSArray*) array_photo{

    NSMutableArray *array = [[NSMutableArray alloc]init];
    // trick to remove the icloud photo share extension
    [array addObject: @""];
    for (int i = 0; i <2; i++) {
        NSString *URL = array_photo[i];
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:URL]];
        UIImage *imagerang = [UIImage imageWithData:data];

        NSString *path_sandox = NSHomeDirectory();
        NSString *imagePath = [path_sandox stringByAppendingString:[NSString stringWithFormat:@"/Documents/ShareWX%d.jpg",i]];
        [UIImagePNGRepresentation(imagerang) writeToFile:imagePath atomically:YES];

        NSURL *shareobj = [NSURL fileURLWithPath:imagePath];

        /** 这里做个解释 imagerang : UIimage 对象  shareobj:NSURL 对象 这个方法的实际作用就是 在吊起微信的分享的时候 传递给他 UIimage对象,在分享的时候 实际传递的是 NSURL对象 达到我们分享九宫格的目的 */

        SharedItem *item = [[SharedItem alloc] initWithData:imagerang andFile:shareobj];

        [array addObject:item];
    }


    UIActivityViewController *activityViewController =[[UIActivityViewController alloc] initWithActivityItems:array applicationActivities: nil];

    activityViewController.excludedActivityTypes = @[UIActivityTypePostToFacebook,UIActivityTypeAssignToContact,UIActivityTypeAddToReadingList,UIActivityTypePrint,UIActivityTypeMessage,UIActivityTypePostToTwitter,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeOpenInIBooks,@"com.apple.mobilenotes.SharingExtension",@"com.apple.reminders.RemindersEditorExtension",@"com.apple.mobileslideshow.StreamShareService",@"com.google.Drive.ShareExtension"];


    [[self getTopMostViewController] presentViewController:activityViewController animated:TRUE completion:nil];


}

- (WechatTimelineShareViewController*) getTopMostViewController {
    WechatTimelineShareViewController *presentingViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
    while (presentingViewController.presentedViewController != nil) {
        presentingViewController = presentingViewController.presentedViewController;
    }
    return presentingViewController;
}


@end
