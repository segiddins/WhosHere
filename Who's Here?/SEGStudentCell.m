//
//  SEGStudentCell.m
//  Who's Here?
//
//  Created by Samuel E. Giddins on 1/12/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import "SEGStudentCell.h"

@implementation SEGStudentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self->untouched = true;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
