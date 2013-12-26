function x_norm = znorm1(x)
% Normalization of output of track before making the image
% We normalize the output to between 0 and 1 as below:
%           (v - v_min)
% v_norm = ---------------
%          (v_max - v_min)
% I just don't want to clutter my main script with these normalization
% calls each time.  20131225  -mcbaron

x_min = min(x);
x_max = max(x);
x_norm = (x - x_min)/(x_max-x_min);

end