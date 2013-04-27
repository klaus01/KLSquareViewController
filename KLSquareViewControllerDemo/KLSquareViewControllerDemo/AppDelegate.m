//
//  AppDelegate.m
//  KLSquareViewControllerDemo
//
//  Created by 柯磊 on 13-4-27.
//  Copyright (c) 2013年 柯磊. All rights reserved.
//

#import "AppDelegate.h"
#import "KLSquareViewController.h"
#import "ChildViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    ChildViewController *leftTopViewController = [[ChildViewController alloc] init];
    leftTopViewController.view.backgroundColor = [UIColor redColor];
    leftTopViewController.label.text = @"1";
    ChildViewController *rightTopViewController = [[ChildViewController alloc] init];
    rightTopViewController.view.backgroundColor = [UIColor greenColor];
    rightTopViewController.label.text = @"2";
    ChildViewController *leftBottomViewController = [[ChildViewController alloc] init];
    leftBottomViewController.view.backgroundColor = [UIColor blueColor];
    leftBottomViewController.label.text = @"3";
    ChildViewController *rightBottomViewController = [[ChildViewController alloc] init];
    rightBottomViewController.view.backgroundColor = [UIColor cyanColor];
    rightBottomViewController.label.text = @"4";
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    label.backgroundColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"move me";
    
    KLSquareViewController *viewController = [[KLSquareViewController alloc] init];
    viewController.leftTopViewController = leftTopViewController;
    viewController.rightTopViewController = rightTopViewController;
    viewController.leftBottomViewController = leftBottomViewController;
    viewController.rightBottomViewController = rightBottomViewController;
    viewController.buttonView = label;
    self.window.rootViewController = viewController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
