//
//  Quarantine_Filter.h
//  Quarantine Filter
//
//  Created by Mark Lilback on 6/27/16.
//  Copyright © 2016 Mark Lilback. All rights reserved.
//

#import <Automator/AMBundleAction.h>

@interface Quarantine_Filter : AMBundleAction

- (id)runWithInput:(id)input fromAction:(AMAction *)anAction error:(NSDictionary **)errorInfo;

@end
