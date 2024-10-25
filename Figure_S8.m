%% Figure S8

%DataPath = '... \data\Fig 4'; %% Put the path of the 'data' folder
addpath("DataPath")

% Panel A center
load(fullfile(DataPath, 'Fig S8_A.mat'))

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

% Panel B
load(fullfile(DataPath, 'Fig S8_B.mat'))
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