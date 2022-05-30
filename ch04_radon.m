clc; clear all; close all;

g1 = zeros(600, 600);
g1(100:500, 250:350) = 1;
g2 = phantom('Modified Shepp-Logan', 600);

theta = 0:0.5:179.5;
[R1, xp1] = radon(g1, theta);
[R2, xp2] = radon(g2, theta);

% R1 = flipud(R1');
% R2 = flipud(R2');



subplot(3,2,1); imshow(g1, []); title('square image');
subplot(3,2,2); imshow(g2, []); title('Modifed Shepp-Logan');
subplot(3,2,3); imshow(R1, [], 'XData', xp1([1 end]), 'YData', [179.5 0]), axis xy, axis on, xlabel('\rho'), ylabel('\theta');
subplot(3,2,4); imshow(R2, [], 'XData', xp2([1 end]), 'YData', [179.5 0]), axis xy, axis on, xlabel('\rho'), ylabel('\theta');

% not using filter
% f1 = iradon(R1, theta, 'none');
% f2 = iradon(R2, theta, 'none');
% subplot(3,2,5), imshow(f1, []), title('reconstructed with filter none');
% subplot(3,2,6), imshow(f2, []), title('reconstructed with filter none');

% default Ram-Lak filter
% f1_ram = iradon(R1, theta);
% f2_ram = iradon(R2, theta);
% subplot(3,2,5), imshow(f1_ram, []), title('reconstructed with filter ram');
% subplot(3,2,6), imshow(f2_ram, []), title('reconstructed with filter ram');

% Hamming
f1_hamm = iradon(R1, theta, 'Hamming');
f2_hamm = iradon(R2, theta, 'Hamming');
subplot(3,2,5), imshow(f1_hamm, []), title('reconstructed with filter Hamming');
subplot(3,2,6), imshow(f2_hamm, []), title('reconstructed with filter Hamming');
