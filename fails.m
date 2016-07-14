function [ repaymentAll, Nsurvive] = fails( network_m,S,endCondition,dom_node,int_node,firm_node)

%.........................................................................
%  Assumptions- No price impact of asset firesales
%               No aggregate macroeconomic shocks to firms
%dom_node,int_node,firm_node= number of nodes for the institution
%.........................................................................

%------------------------------------------------------------------------%
% domdom_network= network of interbank lending for domestic bank
% intint_network= network of interbank lending for international bank
% intdom_network= network of interbank lending for domestic to international bank
% domint_network= network of interbank lending for international to domestic bank
% domfirm_network= network of lending for domestic banks to firms
% intfirm_network= network of lending for international bank to firms
%------------------------------------------------------------------------%
% domdom_network= network_m(1:dom_node,1:dom_node);
% intint_network= network_m(dom_node+1:dom_node+int_node,dom_node+1:dom_node+int_node);
% intdom_network= network_m(1:dom_node,dom_node+1:dom_node+int_node);
% domint_network= network_m(dom_node+1:dom_node+int_node,1:dom_node);
% domfirm_network= network_m(dom_node+int_node+1:end,1:dom_node);
% intfirm_network= network_m(dom_node+int_node+1:end,dom_node+1:dom_node+int_node);
% 
% 
% domdom_lending = sum(domdom_network,2);
% domdom_borrowing = sum(domdom_network)';
% intint_lending = sum(intint_network,2);
% intint_borrowing = sum(intint_network)';
% intdom_lending = sum(intdom_network,2);
% intdom_borrowing = sum(intdom_network)';
% domint_lending = sum(domint_network,2);
% domint_borrowing = sum(domint_network)';
% domfirm_lending = sum(domfirm_network,2);
% domfirm_borrowing = sum(domfirm_network)';
% intfirm_lending = sum(intfirm_network,2);
% intfirm_borrowing = sum(intfirm_network)';
lending=sum(network_m,2);
borrowing=sum(network_m)';
% 
% dom_lend=domdom_lending+intdom_lending;
% int_lend=intint_lending+domint_lending;
% dom_bor=domdom_borrowing+domint_borrowing;
% int_bor=intint_borrowing+intdom_borrowing;

%------------------------------------
% lending= interbank assests (10%)
% loan to firms=80%
% equities=10%
%-----------------------------------
%------------------------------------------------------------------------%
% Parameters of the system, can change if you want
%   R = investment interest rate
%   r = interbank interest rate
%   f = asset fraction that is interbank loans
%   flambda = asset fraction that is liquid assets (assume no illiquid)
%   leverage = leverage of the bank = assets/capital
%   shockSize = shock size, currently only looking at full shock
%   endCondition = point at which deem fixed point is reached
%   kstar = critical degree
%------------------------------------------------------------------------%

f=0.9;
fLambda=1-f;
assets = lending/f;
liquidAssets = fLambda*assets;
liabilities = borrowing;
R=1.05;
r=1.04;
% the return on investment and junior debt are both calculated for a given
% shock S
actualROI = (R*S-1).*(borrowing);
juniorDebt = r*borrowing;

%------------------------------------------------------------------------%
%   Calculation of the fixed point for repayments made
%   X1 and X2 are the current and previous repayment fractions, used to
%   determine when the end condition has been reached.
%------------------------------------------------------------------------%
%%% Assume that the repayment fraction is 1 initially
repayFrac = ones(size(lending));
X1 = repayFrac;
repayment = actualROI + liquidAssets + r*network_m*repayFrac;
repayFrac = max(min(repayment,juniorDebt),0)./(borrowing*r);
%%% if no borrowing is done, dividing by 0 above gives NAN, so it is here
%%% set to 1 to fix that problem
repayFrac(borrowing==0) = 1;
X2 = repayFrac;


%%% Repeat above calculations updating the repayment fraction until the end
%%% condition has been reached
while( max(abs(X1-X2)./X2) > endCondition )
    repayment = actualROI + liquidAssets+ r*network_m*repayFrac;
    repayFrac = max(min(repayment,juniorDebt),0)./(borrowing*r);
    repayFrac(borrowing==0) = 1;
    X1 = X2;
    X2 = repayFrac;
end

%------------------------------------------------------------------------%
% Calculate the number of surviving banks, as defined by those having a
% positive net worth after all collapsing banks have collapsed, or as not
% having lent or borrowed anything, (ie, not part of the network)
%------------------------------------------------------------------------%
netWorth = actualROI + liquidAssets  + network_m*r*repayFrac - borrowing*r.*repayFrac;
Nsurvive = sum(netWorth>0|(lending==0&borrowing==0));
repaymentAll = repayFrac.*borrowing;

end