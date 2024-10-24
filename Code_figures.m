clear all
close all
clc

%% Figure 2

% BCI_path = '\\Data\Fig 2'; %% Put the path of the 'data' folder
% cd(BCI_path)

% Panel B (left)

load("Panel B_C1.mat");
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

load("Panel B_C2.mat");
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

load("Panel CDE_C1.mat");
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

load('Panel D_C2.mat')
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

load("Panel E_Fig S2C_C1.mat");
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

%% Figure S2
clear all
close all
clc

% Panel A

load("Fig S2_A.mat");
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

load('Fig S2_B.mat')
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


%% Figure S3
clear all
close all

% Panel C

load('Fig S3_C.mat')
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

%% Figure 3
clear all
close all

% BCI_path = '\\Data\Fig 3'; %%move to Fig 3
% cd(BCI_path)

% Panel B

load("Panel B_convex.mat");

order_colors = [.26 .26 .26;...
    .36 .42 .75;...
    .94 .33 .31];

sigfun = @(c,x) 1./(1 + exp(-c(1).*(x-c(2))));
invsig = @(c,y) (log(1/y - 1)/-c(1)) + c(2);
sigc2jnd = @(sig_c) (invsig(sig_c, .75) - invsig(sig_c, .25)) / 2;
opts = optimset('Display','off');

for e = 1:length(AS4mcEData)
    hold all
    u_types = unique(AS4mcEData(e).ResponseSummary.Type);
    for f = 1:length(u_types)
        subplot(1,length(u_types),f); hold on
        title('Curvature Discrimination')
        fidx = AS4mcEData(e).ResponseSummary.Type == u_types(f);
        x = AS4mcEData(e).ResponseSummary.CompCurv(fidx);
        % Mean
        y = AS4mcEData(e).ResponseSummary.pH(fidx);
        Sr= sortrows([x y],1);
        x=Sr(:,1);
        y=Sr(:,2);
        scatter(x, y, 'MarkerFaceColor', order_colors(3,:), 'MarkerEdgeColor', order_colors(3,:), 'MarkerFaceAlpha', 0.15)
        c = lsqcurvefit(sigfun, [0.01*mean(x), mean(x)], x,y, [-1, x(1)], [1, x(end)], opts);
        xq = linspace(min(x), max(x));
        plot(xq, sigfun(c,xq), 'Color', order_colors(3,:), 'LineWidth', 1.5);
        yticks([0 .5 1])
        if f == 1
            ylabel('p(CompHigher)');
        else
            yticklabels({});
        end
        xlabel(sprintf('Curvature (%)'))
    end
end
ylim([0 1])

load("Panel B_concave.mat");
for e = 1:length(AS4mcEData)
    hold all
    u_types = unique(AS4mcEData(e).ResponseSummary.Type);
    for f = 1:length(u_types)
        subplot(1,length(u_types),f); hold on
        title('Curvature Discrimination')
        fidx = AS4mcEData(e).ResponseSummary.Type == u_types(f);
        x = AS4mcEData(e).ResponseSummary.CompCurv(fidx);
        % Mean
        y = AS4mcEData(e).ResponseSummary.pH(fidx);
        Sr= sortrows([x y],1);
        x=Sr(:,1);
        y=1-Sr(:,2);
        scatter(x, y, 'MarkerFaceColor', order_colors(1,:), 'MarkerEdgeColor', order_colors(1,:), 'MarkerFaceAlpha', 0.15)
        c = lsqcurvefit(sigfun, [0.01*mean(x), mean(x)], x,y, [-1, x(1)], [1, x(end)], opts);
        xq = linspace(min(x), max(x));
        plot(xq, sigfun(c,xq), 'Color', order_colors(1,:), 'LineWidth', 1.5);
        yticks([0 .5 1])
        if f == 1
            ylabel('p(CompHigher)');
        else
            yticklabels({});
        end
        xlabel(sprintf('Curvature (%)'))
    end
end
ylim([0 1])

% Panel C
load('Panel C.mat')
group={'Cylinder','Pen','Ball'};

for i = 1:length(NC1Data)

    response=NC1Data(i).ResponseTable;
    rep=size(response,1);


    [C,order] = confusionmat(response.Orient,response.ReportedOrient,'Order',group);
    Title = strcat(['MultiDigitEdges - N=', num2str(rep)]);
    String = {'Can','Pen','Ball'};

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
end

%% Figure S5
clear all
close all

load("Fig S5.mat");
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

%% Figure 4 & S7
clear all
close all

% Figure 4 Panel A top
% BCI_path = '\\Data\Fig 4'; %Move to Fig 4
% cd(BCI_path)

load("Panel A_top_C1.mat");

for i = 1:length(NC1Data)

    response=NC1Data(i).ResponseTable;
    rep=size(response,1);
    if i==2
        id=25;
        group={'Th-Pi','Pi-Th','Pa-Tip','Tip-Pa'};
        [C,order] = confusionmat(response.Motion,response.ReportedMotion);
    else
        id=20;
        group={'P-T','T-P','P-Pi','Pi-P'};
    end
    [C,order] = confusionmat(response.Motion,response.ReportedMotion,'Order',group);
    String = {'Ulnar-Radial','Radial-Ulnar', 'Proximal-Distal','Distal-Proximal',};
    C_perc=(C./id)*100;
    CC{i}=C_perc;
end

M_1=(CC{1}+CC{2})/length(CC);
ax=imagesc(M_1,[0,100]);
Title = strcat(['Detection of Motion - N=180']);
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
    P=round(M_1(k, k));
    text(z, k, num2str(P),'Color','black','FontSize', 30,'FontWeight','bold');
    z = z+1;
end

%C1
figure
bar(mean([M_1(1,1) M_1(2,2) M_1(3,3)]))
hold on
errorbar(mean([M_1(1,1) M_1(2,2) M_1(3,3)]),std([M_1(1,1) M_1(2,2) M_1(3,3)]),'LineStyle','none')
title('Fig.4 Panel A right C1')
xticklabels('C1')
ylabel('Performance (%)')

% Figure S7A
load("Panel A_top_Fig S7A_C2.mat");
figure

for i = 1:length(NC1Data)

    response=NC1Data(i).ResponseTable;
    rep=size(response,1);
    group={'R-I','I-R','Down','Up'};
    [C,order] = confusionmat(response.Motion,response.ReportedMotion,'Order',group);
    String = {'Ulnar-Radial','Radial-Ulnar', 'Proximal-Distal','Distal-Proximal',};
    C_perc=(C./15)*100;
    ax=imagesc(C_perc,[0,100]);
    Title = strcat(['Detection of Motion - N=60']);
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

%C2 (Figure 4A top)
figure
bar(mean([C_perc(1,1) C_perc(2,2) C_perc(3,3) C_perc(4,4)]))
hold on
errorbar(mean([C_perc(1,1) C_perc(2,2) C_perc(3,3) C_perc(4,4)]),std([C_perc(1,1) C_perc(2,2) C_perc(3,3) C_perc(4,4)]),'LineStyle','none')
title('Fig.4 Panel A right C2')
xticklabels('C2')
ylabel('Performance (%)')

% Figure S7B

load("Panel A_bottom_Fig S7BC.mat");

for i = 1:length(NC1Data)

    response=NC1Data(i).ResponseTable;
    rep=size(response,1);
    [C,order] = confusionmat(response.Motion,response.ReportedMotion);
    Title = strcat(['MultiDigitMotion - N=', num2str(rep)]);
    String = {'Ulnar-Radial', 'Radial-Ulanr', 'No Motion'};
    if i==2
        id=25;
    else
        id=40;
    end
    h=figure;
    C_perc=(C./id)*100;
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
    Perf=0;
    for k = 1 : 3
        P=round(C_perc(k, k));
        text(z, k, num2str(P),'Color','black','FontSize', 30,'FontWeight','bold');
        z = z+1;
        Perf = P+Perf;
    end
    Perf=Perf/(2+1);

    CC{i}=C_perc;
end

% Figure 4 Panel A bottom
%C1
figure
bar(mean([CC{1}(1,1) CC{1}(2,2) CC{1}(3,3)]))
hold on
errorbar(mean([CC{1}(1,1) CC{1}(2,2) CC{1}(3,3)]),std([CC{1}(1,1) CC{1}(2,2) CC{1}(3,3)]),'LineStyle','none')
title('Fig.4 Panel A bottom C1')
xticklabels('C1')
ylabel('Performance (%)')

%C2
figure
bar(mean([CC{2}(1,1) CC{2}(2,2) CC{2}(3,3)]))
hold on
errorbar(mean([CC{2}(1,1) CC{2}(2,2) CC{2}(3,3)]),std([CC{2}(1,1) CC{2}(2,2) CC{2}(3,3)]),'LineStyle','none')
title('Fig.4 Panel A bottom C2')
xticklabels('C2')
ylabel('Performance (%)')

% Figure S7C
Inter_Intra=[mean([CC{1}(1,1) CC{1}(2,2) CC{1}(3,3)]) mean([M_1(1,1) M_1(2,2) M_1(3,3) M_1(4,4)])];
figure
bar(Inter_Intra)
hold on
errorbar(Inter_Intra,[std([CC{1}(1,1) CC{1}(2,2) CC{1}(3,3)]) std([M_1(1,1) M_1(2,2) M_1(3,3) M_1(4,4)])],'LineStyle','none')
title('Fig. S7 Panel C')
xticklabels({'Inter-digits', 'Intra-digit'})
ylabel('Performance (%)')

% Figure 4 Panel B

%C1
load('Panel B_C1.mat')
group={'No Motion','Motion','Succesive'};
Reps=10;
Resp=cell(1,3);

for i = 1:length(NC1Data)
    response=NC1Data(i).ResponseTable;
    Gaps=unique(response.Gap);
    for j=1:length(Gaps)
        R=response(find(response.Gap==Gaps(j)),:);
        tmp_noM=strcmp(R.ReportedMotion,'No Motion');
        tmp_M=strcmp(R.ReportedMotion,'Motion');
        tmp_S=strcmp(R.ReportedMotion,'Successive');
        Resp{i}(1,j)=length(find(tmp_noM==1))/Reps;
        Resp{i}(2,j)=length(find(tmp_M==1))/Reps;
        Resp{i}(3,j)=length(find(tmp_S==1))/Reps;
    end
end

RespM_No=[Resp{1}(1,:);Resp{2}(1,:);Resp{3}(1,:)];
RespM_M=[Resp{1}(2,:);Resp{2}(2,:);Resp{3}(2,:)];
RespM_S=[Resp{1}(3,:);Resp{2}(3,:);Resp{3}(3,:)];

figure
hold all
plot(Gaps,mean(RespM_No))
plot(Gaps,mean(RespM_M))
plot(Gaps,mean(RespM_S))
title('Fig. 4 Panel B C1')
xlabel('Inter-Trains-Interval(s)')
legend({'Simultaneous Tap','Continous Motion','Successive Taps'})
ylabel('Performance (%)')
ylim([0 1]);

%C2
load('Panel B_C2.mat')
group={'No Motion','Motion','Succesive'};
Reps=10;
Resp=cell(1,3);

for i = 1:length(NC1Data)
    response=NC1Data(i).ResponseTable;
    Gaps=unique(response.Gap);
    for j=1:length(Gaps)
        R=response(find(response.Gap==Gaps(j)),:);
        tmp_noM=strcmp(R.ReportedMotion,'No Motion');
        tmp_M=strcmp(R.ReportedMotion,'Motion');
        tmp_S=strcmp(R.ReportedMotion,'Successive');
        Resp{i}(1,j)=length(find(tmp_noM==1))/Reps;
        Resp{i}(2,j)=length(find(tmp_M==1))/Reps;
        Resp{i}(3,j)=length(find(tmp_S==1))/Reps;
    end
end

RespM_No=[Resp{1}(1,:);Resp{2}(1,:);Resp{3}(1,:)];
RespM_M=[Resp{1}(2,:);Resp{2}(2,:);Resp{3}(2,:)];
RespM_S=[Resp{1}(3,:);Resp{2}(3,:);Resp{3}(3,:)];

figure
hold all
plot(Gaps,mean(RespM_No))
plot(Gaps,mean(RespM_M))
plot(Gaps,mean(RespM_S))
title('Fig. 4 Panel B C2')
xlabel('Inter-Trains-Interval(s)')
legend({'Simultaneous Tap','Continous Motion','Successive Taps'})
ylabel('Performance (%)')
ylim([0 1]);

% Figure 4 Panel C

load('Panel C.mat')
group={'Th-Pi','Pi-Th','Pa-Tip','Tip-Pa'};

for i = 1:length(NC1Data)

    response=NC1Data(i).ResponseTable;
    rep=size(response,1);

    [C,order] = confusionmat(response.Motion,response.ReportedMotion,'Order',group);
    Title = strcat(['Direction of Motion - N=', num2str(rep), '- Digit D2 ']);
    String = {'Ulanr Radial', 'Radial Ulanr', 'Proxiaml Distal','Proximanl Distal'};

    h=figure;
    C_perc=(C./40)*100;
    ax=imagesc(C_perc,[0,100]);
    title(Title,'FontSize',30,'FontWeight','bold');
    set(gca,'YTick',1:3+1,'YTickLabel',String);
    set(gca,'XTick',1:3+1,'XTickLabel',String);
    % box off
    ax = gca;
    ax.LineWidth = 0.1;
    ax.FontSize = 15;
    ax.FontWeight='bold';
    colormap(ax,gray)
    colorbar

    z=0.8;
    Perf=0;
    for k = 1 : 4
        P=C_perc(k, k);
        text(z, k, num2str(round(P)),'Color','black','FontSize', 30,'FontWeight','bold');
        z = z+1;
        Perf = P+Perf;
    end
    Perf=Perf/(4+1);

    CC{i}=C_perc;
end

NOVFS_VFS=[mean([CC{1}(1,1) CC{1}(2,2) CC{1}(3,3) CC{1}(4,4)]) ...
    mean([M_1(1,1) M_1(2,2) M_1(3,3) M_1(4,4)])];
figure
bar(NOVFS_VFS)
hold on
errorbar(NOVFS_VFS,[std([CC{1}(1,1) CC{1}(2,2) CC{1}(3,3) CC{1}(4,4)]) ...
    std([M_1(1,1) M_1(2,2) M_1(3,3) M_1(4,4)])],'LineStyle','none')
xticklabels({'VFS','NO-VFS'})

title('Fig. 4 Panel C')
ylabel('Performance (%)')

% Figure 4 Panel D

%C1
load("Panel D_C1.mat");
figure

for ii=1:size(Data,1)

    ref_speed = 500;
    order_colors = [.26 .26 .26;...
        .36 .42 .75;...
        .94 .33 .31];

    sigfun = @(c,x) 1./(1 + exp(-c(1).*(x-c(2))));
    invsig = @(c,y) (log(1/y - 1)/-c(1)) + c(2);
    sigc2jnd = @(sig_c) (invsig(sig_c, .75) - invsig(sig_c, .25)) / 2;
    opts = optimset('Display','off');

    AS4mcEData=Data(ii);

    %% Plot summaries
    for e = 1:length(AS4mcEData)
        hold all
        u_types = unique(AS4mcEData(e).ResponseSummary.Type);
        for f = 1:length(u_types)
            subplot(1,length(u_types),f); hold on
            title('Speed of Motion Discrimination - Dur C1')
            fidx = AS4mcEData(e).ResponseSummary.Type == u_types(f);
            x = AS4mcEData(e).ResponseSummary.CompSpeed(fidx);
            % Mean
            y = AS4mcEData(e).ResponseSummary.pH(fidx);
            Sr= sortrows([x y],1);
            x=Sr(:,1);
            y=1-Sr(:,2);
            scatter(x, y, 'MarkerFaceColor', order_colors(1,:), 'MarkerEdgeColor', order_colors(1,:), 'MarkerFaceAlpha', 0.15)
            c = lsqcurvefit(sigfun, [0.01*mean(x), mean(x)], x,y, [-1, x(1)], [1, x(end)], opts);
            xq = linspace(min(x), max(x));
            plot(xq, sigfun(c,xq), 'Color', order_colors(1,:), 'LineWidth', 1.5);
            yticks([0 .5 1])
            if f == 1
                ylabel('p(CompHigher)');
            else
                yticklabels({});
            end
            xlabel(sprintf('Comparison Dur (ms)'))
        end
    end
    ylim([0 1])
end

%C2
load("Panel D_C2.mat");
figure

for ii=1:size(Data,1)

    ref_speed = 1000;
    order_colors = [.26 .26 .26;...
        .36 .42 .75;...
        .94 .33 .31];

    sigfun = @(c,x) 1./(1 + exp(-c(1).*(x-c(2))));
    invsig = @(c,y) (log(1/y - 1)/-c(1)) + c(2);
    sigc2jnd = @(sig_c) (invsig(sig_c, .75) - invsig(sig_c, .25)) / 2;
    opts = optimset('Display','off');

    AS4mcEData=Data(ii);

    %% Plot summaries
    for e = 1:length(AS4mcEData)
        hold all
        u_types = unique(AS4mcEData(e).ResponseSummary.Type);
        for f = 1:length(u_types)
            subplot(1,length(u_types),f); hold on
            title('Speed of Motion Discrimination - Dur C2')
            fidx = AS4mcEData(e).ResponseSummary.Type == u_types(f);
            x = AS4mcEData(e).ResponseSummary.CompSpeed(fidx);
            % Mean
            y = AS4mcEData(e).ResponseSummary.pH(fidx);
            Sr= sortrows([x y],1);
            x=Sr(:,1);
            y=1-Sr(:,2);
            scatter(x, y, 'MarkerFaceColor', order_colors(3,:), 'MarkerEdgeColor', order_colors(3,:), 'MarkerFaceAlpha', 0.15)
            c = lsqcurvefit(sigfun, [0.01*mean(x), mean(x)], x,y, [-1, x(1)], [1, x(end)], opts);
            xq = linspace(min(x), max(x));
            plot(xq, sigfun(c,xq), 'Color', order_colors(3,:), 'LineWidth', 1.5);
            yticks([0 .5 1])
            if f == 1
                ylabel('p(CompHigher)');
            else
                yticklabels({});
            end
            xlabel(sprintf('Comparison Dur (ms)'))
        end
    end
    ylim([0 1])
end

% Figure S7D
load("Fig S7_D.mat");

for i = 1:length(NC1Data)
    response=NC1Data(i).ResponseTable;
    rep=size(response,1);
    [C,order] = confusionmat(response.Motion,response.ReportedMotion);
    Title = strcat(['Direction of Motion - N=', num2str(rep), '- Digit D2 - CIRCULAR ']);
    String = {'Clockwise', 'Counter-Clockwise', 'Neither'};
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
        P=C_perc(k, k);
        text(z, k, num2str(round(P)),'Color','black','FontSize', 30,'FontWeight','bold');
        z = z+1;
    end
end

load("Fig S7_E.mat");
for i = 1:length(NC1Data)
    response=NC1Data(i).ResponseTable;
    rep=size(response,1);
    [C,order] = confusionmat(response.Motion,response.ReportedMotion);
    Title = strcat(['Direction of Motion - N=', num2str(rep), '- Digit D2 - RADIAL ']);
    String = { 'STATIC','EXPANSION', 'CONTRACTION'};
    h=figure;
    C_perc=(C./25)*100;
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
        P=C_perc(k, k);
        text(z, k, num2str(round(P)),'Color','black','FontSize', 30,'FontWeight','bold');
        z = z+1;
    end
end


%% Figure S6A
clear all
load('Fig S6_A.mat')
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

% Figure S6B
clear all
load('Fig S6_B.mat')
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


%% Figure S8A

% center
clear all
load("Fig S8_A.mat");

for ii=1:size(Data,2)
    ref_speed = 500;

    order_colors = [.26 .26 .26;...
        .36 .42 .75;...
        .94 .33 .31];

    sigfun = @(c,x) 1./(1 + exp(-c(1).*(x-c(2)))); % c(1) = rate of change, c(2) = x-offset
    invsig = @(c,y) (log(1/y - 1)/-c(1)) + c(2);
    sigc2jnd = @(sig_c) (invsig(sig_c, .75) - invsig(sig_c, .25)) / 2;
    opts = optimset('Display','off');

    AS4mcEData=Data(ii);
    for e = 1:length(AS4mcEData)
        hold all
        u_types = unique(AS4mcEData(e).ResponseSummary.Type);
        for f = 1:length(u_types)
            subplot(1,length(u_types),f); hold on
            title('Fig. S8A')
            fidx = AS4mcEData(e).ResponseSummary.Type == u_types(f);
            x = AS4mcEData(e).ResponseSummary.CompSpeed(fidx);
            % Mean
            y = AS4mcEData(e).ResponseSummary.pH(fidx);
            Sr= sortrows([x y],1);
            %x=(1.4./Sr(:,1))*1000; % for speed: convert x-axis and fit
            x=Sr(:,1);
            y=Sr(:,2); % for speed change orientation: y=1-Sr(:,2);
            scatter(x, y, 'MarkerFaceColor', order_colors(1,:), 'MarkerEdgeColor', order_colors(1,:), 'MarkerFaceAlpha', 0.15)
            c = lsqcurvefit(sigfun, [0.01*mean(x), mean(x)], x,y, [-1, x(1)], [1, x(end)], opts);
            xq = linspace(min(x), max(x));
            plot(xq, sigfun(c,xq), 'Color', order_colors(1,:), 'LineWidth', 1.5);

            yticks([0 .5 1])
            if f == 1
                ylabel('p(CompFaster)');
            else
                yticklabels({});
            end
            xlabel(sprintf('Comparison Dur (ms)'))
        end
    end
    ylim([0 1])
end

% Figure S8B
clear all
load("Fig S8_B.mat");
figure 

for ii=1:size(Data,2)
    ref_speed = 500;

    order_colors = [.26 .26 .26;...
        .36 .42 .75;...
        .94 .33 .31];

    sigfun = @(c,x) 1./(1 + exp(-c(1).*(x-c(2)))); % c(1) = rate of change, c(2) = x-offset
    invsig = @(c,y) (log(1/y - 1)/-c(1)) + c(2);
    sigc2jnd = @(sig_c) (invsig(sig_c, .75) - invsig(sig_c, .25)) / 2;
    opts = optimset('Display','off');

    AS4mcEData=Data(ii);

    for e = 1:length(AS4mcEData)
        hold all
        u_types = unique(AS4mcEData(e).ResponseSummary.Type);
        for f = 1:length(u_types)
            subplot(1,length(u_types),f); hold on
            title('Fig. S8B')
            fidx = AS4mcEData(e).ResponseSummary.Type == u_types(f);
            x = AS4mcEData(e).ResponseSummary.CompSpeed(fidx);
            % Mean
            y = AS4mcEData(e).ResponseSummary.pH(fidx);
            Sr= sortrows([x y],1);
            x=Sr(:,1);
            y=1-Sr(:,2);
            scatter(x, y, 'MarkerFaceColor', order_colors(3,:), 'MarkerEdgeColor', order_colors(3,:), 'MarkerFaceAlpha', 0.15)
            c = lsqcurvefit(sigfun, [0.01*mean(x), mean(x)], x,y, [-1, x(1)], [1, x(end)], opts);
            xq = linspace(min(x), max(x));
            plot(xq, sigfun(c,xq), 'Color', order_colors(3,:), 'LineWidth', 1.5);
            yticks([0 .5 1])
            if f == 1
                ylabel('p(CompFaster)');
            else
                yticklabels({});
            end
            xlabel(sprintf('Comparison Dur (ms)'))
        end
    end
    ylim([0 1])
end

%% Figure S9

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

%% Figure 5

% Panel B
clear all
close all

% BCI_path = '\\Data\Fig 5'; % Move to Fig 5
% cd(BCI_path)

load("PanelABC.mat");

group={'T','L','C','O','I'};

for i = 1:length(NC1Data)

    response=NC1Data(i).ResponseTable;
    rep=size(response,1);

    [C,order] = confusionmat(response.Letter,response.ReportedLetter,'Order',group);
    if i==1
        Title = strcat(['Letter task SEQUENTIAL - N=', num2str(rep), '- Digit D2 ']);
    else
        Title = strcat(['Letter task SIMULTANEOUS- N=', num2str(rep), '- Digit D2 ']);
    end
    String = {'T','L','C','O','I'};

    h=figure;
    C_perc=(C./30)*100;
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
        P=C_perc(k, k);
        text(z, k, num2str(round(P)),'Color','white','FontSize', 30,'FontWeight','bold');
        z = z+1;
    end
    CC{i}=C_perc;
end

% Panel C (left)

figure
bar([mean([CC{2}(1,1) CC{2}(2,2) CC{2}(3,3) CC{2}(4,4) CC{2}(5,5)]) ...
    mean([CC{1}(1,1) CC{1}(2,2) CC{1}(3,3) CC{1}(4,4) CC{1}(5,5)])])
hold on
errorbar([mean([CC{2}(1,1) CC{2}(2,2) CC{2}(3,3) CC{2}(4,4) CC{2}(5,5)])...
    mean([CC{1}(1,1) CC{1}(2,2) CC{1}(3,3) CC{1}(4,4) CC{1}(5,5)])]...
    ,[std([CC{2}(1,1) CC{2}(2,2) CC{2}(3,3) CC{2}(4,4) CC{2}(5,5)]) ...
    std([CC{1}(1,1) CC{1}(2,2) CC{1}(3,3) CC{1}(4,4) CC{1}(5,5)])],'LineStyle','none')
xticklabels({'Simultaneous','Sequential'})
ylabel('Performance (%)')
title('Fig.5 Panel C left')

% Panel C (right)

figure
scatter([2 3 4 6],[mean([CC{2}(2,2) CC{2}(5,5)]) CC{2}(1,1) CC{2}(3,3) CC{2}(4,4)],'red')
hold on
lsline
scatter([2 3 4 6],[mean([CC{1}(2,2) CC{1}(5,5)]) CC{1}(1,1) CC{1}(3,3) CC{1}(4,4)],'black')
lsline
legend({'Simultaneous','','Sequential',''})
xlabel('Number of Edges')
ylabel('Performance (%)')
title('Fig.5 Panel C right')

% Panel E

clear all

load('PanelE.mat')
class_names = ["LEFT", "CONTROL", "RIGHT"];
t_offset = 10;
data_points = 50 * t_offset * 2;

figure
[ap, atab, s] = anova1(tab.EndPosition, tab.Stim, 'off');
mc = multcompare(s);

% Confusion matrix
figure
u_set = unique(tab.Set);
titles = {'Normal', 'HighCL', 'Normal', 'LowCL'};
clf; tiledlayout('flow');
for s = [1,4,2]
    nexttile()
    count_mat = zeros(3);
    if s == 1
        set_idx = tab.Set == u_set(s) | tab.Set == u_set(3);
    else
        set_idx = tab.Set == u_set(s);
    end
    for s1 = 1:3
        for s2 = 1:3
            count_mat(s1,s2) = sum(strcmp(tab.Stim, class_names{s1}) & ...
                strcmp(tab.EndPositionClass, class_names{s2}) & set_idx);
        end
    end
    perf_mat = count_mat ./ sum(count_mat, 1);
    [~,~,p,~] = crosstab(tab.Stim, tab.EndPositionClass);
    fprintf('%s: %d%%, %s\n', titles{s}, sum(diag(count_mat)) / sum(count_mat, 'all')* 100, pStr(p))


    imagesc(perf_mat')
    clim([0 1]);
    colormap gray
    title(titles{s})
    set(gca, 'XTickLabel', {'Left', 'None', 'Right'}, ...
        'YTickLabel', {'Left', 'None', 'Right'},...
        'XTick', [1:3], 'YTick', [1:3])
    xlabel('Target')
    ylabel('Selected')
end

% Plot left/right
x = linspace(-t_offset, t_offset, data_points + 1);
figure
clf;
subplot(1,2,1)
    % Control condition
    idx = strcmp(tab.Stim, 'CONTROL') & (tab.Set == 13);
    temp = cat(1, tab.Position{idx});
    AlphaLine(x, temp, [.6 .6 .6], 'ErrorType', 'SEM')
    % Right
    idx = strcmp(tab.Stim, 'RIGHT') & (tab.Set == 13);
    temp = cat(1, tab.Position{idx});
    AlphaLine(x, temp, rgb(251, 140, 0), 'ErrorType', 'SEM')
    % Left
    idx = strcmp(tab.Stim, 'LEFT') & (tab.Set == 13);
    temp = cat(1, tab.Position{idx});
    AlphaLine(x, temp, rgb(30, 136, 229), 'ErrorType', 'SEM')
    % Formatting
    set(gca, 'XLim', [-1 5], 'XTick', [-t_offset:t_offset], 'Box', 'off', 'YTick', [])
    ylabel('Wheel Position')
    xlabel('Time (s)')
    [ax,ay] = GetAxisPosition(gca, 5, 95);
    text(ax,ay, ColorText({'Right',  'Left'}, ...
        [rgb(251, 140, 0); rgb(30, 136, 229)]))
    plot([0,0], gca().YLim, 'Color', [.6 .6 .6], 'LineStyle', '--')

subplot(1,2,2)
    % Control condition
    idx = strcmp(tab.Stim, 'CONTROL') & (tab.Set == 13);
    temp = cat(1, tab.Feedback{idx});
    AlphaLine(x, temp, [.6 .6 .6], 'ErrorType', 'SEM')
    % Right
    idx = strcmp(tab.Stim, 'RIGHT') & (tab.Set == 13);
    temp = cat(1, tab.Feedback{idx});
    AlphaLine(x, temp, rgb(251, 140, 0), 'ErrorType', 'SEM')
    % Left
    idx = strcmp(tab.Stim, 'LEFT') & (tab.Set == 13);
    temp = cat(1, tab.Feedback{idx});
    AlphaLine(x, temp, rgb(30, 136, 229), 'ErrorType', 'SEM')
    % Formatting
    set(gca, 'XLim', [-1 5], 'XTick', [-t_offset:t_offset], 'Box', 'off', 'YTick', [])
    ylabel('Decoder Output')
    xlabel('Time (s)')
    plot([0,0], gca().YLim, 'Color', [.6 .6 .6], 'LineStyle', '--')

u_set = unique(tab.Set);
titles = {'No CL'};
figure
clf;
for j = 1
    hold on
    title(titles{j})
    % Temporary table with set info
    if j == 1
        set_idx = tab.Set == 7 | tab.Set == 13;
    elseif j == 2
        set_idx = tab.Set == 18;
    else
        set_idx = tab.Set == 12;
    end
    temp_tab = tab(set_idx, :);

    plot([0 4], [7.5 7.5], 'Color', [.6 .6 .6], 'LineStyle', '--')
    plot([0 4], [-7.5 -7.5], 'Color', [.6 .6 .6], 'LineStyle', '--')
    for i = 1:3
        idx = strcmp(temp_tab.Stim, class_names{i});
        y = temp_tab.EndPosition(idx);
        ci = temp_tab.Correct(idx);
        c = zeros(length(ci), 3);
        c(ci,:) = repmat([.6 1 .6], [sum(ci), 1]);
        c(~ci,:) = repmat([1 .6 .6], [sum(~ci), 1]);

        Swarm(i, y, "Color", [.6 .6 .6], 'SwarmColor', c)
    end
    set(gca, 'XTick', [1:3], 'XTickLabel', class_names)
    if j == 1
        ylabel('Wheel Position')
    end
end

