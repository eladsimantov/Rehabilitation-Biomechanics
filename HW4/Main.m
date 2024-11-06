% Main
clc; close all; clearvars;
rng(1);

%% Q1 LS markers simulation
N = 1000; % num of markers
r = 5;
theta = 2*pi*rand(N,1); z = 5*rand(N,1); 
x = (r-z).*cos(theta); y = (r-z).*sin(theta);

% Plot the cone
scatter3(x,y,z, 'filled'); set(gcf, 'Color', 'white')
hold on;
% plot_cs([0 0 0], [1 0 0], [0 1 0], [0 0 1])
% plot_cs([mean(x) mean(y) mean(z)], [1 0 0], [0 1 0], [0 0 1])
xlabel('$x$','Interpreter','latex'); ylabel('$y$','Interpreter','latex'); zlabel('$z$','Interpreter','latex');
grid on; 
saveas(gcf, "Q1.png");

%% Q2 
theta1 = 2*pi*rand(1,1); % create theta_1 from 0 to 2pi
t1 = 20*rand(3,1)-10; % create between -10 and 10
display(rad2deg(theta1))
display(t1)

% rotate the cone by theta1 about x and translate by t1
rotm1 = axang2rotm([1 0 0 theta1]);
a = rotm1*[x'; y'; z'] + repmat(t1, 1, N);

% Plot the transformed cone
scatter3(a(1,:),a(2,:),a(3,:),'filled','Color','r'); set(gcf, 'Color', 'white')
% plot_cs(t1, rotm1(:, 1), rotm1(:, 2), rotm1(:, 3))
% plot_cs([0 0 0], [1 0 0], [0 1 0], [0 0 1])
legend("Lab", "pose (a)")
saveas(gcf, "Q2.png");

%% Q3
theta2 = 2*pi*rand(1,1); % create theta_1 from 0 to 2pi
t2 = 20*rand(3,1)-10; % create between -10 and 10
display(rad2deg(theta2)); 
display(t2)

% rotate the cone by theta1 about x and translate by t1
rotm2 = axang2rotm([0 0 1 theta2]);
b = rotm2*[a(1,:); a(2,:); a(3,:)] + repmat(t2, 1, N);
R_bI = rotm2*rotm1;
% Plot the transformed cone
scatter3(b(1,:),b(2,:),b(3,:),'filled','Color','r'); set(gcf, 'Color', 'white')
plot_cs(rotm2*t1+t2, R_bI(:, 1), R_bI(:, 2), R_bI(:, 3))
plot_cs(t1, rotm1(:, 1), rotm1(:, 2), rotm1(:, 3))
plot_cs([0 0 0], [1 0 0], [0 1 0], [0 0 1])

legend("Lab", "pose (a)", "pose (b)")
% saveas(gcf, "Q3.png");

%% Q4 is qualitative
%% Q5 - LS optimization
[R_calc, t_calc] = LS_motion_capture(a,b);
axang_calc = rotm2axang(R_calc);
display(axang_calc)
display("theta = " + rad2deg(axang_calc(4)) + " deg") % show theta

%% Q6 Errors
err_mat = R_calc*a + repmat(t_calc, 1, N) - b;
E = 0;
for i=1:N
    E = E + norm(err_mat(:,i))^2;
end
normalized_E = E/N;

%% Q7 is just repeating stuff
err_theta_2 = norm(axang_calc(4) - theta2); disp(err_theta_2);% show error in theta_2

%% Q8 R and t 
R_ab = transpose(rotm1)*R_calc*rotm1;
rotm2axang(R_ab)
a_avg = mean(a, 2); b_avg = mean(b, 2); % average location of points
t_ab = b_avg - R_calc*(a_avg - t1) - t1
 

%% Q10
a_small = a(:, 1:5); b_small = b(:, 1:5);
hold off
scatter3(a_small(1,:),a_small(2,:),a_small(3,:),'filled','Color','r'); hold on;
scatter3(b_small(1,:),b_small(2,:),b_small(3,:),'filled','Color','r');
set(gcf, 'Color', 'white')
xlabel('$x$','Interpreter','latex'); ylabel('$y$','Interpreter','latex'); zlabel('$z$','Interpreter','latex');
legend("reduced a", "reduced b"); grid on; 
% saveas(gcf, "Q10.png");
%% Q10
[R_small, t_small] = LS_motion_capture(a_small,b_small);
R_ab_small = transpose(rotm1)*R_small*rotm1;
a_avg_small = mean(a_small, 2); b_avg_small = mean(b_small, 2); % average location of points
t_ab_small = b_avg_small - R_small*(a_avg_small - t1) - t1

err_mat_small = R_small*a_small + repmat(t_small, 1, 5) - b_small;
E_small = 0;
for i=1:5
    E_small = E_small + norm(err_mat_small(:,i))^2;
end
normalized_E_small = E_small/5


%% Q11
w = 0.5*randn(3, N); % add noise to pose (b)
b_nois = b + w
scatter3(a(1,:),a(2,:),a(3,:),'filled','Color','r'); set(gcf, 'Color', 'white')
hold on;
% plot_cs(t1, rotm1(:, 1), rotm1(:, 2), rotm1(:, 3))
% plot_cs([0 0 0], [1 0 0], [0 1 0], [0 0 1])
scatter3(b_nois(1,:),b_nois(2,:),b_nois(3,:),'filled','Color','r'); 
legend("Pose (a)", "Pose (b noisy)")
xlabel('$x$','Interpreter','latex'); ylabel('$y$','Interpreter','latex'); zlabel('$z$','Interpreter','latex');
saveas(gcf, "Q11.png");
[R_nois, t_nois] = LS_motion_capture(a,b_nois);
R_ab_nois = transpose(rotm1)*R_nois*rotm1;
b_avg_nois = mean(b_nois, 2); % average location of points
t_ab_nois = b_avg_nois - R_nois*(a_avg - t1) - t1
%
err_mat_nois = R_nois*a + repmat(t_nois,1,N) - b_nois;
E_nois = 0;
for i=1:1000
    E_nois = E_nois + norm(err_mat_nois(:,i))^2;
end
display(E_nois/1000);

%% Q12
% a_small = a(:, 1:5); 
b_smallnois = b_nois(:, 1:5);
[R_small_nois, ~] = LS_motion_capture(a_small,b_smallnois);
theta_2_five_nois = rad2deg(rotm2axang(R_small_nois));
v = 1:5;
c = combnk(v,3)
acomb1 = [a_small(:,c(1,1)),a_small(:,c(1,2)),a_small(:,c(1,3))]
bcombi1 = [b_smallnois(:,c(1,1)),b_smallnois(:,c(1,2)),b_smallnois(:,c(1,3))]
acomb2 = [a_small(:,c(2,1)),a_small(:,c(2,2)),a_small(:,c(2,3))]
bcombi2 = [b_smallnois(:,c(2,1)),b_smallnois(:,c(2,2)),b_smallnois(:,c(2,3))]
acomb3 = [a_small(:,c(3,1)),a_small(:,c(3,2)),a_small(:,c(3,3))]
bcombi3 = [b_smallnois(:,c(3,1)),b_smallnois(:,c(3,2)),b_smallnois(:,c(3,3))]
acomb4 = [a_small(:,c(4,1)),a_small(:,c(4,2)),a_small(:,c(4,3))]
bcombi4 = [b_smallnois(:,c(4,1)),b_smallnois(:,c(4,2)),b_smallnois(:,c(4,3))]
acomb5 = [a_small(:,c(5,1)),a_small(:,c(5,2)),a_small(:,c(5,3))]
bcombi5 = [b_smallnois(:,c(5,1)),b_smallnois(:,c(5,2)),b_smallnois(:,c(5,3))]
acomb6 = [a_small(:,c(6,1)),a_small(:,c(6,2)),a_small(:,c(6,3))]
bcombi6 = [b_smallnois(:,c(6,1)),b_smallnois(:,c(6,2)),b_smallnois(:,c(6,3))]
acomb7 = [a_small(:,c(7,1)),a_small(:,c(7,2)),a_small(:,c(7,3))]
bcombi7 = [b_smallnois(:,c(7,1)),b_smallnois(:,c(7,2)),b_smallnois(:,c(7,3))]
acomb8 = [a_small(:,c(8,1)),a_small(:,c(8,2)),a_small(:,c(8,3))]
bcombi8 = [b_smallnois(:,c(8,1)),b_smallnois(:,c(8,2)),b_smallnois(:,c(8,3))]
acomb9 = [a_small(:,c(9,1)),a_small(:,c(9,2)),a_small(:,c(9,3))]
bcombi9 = [b_smallnois(:,c(9,1)),b_smallnois(:,c(9,2)),b_smallnois(:,c(9,3))]
acomb10 = [a_small(:,c(10,1)),a_small(:,c(10,2)),a_small(:,c(10,3))]
bcombi10 = [b_smallnois(:,c(10,1)),b_smallnois(:,c(10,2)),b_smallnois(:,c(10,3))]


%% Q12

[R_small1, t_smal1] = LS_motion_capture(acomb1,bcombi1);
[R_small2, t_smal2] = LS_motion_capture(acomb2,bcombi2);
[R_small3, t_smal3] = LS_motion_capture(acomb3,bcombi3);
[R_small4, t_smal4] = LS_motion_capture(acomb4,bcombi4);
[R_small5, t_smal5] = LS_motion_capture(acomb5,bcombi5);
[R_small6, t_smal6] = LS_motion_capture(acomb6,bcombi6);
[R_small7, t_smal7] = LS_motion_capture(acomb7,bcombi7);
[R_small8, t_smal8] = LS_motion_capture(acomb8,bcombi8);
[R_small9, t_smal9] = LS_motion_capture(acomb9,bcombi9);
[R_small10, t_smal10] = LS_motion_capture(acomb10,bcombi10);

axang_smal1 = rad2deg(rotm2axang(R_small1))
axang_smal2 = rad2deg(rotm2axang(R_small2))
axang_smal3 = rad2deg(rotm2axang(R_small3))
axang_smal4 = rad2deg(rotm2axang(R_small4))
axang_smal5 = rad2deg(rotm2axang(R_small5))
axang_smal6 = rad2deg(rotm2axang(R_small6))
axang_smal7 = rad2deg(rotm2axang(R_small7))
axang_smal8 = rad2deg(rotm2axang(R_small8))
axang_smal9 = rad2deg(rotm2axang(R_small9))
axang_smal10 = rad2deg(rotm2axang(R_small10))
%%
% final plot
figure(); set(gcf, "Color", "white"); grid on; hold on;
yline(rad2deg(theta2), "LineStyle","--", "Color", "black", "DisplayName", "\theta_2 \approx 106.6068 [deg]", "Interpreter","latex") % the original theta
yline(theta_2_five_nois(4), "LineStyle", "--", "Color", "red", "DisplayName", "\theta_{2\omega}  \approx " + theta_2_five_nois(4) + " [deg]", "Interpreter","latex")
legend("show", Location="eastoutside")

scatter(1, axang_smal1(4), "DisplayName","\theta_{2,1}  \approx " + axang_smal1(4) + " [deg]")
scatter(2, axang_smal2(4), "DisplayName","\theta_{2,2}  \approx " + axang_smal2(4) + " [deg]")
scatter(3, axang_smal3(4), "DisplayName","\theta_{2,3}  \approx " + axang_smal3(4) + " [deg]")
scatter(4, axang_smal4(4), "DisplayName","\theta_{2,4}  \approx " + axang_smal4(4) + " [deg]")
scatter(5, axang_smal5(4), "DisplayName","\theta_{2,5}  \approx " + axang_smal5(4) + " [deg]")
scatter(6, axang_smal6(4), "DisplayName","\theta_{2,6}  \approx " + axang_smal6(4) + " [deg]")
scatter(7, axang_smal7(4), "DisplayName","\theta_{2,7}  \approx " + axang_smal7(4) + " [deg]")
scatter(8, axang_smal8(4), "DisplayName","\theta_{2,8}  \approx " + axang_smal8(4) + " [deg]")
scatter(9, axang_smal9(4), "DisplayName","\theta_{2,9}  \approx " + axang_smal9(4) + " [deg]")
scatter(10, axang_smal10(4), "DisplayName","\theta_{2,10}  \approx " + axang_smal10(4) + " [deg]")

xlabel('$Combination$','Interpreter','latex'); ylabel('$\theta [deg]$','Interpreter','latex','Rotation',0);
xlim([0 10]); ylim([100 155]);
xticks(1:10); xticklabels(1:10);
saveas(gcf, "Q12.png")
%%
