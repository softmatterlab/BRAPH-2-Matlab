% test Cohort
br1 = BrainRegion('BR1', 'brain region 1', 1, 11, 111);
br2 = BrainRegion('BR2', 'brain region 2', 2, 22, 222);
br3 = BrainRegion('BR3', 'brain region 3', 3, 33, 333);
br4 = BrainRegion('BR4', 'brain region 4', 4, 44, 444);
br5 = BrainRegion('BR5', 'brain region 5', 5, 55, 555);
atlas = BrainAtlas('brain atlas', {br1, br2, br3, br4, br5});

sub_class_list = Subject.getList();

%% Test 1: Instantiation Empty
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    cohort = Cohort('cohort', sub_class, atlases, {});
end

%% Test 2: Instantiation with Subjects
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    sub1 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ')']);
    sub2 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ')']);
    sub3 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ')']);
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});
end

%% Test 3: Basic functionalities
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    sub1 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''1'')']);
    sub2 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''2'')']);
    sub3 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''3'')']);
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3});

    assert(cohort.subjectnumber()==3, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.subjectnumber does not work')
    assert(cohort.contains_subject(1), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.contains_subject does not work')
    assert(~cohort.contains_subject(4), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.contains_subject does not work')
    assert(isequal(cohort.getSubject(2).getID(), '2'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.getSubject does not work')
end

%% Test 3: Add
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    sub1 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''1'')']);
    sub2 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''2'')']);
    sub3 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''3'')']);
    sub4 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''4'')']);
    sub5 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''5'')']);
    sub6 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''6'')']);
    
    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub4, sub5});
   
    cohort.addSubject(sub3, 3)

    assert(cohort.subjectnumber()==5, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.addSubject does not work')
    assert(isequal(cohort.getSubject(3).getID(), '3'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.addSubject does not work')

    cohort.addSubject(sub6)

    assert(cohort.subjectnumber()==6, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.addSubject does not work')
    assert(isequal(cohort.getSubject(6).getID(), '6'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.addSubject does not work')
end

%% Test 4: Remove
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    sub1 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''1'')']);
    sub2 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''2'')']);
    sub3 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''3'')']);
    sub4 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''4'')']);
    sub5 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''5'')']);
    sub6 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''6'')']);

    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});
    
    cohort.removeSubject(3)

    assert(cohort.subjectnumber()==4, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.removeSubject does not work')
    assert(isequal(cohort.getSubject(2).getID(), '2'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.removeSubject does not work')
    assert(isequal(cohort.getSubject(3).getID(), '4'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.removeSubject does not work')

    cohort.removeSubject(1)

    assert(cohort.subjectnumber()==3, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.removeSubject does not work')
    assert(isequal(cohort.getSubject(1).getID(), '2'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.removeSubject does not work')
end

%% Test 5: Replace
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    sub1 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''1'')']);
    sub2 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''2'')']);
    sub3 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''3'')']);
    sub4 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''4'')']);
    sub5 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''5'')']);
    sub6 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''6'')']);

    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});
 
    cohort.replaceSubject(3, sub6)

    assert(cohort.subjectnumber()==5, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.replaceSubject does not work')
    assert(isequal(cohort.getSubject(3).getID(), '6'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.replaceSubject does not work')
end

%% Test 6: Invert
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    sub1 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''1'')']);
    sub2 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''2'')']);
    sub3 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''3'')']);
    sub4 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''4'')']);
    sub5 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''5'')']);
    sub6 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''6'')']);

    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});
 
    cohort.invertSubjects(2, 4)

    assert(cohort.subjectnumber()==5, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.invertSubjects does not work')
    assert(isequal(cohort.getSubject(2).getID(), '4'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.invertSubjects does not work')
    assert(isequal(cohort.getSubject(4).getID(), '2'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.invertSubjects does not work')
end

%% Test 7: MoveTo
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    sub1 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''1'')']);
    sub2 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''2'')']);
    sub3 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''3'')']);
    sub4 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''4'')']);
    sub5 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''5'')']);

    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});
 
    cohort.movetoSubject(4, 2)

    assert(cohort.subjectnumber()==5, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.movetoSubject does not work')
    assert(isequal(cohort.getSubject(2).getID(), '4'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.movetoSubject does not work')

    cohort.movetoSubject(1, 5)

    assert(cohort.subjectnumber()==5, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.movetoSubject does not work')
    assert(isequal(cohort.getSubject(5).getID(), '1'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.movetoSubject does not work')
end

%% Test 8: Remove All
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    sub1 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''1'')']);
    sub2 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''2'')']);
    sub3 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''3'')']);
    sub4 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''4'')']);
    sub5 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''5'')']);

    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    cohort = Cohort('cohort', sub_class, atlases, {sub1, sub2, sub3, sub4, sub5});

    selected = cohort.removeSubjects([2, 4]);

    assert(cohort.subjectnumber()==3, ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.removeSubjects does not work')
    assert(isequal(cohort.getSubject(3).getID(), '5'), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.removeSubjects does not work')
    assert(isempty(selected), ...
        'BRAPH:Cohort:Bug', ...
        'Cohort.removeSubjects does not work')
end

%% Test 9: Add Above
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    sub1 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''1'')']);
    sub2 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''2'')']);
    sub3 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''3'')']);
    sub4 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''4'')']);
    sub5 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''5'')']);
    sub6 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''6'')']);

    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    cohort = Cohort('cohort', sub_class, atlas, {sub1, sub2, sub3, sub4, sub5});

% [selected, added] = cohort.addaboveBrainRegions([1 3 5]);
% 
% assert(cohort.subjectnumber()==8, ...
%     'BRAPH:Cohort:Bug', ...
%     'Cohort.subjectnumber does not work')
% for i = [1 4 7]
%     assert(isequal(cohort.getSubject(i).getID(), ''), ...
%         'BRAPH:Cohort:Bug', ...
%         'Cohort.getSubject does not work')
% end
% assert(isequal(selected, [2 5 8]), ...
%     'BRAPH:Cohort:Bug', ...
%     'Cohort.getSubject does not work')
% assert(isequal(added, [1 4 7]), ...
%     'BRAPH:Cohort:Bug', ...
%     'Cohort.getSubject does not work')
end

%% Test 10: Add Below
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    sub1 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''1'')']);
    sub2 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''2'')']);
    sub3 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''3'')']);
    sub4 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''4'')']);
    sub5 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''5'')']);
    sub6 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''6'')']);

    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    cohort = Cohort('cohort', sub_class, atlas, {sub1, sub2, sub3, sub4, sub5});

% [selected, added] = cohort.addbelowBrainRegions([1 3 5]);
% 
% assert(cohort.subjectnumber()==8, ...
%     'BRAPH:Cohort:Bug', ...
%     'Cohort.subjectnumber does not work')
% for i = [2 5 8]
%     assert(isequal(cohort.getSubject(i).getID(), ''), ...
%         'BRAPH:Cohort:Bug', ...
%         'Cohort.getSubject does not work')
% end
% assert(isequal(selected, [1 4 7]), ...
%     'BRAPH:Cohort:Bug', ...
%     'Cohort.getSubject does not work')
% assert(isequal(added, [2 5 8]), ...
%     'BRAPH:Cohort:Bug', ...
%     'Cohort.getSubject does not work')
% 
% %% Test 10: Move Up
% ba = BrainAtlas('brain atlas', {br1, br2, br3, br4, br5});
% 
% selected = cohort.moveupBrainRegions([1 3 5]);
% 
% assert(cohort.subjectnumber()==5, ...
%     'BRAPH:Cohort:Bug', ...
%     'Cohort.subjectnumber does not work')
% assert(isequal(selected, [1 2 4]), ...
%     'BRAPH:Cohort:Bug', ...
%     'Cohort.getSubject does not work')
end

%% Test 11: Move Down
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    sub1 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''1'')']);
    sub2 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''2'')']);
    sub3 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''3'')']);
    sub4 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''4'')']);
    sub5 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''5'')']);
    sub6 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''6'')']);

    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    cohort = Cohort('cohort', sub_class, atlas, {sub1, sub2, sub3, sub4, sub5});

% selected = cohort.movedownBrainRegions([1 3 5]);
% 
% assert(cohort.subjectnumber()==5, ...
%     'BRAPH:Cohort:Bug', ...
%     'Cohort.subjectnumber does not work')
% assert(isequal(selected, [2 4 5]), ...
%     'BRAPH:Cohort:Bug', ...
%     'Cohort.getSubject does not work')
end

%% Test 12: Move to Top
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    sub1 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''1'')']);
    sub2 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''2'')']);
    sub3 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''3'')']);
    sub4 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''4'')']);
    sub5 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''5'')']);
    sub6 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''6'')']);

    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    cohort = Cohort('cohort', sub_class, atlas, {sub1, sub2, sub3, sub4, sub5});

% selected = cohort.move2topBrainRegions([1 3 5]);
% 
% assert(cohort.subjectnumber()==5, ...
%     'BRAPH:Cohort:Bug', ...
%     'Cohort.subjectnumber does not work')
% assert(isequal(selected, [1 2 3]), ...
%     'BRAPH:Cohort:Bug', ...
%     'Cohort.getSubject does not work')
end

%% Test 12: Move to Bottom
for i = 1:1:length(sub_class_list)
    sub_class = sub_class_list{i};
    
    sub1 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''1'')']);
    sub2 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''2'')']);
    sub3 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''3'')']);
    sub4 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''4'')']);
    sub5 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''5'')']);
    sub6 = eval(['Subject.getSubject(sub_class' repmat(', atlas', 1, Subject.getBrainAtlasNumber(sub_class)) ', ''SubID'', ''6'')']);

    atlases = repmat({atlas}, 1, Subject.getBrainAtlasNumber(sub_class));
    cohort = Cohort('cohort', sub_class, atlas, {sub1, sub2, sub3, sub4, sub5});

% selected = cohort.move2bottomBrainRegions([1 3 5]);
% 
% assert(cohort.subjectnumber()==5, ...
%     'BRAPH:Cohort:Bug', ...
%     'Cohort.subjectnumber does not work')
% assert(isequal(selected, [3 4 5]), ...
%     'BRAPH:Cohort:Bug', ...
%     'Cohort.getSubject does not work')
end