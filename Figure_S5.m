%% Figure S5

%DataPath = '... \data\Fig 3'; %% Put the path of the 'data' folder
addpath("DataPath")

load(fullfile(DataPath, 'Fig S5.mat'))
group={'Concave','Convex','Flat'};
for i = 1:length(NC1Data)
    response=NC1Data(i).ResponseTable;
    rep=size(response,1);
    [C,order] = confusionmat(response.Curvature,response.ReportedCurvature,'Order',group);
    Title = strcat(['Curvature Detection - N=', num2str(rep), '- Digit D2 ']);
    String = {'Concave','Convex','Flat'};
    h=figure;
    C_perc=(C./25)*100;
    ax=imagesc(C_perc,[0,80]);
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
    end
end