%% Figure 3

%DataPath = '... \data\Fig 3'; %% Put the path of the 'data' folder
addpath("DataPath")

% Panel B
load(fullfile(DataPath, 'Panel B_convex.mat'))
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
        xlabel('Curvature (%)')
    end
end
ylim([0 1])

load(fullfile(DataPath, 'Panel B_concave.mat'))
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
        xlabel('Curvature (%)')
    end
end
ylim([0 1])

% Panel C
load(fullfile(DataPath, 'Panel C.mat'))
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