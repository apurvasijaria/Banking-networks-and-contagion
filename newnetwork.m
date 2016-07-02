%function [NetworkSys] = newnetwork(dom_node, int_node,firm_node,no_network)

dom_node=6;     %test data
int_node=2;     %test data
firm_node=3;     %test data
no_network=1;   %test data


    % dom_node=no of domestic bank nodes
    % int_node= no of international bank nodes
    % firm_node=no of firm node
    % tot_node= total no of nodes including domestic, internation, and firm

tot_node= dom_node+int_node+firm_node;
networkSys = zeros(tot_node,tot_node,no_network);



    weights = rand(tot_node);


% for creatinf domestic bank network; complete form of network

% %  for i = 1:no_network
% %             network = weights(1:dom_node,1:dom_node).*(1-eye(dom_node));
% %         
% %  end
% %   networkSys(1:dom_node,1:dom_node)=network; 
  Q=dom_node;
 % for creating international node links
 %Since international and domestic banks are link are unidirectional nodes
 %represented as (dom_node+1,:) will be zero to have no link from
 %international bank to domestic banks forming a scale free network
 for j = 1:no_network
            start = 1-eye(Q);
            network = zeros(dom_node,int_node);
            network(1:Q,1:Q) = start;
            if Q==1
                network(1:2,1:2) = 1-eye(2);
            end
            for i = Q+1:tot_node,
                %%% just using in degree for probabilities to minimize
                %%% differences in lending/borrowing amounts. ie, smaller
                %%% probability that the bank that lends a lot is not the
                %%% bank that borrows a lot
%                 pout = sum(network,2)/sum(sum(network));
                pin = sum(network)/sum(sum(network));
                cin = cumsum(pin);
%                 cout = cumsum(pout);
                r = rand(2,Q);
                for k = 1:Q
                    i1 = find(cin>r(1,k),1);
                    i2 = find(cin>r(2,k),1);
                    network(i2,i) = 1;
                    network(i,i1) = 1;
                end
            end
            networkSys(:,:,j) = network.*weights;
 networkSys(int_node+dom_node+1:end,1:dom_node)=0; %Nolink from internaltional banks and firms to domestic banks
 networkSys(dom_node+int_node+1:end,dom_node+int_node+1:end)=0; %no firm inter-lending
 
 end
 
 %Plotting the nodes using gplot
% k = 1:tot_node;
% coord=[cos((1:n).*(2*pi/n)),sin((1:n).*(2*pi/n))]; % points on a circle for nodes
% gplot(networkSys(:,:),coord,'-*')
% axis square
 
 
