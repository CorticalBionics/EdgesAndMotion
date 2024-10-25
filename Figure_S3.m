%% Figure S3

%DataPath = '... \data\Fig 2'; %% Put the path of the 'data' folder
addpath("DataPath")

% Panel C
load(fullfile(DataPath, 'Fig S3_C.mat'))
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
    end
end

for i = 2:length(NC1Data)

    response=NC1Data(i).ResponseTable;
    rep=size(response,1);
    Title = strcat(['MultiEdges - N=', num2str(rep)]);
    String = {'E1', 'E2', 'E3','E4'};
    [C,order] = confusionmat(response.Orient,response.ReportedOrient);

    h=figure;
    C_perc=(C./40)*100;
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
    for k = 1 : 4
        P=round(C_perc(k, k));
        text(z, k, num2str(P),'Color','black','FontSize', 30,'FontWeight','bold');
        z = z+1;
    end
end

% Panel EF

%C1
Pred_a1=[7 103 80 144 38 54 126 95 99 120];
Perc_a1=[10 115 80 76 56 5 20 83 129 135];

Pred_l1=[ 36.3 48.6 65.3 73.1 61.5 29.5 43.8 66.4 44.8 65.3];%
Perc_l1=[38.5 36.9 40.8 57.5 16.6 33.9 57 66.3 43.2 91 ]; %

%C2
Pred_a2=[140 4 38 112 90 97.5];
Perc_a2=[95 52 42 90 94 94.13];

Pred_l2=[35.4 17.8 10.2 40.8 52.8 95.4];
Perc_l2=[53.5 18.6 9.1 46.6 86.9 49.4];

figure
scatter([Pred_l1 Pred_l2],[Perc_l1 Perc_l2])
title('Fig. S3 Panel F')
axis square
xlim([10 100])
ylim([10 100])
lsline
[R,p]=corrcoef([Pred_l1 Pred_l2],[Perc_l1 Perc_l2])

figure
scatter([Pred_a1 Pred_a2],[Perc_a1 Perc_a2])
title('Fig. S3 Panel E')
axis square
xlim([0 180])
ylim([0 180])
lsline
[R,p]=corrcoef([Pred_a1 Pred_a2],[Perc_a1 Perc_a2])