% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 662.495256261291388 ; 664.677378668736765 ];

%-- Principal point:
cc = [ 306.512775479335630 ; 241.750852912723076 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.279075227889648 ; 0.320252961020875 ; 0.000504412905417 ; 0.000278180860933 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 1.434037830317650 ; 1.542648569557957 ];

%-- Principal point uncertainty:
cc_error = [ 2.834902583317828 ; 2.608342897385679 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.011437009090840 ; 0.047294701978641 ; 0.000643556247949 ; 0.000669426647646 ; 0.000000000000000 ];

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
omc_1 = [ 1.65309 ; 1.64618 ; -0.668099 ];
Tc_1  = [ -607.262 ; -274.638 ; 2860.01 ];
omc_error_1 = [ 0.00328884 ; 0.00427089 ; 0.00544263 ];
Tc_error_1  = [ 12.2839 ; 11.3436 ; 6.40616 ];

%-- Image #2:
omc_2 = [ 1.84581 ; 1.89459 ; -0.397258 ];
Tc_2  = [ -530.321 ; -526.818 ; 2543.71 ];
omc_error_2 = [ 0.00348908 ; 0.00428589 ; 0.00663737 ];
Tc_error_2  = [ 10.9867 ; 10.0853 ; 6.28622 ];

%-- Image #3:
omc_3 = [ 1.73943 ; 2.0711 ; -0.505741 ];
Tc_3  = [ -431.421 ; -577.497 ; 2603.77 ];
omc_error_3 = [ 0.00319246 ; 0.00453816 ; 0.00686193 ];
Tc_error_3  = [ 11.2347 ; 10.3208 ; 6.0336 ];

%-- Image #4:
omc_4 = [ 1.82623 ; 2.1103 ; -1.09772 ];
Tc_4  = [ -229.035 ; -511.904 ; 2614.25 ];
omc_error_4 = [ 0.00285825 ; 0.00466201 ; 0.00636852 ];
Tc_error_4  = [ 11.2932 ; 10.2949 ; 4.86788 ];

%-- Image #5:
omc_5 = [ 2.17584 ; 0.609479 ; 0.619769 ];
Tc_5  = [ -564.254 ; -118.44 ; 1614.41 ];
omc_error_5 = [ 0.0044209 ; 0.00269057 ; 0.00519534 ];
Tc_error_5  = [ 7.13108 ; 6.50738 ; 5.81686 ];

%-- Image #6:
omc_6 = [ -1.69961 ; -1.93116 ; -0.798327 ];
Tc_6  = [ -504.395 ; -262.824 ; 1494.15 ];
omc_error_6 = [ 0.00271031 ; 0.00435788 ; 0.00588941 ];
Tc_error_6  = [ 6.45678 ; 6.06893 ; 5.09536 ];

%-- Image #7:
omc_7 = [ 1.99186 ; 1.93144 ; 1.31418 ];
Tc_7  = [ -284.959 ; -257.04 ; 1484.65 ];
omc_error_7 = [ 0.00513316 ; 0.00263844 ; 0.00615895 ];
Tc_error_7  = [ 6.51703 ; 5.95872 ; 5.3782 ];

%-- Image #8:
omc_8 = [ 1.95814 ; 1.82483 ; 1.32769 ];
Tc_8  = [ -577.699 ; -343.313 ; 1559.8 ];
omc_error_8 = [ 0.00486278 ; 0.00267641 ; 0.00587536 ];
Tc_error_8  = [ 7.163 ; 6.48846 ; 6.05294 ];

%-- Image #9:
omc_9 = [ -1.36819 ; -1.98733 ; 0.316227 ];
Tc_9  = [ -19.1449 ; -747.421 ; 2451.5 ];
omc_error_9 = [ 0.00334283 ; 0.00428475 ; 0.00557169 ];
Tc_error_9  = [ 10.6472 ; 9.68804 ; 6.17323 ];

%-- Image #10:
omc_10 = [ -1.51848 ; -2.093 ; 0.182097 ];
Tc_10  = [ -114.521 ; -997.094 ; 2891.66 ];
omc_error_10 = [ 0.00408355 ; 0.00488394 ; 0.00745014 ];
Tc_error_10  = [ 12.7881 ; 11.5086 ; 8.20028 ];

%-- Image #11:
omc_11 = [ -1.79227 ; -2.06601 ; -0.488475 ];
Tc_11  = [ -516.409 ; -779.414 ; 2364.28 ];
omc_error_11 = [ 0.00366188 ; 0.00460081 ; 0.00791908 ];
Tc_error_11  = [ 10.4633 ; 9.84259 ; 8.08422 ];

%-- Image #12:
omc_12 = [ -1.83772 ; -2.08834 ; -0.524087 ];
Tc_12  = [ -455.924 ; -586.657 ; 2029.76 ];
omc_error_12 = [ 0.003143 ; 0.00444896 ; 0.00734155 ];
Tc_error_12  = [ 8.90809 ; 8.31378 ; 6.76626 ];

%-- Image #13:
omc_13 = [ -1.917 ; -2.1172 ; -0.602402 ];
Tc_13  = [ -452.207 ; -475.026 ; 1828.71 ];
omc_error_13 = [ 0.00294513 ; 0.00441338 ; 0.00721796 ];
Tc_error_13  = [ 8.00089 ; 7.44463 ; 6.1492 ];

%-- Image #14:
omc_14 = [ -1.95278 ; -2.12563 ; -0.592897 ];
Tc_14  = [ -420.851 ; -454.035 ; 1648.66 ];
omc_error_14 = [ 0.00276417 ; 0.00430635 ; 0.00704854 ];
Tc_error_14  = [ 7.22724 ; 6.71083 ; 5.52221 ];

%-- Image #15:
omc_15 = [ -2.11089 ; -2.2563 ; -0.485064 ];
Tc_15  = [ -673.263 ; -448.269 ; 1617.36 ];
omc_error_15 = [ 0.0031855 ; 0.00396992 ; 0.00764216 ];
Tc_error_15  = [ 7.22959 ; 6.74068 ; 5.90664 ];

%-- Image #16:
omc_16 = [ 1.88547 ; 2.33209 ; -0.154035 ];
Tc_16  = [ -65.6979 ; -565.483 ; 2337.13 ];
omc_error_16 = [ 0.00430471 ; 0.00453875 ; 0.00916425 ];
Tc_error_16  = [ 10.0801 ; 9.17878 ; 7.04558 ];

%-- Image #17:
omc_17 = [ -1.61339 ; -1.95691 ; -0.356379 ];
Tc_17  = [ -459.627 ; -460.082 ; 1644.78 ];
omc_error_17 = [ 0.00272339 ; 0.00414471 ; 0.00584359 ];
Tc_error_17  = [ 7.13197 ; 6.65368 ; 4.92148 ];

%-- Image #18:
omc_18 = [ -1.34491 ; -1.70674 ; -0.309076 ];
Tc_18  = [ -621.422 ; -521.078 ; 1496.08 ];
omc_error_18 = [ 0.00308368 ; 0.0040417 ; 0.00462495 ];
Tc_error_18  = [ 6.54188 ; 6.12352 ; 4.73656 ];

%-- Image #19:
omc_19 = [ -1.92353 ; -1.84021 ; -1.4424 ];
Tc_19  = [ -363.546 ; -263.65 ; 1131.25 ];
omc_error_19 = [ 0.0026815 ; 0.00468479 ; 0.00592176 ];
Tc_error_19  = [ 5.07996 ; 4.67869 ; 4.48988 ];

%-- Image #20:
omc_20 = [ 1.89244 ; 1.59346 ; 1.47274 ];
Tc_20  = [ -489.176 ; -292.167 ; 1339.68 ];
omc_error_20 = [ 0.00492816 ; 0.00273649 ; 0.00531604 ];
Tc_error_20  = [ 6.22078 ; 5.56263 ; 5.41381 ];

