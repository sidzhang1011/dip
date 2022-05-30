clc; clear; close all;
M = 512;
N = 512;

% Center the plots for easier visualization. 
xc = round(M/2);
yc = round(N/2);

lambda = 180;
angle = 45; % Rotation angle in degrees.
theta = angle*pi/180; % In radians.
% Gaussian kernel. 
y = 1:N;
x = (1:M)';
x = x - xc;
y = y - yc;

xr = x.*cos(theta) + y.*sin(theta); % Eq.(11-34).
yr = -x.*sin(theta) + y.*cos(theta);
sigxr = 40; % Standard deviations.
sigyr = 100;

w = exp(-0.5*((xr).^2/sigxr^2 + (yr).^2/sigyr^2)); 
% Eq. (11-33). 
subplot(2,2,1), imshow(w) % Figure 11.29(a).

% Sinusoidal plane wave.
s = exp(1i*2*pi*xr/lambda); % From Eq. (11-37). 
% Plot the real part.
subplot(2,2,2), imshow(real(s)) % Figure 11.29(b).

% Compute the Gabor kernel and its real and imaginary parts.
gab = w .* s;
hr = w .* real(gab);
hi = w .* imag(gab);
subplot(2,2,3), imshow(hr);
subplot(2,2,4), imshow(hi);