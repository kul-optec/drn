drn_path = fileparts(mfilename('fullpath'));
private_path = fullfile(drn_path, 'private');

to_compile = {
  fullfile(private_path, 'lbfgs.c'),
};

error_msg = 'Some dependency could not be compiled: ';
success_msg = 'Succesfully compiled: ';

for k = 1:length(to_compile)
  if mex('-outdir', private_path, to_compile{k})
    error([error_msg, to_compile{k}]);
  else
    disp([success_msg, to_compile{k}]);
  end
end

disp(['Adding DRN directory to MATLAB path: ', drn_path]);
addpath(drn_path);
savepath;

disp('DRN was succesfully configured and installed');
disp('Type ''help drn'' to access the help file');
clear drn_path private_path to_compile error_msg;
