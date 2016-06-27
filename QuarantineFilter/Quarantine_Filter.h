//
//  Quarantine_Filter.h
//  Quarantine Filter
//
//  Copyright © 2016 Mark Lilback. This file is licensed under the ISC license.
//

#import <Cocoa/Cocoa.h>
#import <Automator/AMBundleAction.h>

@interface Quarantine_Filter : AMBundleAction
@property (strong) IBOutlet NSPopUpButton *filterPopup;
@property NSInteger selectedFilterTag;

- (id)runWithInput:(id)input fromAction:(AMAction *)anAction error:(NSDictionary **)errorInfo;

@end
