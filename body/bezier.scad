function bezier_coordinate(t, n0, n1, n2, n3) = 
    n0 * pow((1 - t), 3) + 3 * n1 * t * pow((1 - t), 2) + 
        3 * n2 * pow(t, 2) * (1 - t) + n3 * pow(t, 3);

function bezier_point(t, p0, p1, p2, p3) = 
    [for(i = [0:1:len(p0)-1]) bezier_coordinate(t, p0[i], p1[i], p2[i], p3[i])];

function bezier_curve(t_step, p0, p1, p2, p3) = 
    concat([p0], [for(t = [t_step: t_step: 1-t_step]) bezier_point(t, p0, p1, p2, p3)],[p3]);

function bezier_curve_dpi(dpi, p0, p1, p2, p3) = bezier_curve(calculate_tstep_dpi(dpi,p0,p3),p0,p1,p2,p3);
        
function bezier_points(t_step, points, _old_points=[], _points_index = 0) = 
     ((_points_index > (len(points) - 3) || _points_index >= 100) ?
        _old_points:
        bezier_points(
            t_step,
            points,
            concat(_old_points, bezier_curve(t_step, points[_points_index], points[_points_index+1], points[_points_index+2], points[_points_index+3])),
            _points_index + 3
        )
    );
function bezier_points_dpi(dpi, points, _old_points=[], _points_index = 0) = 
     ((_points_index > (len(points) - 3) || _points_index >= 100) ?
        _old_points:
        bezier_points(
            t_step,
            points,
            concat(_old_points, bezier_curve_dpi(dpi, points[_points_index], points[_points_index+1], points[_points_index+2], points[_points_index+3])),
            _points_index + 3
        )
    );
function relative_handle_points(points, _old_points=[], _points_index = 0) = 
     ((_points_index > (len(points) - 3) || _points_index >= 100) ?
        concat(_old_points, [points[len(points)-1]]):
        relative_handle_points(
            points,
            concat(_old_points,[points[_points_index], points[_points_index] + points[_points_index+1], points[_points_index+2] + points[_points_index+3]]),
            _points_index + 3
        )
    );
function relative_handle_angled_points(points, _old_points=[], _points_index = 0) = 
  ((_points_index >= (len(points) - 1) || _points_index >= 100) ?
    concat(_old_points, [points[len(points)-1][0]]):
    (//(_points_index == 0) ?
      // relative_handle_angled_points(points, [points[0][0], [points[0][0]]], 1):
      relative_handle_angled_points(
        points,
        concat(
          _old_points,
          [
            points[_points_index][0],
            points[_points_index][0]+[cos(points[_points_index][3])*points[_points_index][2],sin(points[_points_index][3])*points[_points_index][2]],
            points[_points_index+1][0]-[cos(points[_points_index+1][3])*points[_points_index+1][1],sin(points[_points_index+1][3])*points[_points_index+1][1]]
          ]),
        _points_index + 1
      )
    )
  );
function dist(p0,p1) = sqrt(pow(p0[0] - p1[0],2) + pow(p0[1] - p1[1],2));
function calculate_tstep_dpi(dpi, p0, p1) = 1 / (dist(p0, p1) * dpi);
function bezier_points_rel(t_step, points) = bezier_points(t_step, relative_handle_points(points));


module line(point1, point2, width = 1, cap_round = true) {
    angle = 90 - atan((point2[1] - point1[1]) / (point2[0] - point1[0]));
    offset_x = 0.5 * width * cos(angle);
    offset_y = 0.5 * width * sin(angle);

    offset1 = [-offset_x, offset_y];
    offset2 = [offset_x, -offset_y];

    if(cap_round) {
        translate(point1) circle(d = width, $fn = 24);
        translate(point2) circle(d = width, $fn = 24);
    }

    polygon(points=[
        point1 + offset1, point2 + offset1,  
        point2 + offset2, point1 + offset2
    ]);
}

module line_points(points, width = 1, cap_round = true) {
   for (i = [0:1:len(points)-2]) {
       line(points[i], points[i+1], width, cap_round);
   }
}

module polyline(points, width = 1) {
    module polyline_inner(points, index) {
        if(index < len(points)) {
            line(points[index - 1], points[index], width);
            polyline_inner(points, index + 1);
        }
    }

    polyline_inner(points, 1);
}
