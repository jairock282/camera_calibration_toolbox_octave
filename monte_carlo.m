# ======================= MONTE CARLO =======================================
printf("Generating Samples with MonteCarlo\n");
while true
  n_mc_iter = input("How many MonteCarlo's iteration do you want to execute? => ");
  if (isnumeric(n_mc_iter) && mod(n_mc_iter, 1) == 0)
    break;
  endif

  printf("\nSet a valid number (integer)\n");

endwhile

printf("\nIterating %d times with MonteCarlo...\n", n_mc_iter);

if ~exist("active_images")
  printf("There are not active images. Please, run 'Extract grid corners' or load calibration file \n");
  return
endif

cnt_samples = length(active_images);
printf("\nCurrent active images => %d\n", cnt_samples);
for kk = [1:cnt_samples]
  if ~exist(['x_' num2str(kk)]) || ~exist(['X_' num2str(kk)])
    continue;
  endif

  ## Save base coords
  eval(['x_' num2str(kk) '_og = x_' num2str(kk) ';']); ## 2D coords
  ## Save len
  eval(['x_tmp = x_' num2str(kk) ';']);
  printf("Based coords saved into x_%d_og and X_%d_og\n", kk, kk);
endfor

fileID = fopen("test_calibration_results.txt", "w");

## Valores intrinsecos
fc_total = [];
cc_total = [];
kc_total = [];

## Valores extrinsicos
omc_x_total = [];
omc_y_total = [];
omc_z_total = [];

Tc_x_total = [];
Tc_y_total = [];
Tc_z_total = [];

for i = [1:n_mc_iter]
  printf("MonteCarlo iter [%d/%d]\n", i, n_mc_iter);

  printf("Setting Noise\n")
  mr = randn(length(x_tmp),1);
  noise = mr/std(mr);

  for kk = [1:cnt_samples]
    ## set x_kk
    eval(['x_kk = x_' num2str(kk) '_og;']); ## 2D coords

    ## Add noise in x_kk
    tmp_x_kk = x_kk;
    tmp_x_kk(1,:) = tmp_x_kk(1,:) + noise';
    tmp_x_kk(2,:) = tmp_x_kk(2,:) + noise';
    tmp_x_kk(isnan(tmp_x_kk)) = 0;

    ## Save new sample
    eval(['x_' num2str(kk) ' = tmp_x_kk;']); ## 2D coords
    printf("Noise added to sample x_%d \n", kk);

  endfor

  ## Calibration
  go_calib_optim;
  fileID = fopen("test_calibration_results.txt", "a");
  fprintf(fileID,'MonteCarlo Iteration: %d\n', i);
  fprintf(fileID,'Calibration results after optimization (with uncertainties):\n\n');
  fprintf(fileID,'Focal Length:          fc = [ %3.5f   %3.5f ] +/- [ %3.5f   %3.5f ]\n',[fc;fc_error]);
  fprintf(fileID,'Principal point:       cc = [ %3.5f   %3.5f ] +/- [ %3.5f   %3.5f ]\n',[cc;cc_error]);
  fprintf(fileID,'Skew:             alpha_c = [ %3.5f ] +/- [ %3.5f  ]   => angle of pixel axes = %3.5f +/- %3.5f degrees\n',[alpha_c;alpha_c_error],90 - atan(alpha_c)*180/pi,atan(alpha_c_error)*180/pi);
  fprintf(fileID,'Distortion:            kc = [ %3.5f   %3.5f   %3.5f   %3.5f  %5.5f ] +/- [ %3.5f   %3.5f   %3.5f   %3.5f  %5.5f ]\n',[kc;kc_error]);
  fprintf(fileID,'Pixel error:          err = [ %3.5f   %3.5f ]\n',err_std);
  fprintf(fileID,'==================================================================================\n\n\n');
  fclose(fileID);

  # TODO: Guardar valores por cada iteracion
  # Valores intrinsecos cada iteracion
    # fc = [ %3.5f   %3.5f ]
    # cc = [ %3.5f   %3.5f ]
    # kc = [ %3.5f   %3.5f   %3.5f   %3.5f  %5.5f ]
    fc_total = [fc_total; fc']; #n_iter x 2
    cc_total = [cc_total; cc']; #n_iter x 2
    kc_total = [kc_total; kc']; #n_iter x 5


  # Valores extrinsicos cada imagen, cada iteracion
    # omc_n = [ 2.17475 ; 0.607741 ; 0.621614 ];
    # Tc_n  = [ -569.175 ; -118.916 ; 1618.37 ];
    omc_x_samples = [];
    omc_y_samples = [];
    omc_z_samples = [];
    Tc_x_samples = [];
    Tc_y_samples = [];
    Tc_z_samples = [];
    for kk = [1:cnt_samples]
      eval(['omc_tmp = omc_' num2str(kk) ';']); ## omc_n
      eval(['Tc_tmp = Tc_' num2str(kk) ';']); ## omc_n

      omc_x_samples = [omc_x_samples, omc_tmp(1)];
      omc_y_samples = [omc_y_samples, omc_tmp(2)];
      omc_z_samples = [omc_z_samples, omc_tmp(3)];

      Tc_x_samples = [Tc_x_samples, Tc_tmp(1)];
      Tc_y_samples = [Tc_y_samples, Tc_tmp(2)];
      Tc_z_samples = [Tc_z_samples, Tc_tmp(2)];
    endfor

    omc_x_total = [omc_x_total; omc_x_samples]; # n_iter * n_samples
    omc_y_total = [omc_y_total; omc_y_samples]; # n_iter * n_samples
    omc_z_total = [omc_z_total; omc_z_samples]; # n_iter * n_samples

    Tc_x_total = [Tc_x_total; Tc_x_samples]; # n_iter * n_samples
    Tc_y_total = [Tc_y_total; Tc_y_samples]; # n_iter * n_samples
    Tc_z_total = [Tc_z_total; Tc_z_samples]; # n_iter * n_samples

endfor

# Compute Estimated values (avg from all iteration) and Uncertainty (std)
# Intrinsic Parameters
# Focal length
alpha_p_mean = mean(fc_total(:,1));
beta_p_mean = mean(fc_total(:,2));

alpha_p_std = std(fc_total(:,1));
beta_p_std = std(fc_total(:,2));

# Optical centre
u_p_mean = mean(cc_total(:,1));
v_p_mean = mean(cc_total(:,2));

u_p_std = std(cc_total(:,1));
v_p_std = std(cc_total(:,2));

# Radial distortion
k1_p_mean = mean(kc_total(:,1));
k2_p_mean = mean(kc_total(:,2));
k3_p_mean = mean(kc_total(:,3));
k4_p_mean = mean(kc_total(:,4));
k5_p_mean = mean(kc_total(:,5));

k1_p_std = std(kc_total(:,1));
k2_p_std = std(kc_total(:,2));
k3_p_std = std(kc_total(:,3));
k4_p_std = std(kc_total(:,4));
k5_p_std = std(kc_total(:,5));

# Extrinsic Parameters
rotation_p_mean = zeros(cnt_samples, 3); #n_samples * 3
rotation_p_std = zeros(cnt_samples, 3); #n_samples * 3
translation_p_mean = zeros(cnt_samples, 3); #n_samples * 3
translation_p_std = zeros(cnt_samples, 3); #n_samples * 3
for i = [1:cnt_samples]
  # Rotation (omc_kk) (x, y, z)
  rotation_p_mean(i,1) = mean(omc_x_total(:,i));
  rotation_p_mean(i,2) = mean(omc_y_total(:,i));
  rotation_p_mean(i,3) = mean(omc_z_total(:,i));

  rotation_p_std(i,1) = std(omc_x_total(:,i));
  rotation_p_std(i,2) = std(omc_y_total(:,i));
  rotation_p_std(i,3) = std(omc_z_total(:,i));

  # Translation (Tc_kk) (x, y, z)
  translation_p_mean(i,1) = mean(Tc_x_total(:,i));
  translation_p_mean(i,2) = mean(Tc_y_total(:,i));
  translation_p_mean(i,3) = mean(Tc_z_total(:,i));

  translation_p_std(i,1) = std(Tc_x_total(:,i));
  translation_p_std(i,2) = std(Tc_y_total(:,i));
  translation_p_std(i,3) = std(Tc_z_total(:,i));

endfor

# Save data
save("fc_total.mat", "fc_total");
save("cc_total.mat", "cc_total");
save("kc_total.mat", "kc_total");
save("omc_x_total.mat", "omc_x_total");
save("omc_y_total.mat", "omc_y_total");
save("omc_z_total.mat", "omc_z_total");
save("Tc_x_total.mat", "Tc_x_total");
save("Tc_y_total.mat", "Tc_y_total");
save("Tc_z_total.mat", "Tc_z_total");


% Print table header
fileID = fopen("intrinsic_extrinsic_results.txt", "w");
fprintf(fileID, "+--------------------------+-----------------------+------------------+\n");
fprintf(fileID, "| Intrinsic Parameters     | Estimated Values      | Uncertainty      |\n");
fprintf(fileID, "+--------------------------+-----------------------+------------------+\n");
fprintf(fileID, "|          α_p             | %10.4f            | %10.4f       |\n", alpha_p_mean, alpha_p_std);
fprintf(fileID, "+--------------------------+-----------------------+------------------+\n");
fprintf(fileID, "|          β_p             | %10.4f            | %10.4f       |\n", beta_p_mean, beta_p_std);
fprintf(fileID, "+--------------------------+-----------------------+------------------+\n");
fprintf(fileID, "|        u_0^p             | %10.4f            | %10.4f       |\n", u_p_mean, u_p_std);
fprintf(fileID, "+--------------------------+-----------------------+------------------+\n");
fprintf(fileID, "|        v_0^p             | %10.4f            | %10.4f       |\n", v_p_mean, v_p_std);
fprintf(fileID, "+--------------------------+-----------------------+------------------+\n");
fprintf(fileID, "|        k_1^p             | %10.4f            | %10.4f       |\n", k1_p_mean, k1_p_std);
fprintf(fileID, "+--------------------------+-----------------------+------------------+\n");
fprintf(fileID, "|        k_2^p             | %10.4f            | %10.4f       |\n", k2_p_mean, k2_p_std);
fprintf(fileID, "+--------------------------+-----------------------+------------------+\n");
fprintf(fileID, "|        k_3^p             | %10.4f            | %10.4f       |\n", k3_p_mean, k3_p_std);
fprintf(fileID, "+--------------------------+-----------------------+------------------+\n");
fprintf(fileID, "|        k_4^p             | %10.4f            | %10.4f       |\n", k4_p_mean, k4_p_std);
fprintf(fileID, "+--------------------------+-----------------------+------------------+\n");
fprintf(fileID, "|        k_5^p             | %10.4f            | %10.4f       |\n", k5_p_mean, k5_p_std);
fprintf(fileID, "+--------------------------+-----------------------+------------------+\n");
fprintf(fileID, "\n\n\n");
fprintf(fileID, "+--------------------+-----------------------+-----------------------+------------------+\n");
fprintf(fileID, "|                                Extrinsic Parameters: Rotation                         |\n");
fprintf(fileID, "+--------------------+-----------------------+-----------------------+------------------+\n");
fprintf(fileID, "|        Image       |         Coords        | Estimated Values      | Uncertainty      |\n");
fprintf(fileID, "+--------------------+-----------------------+-----------------------+------------------+\n");
for i = [1:cnt_samples]

  fprintf(fileID, "|                    |          x            | %10.4f            | %10.4f       |\n", rotation_p_mean(i,1), rotation_p_std(i,1));
  fprintf(fileID, "|                    |-----------------------+-----------------------+------------------+\n");

  if i < 10
    fprintf(fileID, "|         %d          |          y            | %10.4f            | %10.4f       |\n", i, rotation_p_mean(i,2), rotation_p_std(i,3));
  endif

  if i >= 10
    fprintf(fileID, "|         %d         |          y            | %10.4f            | %10.4f       |\n", i,rotation_p_mean(i,2), rotation_p_std(i,2));
  endif

  fprintf(fileID, "|                    |-----------------------+-----------------------+------------------+\n");
  fprintf(fileID, "|                    |          z            | %10.4f            | %10.4f       |\n", rotation_p_mean(i,3), rotation_p_std(i,3));
  fprintf(fileID, "+--------------------+-----------------------+-----------------------+------------------+\n");

endfor
fprintf(fileID, "\n\n\n");
fprintf(fileID, "+--------------------+-----------------------+-----------------------+------------------+\n");
fprintf(fileID, "|                             Extrinsic Parameters: Translation                         |\n");
fprintf(fileID, "+--------------------+-----------------------+-----------------------+------------------+\n");
fprintf(fileID, "|        Image       |         Coords        | Estimated Values      | Uncertainty      |\n");
fprintf(fileID, "+--------------------+-----------------------+-----------------------+------------------+\n");
for i = [1:cnt_samples]

  fprintf(fileID, "|                    |          x            | %10.4f            | %10.4f       |\n", translation_p_mean(i,1), translation_p_std(i,1));
  fprintf(fileID, "|                    |-----------------------+-----------------------+------------------+\n");

  if i < 10
    fprintf(fileID, "|         %d          |          y            | %10.4f            | %10.4f       |\n", i, translation_p_mean(i,2), translation_p_std(i,3));
  endif

  if i >= 10
    fprintf(fileID, "|         %d         |          y            | %10.4f            | %10.4f       |\n", i, translation_p_mean(i,2), translation_p_std(i,2));
  endif

  fprintf(fileID, "|                    |-----------------------+-----------------------+------------------+\n");
  fprintf(fileID, "|                    |          z            | %10.4f            | %10.4f       |\n", translation_p_mean(i,3), translation_p_std(i,3));
  fprintf(fileID, "+--------------------+-----------------------+-----------------------+------------------+\n");

endfor
fclose(fileID);

printf("\nDONE\n")
