% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 663.596707123670171 ; 666.534812631372006 ];

%-- Principal point:
cc = [ 308.363154973679798 ; 241.962050209941253 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.278465801989255 ; 0.336177220465136 ; 0.000777873017097 ; -0.000060745897979 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 1.610895098397810 ; 1.736367825458111 ];

%-- Principal point uncertainty:
cc_error = [ 3.172765675077287 ; 2.920870356087947 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.012889162106054 ; 0.053596199228788 ; 0.000731930483850 ; 0.000765850813299 ; 0.000000000000000 ];

%-- Image size:
nx = 640;
ny = 480;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 20;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 1.65296 ; 1.6439 ; -0.666142 ];
Tc_1  = [ -615.169 ; -275.284 ; 2863.21 ];
omc_error_1 = [ 0.00367297 ; 0.00477954 ; 0.00607877 ];
Tc_error_1  = [ 13.7442 ; 12.6857 ; 7.20444 ];

%-- Image #2:
omc_2 = [ 1.84502 ; 1.89228 ; -0.396339 ];
Tc_2  = [ -537.398 ; -527.164 ; 2547.75 ];
omc_error_2 = [ 0.00390125 ; 0.00480498 ; 0.00741577 ];
Tc_error_2  = [ 12.2994 ; 11.2858 ; 7.06179 ];

%-- Image #3:
omc_3 = [ 1.73871 ; 2.06865 ; -0.504897 ];
Tc_3  = [ -438.59 ; -577.806 ; 2607.96 ];
omc_error_3 = [ 0.00356842 ; 0.00508661 ; 0.00766563 ];
Tc_error_3  = [ 12.5781 ; 11.5492 ; 6.77573 ];

%-- Image #4:
omc_4 = [ 1.82594 ; 2.10815 ; -1.09471 ];
Tc_4  = [ -236.211 ; -512.293 ; 2617.38 ];
omc_error_4 = [ 0.00319136 ; 0.00521323 ; 0.00711294 ];
Tc_error_4  = [ 12.6374 ; 11.5136 ; 5.46959 ];

%-- Image #5:
omc_5 = [ 2.17475 ; 0.607741 ; 0.621614 ];
Tc_5  = [ -569.175 ; -118.916 ; 1618.37 ];
omc_error_5 = [ 0.00494564 ; 0.00301103 ; 0.00580373 ];
Tc_error_5  = [ 7.98943 ; 7.28846 ; 6.54343 ];

%-- Image #6:
omc_6 = [ -1.69813 ; -1.93171 ; -0.802028 ];
Tc_6  = [ -508.548 ; -263.092 ; 1495.98 ];
omc_error_6 = [ 0.00303438 ; 0.00487085 ; 0.00657637 ];
Tc_error_6  = [ 7.22639 ; 6.788 ; 5.71948 ];

%-- Image #7:
omc_7 = [ 1.98979 ; 1.93108 ; 1.317 ];
Tc_7  = [ -289.372 ; -257.457 ; 1489 ];
omc_error_7 = [ 0.005738 ; 0.00295142 ; 0.00687727 ];
Tc_error_7  = [ 7.30823 ; 6.67512 ; 6.04425 ];

%-- Image #8:
omc_8 = [ 1.95639 ; 1.82442 ; 1.32986 ];
Tc_8  = [ -582.841 ; -343.879 ; 1565.01 ];
omc_error_8 = [ 0.00543277 ; 0.00299479 ; 0.00656098 ];
Tc_error_8  = [ 8.04109 ; 7.27174 ; 6.80133 ];

%-- Image #9:
omc_9 = [ -1.36996 ; -1.99058 ; 0.31285 ];
Tc_9  = [ -26.0084 ; -748.162 ; 2456.21 ];
omc_error_9 = [ 0.00373766 ; 0.00479049 ; 0.00624211 ];
Tc_error_9  = [ 11.9235 ; 10.8429 ; 6.93694 ];

%-- Image #10:
omc_10 = [ -1.53874 ; -2.11125 ; 0.193786 ];
Tc_10  = [ -123.605 ; -994.524 ; 2908.3 ];
omc_error_10 = [ 0.00466809 ; 0.00555536 ; 0.00857687 ];
Tc_error_10  = [ 14.3703 ; 12.917 ; 9.2294 ];

%-- Image #11:
omc_11 = [ -1.79161 ; -2.06642 ; -0.493177 ];
Tc_11  = [ -523.067 ; -779.348 ; 2366.67 ];
omc_error_11 = [ 0.00409188 ; 0.00513708 ; 0.00884295 ];
Tc_error_11  = [ 11.7074 ; 11.0081 ; 9.06911 ];

%-- Image #12:
omc_12 = [ -1.83668 ; -2.08846 ; -0.528615 ];
Tc_12  = [ -461.64 ; -586.715 ; 2031.75 ];
omc_error_12 = [ 0.00351546 ; 0.00497136 ; 0.00820079 ];
Tc_error_12  = [ 9.96686 ; 9.29654 ; 7.58953 ];

%-- Image #13:
omc_13 = [ -1.91565 ; -2.11703 ; -0.606606 ];
Tc_13  = [ -457.399 ; -475.189 ; 1830.93 ];
omc_error_13 = [ 0.00329793 ; 0.00493385 ; 0.00806322 ];
Tc_error_13  = [ 8.95423 ; 8.32606 ; 6.89846 ];

%-- Image #14:
omc_14 = [ -1.95141 ; -2.12538 ; -0.597045 ];
Tc_14  = [ -425.558 ; -454.183 ; 1650.8 ];
omc_error_14 = [ 0.00309554 ; 0.00481346 ; 0.00787445 ];
Tc_error_14  = [ 8.08928 ; 7.50608 ; 6.19572 ];

%-- Image #15:
omc_15 = [ -2.10909 ; -2.2552 ; -0.487173 ];
Tc_15  = [ -678.332 ; -448.699 ; 1621.34 ];
omc_error_15 = [ 0.00356881 ; 0.0044307 ; 0.00854342 ];
Tc_error_15  = [ 8.10388 ; 7.54921 ; 6.62429 ];

%-- Image #16:
omc_16 = [ 1.88548 ; 2.33142 ; -0.15288 ];
Tc_16  = [ -71.9994 ; -566.251 ; 2343.13 ];
omc_error_16 = [ 0.00482279 ; 0.00509633 ; 0.0102261 ];
Tc_error_16  = [ 11.2927 ; 10.2784 ; 7.91452 ];

%-- Image #17:
omc_17 = [ -1.61296 ; -1.95809 ; -0.360861 ];
Tc_17  = [ -464.193 ; -460.244 ; 1645.97 ];
omc_error_17 = [ 0.00304302 ; 0.00462944 ; 0.00653126 ];
Tc_error_17  = [ 7.97705 ; 7.43981 ; 5.52832 ];

%-- Image #18:
omc_18 = [ -1.34493 ; -1.7088 ; -0.312204 ];
Tc_18  = [ -625.608 ; -521.25 ; 1497.91 ];
omc_error_18 = [ 0.00344365 ; 0.00451693 ; 0.00516844 ];
Tc_error_18  = [ 7.32004 ; 6.85149 ; 5.31654 ];

%-- Image #19:
omc_19 = [ -1.9211 ; -1.84114 ; -1.44751 ];
Tc_19  = [ -366.015 ; -263.683 ; 1131.39 ];
omc_error_19 = [ 0.0030037 ; 0.00523966 ; 0.00660768 ];
Tc_error_19  = [ 5.68247 ; 5.22775 ; 5.03509 ];

%-- Image #20:
omc_20 = [ 1.88992 ; 1.59248 ; 1.47502 ];
Tc_20  = [ -493.218 ; -292.61 ; 1343.2 ];
omc_error_20 = [ 0.00550572 ; 0.00306022 ; 0.00593245 ];
Tc_error_20  = [ 6.97899 ; 6.2296 ; 6.08066 ];

