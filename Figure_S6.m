%% Figure S6 

%DataPath = '... \data\Fig 4'; %% Put the path of the 'data' folder
addpath("DataPath")

% Panel A
load(fullfile(DataPath, 'Fig S6_A.mat'))
group={'Thu-Pi','Pi-Thu','Pal-Tip','Tip-Pal'};
tmp=1;

for i = 1:length(NC1Data)
    for j=[50 200 400 600 800]
        response=NC1Data(i).ResponseTable;
        response=response(response.Dur==j,:);
        rep=size(response,1);
        [C,order] = confusionmat(response.Motion,response.ReportedMotion,'Order',group); %
        Title = strcat(['Direction of Motion - N=', num2str(rep), '- Dur ', num2str(j)]);
        String = {'Radial-Ulnar', 'Ulnar-Radial', 'Proximal-Distal','Distal-Proximal'};
        h=figure;
        C_perc=(C./15)*100;
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
            P=C_perc(k, k);
            text(z, k, num2str(round(P)),'Color','black','FontSize', 30,'FontWeight','bold');
            z = z+1;
        end
        CC{tmp}=C_perc;
        tmp=tmp+1;
    end
end

M=(CC{1}+CC{2}+CC{3}+CC{4}+CC{5})/length(CC);
ax=imagesc(M,[0,100]);
Title = strcat(['Motion Detection - N=', num2str(rep*length(CC))]);
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

for k = 1 : 4
    P=round(M(k, k));
    text(z, k, num2str(P),'Color','black','FontSize', 30,'FontWeight','bold');
    z = z+1;
end

figure
plot([50 200 400 600 800],[mean([CC{1}(1,1) CC{1}(2,2) CC{1}(3,3)])...
    mean([CC{2}(1,1) CC{2}(2,2) CC{2}(3,3)]),mean([CC{3}(1,1) CC{3}(2,2) CC{3}(3,3)]) ...
    mean([CC{4}(1,1) CC{4}(2,2) CC{4}(3,3)]),mean([CC{5}(1,1) CC{5}(2,2) CC{5}(3,3)])]);
title('Fig. S6 Panel A')
ylabel('Performance (%)')
xlabel('Duration (ms)')
ylim([0 100])

% Panel b
load(fullfile(DataPath, 'Fig S6_B.mat'))
group={'Thu-Pi','Pi-Thu','Pal-Tip','Tip-Pal'};
tmp=1;

for i = 1:length(NC1Data)
    for j=[40 60 80]
        response=NC1Data(i).ResponseTable;
        response=response(response.Amp==j,:);
        rep=size(response,1);
        [C,order] = confusionmat(response.Motion,response.ReportedMotion,'Order',group); %
        Title = strcat(['Direction of Motion - N=', num2str(rep), '- Digit D2 ']);
        String = {'Radial-Ulnar', 'Ulnar-Radial', 'Proximal-Distal','Distal-Proximal'};
        h=figure;
        C_perc=(C./15)*100;
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
            P=C_perc(k, k);
            text(z, k, num2str(round(P)),'Color','black','FontSize', 30,'FontWeight','bold');
            z = z+1;
        end
        CC{tmp}=C_perc;
        tmp=tmp+1;
    end
end

M=(CC{1}+CC{2}+CC{3})/length(CC);
ax=imagesc(M,[0,100]);
Title = strcat(['Motion Detection - N=', num2str(rep*length(CC))]);
String = {'Radial-Ulnar', 'Ulnar-Radial', 'Proximal-Distal','Distal-Proximal'};
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
    P=round(M(k, k));
    text(z, k, num2str(P),'Color','black','FontSize', 30,'FontWeight','bold');
    z = z+1;
end

figure
plot([40 60 80],[mean([CC{1}(1,1) CC{1}(2,2) CC{1}(3,3)])...
    mean([CC{2}(1,1) CC{2}(2,2) CC{2}(3,3)]),mean([CC{3}(1,1) CC{3}(2,2) CC{3}(3,3)])]);
title('Fig. S6 Panel B')
ylabel('Performance (%)')
xlabel('Amplitude (uA)')
ylim([0 100])