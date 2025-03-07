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
  eval(['X_' num2str(kk) '_og = X_' num2str(kk) ';']); ## 3D coords
  printf("Based coords saved into x_%d_og and X_%d_og\n", kk, kk);
endfor

fileID = fopen("test_calibration_results.txt", "w");
for i = [1:n_mc_iter]
  printf("MonteCarlo iter [%d/%d]\n", i, n_mc_iter);

  printf("Setting Noise\n")
  mr = randn(length(x_kk),1);
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

endfor


