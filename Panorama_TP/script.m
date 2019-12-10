
imrgb = double(imread('Pompei.jpg'))/255;
f1 = figure;
figure(f1);
imagesc(imrgb)

% original points
X1 = [124 27.253 1];
X2 = [387.37 25.307 1];
X3 = [77.66 290.08 1];
X4 = [414.18 298.34 1];

% target points 
X1_prime = [80 0 1];
X2_prime = [420 0 1];
X3_prime = [80 350  1];
X4_prime = [420 350  1];

PtO = [X1' X2' X3' X4'];
PtD = [X1_prime' X2_prime' X3_prime' X4_prime'];

H = homography2d(PtO, PtD);
f2 = figure;
figure(f2);
imagesc(vgg_warp_H(imrgb, H))