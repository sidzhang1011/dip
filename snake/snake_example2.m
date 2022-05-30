clc; clear; close 

g = imread('letterB.tif');
if ndims(g) == 3
    g = rgb2gray(g);
end

subplot(2,3,1), imshow(g);

hold on
center = {380, 400};
alpha = 0:pi/150:2*pi;
alpha = alpha';
r = 120;
x0 = r * cos(alpha) + center{1};
y0 = r *sin(alpha) + center{2};

x01 = 260 * ones(1, 81);
y01 = 280:200/80.0:482;
x02 = 500 * ones(1, 81);
y02 = y01;
x03 = 260:240/80.0:502;
y03 = 280 * ones(1, 81);
x04 = x03;
y04 = 480 * ones(1,81);
% x0 = [x01, x02, x03, x04]';
% y0 = [y01, y02, y03, y04]';

% plot(x0,y0, 'og');
curveDisplay(x0, y0, 'go', 'MarkerFaceColor', 'w');
hold off;

% Edge map.
emap = snakeMap(g, 0.001, 7, 3, 'both');
subplot(2,3,2), imshow(emap, []), title('edge map');

% Force
[FMx, FMy] = snakeForce(emap, 'mog');

mag = hypot(FMx, FMy);
small = 1e-10;
% Normalize the forces.
FMx = FMx ./ (mag + small);
FMy = FMy ./ (mag + small);

% Display the force field (it is shown colored and superimposed manually 
% on the edge map).
subplot(2,3,3), quiver(flipud(FMy(1:10:end, 1:10:end)), ...
    flipud(-FMx(1:10:end, 1:10:end))) % Fig. 12.6(c).

x = x0;
y = y0;
% Iterate for 500 iterations.
for i = 1:500
    [x, y] = snakeIterate(1.0, 0.1, 5.0, x, y, 1, FMx, FMy);
    [x, y] = snakeRespace(x, y);
end

% Respace the snake points one last time.
[x, y] = snakeRespace(x, y);

% Display the results.
subplot(2,3,4), imshow(g);
hold on
curveDisplay(x, y, 'go', 'MarkerFaceColor', 'w', 'MarkerSize', 5); % Fig12.6(d)


% Now do using GVF with mu = 0.25 and niter = 100.
[FVx, FVy] = snakeForce(emap, 'GVF', 0.25, 100);
mag = hypot(FVx, FVy);
FVx = FVx ./ (mag + small);
FVy = FVy ./ (mag + small);

% Display the force field (it is shown colored and superimposed 
% manually on the edge map).
subplot(2,3,5), quiver(flipud(FVy(1:10:end,1:10:end)), ...
    flipud(-FVx(1:10:end,1:10:end)));
x = x0;
y = y0;
% 150 iterations.
for i = 1:500
    [x, y] = snakeIterate(1, 0.1, 5.0, x, y, 1, FVx, FVy);
    [x, y] = snakeRespace(x, y);
end
subplot(2,3,6), imshow(g)
hold on
curveDisplay(x, y, 'go', 'MarkerFaceColor', 'w' ,  ...
    'Markersize', 5) % Fig. 12.6(f).
hold off;

