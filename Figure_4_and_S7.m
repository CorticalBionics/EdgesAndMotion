%% Figure 4 & S7

%DataPath = '... \data\Fig 4'; %% Put the path of the 'data' folder
addpath("DataPath")

% Figure 4 Panel A top
load(fullfile(DataPath, 'Panel A_top_C1.mat'))

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

% Figure S7 A
load(fullfile(DataPath, 'Panel A_top_Fig S7A_C2.mat'))
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
load(fullfile(DataPath, 'Panel A_bottom_Fig S7BC.mat'))

for i = 1:length(NC1Data)
    response=NC1Data(i).ResponseTable;
    rep=size(response,1);
    [C,order] = confusionmat(response.Motion,response.ReportedMotion);
    Title = strcat(['MultiDigitMotion - N=', num2str(rep)]);
    String = {'Ulnar-Radial', 'Radial-Ulnar', 'No Motion'};
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
load(fullfile(DataPath, 'Panel B_C1.mat'))
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
load(fullfile(DataPath, 'Panel B_C2.mat'))
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

load(fullfile(DataPath, 'Panel C.mat'))
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
load(fullfile(DataPath, 'Panel D_C1.mat'))
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

    % Plot summaries
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
load(fullfile(DataPath, 'Panel D_C2.mat'))
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

    % Plot summaries
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
load(fullfile(DataPath, 'Fig S7_D.mat'))

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

load(fullfile(DataPath, 'Fig S7_E.mat'))
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