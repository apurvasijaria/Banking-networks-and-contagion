 %----------------------------------
 %ME1
 % This script shows how to use the function ME_DENS1
 % in the case of the Gamma distribution. (see Example 1.)
 function [k]= ME1(tot_node)
 % define the x axis
 dx=0.01
 xmin=0.0001
 xmax=1
 x=[xmin:dx:xmax];
 mu=[0.3,-1.5]';
%  mu=[0.28]';% define the mu values
 [lambda,p,entr]=me_dens1(mu,x);
 k= max(p);
 alpha=-lambda(3); 
 beta=lambda(2);
 m=(1+alpha)/beta; 
 sigma=m/beta;
 disp([mu' alpha beta sigma m entr(length(entr))])
 end
 %----------------------------------
