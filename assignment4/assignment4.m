%% My algorithm
clear;
%set the bias for generating the values of variables
%bias = 0.25;
%bias = 0.375;
bias = 0.4375;

%keep losses of the extperts
l1 = [];
l0 = [];
lalg = [];

%the regret
R = [];

P = [];
X = [];

for t = 1:10000
    
    %calculate the value of p according to the loss of the best expert
    if(sum(l0) < sum(l1))
        p = 0;
    else
        p = 1;
    end 
    P = [P p];
    
    %generate next variable X
    r = rand;
    if r<bias
        x = 1;
    else 
        x = 0;
    end 
    X = [X x];
    
    %calculate the loss
    lalg = [lalg abs(p-x)];
    l1 = [l1 abs(1-x)];
    l0 = [l0 abs(0-x)];   
    
    R = [R sum(lalg) - min(sum(l1),sum(l0))];
 end         
    
    
figure;
hold on;
plot(1:10000,R,'k');
hold off;
 



%% Hedge algorithm from class
clear;
%set the bias for generating the values of variables
%bias = 0.25;
%bias = 0.375;
bias = 0.4375;

%we have 2 experts
N = 2;
%the initial value of L0(a)
Lt = 0;
%the sum used to calculate pta
sumLt = 1;

%keep losses of the extperts
l1 = [];
l0 = [];
lalg = [];

%the regret
R = [];

for t = 1:10000
    %calculate pt(a)
    etta = sqrt(2*log(N)/t);
    pta = exp(-etta*Lt)/sumLt;
    
    %sample pta:
    r = rand;
    if r<pta
        p = 1;
    else 
        p = 0;
    end 
    %generate next variable X
    if r<bias
        x = 1;
    else 
        x = 0;
    end 
    
    %calculate the loss
    lalg = [lalg abs(p-x)];
    l1 = [l1 abs(1-x)];
    l0 = [l0 abs(0-x)];
    
    %find expert with lowest error
    lta = min(l1(t),l0(t));
    Lt = Lt + lta;
    
    sumLt = sumLt +  exp(-etta*(lalg(t))); 
    
    R = [R sum(lalg) - min(sum(l1),sum(l0))];
    
end 


hold on;
plot(1:10000,R,'r');
hold off;

%% Hedge algorithm reparametrized
clear;
%set the bias for generating the values of variables
%bias = 0.25;
%bias = 0.375;
bias = 0.4375;

%we have 2 experts
N = 2;
%the initial value of L0(a)
Lt = 0;
%the sum used to calculate pta
sumLt = 1;

%keep losses of the extperts
l1 = [];
l0 = [];
lalg = [];

%the regret
R = [];

for t = 1:10000
    %calculate pt(a)
    etta = sqrt(8*log(N)/t);
    pta = exp(-etta*Lt)/sumLt;
    
    %sample pta:
    r = rand;
    if r<pta
        p = 1;
    else 
        p = 0;
    end 
    %generate next variable X
    if r<bias
        x = 1;
    else 
        x = 0;
    end 
    
    %calculate the loss
    lalg = [lalg abs(p-x)];
    l1 = [l1 abs(1-x)];
    l0 = [l0 abs(0-x)];
    
    %find expert with lowest error
    lta = min(l1(t),l0(t));
    Lt = Lt + lta;
    
    sumLt = sumLt +  exp(-etta*(lalg(t))); 
    
    R = [R sum(lalg) - min(sum(l1),sum(l0))];
    
end 

hold on;
plot(1:10000,R,'b');
hold off;

%% Hedge algorithm anytime corresponding to simple analysis
clear;
%set the bias for generating the values of variables
%bias = 0.25;
%bias = 0.375;
bias = 0.4375;

%we have 2 experts
N = 2;
%the initial value of L0(a)
Lt = 0;
%the sum used to calculate pta
sumLt = 1;

%keep losses of the extperts
l1 = [];
l0 = [];
lalg = [];

%the regret
R = [];

for t = 1:10000
    %calculate pt(a)
    etta = sqrt(log(N)/t);
    pta = exp(-etta*Lt)/sumLt;
    
    %sample pta:
    r = rand;
    if r<pta
        p = 1;
    else 
        p = 0;
    end 
    %generate next variable X
    if r<bias
        x = 1;
    else 
        x = 0;
    end 
    
    %calculate the loss
    lalg = [lalg abs(p-x)];
    l1 = [l1 abs(1-x)];
    l0 = [l0 abs(0-x)];
    
    %find expert with lowest error
    lta = min(l1(t),l0(t));
    Lt = Lt + lta;
    
    sumLt = sumLt +  exp(-etta*(lalg(t))); 
    
    R = [R sum(lalg) - min(sum(l1),sum(l0))];
    
end 

hold on;
plot(1:10000,R,'g');
hold off;




%% Hedge algorithm anytime corresponding to tighter analysis
clear;
%set the bias for generating the values of variables
%bias = 0.25;
%bias = 0.375;
bias = 0.4375;

%we have 2 experts
N = 2;
%the initial value of L0(a)
Lt = 0;
%the sum used to calculate pta
sumLt = 1;

%keep losses of the extperts
l1 = [];
l0 = [];
lalg = [];

%the regret
R = [];

for t = 1:10000
    %calculate pt(a)
    etta = 2*sqrt(8*log(N)/t);
    pta = exp(-etta*Lt)/sumLt;
    
    %sample pta:
    r = rand;
    if r<pta
        p = 1;
    else 
        p = 0;
    end 
    %generate next variable X
    if r<bias
        x = 1;
    else 
        x = 0;
    end 
    
    %calculate the loss
    lalg = [lalg abs(p-x)];
    l1 = [l1 abs(1-x)];
    l0 = [l0 abs(0-x)];
    
    %find expert with lowest error
    lta = min(l1(t),l0(t));
    Lt = Lt + lta;
    
    sumLt = sumLt +  exp(-etta*(lalg(t))); 
    
    R = [R sum(lalg) - min(sum(l1),sum(l0))];
    
end 

hold on;
plot(1:10000,R,'y'),legend('My algorithm','Hedge normmal','Hedge reparametrized','Hedge anytime simple analysis','Hedge anytime tighter analysis');
hold off;

