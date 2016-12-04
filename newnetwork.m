 function [networkSys] = newnetwork(dom_node, int_node,firm_node,no_network)

% dom_node = number of domestic bank nodes
% int_node = number of international bank nodes
% firm_node = number of firm node
% tot_node = total number of nodes including domestic,international,and firm

tot_node= dom_node+int_node+firm_node;
networkSys = zeros(tot_node,tot_node,no_network);

% For probability of loan/euity or liabilty for international banks
beta=1; 
% mean degree for internatioanl bank network
meannodes=4; 
% Cij and Dij can be 0 or 1 only hence uniform weight
weights = 1;
% for creating domestic bank network; complete form of network

Q=dom_node;
% for creating international node links
% Since international and domestic banks are link are unidirectional nodes
% represented as (dom_node+1,:) will be zero to have no link from
% international bank to domestic banks forming a scale free network
for j = 1:no_network
    start = 1-eye(Q);
    network = zeros(dom_node,dom_node);
    network(1:Q,1:Q) = start;
    if Q==1
        network(1:2,1:2) = 1-eye(2);
    end
    for i = Q+1:tot_node,
        %%% just using in degree for probabilities to minimize
        %%% differences in lending/borrowing amounts. ie, smaller
        %%% probability that the bank that lends a lot is not the
        %%% bank that borrows a lot
        pin = sum(network)/sum(sum(network));
        cin = cumsum(pin);
        r = rand(2,Q);
        for k = 1:Q
            i1 = find(cin>r(1,k),1);
            i2 = find(cin>r(2,k),1);
            network(i2,i) = 1;
            network(i,i1) = 1;
        end 
    end
    networkSys(:,:,j) = network.*weights;
    networkSys(int_node+dom_node+1:end,1:end)=0;
    %Nolink from firms to domestic banks,internaltional banks and other firms
    %1st argument= no of international nodes, 2nd srgument= mean degree/2.
    %third argument for random graph
    networkSys(dom_node+1:dom_node+int_node,dom_node+1:dom_node+int_node)=small_world(int_node,meannodes,beta);
    %  Plotting the nodes using gplot
    % k = tot_node; coord=[cos((1:k).*(2*pi./k)),sin((1:k).*(2*pi./k))]; %
    % points on a circle for nodes gplot(networkSys(:,:),coord,'-*') axis
    % square
    
       
end




