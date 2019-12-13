% read and show the original image
imrgb = double(imread('Pompei.jpg'))/255;
f1 = figure;
figure(f1);
imagesc(imrgb)

% original points 
X1 = [156 61  1];
X2 = [341 60  1];
X3 = [132 237 1];
X4 = [350 241 1];

% target points 
X1_prime = [169 60 1];
X2_prime = [350 60 1];
X3_prime = [169 241  1];
X4_prime = [350 241  1];
%These 4 points form a square inspired by the positions of the extremal
%points of the original image 

PtO = [X1' X2' X3' X4'];
PtD = [X1_prime' X2_prime' X3_prime' X4_prime'];

H = homography2d(PtO, PtD);
f2 = figure;
figure(f2);
imagesc(vgg_warp_H(imrgb, H))



