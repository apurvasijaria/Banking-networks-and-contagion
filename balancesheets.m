% % Each agent is represented by a node on a directed graph and linked to each other
% % through their assets, liabilities, and equity holdings. Specifically, for an agent i, an
% % incoming link from agent j represents an asset – either loans or equities – on i’s
% % balance sheet. Let the value of loans and equities from agent ito j be Aij, Qij ? R+
% % respectively. Outgoing links represent an agent’s liabilities with value Lij ? R+.
% % Connections between agents of different types are formed randomly. The variables
% % cij, dij ? {0, 1} denote whether agent iholds a loan or equity assets against
% % agent j. Thus, we write
% % Aij = cijSij , (1) and Qij = dijTij ,
% % where Sij, Tij ? R+ are random variables that describe the extent of the exposure.
% % The statistics of our random variables are governed by the type of the lending
% % and borrowing agents, i.e., whether one or the other is a domestic or international
% % bank or a firm. We define ?DI(Sij) as the probability density function (PDF) of
% % loans from domestic bank, labeled i, to the international bank, labeled j. Similarly,
% % we can define the PDF ?IF(Tij) of equity holdings between the international bank i
% % and firm j. Considering all possible combinations of agent types, and hence lending
% % arrangements, the statistics for sizes of loan and equity holdingSis governed by 18
% % different probability distributions.
function [A,Q,L] = balancesheets (dom_node, int_node,firm_node,no_network)
tot_node= dom_node+int_node+firm_node;
A=zeros(tot_node);
Q=zeros(tot_node);
L=zeros(tot_node);
% Calls the function newnetwork for cij and dij
% For equity network
cij=newnetwork(dom_node, int_node,firm_node,no_network)
Sij=Exposure(dom_node, int_node,firm_node);
A=cij.*Sij;
% For Loans network
dij=newnetwork(dom_node, int_node,firm_node,no_network)
Tij=Exposure(dom_node, int_node,firm_node);
Q=dij.*Tij;
A
Q
% For liability network

