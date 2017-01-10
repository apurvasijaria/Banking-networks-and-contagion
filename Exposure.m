function [ex]=Exposure(dom_node,int_node,firm_node,x)

tot_node= dom_node+int_node+firm_node;
ex=zeros(tot_node);
for i=1:tot_node
for j=1:tot_node
ex(i,j) = ME1(tot_node);
j=j+i;
end
i=i+1;
end
end