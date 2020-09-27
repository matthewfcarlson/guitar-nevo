include <bezier.scad>

$fn = 0;
$fa = 5;
$fs = .05;

module lespaul_guitar_face(
    include_cut_outs=false
) {
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
    polygon(curve_points);
    // translate([0,0,-1]) {
    //     line_points(curve_points, width=0.1);
    //     for (i = curve_points) {
    //         translate(i) sphere(r=0.2);
    //     }
    // }
    // translate([0,0,-5]) polygon(curve_points);
    // translate([0,0,3]) {
    //     for (i = [1:len(points)-1]) {
    //         //color("red") translate(points[i]) sphere(r=0.5);
    //     }
    // }
    
    // color("pink") translate([0,0,1]) {
    //     for (i = [0:3:len(rel_handled_points)-3]) {
    //         line(rel_handled_points[i], rel_handled_points[i+3], width=0.1);
    //         translate(rel_handled_points[i]) sphere(r=0.4);
    //     }
    // }

    // for (i = [0:3:len(rel_handled_points)-3]) {
    //     //color("gray") line(rel_handled_points[i], rel_handled_points[i+3], width=0.1);
    //     translate(rel_handled_points[i]) sphere(r=0.3);
    //     color("blue") translate(rel_handled_points[i+1]) sphere(r=0.2);
    //     color("green") translate(rel_handled_points[i+2]) sphere(r=0.2);
    //     translate([0,0,-0.1]) color("blue") line(rel_handled_points[i], rel_handled_points[i+1], width=0.1);
    //     translate([0,0,-0.1]) color("green") line(rel_handled_points[i+2], rel_handled_points[i+3], width=0.1);
    // }
}


lespaul_guitar_face();