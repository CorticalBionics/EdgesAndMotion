%% Figure S9

%DataPath = '... \data\Fig 2'; %% Put the path of the 'data' folder
addpath("DataPath")
load(fullfile(DataPath, 'Fig S9.mat'))

%C1
%Brain
Y=[y y1];
Y=Y/max(Y);
%Skin
X=[x x1];
X=X/max(X);

%C2
%Brain
YY=[yy yy1];
YY=YY/max(YY);
%Skin
XX=[xx xx1];
XX=XX/max(XX);

figure
scatter([X XX],[Y YY])
lsline
[R,p]=corrcoef([X XX],[Y YY])

title('Fig. S9 C1C2')
ylabel('Percept Length')
xlabel('Cortical Length')
