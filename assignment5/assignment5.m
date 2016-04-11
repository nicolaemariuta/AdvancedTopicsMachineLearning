%% Policy iteration algorithm
state = [1,2,3,4,5,6,7,8,9,10,11,12];   % set of states
action = [1,2,3,4];                     % set of actions  1->up 2->down 3->left 4->right
V = zeros(length(state),length(action));% initial V could be arbitrary
Vprev = V;
gamma = 0.9;                            % discount factor
epsilon = 0.0001;                         % threshold for stopping the algorithm

reward = [-1 -1 -1 -1 ; ...   % room 1
          -1 -5 -1 -1 ; ...   % room 2
          -1 -1 -1 -1 ; ...   % room 3
          -1 -10 -1 -5 ; ...  % room 4
          -1 -1 -1 -1 ; ...   % room 5
          -1 -5 -5 -1 ; ...   % room 6
          -1 -1 -1 -1 ; ...   % room 7
          -5 -1 -10 -5 ; ...  % room 8
          -1 0 -1 -1 ; ...    % room 9
          -10 -1 -1 -1 ; ...  % room 10
          -1 -1 -1 0 ; ...    % room 11
          -5 -1 -1 -1 ; ...   % room 12
          ] ;
      
transition = [1 4 1 2 ; ...   % room 1
              2 5 1 3 ; ...   % room 2
              3 6 2 3 ; ...   % room 3
              1 7 4 4 ; ...  % room 4
              2 8 5 5 ; ...   % room 5
              3 9 6 6 ; ...   % room 6
              4 10 7 8 ; ...   % room 7
              5 11 7 9 ; ...  % room 8
              6 9 8 9 ; ...    % room 9
              7 10 10 10 ; ...  % room 10
              8 11 11 12 ; ...    % room 11
              12 12 11 12 ; ...   % room 12
              ] ;
      

%the until loop
for r = 1:100
    delta = 0;   
    %for each state loop 
    for i = 1:length(state)
        %take all possible actions
        for j = 1:length(action)
            V(i,j) = reward(state(i),action(j)) + gamma*V(transition(state(i),action(j)),j);
        end 
    end 
    %check if stopping criterion is satisfied
    delta = abs(sum(sum(V - Vprev)));
    if delta < epsilon
        disp('Epsilon reached!');
        break;
    else
        Vprev = V;
    end
    
end 

disp(V);               %show the final V matrix
[C,I]=max(V,[],2);     % finding the max values
% show the results
disp('V(optimal):');
disp(C);
disp('Optimal Policy');
disp(I);

