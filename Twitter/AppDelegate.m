//
//  AppDelegate.m
//  Twitter
//
//  Created by Pankaj Bedse on 9/23/15.
//  Copyright (c) 2015 Pankaj Bedse. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TwitterClient.h"
#import "User.h"
#import "Tweet.h"
#import "TweetsViewController.h"
#import "LeftMenuViewController.h"
#import "SWRevealViewController.h"
#import "ProfileViewController.h"


@interface AppDelegate () <LeftMenuDelegate, LoginDelegate>

@end



@implementation AppDelegate

//@synthesize window = _window;
//@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogout) name:UserDidLogoutNotification object:nil];
    
    User *user = [User currentUser];
    if (user != nil) {
        NSLog(@"Welcome back %@", user.name);
        [self showHomePage];
    } else {
        [self showLoginScreen];
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    [[TwitterClient sharedInstance] openURL:url];    
    return YES;
}

- (void)userDidLogout
{
    [self showLoginScreen];
}

-(void) showLoginScreen
{
    LoginViewController *loginCntr = [[LoginViewController alloc]init];
    loginCntr.delegate = self;
    UINavigationController *nbc = [[UINavigationController alloc] initWithRootViewController:loginCntr];
    self.window.rootViewController = nbc;

}
-(void)showHomePage
{
    LeftMenuViewController *lmvc = [[LeftMenuViewController alloc] init];
    lmvc.delegate = self;
    UINavigationController *lmnc = [[UINavigationController alloc] initWithRootViewController:lmvc];
    TweetsViewController *tvc = [[TweetsViewController alloc] init];
    UINavigationController *tnc = [[UINavigationController alloc] initWithRootViewController:tvc];
    
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:lmnc frontViewController:tnc];//[[TweetsViewController alloc]init];
    revealController.delegate = self;
    self.viewController = revealController;
    self.window.rootViewController = self.viewController;
}

-(void) showProfilePage
{
    LeftMenuViewController *lmvc = [[LeftMenuViewController alloc] init];
    lmvc.delegate = self;
    UINavigationController *lmnc = [[UINavigationController alloc] initWithRootViewController:lmvc];
    ProfileViewController *pvc = [[ProfileViewController alloc] init];
    UINavigationController *pnc = [[UINavigationController alloc] initWithRootViewController:pvc];
    
    SWRevealViewController *revealController = [[SWRevealViewController alloc] initWithRearViewController:lmnc frontViewController:pnc];//[[TweetsViewController alloc]init];
    revealController.delegate = self;
    self.viewController = revealController;
    self.window.rootViewController = self.viewController;

}
-(void)showMenu:(NSString *)menu
{
    if ([menu caseInsensitiveCompare:@"home"] == NSOrderedSame) {
        [self showHomePage];
    } else if ([menu caseInsensitiveCompare:@"profile"] == NSOrderedSame) {
        [self showProfilePage];
    }
}
-(void)showLoggedinState
{
    [self showHomePage];
}
@end
