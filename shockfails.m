
%individual bank data is unavailable


% dom_loan=loan holding on domestic banks on average (in mils);
% dom_eq=equity holding on domestic banks on average (in mils)
% int_loan=loan holding on international banks on average (in mils)
% int_eq=equity holding on international banks on average (in mils)
% 
% dom_int_loan=loan* from domestic banks to internatioanl banks
% dom_int_eq=equity* from domestic banks to internatioanl banks
% int_dom_loan=loan* from international banks to domestic banks
% int_dom_eq=equity* from international banks to domestic banks *data on
% average balance sheet size and contributions from loans and equities

dom_loan=100;
dom_eq=10;
int_loan=12;
int_eq=1.2;
dom_int_loan=3200;
dom_int_eq=4000;
int_dom_loan=3200;
int_dom_eq=4000;


%corporate default probabilities treat the default probability in
%investment (A) grade category
% as having a mean and standard deviation of hPDIGi = 8.65 × 10?5 and ?IG =
% 2* 10?5, respectively. The non-investment grade (BB) category has a mean
% and standard deviation of hPDNIGi = 6.3 × 10?3 and ?NIG = 6.1 × 10?4,
% respectively. The proportion of firms that are investment grade
% (speculative grade) within the system is 0.7 (0.3). We take the firm LGD
% to be 35%.
mu_ig=8.65e-5;
mu_nig=6.3e-3;
sigma_ig=2e-5;
sigma_nig=6.1e-4;
prop_firm=0.7;
lgd=0.35;

% other parameters leverage=Ratio of capital to assets (leverage ratio)
% firesales=Trigger rule for firesales; trigger level of 50 amounts to
% setting the parameter = 0.5 lambda=Liquidity discount parameter,we adopt
% a value for lambda consistent with a more significant price impact.
% psi=Macroeconomic feedback parameter, phi=we (somewhat arbitrarily) set 
% = 6.25 × 10?5 as a working hypothesis.


leverage=0.04;
firesales=0.5;
lambda=0.57;
psi=0.2/((dom_int_loan+int_dom_loan)/2);
phi=6.25e-5;

% Things to change about the system
%   Navg = number of network iterations to average over
%   isWeighted = are the weights uniform(0), random(1), or skew(2)
%   networkType = 'scalefree','random','complete','ring'
%   alphaAll = parameter to change, based on networkType
%   Nshocks = number of simultaneous shocks

Navg = 1000;
isWeighted = 1;
networkType = 'random';
alphaAll = fliplr([.01:.01:.99]);  % for random
Nshocks = 1;

%% the code is yet to be updated.


