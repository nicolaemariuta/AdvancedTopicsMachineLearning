%% Upper Confidence Bounds
clear;
%initialize with number of arms and the biases
k = 16;
optimalBias = 0.9;
biasdiff = 1/16;

armsEmpirical = squeeze(zeros(1,k));

armsPlayed = squeeze(zeros(1,k));

regret = [];

for t = 1:10000
    %generate random rewards for each arm with their biases
    randoms = squeeze(zeros(1,k));
    for i = 1:k
        %the first arm has optimal bias
        if i == 1
            r = rand;
            if(r < optimalBias)
                randoms(i) = 1;
            else 
                randoms(i) = 0;
            end 
        else
            r = rand;
            if(r < (optimalBias-biasdiff))
                randoms(i) = 1;
            else 
                randoms(i) = 0;
            end 
         end 
    end
    
    %calculate empirical reward for each 
    armsEmpirical = armsEmpirical + randoms;
    
    %generate arm to be played
    [value, At] = max(armsEmpirical/t + sqrt((3*log(t))./(2*armsPlayed)));
    armsPlayed(At) = armsPlayed(At)+1;
    
    %calculate regret at step t
    r = armsPlayed(At)*abs((armsEmpirical(1)/t) - (armsEmpirical(At)/t));
    regret = [regret r];
end

%plot of the regret
figure;
hold on;
plot(1:10000,regret,'r');
hold off;


%% EXP 3 implementation
clear;
%initialize with number of arms and the biases
k = 2;
optimalBias = 0.5;
biasdiff = 1/4;
%the initial value of L0(a)
Lt = squeeze(zeros(1,k));
%the sum used to calculate pta
sumLt = squeeze(zeros(1,k))+1;

armsEmpirical = squeeze(zeros(1,k));
armsPlayed = squeeze(zeros(1,k));

regret = [];


for t = 1:10
    %generate random rewards for each arm with their biases
    randoms = squeeze(zeros(1,k));
    for i = 1:k
        %the first arm has optimal bias
        if i == 1
            r = rand;
            if(r < optimalBias)
                randoms(i) = 1;
            else 
                randoms(i) = 0;
            end 
        else
            r = rand;
            if(r < (optimalBias-biasdiff))
                randoms(i) = 1;
            else 
                randoms(i) = 0;
            end 
         end 
    end
    
    %calculate pt(a)
    etta = sqrt(2*log(k)/t);
    pta = exp(-etta*Lt)./sumLt;
    
    %sample At:
    r = rand;
    if r < pta
        at = 1;
    else 
        at = 0;
    end 
    
    
    
    
    
%     %calculate empirical reward for each 
%     armsEmpirical = armsEmpirical + randoms;
%     
%     %generate arm to be played
%     [value, At] = max(armsEmpirical + sqrt((3*log(t))./(2*armsPlayed)));
%     armsPlayed(At) = armsPlayed(At)+1;
%     
%     %calculate regret at step t
%     r = armsPlayed(At)*abs((armsEmpirical(1)/t) - (armsEmpirical(At)/t));
%     regret = [regret r];
end


% hold on;
% plot(1:10000,regret,'b');
% hold off;


