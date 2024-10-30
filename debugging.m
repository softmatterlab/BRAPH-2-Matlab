close all; delete(findall(0, 'type', 'figure')); clear all; clc

%% /neuralnetworks
el_path = '/neuralnetworks';
el_class_list = {'NNxMLP_FeatureImportanceAcrossFUN'}; 
regenerate(el_path, el_class_list, 'UnitTest', false);