w = 100;
l = 40;

h = 10;

screw_radius = 1.5;
screw_counter_sink_radius = 2.5;
screw_offset = 6;

nut_capture_dims = [4.1, 3.1, 3.9];

module nut_capture($nut_outer_radius = 3.5, $nut_inner_radius = 2, $nut_height = 3) {
    cylinder(r=$nut_inner_radius, h=h+2);
    translate([0, 0, 6]) {
        cylinder(r=$nut_outer_radius, h=$nut_height, $fn=6);
    }
}

difference() {
    cube([w, l, h]);

    // Nut capture
    translate([w/5, l/2, -1]) {
        nut_capture(nut_capture_dims[0], nut_capture_dims[1], nut_capture_dims[2]);
    }
    
    translate([w/2, l/2, -1]) {
        nut_capture(nut_capture_dims[0], nut_capture_dims[1], nut_capture_dims[2]);
    }   
    
    translate([w/5*4, l/2, -1]) {
        nut_capture(nut_capture_dims[0], nut_capture_dims[1], nut_capture_dims[2]);
    }

    // Screw hole at each corner
    for (x = [screw_offset, w - screw_offset]) {
        for (y = [screw_offset, l - screw_offset]) {
            translate([x, y, -1]) {
                // Add a counter sunk hole
                cylinder(r = screw_radius, h = h + 2, $fn = 30);
                // Add a screw head capture
                translate([0, 0, 9]) {
                    cylinder(r = screw_counter_sink_radius, h = 3, $fn = 30);
                }
            }
        }
    }
    
    // Cut outs at bottom for adhesive tape
    // translate([5, 10, -1]) {
    //     cube([10, 20, 2]);
    // }
    
    //  translate([85, 10, -1]) {
    //     cube([10, 20, 2]);
    // }
}
