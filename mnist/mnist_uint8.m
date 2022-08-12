%% Create database mnist_uint8 by the original file 

clc; close all; clear;

train_x_file = char('train-images-idx3-ubyte');
test_x_file = char('t10k-images-idx3-ubyte');
train_y_file = char('train-labels-idx1-ubyte');
test_y_file = char('t10k-labels-idx1-ubyte');

train_x = decodefile(train_x_file, 'image');
train_y = decodefile(train_y_file, 'label');
test_x = decodefile(test_x_file, 'image');
test_y = decodefile(test_y_file, 'label');

save('mnist_uint8.mat', 'train_x', 'train_y', 'test_x', 'test_y');

train_x_matrix = reshape(train_x, 28, 28, 60000);
train_x_matrix = permute(train_x_matrix, [2 1 3]);

test_x_matrix = reshape(test_x, 28, 28, 10000);
test_x_matrix = permute(test_x_matrix, [2 1 3]);



for m=1:5
    subplot(2,5,m), imshow(train_x_matrix(:,:,m));
    subplot(2,5,m+5), imshow(test_x_matrix(:,:,m));
end


