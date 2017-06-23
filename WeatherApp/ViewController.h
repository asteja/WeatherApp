//
//  ViewController.h
//  WeatherApp
//
//  Created by Sai Teja on 6/10/17.
//  Copyright © 2017 Sai Teja. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GooglePlaces;
#import "APIWebService.h"

@interface ViewController : UIViewController<GMSAutocompleteResultsViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property GMSAutocompleteResultsViewController *resultsViewController;

@property UISearchController *searchController;

@property APIWebService *client;

@end

