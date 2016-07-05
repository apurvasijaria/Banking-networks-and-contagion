%this script is to plot the graph of emperical , maximum entropy
%ditribution and
%graph of log normal distribution (fig 4)
%with x axis as exposure and y axis as probablity
% for Domestic-Domestic,international-Domestic, Domestic-internation, and
% international-international banks

% dom_n=6;     %test data
% int_n=2;     %test data
% firm_n=3;     %test data
% no_network=1;   %test data

tot_n=dom_n+int_n+firm_n;
countries=20;
bnkdata=csvread(data.csv);
%-----------------------------------------------------------------------
%   tot_n= total no of nodes in the network
%   dom_n= total domestic bank nodes in the network
%   int_n=total international bank nodes in the network
%   firm_n= total firms nodes inthe network
%   countries= total countries whose international banks are considered (in this paper=20)
%   bnkdata= data extracted for loan lended and borrowed in the interbank network
%-----------------------------------------------------------------------
%initialising network and weigh
network=zeros(tot_n); %for the links of the interbank network
weigh=zeros(tot_n);  %for the exposure distribution in inter bank network
network= newnetwork(dom_n,int_n,firm_n,1); %create new network
weigh = ExposureDis(dom_n,int_n,firm_n,countries,bnkdata); 
%initialise the exposure ditribution
dist= network.*weigh; 
%-----------------------------------------------------------------------
%plot exposure on x axis and Probabilty on y axis 
%graph of emperical distribution
%graph of maximum entropy ditribution
%graph of log normal distribution
%-----------------------------------------------------------------------

% figure
%plot-empirical
% % cdfplot(bnkdata)
% % hold on
% % x = bnkdata;
% % f = evcdf(x,0,3);
% % plot(x,f,'m')
% % hold on
%plot-empirical
rng default  % for reproducibility
t=network;
x=weigh;
% Compute the empirical cdf and confidence bounds.
[f,x,flo,fup] = ecdf(t,'empirical',x);
% Plot the cdf and confidence bounds.
figure()
ecdf(t,x,'on');
hold on

%plot- maximum entropy
%need to link to md code
% hold on

% plot- log normal distribution
x = weigh;
mu=mean(weigh,tot_n);
sd=std2(weight);
y = lognpdf(x,log(mu),sd);
plot(x,y)