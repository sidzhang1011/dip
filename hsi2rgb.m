function rgb = hsi2rgb(hsi)
%HSI2RGB(HSI) converts an HSI image to RGB. 
%   RGB = HSI2RGB(HSI) converts an HSI image to RGB, where HSI is 
%   assumed of class double with:
%       HSI(:,:,1) = hue image normalized to the range [0, 1] by dividing
%                    all angle values by 2*pi.
%       HSI(:,:,2) = satureation image, in the range [0,1].
%       HSI(:,:,3) = intensity image, in the range [0, 1].
%
%   The component of the output image are:
%       RGB(:,:, 1) = red.
%       RGB(:,:, 2) = green.
%       RGb(:,:, 3) = blue.

% Extract the individual HSIcomponent images.
H = hsi(:, :, 1) * 2 * pi;
S = hsi(:, :, 2);
I = hsi(:, :, 3);

% Implement the conversion equations.
R = zeros(size(hsi, 1), size(hsi, 2));
G = zeros(size(hsi, 1), size(hsi, 2));
B = zeros(size(hsi, 1), size(hsi, 2));

% RG sector (0 <= H < 2*pi/3).
idx = find( (0 <= H) & (H < 2*pi/3) );
B(idx) = I(idx) .* (1 - S(idx));
R(idx) = I(idx) .* (1 + S(idx) .* cos(H(idx)) ./cos(pi/3 - H(idx)));
G(idx) = 3 * I(idx) - (R(idx) + B(idx));

% BG sector (2*pi/3 <= H < 4*pi/3).
idx = find( (2*pi/3 <= H) & (H < 4*pi/3) );
R(idx) = I(idx) .* (1 - S(idx));
G(idx) = I(idx) .* (1 + S(idx) .* cos(H(idx) - 2*pi/3) ...
    ./cos(pi - H(idx)));
B(idx) = 3 * I(idx) - (R(idx) + G(idx));

% BR sector (4*pi/3 <= H < 2*pi).
idx = find( (4*pi/3 <= H) & (H < 2*pi) );
G(idx) = I(idx) .* (1 - S(idx));
B(idx) = I(idx) .* (1 + S(idx) .* cos(H(idx) - 4*pi/3) ./cos(5*pi/3 - H(idx)));
R(idx) = 3 * I(idx) - (G(idx) + B(idx));

% Combine all three results into an RGB image. Clip to [0, 1] to compensate
% for floating-point arithmetic rounding effects.
rgb = cat(3, R, G, B);
rgb = max(min(rgb, 1), 0);
