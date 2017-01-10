%Inclmplte though

function survival = fails(Sij,Tij,cij,dij,dom_node,int_node,firm_node,Bi,Di)
Nav=1000;
persistance V[Nav];
j=1;
i=1;
tot_node=dom_node+int_node+firm_node;
%Asset for ith bank is given by Ai = Xj?NDiSij+Xj?NIiSij+Xj?NFiSij+Xj?MFiTij+Bi,
SumSA=sum(Sij,2);
SumSL=sum(Sij);
SumT=sum(Tij,2);
A=sumSA+sumT+Bi;
%pi = (0,1);
pi=0.04; %to be changed
Ki=pi.*Ai;
alpha=0.5;
lambda=0.57;
phi=6.25*10^-5
Li=SumSL(1:dom_node+int_node)'+Ki+Di;


%Crisis dynamics and contagion



end