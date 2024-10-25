%% Figure 2

%DataPath = '... \data\Fig 2'; %% Put the path of the 'data' folder
addpath("DataPath")
load(fullfile(DataPath, 'Panel B_C1.mat'))
group={'v','h','n'};
Perf=zeros(3,3);

for i = 1:length(NC1Data)
    response=NC1Data(i).ResponseTable;
    rep=size(response,1);
    Digit=NC1Data(i).Digit;
    [C,order] = confusionmat(response.Orient,response.ReportedOrient,'Order',group);
    Title = strcat(['Orientation Detection - N=', num2str(rep), '- Digit ' , num2str(Digit)]);
    String = {'Vertical', 'Horizontal', 'Neither'};
    h=figure;
    C_perc=(C./50)*100;
    ax=imagesc(C_perc,[0,100]);
    title(Title,'FontSize',30,'FontWeight','bold');
    set(gca,'YTick',1:3+1,'YTickLabel',String);
    set(gca,'XTick',1:3+1,'XTickLabel',String);
    ax = gca;
    ax.LineWidth = 0.1;
    ax.FontSize = 15;
    ax.FontWeight='bold';
    colormap(ax,gray)
    colorbar
    z=0.8;
    for k = 1 : 3
        P=C_perc(k, k);
        text(z, k, num2str(P),'Color','black','FontSize', 30,'FontWeight','bold');
        z = z+1;
        Perf(i,k) = P;
    end
end

% Panel B (right)

load(fullfile(DataPath, 'Panel B_C2.mat'))
group={'Vertical', 'Horizontal', 'Neither'};
Perf_2=zeros(2,3);

for i = 1:length(NC1Data)
    response=NC1Data(i).ResponseTable;
    rep=size(response,1);
    Digit=NC1Data(i).Digit;

    [C,order] = confusionmat(response.Orient,response.ReportedOrient,'Order',group);

    C_perc=(C./25)*100;
    for k = 1 : 3
        P=C_perc(k, k);
        Perf_2(i,k) = P;
    end
end

figure
bar(mean([Perf;Perf_2],2))
hold on
errorbar(mean([Perf;Perf_2],2),std([Perf;Perf_2]'),'LineStyle','none')
xticklabels({'C1 d2','C1 d3','C2 d1','C2 d2','C2 d3'})
ylabel('Performance(%)')
title('Fig.2 Panel B right')

% Panel C
load(fullfile(DataPath, 'Panel CDE_C1.mat'))
Perf_d2_C1=zeros(1,5);

for i = 1
    response=NC1Data(i).ResponseTable;
    rep=size(response,1);
    [C,order] = confusionmat(response.Orient,response.ReportedOrient);
    Title = strcat(['MultiEdges - N=', num2str(rep)]);
    String = {'E1', 'E2', 'E3','E4','E5'};
    h=figure;
    C_perc=(C./40)*100;
    ax=imagesc(C_perc,[0,100]);
    title(Title,'FontSize',30,'FontWeight','bold');
    set(gca,'YTick',1:4+1,'YTickLabel',String);
    set(gca,'XTick',1:4+1,'XTickLabel',String);
    ax = gca;
    ax.LineWidth = 0.1;
    ax.FontSize = 15;
    ax.FontWeight='bold';
    colormap(ax,gray)
    colorbar
    z=0.8;
    for k = 1 : 5
        P=round(C_perc(k, k));
        text(z, k, num2str(P),'Color','black','FontSize', 30,'FontWeight','bold');
        z = z+1;
        Perf_d2_C1(i,k) = P;
    end
end

% Panel D
Perf_d3_C1=zeros(1,5);
for i = 2
    response=NC1Data(i).ResponseTable;
    rep=size(response,1);
    [C,order] = confusionmat(response.Orient,response.ReportedOrient);
    C_perc=(C./40)*100;

    for k = 1 : 5
        P=round(C_perc(k, k));
        Perf_d3_C1(1,k) = P;
    end
end

load(fullfile(DataPath, 'Panel D_C2.mat'))
Perf_C2=zeros(2,3);
for i = 1:length(NC1Data)
    response=NC1Data(i).ResponseTable;
    rep=size(response,1);
    [C,order] = confusionmat(response.Orient,response.ReportedOrient);
    C_perc=(C./25)*100;

    for k = 1 : 3
        P=round(C_perc(k, k));
        Perf_C2(i,k) = P;
    end
end

%C1
figure
bar(mean([Perf_d2_C1;Perf_d3_C1],2))
hold on
errorbar(mean([Perf_d2_C1;Perf_d3_C1],2),std([Perf_d2_C1;Perf_d3_C1]'),'LineStyle','none')
xticklabels({'C1 d2','C1 d3'})
ylabel('Performance(%)')
title('Fig.2 Panel D C1')

%C2
figure
bar(mean(Perf_C2,2))
hold on
errorbar(mean(Perf_C2,2),std(Perf_C2'),'LineStyle','none')
xticklabels({'C2 d3','C2 d2'})
ylabel('Performance(%)')
title('Fig.2 Panel D C2')

% Panel E
load(fullfile(DataPath, 'Panel E_Fig S2C_C1.mat'))
Perf_3PF_C1=zeros(2,4);

for i = 1:length(NC1Data)
    response=NC1Data(i).ResponseTable;
    rep=size(response,1);
    [C,order] = confusionmat(response.Orient,response.ReportedOrient);
    C_perc=(C./40)*100;
    for k = 1 : 4
        P=round(C_perc(k, k));
        Perf_3PF_C1(i,k) = P;
    end
end

figure
plot([mean([Perf_d2_C1;Perf_d3_C1],2) mean(Perf_3PF_C1,2)]')
legend({'d2','d3'})
title('Fig.2 Panel E')
ylabel('Performance(%)')
xticks([1 2])
xticklabels({'2-PFs','2-PFs'})