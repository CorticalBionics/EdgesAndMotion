%% Figure S9

%DataPath = '... \data\Fig 4'; %% Put the path of the 'data' folder
addpath("DataPath")

%C1
%Brain
y=[56.6 114.1 387.7 129.8 456.7];
y1=[115.2 86 179.9 142.3 38.5];
%Skin
x=[18.6 31.2 36.3 23.7 49.9];
x1=[21 20.2 22.3 31.4 9.1];

X=[x x1];
Y=[y y1];
X=X/max(X);
Y=Y/max(Y);

%C2
%Brain
yy=[71 41.9 31.8];
yy1=[29.6 44.6 62.1];
%Skin
xx=[53.5 18.4 9.2];
xx1=[46.7 88.7 48.7];

XX=[xx xx1];
YY=[yy yy1];
XX=XX/max(XX);
YY=YY/max(YY);

figure
scatter([X XX],[Y YY])
lsline
[R,p]=corrcoef([X XX],[Y YY])

title('Fig. S9 C1C2')
ylabel('Percept Length')
xlabel('Cortical Length')
