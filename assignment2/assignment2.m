%% Question 2 SVM training time in practice
clearvars();

%read and normalize data
[data_label, data_scale_inst] = libsvmread(fullfile('D:\master\Advanced Topics in Machine Learning\assignment2','a8a.t'));


%% Question 4 Comparison of Hoeffding's Inequality with kl inequality
clearvars();

%Hoeffding's Inequality for 1000 runs
uppperboundH = [];
n = 10000

for bias = 0:0.01:1
  p = bias + sqrt(log(1/0.01)/(2*n));
  uppperboundH = [uppperboundH p];
end 

%calculating the lower bounud
lowerboundH = [];

for bias = 0:0.01:1
  p = -bias - sqrt(log(1/0.01)/(2*n));
  lowerboundH = [lowerboundH p];
end 


%KL Inequality for 1000 runs
uppperboundKL = [];


for bias = 0:0.01:1
  p = bias + sqrt(log((n+1)/0.01)/(2*n));
  uppperboundKL = [uppperboundKL p];
end 

%calculating the lower bounud
lowerboundKL = [];

for bias = 0:0.01:1
  p = -bias - sqrt(log(1/0.01)/(2*n));
  lowerboundKL = [lowerboundKL p];
end 




plot(0:0.01:1,uppperboundH),plot(0:0.01:1,uppperboundKL),title('Hoeffdings and KL bound for n=10000');
figure;
plot(0:0.01:1,lowerboundH),plot(0:0.01:1,lowerboundKL),title('Hoeffdings and KL bound for n=10000');





%%
%Question 3 (binary classification) 
%linear method : SVM with non-linear kernel
clearvars();
fprintf('Question 3 - non-linear binary classifcation using SVM\n');
%read and normalize data
trainData = importdata('data/keystrokesTrainTwoClass.csv');
testData = importdata('data/keystrokesTestTwoClass.csv');

Means = mean(trainData(:,1:21), 1);
Stds = std(trainData(:,1:21), 1, 1);

normalizedTrainData = my_normalize(trainData, Means, Stds,1,21,22);
normalizedTestData = my_normalize(testData, Means, Stds,1,21,22);

%shuffle the train data so I get almost same number of patterns with label 1 and 0 into the model creation
%during cross validation for each split
normalizedShuffledTrainData= normalizedTrainData(randperm(size(normalizedTrainData,1)),:);


trainX = normalizedShuffledTrainData(:, 1:21);
testX  = normalizedTestData(:, 1:21);
trainY = normalizedShuffledTrainData(:, 22);
testY = normalizedTestData(:, 22);

%mean and standard deviation for test data to check the results of
%normalization with mean and std from train data
testMeansNorm = mean(normalizedTestData(:,1:21), 1);
testStdsNorm = std(normalizedTestData(:,1:21), 1, 1);


%regularization parameters
Cs = [0.01, 0.1, 1, 10, 100, 1000, 10000];
%kernel parameters
gammas = [0.0001, 0.001, 0.01, 0.1, 1, 10, 100];

%best C and gamma for non normalizaed data
blockDimensions = [128,128,128,128,128];
[bestCNorm, bestGammaNorm] = my_fiveFoldGaussianKernelCV(trainX, trainY, Cs, gammas,blockDimensions);

%train the model using the best C and gamma and gaussian kernel
kernel = @(x,y) my_kernel(x, y, bestGammaNorm);
model = svmtrain(trainX, trainY, ...
                'autoscale',false, ... 
                'boxconstraint',ones(size(trainX,1),1) * bestCNorm, ...
                'kernel_function',kernel);

%classify train and test data
trainPredYNorm = svmclassify(model,trainX);
testPredYNorm = svmclassify(model,testX);

trainAccuracyNorm = 1 - (nnz(trainPredYNorm - trainY)) / length(trainPredYNorm);
testAccuracyNorm = 1 - (nnz(testPredYNorm - testY)) / length(testPredYNorm);

fprintf('train accuracy:');
disp(trainAccuracyNorm);
fprintf('test accuracy:');
disp(testAccuracyNorm);

%calcualte sensitivity and specifity for train set

%count number of patterns correctly classified as belonging to positiv
%class for sensitivity and for specifity count the number of patterns
%correctly classified as belonging to negative class
sumTrainPredYNormTrainY = trainPredYNorm + trainY;
sensitiviyTrain = size(find(sumTrainPredYNormTrainY(:) == 2),1);
specifityTrain = size(find(sumTrainPredYNormTrainY(:) == 0),1);
%divide by number of positive or negative patterns in train and divide
%to obtain final value for specifity and sensitivity
nrPositiveTrain = size(find(trainY(:,1) == 1),1);
nrNegativeTrain = size(find(trainY(:,1) == 0),1);
sensitiviyTrain = sensitiviyTrain/nrPositiveTrain;
specifityTrain = specifityTrain/nrNegativeTrain;

fprintf('train sensitivity:');
disp(sensitiviyTrain);
fprintf('train specifity:');
disp(specifityTrain);


%calcualte sensitivity and specifity for test set

%count number of patterns correctly classified as belonging to positiv
%class for sensitivity and for specifity count the number of patterns
%correctly classified as belonging to negative class
sumTestPredYNormTestY = testPredYNorm + testY;
sensitiviyTest = size(find(sumTestPredYNormTestY(:) == 2),1);
specifityTest = size(find(sumTestPredYNormTestY(:) == 0),1);

%divide by number of positive or negative patterns in train and divide
%to obtain final value for specifity and sensitivity
nrPositiveTest = size(find(testY(:,1) == 1),1);
nrNegativeTest = size(find(testY(:,1) == 0),1);

sensitiviyTest = sensitiviyTest/nrPositiveTest;
specifityTest = specifityTest/nrNegativeTest;

fprintf('test sensitivity:');
disp(sensitiviyTest);
fprintf('test specifity:');
disp(specifityTest);
