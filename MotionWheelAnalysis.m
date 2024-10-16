load("U:\UserFolders\CharlesGreenspon\BCI_EdgeMotion\BCI02_iData_576.mat")
class_names = {"LEFT", "CONTROL", "RIGHT"};

%% Sort logi_wheel position messages by arbstim sequence and trial_metadata
variable_names_types = [["Ses", "double"];...
                        ["Set", "double"];...
                        ["Block", "double"];...
                        ["Trial", "double"];...
                        ["Stim", "string"];...
                        ["Position", "cell"];...
                        ["Feedback", "cell"];...
                        ["Correct", "logical"];...
                        ["DecoderStart", "double"];...
                        ["TrialEnd", "double"];...
                        ["EndPosition", "double"];...
                        ["EndPositionClass", "string"]];
num_trials = length(iData.QL.Data.TRIAL_METADATA.session_num);
% Create data table
tab = table('Size',[num_trials, size(variable_names_types,1)],...
            'VariableNames', variable_names_types(:,1),...
            'VariableTypes', variable_names_types(:,2));
t_offset = 10;
data_points = 50 * t_offset * 2;

state_names = cell(size(iData.QL.Data.TASK_STATE_CONFIG.state_name, 2), 1);
for i = 1:size(iData.QL.Data.TASK_STATE_CONFIG.state_name, 2)
    state_names{i} = deblank(char(iData.QL.Data.TASK_STATE_CONFIG.state_name(:,i))');
end
state_seq_nos = iData.QL.SequenceNo.TASK_STATE_CONFIG;
reach_seq_idx = find(strcmp(state_names, 'Reach'));
reach_seq_nos = state_seq_nos(reach_seq_idx);

for t = 1:num_trials
    % Trial metadata
    tab{t, "Ses"} = iData.QL.Data.TRIAL_METADATA.session_num(t);
    tab{t, "Set"} = iData.QL.Data.TRIAL_METADATA.set_num(t);
    tab{t, "Block"} = iData.QL.Data.TRIAL_METADATA.block_num(t);
    tab{t, "Trial"} = iData.QL.Data.TRIAL_METADATA.trial_num(t);

    % Stim info
    stim_path = char(iData.QL.Data.CERESTIM_CONFIG_CHAN_PRESAFETY_ARBITRARY.pathname(...
        1:iData.QL.Data.CERESTIM_CONFIG_CHAN_PRESAFETY_ARBITRARY.pathlength(t), t))';
    [~, stim_fname, ~] = fileparts(stim_path);
    fsplit = strsplit(stim_fname, '_');
    tab{t, "Stim"} = fsplit(3);
    
    % CS_TRAIN_END to align each trial
    cs_seq_no = iData.QL.SequenceNo.CS_TRAIN_END(t);

    % Decoder enabled
    de_seq_idx = find(reach_seq_nos > cs_seq_no, 1, 'first');
    de_seq_time = iData.QL.Headers.TASK_STATE_CONFIG.recv_time(reach_seq_idx(de_seq_idx));
    tab{t, "DecoderStart"} = de_seq_time - iData.QL.Headers.CS_TRAIN_END.recv_time(t);
    
    % Trial end
    te_seq_time = iData.QL.Headers.TASK_STATE_CONFIG.recv_time(reach_seq_idx(de_seq_idx)+1);
    tab{t, "TrialEnd"} = te_seq_time - iData.QL.Headers.CS_TRAIN_END.recv_time(t);

    % Wheel position
    seq = find(iData.QL.SequenceNo.LOGI_WHEEL > cs_seq_no, 1, 'first');
    seq_time = iData.QL.Headers.LOGI_WHEEL.recv_time(seq);
    start_idx = find(iData.QL.Headers.LOGI_WHEEL.recv_time < seq_time - t_offset, 1, 'last');
    tab{t, "Position"} = {iData.QL.Data.LOGI_WHEEL.position(start_idx:start_idx+data_points)};

    % Feedback position
    seq = find(iData.QL.SequenceNo.FINISHED_COMMAND > cs_seq_no, 1, 'first');
    seq_time = iData.QL.Headers.FINISHED_COMMAND.recv_time(seq);
    start_idx = find(iData.QL.Headers.FINISHED_COMMAND.recv_time < seq_time - t_offset, 1, 'last');
    tab{t, "Feedback"} = {iData.QL.Data.FINISHED_COMMAND.command(3,start_idx:start_idx+data_points)};

    % End position
    te_seq_num = iData.QL.SequenceNo.TASK_STATE_CONFIG(reach_seq_idx(de_seq_idx)+1);
    seq = find(iData.QL.SequenceNo.LOGI_WHEEL > te_seq_num, 1, 'first');
    tab{t, "EndPosition"} = iData.QL.Data.LOGI_WHEEL.position(seq);
    if tab{t, "EndPosition"} < -7.5
        tab{t, "EndPositionClass"} = {"LEFT"};
    elseif tab{t, "EndPosition"} > 7.5
        tab{t, "EndPositionClass"} = {"RIGHT"};
    else
        tab{t, "EndPositionClass"} = {"CONTROL"};
    end
 
    % Use our own classification for correct/incorrect
    if strcmp(tab{t, "Stim"}, tab{t, "EndPositionClass"})
        tab{t, "Correct"} = true;
    end
end

[ap, atab, s] = anova1(tab.EndPosition, tab.Stim, 'off');
mc = multcompare(s);


%% Confusion matrix
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

%% Plot left/right
x = linspace(-t_offset, t_offset, data_points + 1);
clf;
subplot(1,2,1)
    % Control condition
    idx = strcmp(tab.Stim, 'CONTROL') & (tab.Set == 13);
    temp = cat(1, tab.Position{idx});
    AlphaLine(x, temp, [.6 .6 .6], 'ErrorType', 'SEM')
    % Right
    idx = strcmp(tab.Stim, 'RIGHT') & (tab.Set == 13);
    temp = cat(1, tab.Position{idx});
    AlphaLine(x, temp, rgb(30, 136, 229), 'ErrorType', 'SEM')
    % Left
    idx = strcmp(tab.Stim, 'LEFT') & (tab.Set == 13);
    temp = cat(1, tab.Position{idx});
    AlphaLine(x, temp, rgb(251, 140, 0), 'ErrorType', 'SEM')
    % Formatting
    set(gca, 'XLim', [-1 5], 'XTick', [-t_offset:t_offset], 'Box', 'off', 'YTick', [])
    ylabel('Wheel Position')
    xlabel('Time (s)')
    [ax,ay] = GetAxisPosition(gca, 5, 95);
    text(ax,ay, ColorText({'Right',  'Left'}, ...
        [rgb(30, 136, 229); rgb(251, 140, 0)]))
    plot([0,0], gca().YLim, 'Color', [.6 .6 .6], 'LineStyle', '--')

subplot(1,2,2)
    % Control condition
    idx = strcmp(tab.Stim, 'CONTROL') & (tab.Set == 13);
    temp = cat(1, tab.Feedback{idx});
    AlphaLine(x, temp, [.6 .6 .6], 'ErrorType', 'SEM')
    % Right
    idx = strcmp(tab.Stim, 'RIGHT') & (tab.Set == 13);
    temp = cat(1, tab.Feedback{idx});
    AlphaLine(x, temp, rgb(30, 136, 229), 'ErrorType', 'SEM')
    % Left
    idx = strcmp(tab.Stim, 'LEFT') & (tab.Set == 13);
    temp = cat(1, tab.Feedback{idx});
    AlphaLine(x, temp, rgb(251, 140, 0), 'ErrorType', 'SEM')
    % Formatting
    set(gca, 'XLim', [-1 5], 'XTick', [-t_offset:t_offset], 'Box', 'off', 'YTick', [])
    ylabel('Decoder Output')
    xlabel('Time (s)')
    plot([0,0], gca().YLim, 'Color', [.6 .6 .6], 'LineStyle', '--')

shg

%%
u_set = unique(tab.Set);
titles = {'No CL', 'Low CL', 'High CL'};

clf;
for j = 1:3
    subplot(1,3,j); hold on
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

shg
return
%% Plot raw traces
clf; hold on
plot(rescale(iData.QL.Data.LOGI_WHEEL.position))
plot(rescale(iData.QL.Data.FINISHED_COMMAND.command(3,:)))
shg