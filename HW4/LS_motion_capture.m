function [R,t] = LS_motion_capture(a,b)
%LS_MOTION_CAPTURE Takes two matrices of size 3xN representing N markers with x,y,z coordinates. 
%It returns the rotation matrix and translation vector by solving an optimization problem.

N = size(a, 2); % num of cols is num of markers 
a_avg = mean(a, 2); b_avg = mean(b, 2); % average location of points
Da = a - repmat(a_avg, 1, N); % find difference from average loc
Db = b - repmat(b_avg, 1, N); % repeat the average N times to substract it from a...
BA_t = Db*transpose(Da); 
[U, ~, V] = svd(BA_t); % do the trick
R = U*transpose(V);
disp("det(R) = " + det(R)) % make sure right hand rule
if det(R) + 1 <= 1e-2
    R = U*[1 0 0; 0 1 0; 0 0 -1]*transpose(V);
    disp("updated det(R)") % make sure right hand rule
end
t = b_avg - R*a_avg;

end

