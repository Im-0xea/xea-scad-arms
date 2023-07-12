$fn         = 100;
cl          =   1;

upper_len   = 180;
upper_cal   =  30;
upper_walls =   2;

barrel_len  =  80;
barrel_cal  =   8;

slot_len    =  40;
slot_start  =  40;
slot_rad    =   5;
slot_depth  =  10;

chamber_cal =   9;
chamber_len =  19;

bolt_len    = 100;
bolt_cal    =  25;

// upper receiver
translate([0,0,0])
difference() {
	cylinder(upper_len, d = upper_cal);
	union() {
		// bolt recess
		translate([0,0,-cl]) cylinder(upper_len + (cl * 2), d = bolt_cal);
		// front sight cutout
		translate([0,15,10]) cube([30,5,5], center = true);
		// ejection port
		translate([0,0,slot_start])
		union() {
			translate([0,15, 20]) cube([30,slot_depth,slot_len], center = true);
			translate([0,15,0]) rotate([0, 90, 0])
			cylinder(30, r = slot_rad, center = true);
			translate([0,15,40]) rotate([0, 90, 0])
			cylinder(30, r = slot_rad, center = true);
		};
	}
};

// barrel
translate([0,0,250])
difference() {
	cylinder(barrel_len, r = 13);
	translate([0,0,-cl]) union() {
		cylinder(barrel_len + (cl * 2), d = barrel_cal);
		cylinder(chamber_len + cl, d = chamber_cal);
	}
}

// bolt
translate([0,0,-50])
rotate([0,180,0])
difference() {
	cylinder(bolt_len, d = bolt_cal);
	union() {
		// recess for casing
		translate ([0,0,-cl])cylinder(10, d = chamber_cal + 1);
		// firing pin hole
		cylinder(10, 1.5, 1.5);
		// cutout for extractor
		union() {
			//translate([0,8,0]) cube([2.5,10,3], center = true);
			//translate([0,15,15]) cube([2.5,10,30], center = true);
			rotate([0,-90,0]) polygon([
				[5,0],
				[5,10],
				[30,10],
				[30,10 + 5],
				[-cl, 10 + 5],
				[-cl, 0]
			]);
		}
		// recess for spring
		translate([0,15,30]) rotate([90,0,0])
		cylinder(15, 1.5, 1.5, center = true);
		// cutout for spring
		translate([0, 0, 40]) cylinder(80, 10, 10);
	}
};

mag_walls  = 1;
mag_width  = chamber_cal + 1 + (mag_walls * 2);
mag_height = chamber_len + 1 + (mag_walls * 2);
mag_len    = 100;

// magazine
translate([0,-100,0])
rotate([-35 - 20,0,0])
difference() {
    cube([mag_width,mag_height,mag_len], center = true);
		union() {
			cube([mag_width - (mag_walls * 2),mag_height - (mag_walls * 2),mag_len + cl], center = true);
			translate([0,0,-1 * (mag_len / 2) ]) rotate([-35,0,0])
			cube([mag_width + 20,mag_height * 2.5,20], center = true);
			translate([0,0,1 * (mag_len / 2) ]) rotate([-35,0,0])
			cube([mag_width - (mag_walls * 2),mag_height * 2.5,20], center = true);
			translate([0,0,1 * (mag_len / 2) + 5 ]) rotate([-35,0,0])
			cube([mag_width * 2,mag_height * 2.5,20], center = true);
		}
};