%% Figure S2

%DataPath = '... \data\Fig 2'; %% Put the path of the 'data' folder
addpath("DataPath")

% Panel A
load(fullfile(DataPath, 'Fig S2_A.mat'))
tmp=1;
for i = 1:length(NC1Data)
    for j=[0.25 0.5 1 2 3]
        response=NC1Data(i).ResponseTable;
        response=response(response.Dur==j,:);
        rep=size(response,1);
        String = {'Vertical','Horizontal', 'Neither'};
        [C,order] = confusionmat(response.Orient,response.ReportedOrient,'Order',String);
        Title = strcat(['Orientation Detection - N=', num2str(rep)]);
        h=figure;
        C_perc=(C./15)*100;
        ax=imagesc(C_perc,[0,100]);
        title(Title,'FontSize',30,'FontWeight','bold');
        set(gca,'YTick',1:2+1,'YTickLabel',String);
        set(gca,'XTick',1:2+1,'XTickLabel',String);
        ax = gca;
        ax.LineWidth = 0.1;
        ax.FontSize = 15;
        ax.FontWeight='bold';
        colormap(ax,gray)
        colorbar
        z=0.8;
        for k = 1 : 3
            P=round(C_perc(k, k));
            text(z, k, num2str(P),'Color','black','FontSize', 30,'FontWeight','bold');
            z = z+1;
        end
        CC{tmp}=C_perc;
        tmp=tmp+1;
    end
end

M=(CC{1}+CC{2}+CC{3}+CC{4}+CC{5})/length(CC);
ax=imagesc(M,[0,100]);
Title = strcat(['Orientation Detection - N=', num2str(rep*length(CC))]);
title(Title,'FontSize',30,'FontWeight','bold');
set(gca,'YTick',1:2+1,'YTickLabel',String);
set(gca,'XTick',1:2+1,'XTickLabel',String);
ax = gca;
ax.LineWidth = 0.1;
ax.FontSize = 15;
ax.FontWeight='bold';
colormap(ax,gray)
colorbar
z=0.8;
for k = 1 : 3
    P=round(M(k, k));
    text(z, k, num2str(P),'Color','black','FontSize', 30,'FontWeight','bold');
    z = z+1;
end

plot([0.25 0.5 1 2 3],[mean([CC{1}(1,1) CC{1}(2,2) CC{1}(3,3)])...
    mean([CC{2}(1,1) CC{2}(2,2) CC{2}(3,3)]),mean([CC{3}(1,1) CC{3}(2,2) CC{3}(3,3)]) ...
    mean([CC{4}(1,1) CC{4}(2,2) CC{4}(3,3)]),mean([CC{5}(1,1) CC{5}(2,2) CC{5}(3,3)])]);
title('Fig. S2 Duration')
xlabel('Duration (s)')
ylabel('Performance(%)')

% Panel B
load(fullfile(DataPath, 'Fig S2_B.mat'))
tmp=1;
for i = 1:length(NC1Data)
    for j=[40 60 80]
        response=NC1Data(i).ResponseTable;
        response=response(response.Amp==j,:);
        rep=size(response,1);
        String = {'Vertical','Horizontal', 'Neither'};
        [C,order] = confusionmat(response.Orient,response.ReportedOrient,'Order',String);
        Title = strcat(['Orientation Detection - N=', num2str(rep)]);
        h=figure;
        C_perc=(C./30)*100;
        ax=imagesc(C_perc,[0,100]);
        title(Title,'FontSize',30,'FontWeight','bold');
        set(gca,'YTick',1:2+1,'YTickLabel',String);
        set(gca,'XTick',1:2+1,'XTickLabel',String);
        ax = gca;
        ax.LineWidth = 0.1;
        ax.FontSize = 15;
        ax.FontWeight='bold';
        colormap(ax,gray)
        colorbar
        z=0.8;
        for k = 1 : 3
            P=round(C_perc(k, k));
            text(z, k, num2str(P),'Color','black','FontSize', 30,'FontWeight','bold');
            z = z+1;
        end
        CC_2{tmp}=C_perc;
        tmp=tmp+1;
    end
end

M=(CC_2{1}+CC_2{2}+CC_2{3})/length(CC_2);
ax=imagesc(M,[0,100]);
Title = strcat(['Orientation Detection - N=', num2str(rep*length(CC))]);
title(Title,'FontSize',30,'FontWeight','bold');
set(gca,'YTick',1:2+1,'YTickLabel',String);
set(gca,'XTick',1:2+1,'XTickLabel',String);
ax = gca;
ax.LineWidth = 0.1;
ax.FontSize = 15;
ax.FontWeight='bold';
colormap(ax,gray)
colorbar
z=0.8;
for k = 1 : 3
    P=round(M(k, k));
    text(z, k, num2str(P),'Color','black','FontSize', 30,'FontWeight','bold');
    z = z+1;
end

figure
plot([40 60 80],[mean([CC{1}(1,1) CC{1}(2,2) CC{1}(3,3)])...
    mean([CC{2}(1,1) CC{2}(2,2) CC{2}(3,3)]),mean([CC{3}(1,1) CC{3}(2,2) CC{3}(3,3)])]);
title('Fig. S2 Amplitude')
xlabel('Amplitude (uA)')
ylabel('Performance(%)')
