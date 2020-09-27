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

module lespaul_guitar_face() {
    // it's all in cm
    chin_width = 33.400;
    chin_half_width = chin_width /2;
    chin_length = 7.940 + 5.980;
    
    handle_scale = 33.40/189.80;
    mid_chin_length_percentage =0.42;
    mid_chin_width_percentage = 0.84;

    upper_chin_top_y = (0.4 + 1) * chin_length; // the top of the upper chin
    upper_chin_width = 0.92 * chin_width; // the percentage of chin_width

    waist_length = 15.37; // cm
    waist_mid_point_length_perc = 0.6;
    waist_chin_width_perc = 0.54;
    waist_top_y = upper_chin_top_y + waist_length;

    forehead_length = 9;
    forehead_top_y = waist_top_y + forehead_length;

    neck_slot_half_width = 2.66;
    
    rfin_bottom_width_perc = 0.68; // percentage of chin
    rfin_bottom_width_half = chin_half_width*rfin_bottom_width_perc;
    
    lfin_top_width_perc = .54; // percentage of chin_width
    lfin_length_mid_perc = .8; // percentage of forehead_length

    test9x = (62.05*handle_scale) - neck_slot_half_width;
    echo("7_x");
    echo (test9x);
    echo(test9x/rfin_bottom_width_half);

    test9y = 25.1*handle_scale;
    echo("7_y");
    echo (test9y);
    echo(test9y/forehead_length);

    // test10x = (33.22*handle_scale) - neck_slot_half_width;
    // echo("10_x");
    // echo (test10x);
    // echo(test10x/rfin_bottom_width_half);

    // test10y = 10.18*handle_scale;
    // echo("10_y");
    // echo (test10y);
    // echo(test10y/forehead_length);

    // test11x = (18.36*handle_scale) - neck_slot_half_width;
    // echo("11_x");
    // echo (test11x);
    // echo(test11x/rfin_bottom_width_half);

    // test11y = 20.94*handle_scale;
    // echo("11_y");
    // echo (test11y);
    // echo(test11y/forehead_length);

    // test12x = (15.95*handle_scale) - neck_slot_half_width;
    // echo("12_x");
    // echo (test12x);
    // echo(test12x/rfin_bottom_width_half);

    // test12y = 34.54*handle_scale;
    // echo("12_y");
    // echo (test12y);
    // echo(test12y/forehead_length);
    points = [
        undef, // 0 so don't do anything
        [0,0], // 1
        [chin_half_width *mid_chin_width_percentage, chin_length * mid_chin_length_percentage], // 2
        [chin_half_width, chin_length], //3
        [upper_chin_width/2, upper_chin_top_y], // 4
        [chin_half_width * waist_chin_width_perc,upper_chin_top_y + (waist_length * waist_mid_point_length_perc)], // 5
        [rfin_bottom_width_half,waist_top_y], // 6
        [neck_slot_half_width+(.73*rfin_bottom_width_half), waist_top_y+(0.49*forehead_length)], // 7
        [neck_slot_half_width+(.63*rfin_bottom_width_half), waist_top_y+(0.47*forehead_length)], // 8
        [neck_slot_half_width+(.46*rfin_bottom_width_half), waist_top_y+(0.24*forehead_length)], // 9
        [neck_slot_half_width+(.28*rfin_bottom_width_half), waist_top_y+(0.2*forehead_length)], // 10
        [neck_slot_half_width+(.05*rfin_bottom_width_half), waist_top_y+(0.41*forehead_length)], // 11
        [neck_slot_half_width+(.013*rfin_bottom_width_half), waist_top_y+(0.67*forehead_length)], // 12
        [neck_slot_half_width,forehead_top_y], // 13
        [-neck_slot_half_width,forehead_top_y], // 14
        [-chin_half_width*lfin_top_width_perc,waist_top_y + lfin_length_mid_perc*forehead_length], // 15
        [-chin_half_width*rfin_bottom_width_perc,waist_top_y], // 16
        [-chin_half_width * waist_chin_width_perc,upper_chin_top_y + (waist_length * waist_mid_point_length_perc)], , // 17
        [-upper_chin_width/2, upper_chin_top_y], // 18
        [-chin_half_width, chin_length], // 19 
        [-chin_half_width *mid_chin_width_percentage, chin_length * mid_chin_length_percentage]  // 20 
    ];

    full_handled_points = [
        // [x,y,z],  l_handle_length, r_handle_length, angle (0 being horizontal to the right)
        [points[1],  undef, 30.4 * handle_scale, 0], //1
        [points[2],  30.5* handle_scale, 14.5*handle_scale , 56],    // 2
        [points[3],  18.8*handle_scale, 12.4*handle_scale , 91],    // 3
        [points[4],  11.8*handle_scale, 31.8*handle_scale , 118],    // 4
        [points[5],  14.8*handle_scale, 11.4*handle_scale , 90],    // 5
        [points[6],  12.5*handle_scale, 11.1*handle_scale , 75],    // 6
        [points[7],  7.32*handle_scale, 2.3*handle_scale, 148],    // 7
        [points[8],  2.3*handle_scale, 4.2*handle_scale , 231],    // 8
        [points[9],  6.3*handle_scale, 4.6*handle_scale ,208],    // 9
        [points[10], 2.4*handle_scale, 6.1*handle_scale , 164],    // 10
        [points[11], 6.4*handle_scale, 4.8*handle_scale , 117],    // 11
        [points[12], 4.47*handle_scale, 9.2*handle_scale, 93],    // 12
        [points[13], 0                 , 10*handle_scale , 180],    // 13
        [points[14], 14.8*handle_scale, 12.1*handle_scale , 180],    // 14
        [points[15], 12.5*handle_scale, 11.8*handle_scale , -143],    // 15
        [points[16], 17.0*handle_scale, 17.8*handle_scale , -72],    // 16
        [points[17], 11.4*handle_scale, 14.8*handle_scale , 270],    // 17
        [points[18], 31.9*handle_scale, 11.8*handle_scale , 243],    // 18
        [points[19], 12.3*handle_scale, 18.8*handle_scale , 270],    // 19
        [points[20], 14.5*handle_scale, 31.1*handle_scale , -55],    // 20
        [points[1],  30.6*handle_scale, undef , 0],    // 21
    ];

    rel_handled_points = relative_handle_angled_points(full_handled_points);
        curve_points = bezier_points(0.05, rel_handled_points);
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


lespaul_guitar_face();