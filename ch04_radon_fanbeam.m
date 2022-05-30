clc; clear all; close all;

%% fanbeam %%

% g1 = zeros(600, 600);
% g1(100:500, 250:350) = 1;
% g2 = phantom('Modified Shepp-Logan', 600);
% D = 1.5*hypot(size(g1, 1), size(g1,2))/2;
% B1_line = fanbeam(g1, D, 'FanSensorGeometry', 'line', ...
%     'FanSensorSpacing', 1, 'FanRotationIncrement', 0.5);
% B2_line = fanbeam(g2, D, 'FanSensorGeometry', 'line', ...
%     'FanSensorSpacing', 1, 'FanRotationIncrement', 0.5);
% 
% B1_line = flipud(B1_line');
% B2_line = flipud(B2_line');
% 
% B1_arc = fanbeam(g1, D, 'FanSensorGeometry', 'arc', ...
%     'FanSensorSpacing', 0.08, 'FanRotationIncrement', 0.5);
% B2_arc = fanbeam(g2, D, 'FanSensorGeometry', 'arc', ...
%     'FanSensorSpacing', .08, 'FanRotationIncrement', 0.5);
% 
% B1_arc = flipud(B1_arc');
% B2_arc = flipud(B2_arc');
% 
% 
% subplot(3,2,1); imshow(g1, []); title('square image');
% subplot(3,2,2); imshow(g2, []); title('Modifed Shepp-Logan');
% subplot(3,2,3); imshow(B1_line, []);
% subplot(3,2,4); imshow(B2_line, []);
% subplot(3,2,5); imshow(B1_arc, []);
% subplot(3,2,6); imshow(B2_arc, []);


%% ifanbeam %%
g = phantom('Modified Shepp-Logan', 600);
D = 1.5 * hypot(size(g, 1), size(g,2))/2;
B1 = fanbeam(g, D);
f1 = ifanbeam(B1, D);
B2 = fanbeam(g, D, 'FanRotationIncrement', 0.5, 'FanSensorSpacing', 0.5);
f2 = ifanbeam(B2, D, 'FanRotationIncrement', 0.5, ...
    'FanSensorSpacing', 0.5, 'Filter', 'Hamming');
B3 = fanbeam(g, D, 'FanRotationIncrement', 0.5, 'FanSensorSpacing', 0.05);
f3 = ifanbeam(B3, D, 'FanRotationIncrement', 0.5, ...
    'FanSensorSpacing', 0.05, 'Filter', 'Hamming');

subplot(2,2,1), imshow(g, []);

subplot(2,2,2), imshow(f1, []);
subplot(2,2,3), imshow(f2, []);
subplot(2,2,4), imshow(f3, []);
