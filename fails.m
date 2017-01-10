%Inclmplte though

function survival = fails(Sij,Tij,cij,dij,dom_node,int_node,firm_node,Bi,Di)
j=1;
i=1;
tot_node=dom_node+int_node+firm_node;
%Asset for ith bank is given by Ai = Xj?NDiSij+Xj?NIiSij+Xj?NFiSij+Xj?MFiTij+Bi,
SDD=Sij(1:dom_node,1:dom_node);
SDI=Sij(1:dom_node,dom_node+1:int_node);
SDF=Sij(1:dom_node,int_node+dom_node+1:tot_node);
SID=Sij(dom_node+1:int_node,1:dom_node);
SII=Sij(dom_node+1:int_node,dom_node+1:int_node);
SIF=Sij(dom_node+1:int_node,int_node+dom_node+1:tot_node);
SFD=Sij(dom_node+1:int_node,1:dom_node);
SFI=Sij(dom_node+1:int_node,dom_node+1:int_node);
SFF=Sij(dom_node+1:int_node,int_node+dom_node+1:tot_node);


TDD=Tij(1:dom_node,1:dom_node);
TDI=Tij(1:dom_node,dom_node+1:int_node);
TDF=Tij(1:dom_node,int_node+dom_node+1:tot_node);
TID=Tij(dom_node+1:int_node,1:dom_node);
TII=Tij(dom_node+1:int_node,dom_node+1:int_node);
TIF=Tij(dom_node+1:int_node,int_node+dom_node+1:tot_node);
TFD=Tij(dom_node+1:int_node,1:dom_node);
TFI=Tij(dom_node+1:int_node,dom_node+1:int_node);
TFF=Tij(dom_node+1:int_node,int_node+dom_node+1:tot_node);

Adom=sum(SDD,2)+sum(SDI,2)+sum(SDF,2)+sum(TDF,2)+Bi(1:dom_node);
Aint=sum(SID,2)+sum(SII,2)+sum(SIF,2)+sum(TIF,2)+Bi(dom_node+1:int_node);
Afirm=sum(SFD,2)+sum(SFI,2)+sum(SFF,2)+sum(TDF,2)+Bi(1+dom_node+int_node:tot_node);
Ai=vertcat(Adom,Aint,Afirm);
S=sum(Sij);
%pi = (0,1);
pi=0.04; %to be changed
Ki=pi.*Ai;
alpha=0.5;
lambda=0.57;
phi=6.25*10^-5
Li=S(1:dom_node+int_node)'+Ki+Di;


%Crisis dynamics and contagion



end