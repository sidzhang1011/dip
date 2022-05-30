clc; clear; close 

g = imread('U200.tif');
if ndims(g) == 3
    g = rgb2gray(g);
end

subplot(2,3,1), imshow(g);

hold on
center = {100, 80};
alpha = 0:pi/30:2*pi;
alpha = alpha';
r = 60;
x0 = r * cos(alpha) + center{1};
y0 = r *sin(alpha) + center{2};

% plot(x0,y0, 'og');
curveDisplay(x0, y0, 'go', 'MarkerFaceColor', 'w');
hold off;

% Edge map.
emap = snakeMap(g, 0.001, 3, 1, 'both');
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
subplot(2,3,3), quiver(flipud(FMy(1:2:end, 1:2:end)), ...
    flipud(-FMx(1:2:end, 1:2:end))) % Fig. 12.6(c).

x = x0;
y = y0;
% Iterate for 500 iterations.
for i = 1:1000
    [x, y] = snakeIterate(0.06, 0, 1.0, x, y, 1, FMx, FMy);
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
subplot(2,3,5), quiver(flipud(FVy(1:2:end,1:2:end)), ...
    flipud(-FVx(1:2:end,1:2:end)));
x = x0;
y = y0;
% 400 iterations.
for i = 1:5600
    [x, y] = snakeIterate(0.06, 0, 1.0, x, y, 1, FVx, FVy);
    [x, y] = snakeRespace(x, y);
end
subplot(2,3,6), imshow(g)
hold on
curveDisplay(x, y, 'go', 'MarkerFaceColor', 'w' ,  ...
    'Markersize', 5) % Fig. 12.6(f).
hold off;

