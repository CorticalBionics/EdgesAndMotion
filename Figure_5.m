%% Figure 5

%DataPath = '... \data\Fig 5'; %% Put the path of the 'data' folder
addpath("DataPath")

% Panel B
load(fullfile(DataPath, 'PanelABC.mat'))

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

load(fullfile(DataPath, 'PanelE.mat'))
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
