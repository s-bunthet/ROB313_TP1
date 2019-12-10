
% display the original images
img1 = double(imread('Amst-3.jpg'))/255;
f1 = figure;
figure(f1);
imagesc(img1)

img2 = double(imread('Amst-2.jpg'))/255;
f2 = figure;
figure(f2);
imagesc(img2)

% put the first image in bbox1
bbox1 = [-800 600 -50 450  ];
H1 = eye(3);
img_warped1 = vgg_warp_H(img1, H1, 'linear', bbox1);

%% display the first warped image
f3 = figure;
figure(f3);
imagesc(img_warped1)

% put the seconde image in bbox2

%% define Pt0 and PtD
% original points
X1 = [439.67 112.19 1];
X2 = [499.58 108.32 1];
X3 = [439.67 215.82 1];
X4 = [502 216.79 1];

% target points 
X1_prime = [60.638 111.22 1];
X2_prime = [122.85 113.15 1];
X3_prime = [58.534 211.79  1];
X4_prime = [127.46 213.72  1];

PtO = [X1' X2' X3' X4'];
PtD = [X1_prime' X2_prime' X3_prime' X4_prime'];
H2 = homography2d(PtO, PtD);
bbox2 = [-800 600 -50 450  ];
img_warped2 = vgg_warp_H(img2, H2, 'linear', bbox2);
%% display the first warped image
f4 = figure;
figure(f4);
imagesc(img_warped2)
% merge the two boxes 