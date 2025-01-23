clc; clear

%% genesis of a simple hello+world software

%% genesis of a set of ready-pipelines software (CON and FUN)

%% genesis of memory capacity software
rollcall = { ...
'+util', '+_Exporter.gen.m', '+_Importer.gen.m', ...
'+ds*', '-ds_examples', ...
'+atlas*', ...
'+gt', '+_Measure.gen.m', '+_Graph.gen.m', '+_GraphAdjPF.gen.m', '+_GraphHistPF.gen.m', '+_GraphPP_MDict.gen.m', '+_NoValue.gen.m', ...
'+_MeasurePF.gen.m', '+_MeasurePF_GU.gen.m', '+_MeasurePF_NU.gen.m', '+_MeasurePF_NxPP_Node.gen.m', '+_MeasurePF_xUPP_Layer.gen.m', ...
'+cohort*', ...
'+analysis', '+_AnalyzeEnsemble.gen.m', '+_AnalyzeEnsemblePP_GDict.gen.m', '+_AnalyzeEnsemblePP_MeDict.gen.m', '+_CompareEnsemble.gen.m', '+_CompareEnsemblePP_CpDict.gen.m', ...
'+_ComparisonEnsemble.gen.m', '+_ComparisonEnsembleBrainPF.gen.m', '+_ComparisonEnsembleBrainPF_BB.gen.m', '+_ComparisonEnsembleBrainPF_BS.gen.m', '+_ComparisonEnsembleBrainPF_BU.gen.m', ...
'+_ComparisonEnsembleBrainPF_GB.gen.m', '+_ComparisonEnsembleBrainPF_GS.gen.m', '+_ComparisonEnsembleBrainPF_GU.gen.m', '+_ComparisonEnsembleBrainPF_NB.gen.m', '+_ComparisonEnsembleBrainPF_NS.gen.m', ...
'+_ComparisonEnsembleBrainPF_NU.gen.m', '+_ComparisonEnsembleBrainPF_xSPP_Layer.gen.m', '+_ComparisonEnsembleBrainPF_xUPP_Layer.gen.m', '+_ComparisonEnsemblePF.gen.m', ...
'+_ComparisonEnsemblePF_BB.gen.m', '+_ComparisonEnsemblePF_BS.gen.m', '+_ComparisonEnsemblePF_BU.gen.m', '+_ComparisonEnsemblePF_BxPP_Nodes.gen.m', '+_ComparisonEnsemblePF_GB.gen.m', ...
'+_ComparisonEnsemblePF_GS.gen.m', '+_ComparisonEnsemblePF_GU.gen.m', '+_ComparisonEnsemblePF_NB.gen.m', '+_ComparisonEnsemblePF_NS.gen.m', '+_ComparisonEnsemblePF_NU.gen.m', '+_ComparisonEnsemblePF_NxPP_Node.gen.m', ...
'+_ComparisonEnsemblePF_xUPP_Layer.gen.m', '+_MeasureEnsemble.gen.m', ...
'+_MeasureEnsembleBrainPF.gen.m', '+_MeasureEnsembleBrainPF_GU.gen.m', '+_MeasureEnsembleBrainPF_NU.gen.m', '+_MeasureEnsembleBrainPF_xUPP_Layer.gen.m', ...
'+_MeasureEnsemblePF.gen.m', '+_MeasureEnsemblePF_GU.gen.m', '+_MeasureEnsemblePF_NU.gen.m', '+_MeasureEnsemblePF_NxPP_Node.gen.m', '+_MeasureEnsemblePF_xUPP_Layer.gen.m', ...
'+_PanelPropCellFDR.gen.m', ...
'-nn', ...
'+gui*', '-gui_examples', ...
'+brainsurfs*', ...
'+atlases*', ...
'+graphs',  '+_GraphWU.gen.m', ...
'+measures', ...
'-neuralnetworks', ...
'+pipelines', ...
'+connectivity*', '-_AnalyzeEnsemble_CON_BUD.gen.m', '-_AnalyzeEnsemble_CON_BUT.gen.m', ...
'+memorycapacity*', ...
'+test*', ...
'-sandbox' ...
};
braph2lite_genesis({'memorycapacity'}, 'tags', '2.0.0', rollcall, 'braph2memorycapacity')