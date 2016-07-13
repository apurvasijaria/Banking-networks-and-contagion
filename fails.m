function [ repaymentAll, Nsurvive] = fails( network_m,endCondition,dom_node,int_node,firm_node)

%.........................................................................
%  Assumptions- No price impact of asset firesales
%               No aggregate macroeconomic shocks to firms
%dom_node,int_node,firm_node= number of nodes for the institution
%.........................................................................

lending=sum(network_m,2);
borrowing=sum(network_m)';

assets = lending/f;
liquidAssets = fLambda*assets;
seniorliability = (leverage-1)/(leverage*f)*lending - borrowing;
liabilities = borrowing + seniorliability;

% the return on investment and junior debt are both calculated for a given
% shock S
actualROI = (R*S-1).*max(liabilities,borrowing);
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
netWorth = actualROI + liquidAssets - seniorliability + network_m*r*repayFrac - borrowing*r.*repayFrac;
Nsurvive = sum(netWorth>0|(lending==0&borrowing==0));
repaymentAll = repayFrac.*borrowing;

end