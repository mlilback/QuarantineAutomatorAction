//
//  Quarantine_Filter.m
//  Quarantine Filter
//
//  Copyright © 2016 Mark Lilback. This file is licensed under the ISC license.
//

#import "Quarantine_Filter.h"
#import <CoreServices/CoreServices.h>

@implementation Quarantine_Filter

-(instancetype)initWithDefinition:(NSDictionary<NSString *,id> *)dict fromArchive:(BOOL)archived
{
	if ((self = [super initWithDefinition:dict fromArchive:archived])) {
		NSDictionary *d = [dict objectForKey:@"ActionParameters"];
		NSNumber *tagInt = [d objectForKey:@"filterTag"];
		if (nil == tagInt)
			tagInt = @(0);
		_selectedFilterTag = [tagInt integerValue];
	}
	return self;
}

-(void)writeToDictionary:(NSMutableDictionary<NSString *,id> *)dictionary
{
	[super writeToDictionary:dictionary];
	[dictionary setObject:[NSNumber numberWithInteger:_selectedFilterTag] forKey:@"filterTag"];
}

-(void)updateParameters
{
	[super updateParameters];
	[self.parameters setObject:[NSNumber numberWithInteger:_selectedFilterTag] forKey:@"filterTag"];
}

-(void)parametersUpdated
{
	[super parametersUpdated];
	_selectedFilterTag = [[self.parameters objectForKey:@"filterTag"] integerValue];
}

- (id)runWithInput:(id)input fromAction:(AMAction *)anAction error:(NSDictionary **)errorInfo
{
	NSString *filterType = @"";
	switch(self.selectedFilterTag) {
		case 0:
		default:
			filterType = (NSString*)kLSQuarantineTypeWebDownload;
			break;
		case 1:
			filterType = @"LSQuarantineTypeAirDrop";
			break;
		case 2:
			filterType = (NSString*)kLSQuarantineTypeEmailAttachment;
			break;
		case 3:
			filterType = (NSString*)kLSQuarantineTypeInstantMessageAttachment;
			break;
	}
	NSMutableArray *output = [[NSMutableArray alloc] init];
	for (NSURL *aUrl in input) {
		id rvalue;
		NSError *err;
		if ([aUrl getResourceValue:&rvalue forKey:NSURLQuarantinePropertiesKey error:&err]) {
			NSString *qtype = [rvalue objectForKey:@"LSQuarantineType"];
			if ([qtype isEqualToString:filterType]) {
				[output addObject:aUrl];
			}
		} else {
			NSLog(@"error getting quarantine properties:%@", err);
		}
	}
	return output;
}

@end
