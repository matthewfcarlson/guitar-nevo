include <bezier.scad>

$fn = 0;
$fa = 5;
$fs = .05;

module guitar_face(
    chin_length,
    chin_width,
    body_length,
    lfin_width,
    neck_slot_length,
    neck_slot_width,
    rfin_neck_offset,
    ) {
        t_step = 10;

        chin_bottom_handle = 3;
        chin_top_left_handle = 2;

        body_total_length = chin_length + body_length;
        body_top_width = lfin_width;
        rbody_length_offset = 0.2; // TODO fix this

        neck_slot_width_half = neck_slot_width / 2;
        neck_slot_center_offset_width = 0.1; //TODO
        neck_slot_length_offset = 3; // TODO fix
        neck_slot_bottom_y = neck_slot_length_offset + body_total_length;


        r_waist_width = chin_width*.6; // TODO fix this
        l_waist_width = r_waist_width;
        waist_bottom_y = body_total_length - neck_slot_length_offset;

        rfin_width = lfin_width;
        rfin_neck_connect_y = rfin_neck_offset + body_total_length;

        lfin_edge_y = body_total_length + 2; // TODO fix this
        lfin_top_x = 5.5; // TODO fix this
        l_fin_body_offset_length = 0.2; // TODO fix this
        l_fin_slot_offset_length = 0.5; // TODO fix this
        lfin_top_y = body_total_length + 5.31; // TODO fix this
        rfin_top_x = neck_slot_width_half + 2; // TODO fix this
        rfin_total_length = body_total_length + 2.5; // TODO fix this

        points = [
            undef, // 0 so don't do anything
            [0,0], // 1
            [chin_width *.8, chin_length * .4], // 2 // FIX
            [chin_width, chin_length + rbody_length_offset], //3
            [r_waist_width, waist_bottom_y], // 4
            [rfin_width,body_total_length + 4], // 5 // FIX
            [rfin_width - 1,body_total_length + 6], // 6 // FIX
            [rfin_width - 2.2,body_total_length + 4.3], // 7
            [rfin_width - 3,body_total_length + 3], // 8
            [neck_slot_width_half-neck_slot_center_offset_width, neck_slot_bottom_y + l_fin_slot_offset_length], // 9
            [neck_slot_width_half-neck_slot_center_offset_width, neck_slot_bottom_y + neck_slot_length- .2], // 10
            [neck_slot_width_half-neck_slot_center_offset_width-.2, neck_slot_bottom_y + neck_slot_length], // 11
            [-(neck_slot_center_offset_width+neck_slot_width_half), neck_slot_bottom_y + neck_slot_length], // 12
            [-(neck_slot_center_offset_width+neck_slot_width_half+1),neck_slot_bottom_y + 2], // 13
            [-rfin_width+2,neck_slot_bottom_y+4], // 14
            [-rfin_width+1,neck_slot_bottom_y+6], // 15
            [-l_waist_width, waist_bottom_y + l_fin_body_offset_length], // 16
            [-chin_width, chin_length], // 17
            [-chin_width *.8, chin_length * .4]  // 18 // FIX
        ];

        full_handled_points = [
            // [x,y,z],  l_handle_length, r_handle_length, angle (0 being horizontal to the right)
            [points[1],  undef, chin_bottom_handle, 0], //1
            [points[2],  1, 1 , 55],    // 2
            [points[3],  2, 5 , 90],    // 3
            [points[4],  3, 4 , 80],    // 4
            [points[5],  2, 1 , 95],    // 5
            [points[6],  .5, .5 , 180],    // 6
            [points[7],  1, .5 , 270],    // 7
            [points[8],  .5, .5 , 200],    // 8
            [points[9],  1.2, 0 , 130],    // 9
            [points[10], 0.2, 0.2 , 90],    // 10
            [points[11], 0.1, 0.1 , 180],    // 11
            [points[12], 0, 0.5 , 240],    // 12
            [points[13], 1, 1 , 180],    // 13
            [points[14], 1, 0.5 , 105],    // 14
            [points[15], 2, 4 , 210],    // 15
            [points[16], 4, 3 , 280],    // 16
            [points[17], 5, 2 , 270],    // 17
            [points[18], 1, 1 , -55],    // 18
            [points[1],  chin_bottom_handle, undef , 0],    // 19
            
        ];
        rel_handled_points = relative_handle_angled_points(full_handled_points);
        echo("relative_full_handled_points");
        echo(rel_handled_points);
        curve_points = bezier_points(0.05, rel_handled_points);
        echo("Curved points");
        echo(curve_points);
        translate([0,0,-1]) {
            line_points(curve_points, width=0.1);
            for (i = curve_points) {
                translate(i) sphere(r=0.2);
            }
        }
        translate([0,0,-5]) polygon(curve_points);
        translate([0,0,3]) {
            for (i = [1:len(points)-1]) {
                //color("red") translate(points[i]) sphere(r=0.5);
            }
        }
        color("purple") translate([0,0,2]) {
            for (i = [0:1:len(full_handled_points)-2]) {
                line(full_handled_points[i][0], full_handled_points[i+1][0], width=0.1);
                translate(full_handled_points[i][0]) sphere(r=0.4);
            }
        }
        color("pink") translate([0,0,1]) {
            for (i = [0:3:len(rel_handled_points)-3]) {
                line(rel_handled_points[i], rel_handled_points[i+3], width=0.1);
                translate(rel_handled_points[i]) sphere(r=0.4);
            }
        }

        for (i = [0:3:len(rel_handled_points)-3]) {
            //color("gray") line(rel_handled_points[i], rel_handled_points[i+3], width=0.1);
            translate(rel_handled_points[i]) sphere(r=0.3);
            color("blue") translate(rel_handled_points[i+1]) sphere(r=0.2);
            color("green") translate(rel_handled_points[i+2]) sphere(r=0.2);
            translate([0,0,-0.1]) color("blue") line(rel_handled_points[i], rel_handled_points[i+1], width=0.1);
            translate([0,0,-0.1]) color("green") line(rel_handled_points[i+2], rel_handled_points[i+3], width=0.1);
        }
}

module stratocaster_guitar_face() {
    guitar_face(
        7 + 9/16, // chin face length
        6 + 5/8, // chin face width
        12 + 3/4, // body length
        5 + 1/2, // left fin width
        3, // neck slot length
        2.215, // neck slot width
        .625 // right fin neck offset
    );
}


stratocaster_guitar_face();