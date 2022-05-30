clc; clear; close 

g = imread('noisy-elliptical-object.tif');
if ndims(g) == 3
    g = rgb2gray(g);
end

subplot(2,3,1), imshow(g);

hold on
center = {380, 400};
alpha = 0:pi/150:2*pi;
alpha = alpha';
r = 180;
x0 = r * cos(alpha) + center{1};
y0 = r *sin(alpha) + center{2};
% plot(x0,y0, 'og');
curveDisplay(x0, y0, 'go', 'MarkerFaceColor', 'w');
hold off;

emap1 = snakeMap(g, 0.001, 15, 3, 'after');
subplot(2,3,2), imshow(emap1, []);
[Fx1, Fy1] = snakeForce(emap1, 'mog');

mag = hypot(Fx1, Fy1);
small = 1e-10;
Fx1 = Fx1 ./ (mag + small);
Fy1 = Fy1 ./ (mag + small);

x1 = x0;
y1 = y0;
for n = 1:1
    for i = 1:250    
        [x1, y1] = snakeIterate(0.05, 0.01, 0.6, x1, y1, 1, Fx1, Fy1);
        [x1, y1] = snakeRespace(x1, y1);
    end

    [x1, y1] = snakeRespace(x1, y1);
    subplot(2,3, n+2), imshow(g), title('mog');
    hold on
    curveDisplay(x1, y1, 'go', 'MarkerFaceColor', 'w');
    hold off;
end

