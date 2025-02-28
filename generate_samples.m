printf("Generating Samples with MonteCarlo\n");

while true
  n_mc_samples = input("How many samples do you want to generate? => ");

  if isnumeric(n_mc_samples) && mod(n_mc_samples, 1) == 0
    break;
  endif

  printf("\nSet a valid number (integer)\n");

endwhile

printf("\nGenerating %d samples with MonteCarlo...\n", n_mc_samples)

if ~exist("active_images")
  printf("There are not active images. Please, run 'Extract grid corners' or load calibration file \n")
  return
endif

printf("\nCurrent active images => %d\n", length(active_images))

cnt_samples = length(active_images);

## Repeat until we get all the samples
while true
  if cnt_samples >= (length(active_images) + n_mc_samples)
    break;
  endif

  ##Select Random Sample
  kk = randi([1, length(active_images)]);
  if ~exist(['x_' num2str(kk)]) || ~exist(['X_' num2str(kk)])
    continue;
  endif

  eval(['x_kk = x_' num2str(kk) ';']); ## 2D coords
  eval(['X_kk = X_' num2str(kk) ';']); ## 3D coords

  sigma = randi([1, 10]);

  ## Get noise x
  mu_x = mean(x_kk(1,:));
  std_x = std(x_kk(1,:));
  noise_x = mu_x/std_x;

  ## Get noise y
  mu_y = mean(x_kk(2,:));
  std_y = std(x_kk(2,:));
  noise_y = mu_y/std_y;

  ## Get noise X
  mu_X = mean(X_kk(1,:));
  std_X = std(X_kk(1,:));
  noise_X = mu_X/std_X;

  ## Get noise Y
  mu_Y = mean(X_kk(2,:));
  std_Y = std(X_kk(2,:));
  noise_Y = mu_Y/std_Y;

  ## Get noise Z
  mu_Z = mean(X_kk(3,:));
  std_Z = std(X_kk(3,:));
  noise_Z = mu_Z/std_Z;
  noise_Z(isnan(noise_Z)) = 0;

  ## Add noise in x_kk
  tmp_x_kk = x_kk;
  tmp_x_kk(1,:) = tmp_x_kk(1,:) + noise_x'*sigma;
  tmp_x_kk(2,:) = tmp_x_kk(2,:) + noise_y'*sigma;
  tmp_x_kk(isnan(tmp_x_kk)) = 0;

  ## Add noise in X_KK
  tmp_X_kk = X_kk;
  tmp_X_kk(1,:) = tmp_X_kk(1,:) + noise_X'*sigma;
  tmp_X_kk(2,:) = tmp_X_kk(2,:) + noise_Y'*sigma;
  tmp_X_kk(3,:) = tmp_X_kk(3,:) + noise_Z'*sigma;
  tmp_X_kk(isnan(tmp_X_kk)) = 0;

  ## Save new sample
  cnt_samples += 1;
  eval(['x_' num2str(cnt_samples) ' = tmp_x_kk;']); ## 2D coords
  eval(['X_' num2str(cnt_samples) ' = tmp_X_kk;']); ## 3D coords
  printf("Generating sample x_%d and X_%d \n", cnt_samples, cnt_samples);

endwhile

##Update active images
active_images = ones(1, cnt_samples);
n_ima = length(active_images);
printf("\Final active images => %d\n", length(active_images));

