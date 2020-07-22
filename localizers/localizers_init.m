clear all
% (Re)Initialize FieldTrip
addpath %insert path to FieldTrip here 
ft_defaults;

% lead-fields
load('PATH_TO_LEADFIELDS_HERE');

% data
load('PATH_TO_DATA_HERE');

% truncated data - first n trials only
n = 100;
y_Pre = data(1:240,:,1:n);
y_Pst = data(241:480,:,1:n);

% y_Pre = data(1:240,:,:);
% y_Pst = data(241:480,:,:);

%covariance matrices
N = cov(reshape(permute(y_Pre,[1 3 2]),[],size(y_Pre,2),1));
R = cov(reshape(permute(y_Pst,[1 3 2]),[],size(y_Pst,2),1));
