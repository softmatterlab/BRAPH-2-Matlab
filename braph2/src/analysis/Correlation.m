classdef Correlation
    %Correlation correlates a matrix.
    % Correlation correlates a matrix with the given correlation rule.
    % 
    % Correlation returns an adjacency matrix. Depending on the correlation
    %  rule, it uses a different type of correlation function. It also
    %  returns the adjacency matrix with modified values depending on the
    %  negative rule.
    %
    % The list of correlation properties (Constant) is:
    %  PEARSON                      - is Pearson's linear correlation coefficient
    %  SPEARMAN                     - is pairwise correlations Spearman's rho
    %  KENDALL                      - is pairwise correlations Kendall's tau
    %  PEARSON_CV                   - is linear partial Pearson correlations
    %  SPEARMAN_CV                  - is Spearman's rank partial correlations
    %  ZERO                         - changes all negative values to zero
    %  ABS                          - outputs the absolute value
    %  NONE                         - does not filter the output
    %  CORRELATION_RULE_LIST        - PEARSON, SPEARMAN, KENDALL, PEARSON_CV
    %                                 SPEARMAN_CV
    %  NEGATIVE_WEIGHT_RULE_LIST    - ZERO, ABS, NONE
    %
    % Correlation methods (Static)
    %  getAdjacencyMatrix           - returns an adjacency matrix and p-values
    %
    % See also Analysis, Measurement.   
    
    properties (Constant)
        PEARSON = 'Pearson';
        SPEARMAN = 'Spearman';
        KENDALL = 'Kendall';
        PEARSON_CV = 'Pearson with covariates';
        SPEARMAN_CV = 'Spearman with covariates';
        
        CORRELATION_RULE_LIST = {Correlation.PEARSON, Correlation.SPEARMAN, Correlation.KENDALL, Correlation.PEARSON_CV, Correlation.SPEARMAN_CV};

        ZERO = 'zero';
        ABS = 'abs';
        NONE = 'none';
        
        NEGATIVE_WEIGHT_RULE_LIST = {Correlation.ZERO, Correlation.ABS, Correlation.NONE};
    end
    methods (Static)
        function [A, P] = getAdjacencyMatrix(data, correlation_rule, negative_weight_rule, covariates)
            %GETADJACENCYMATRIX returns an adjacency matrix.
            %
            % [A, P] = GETADJACENCYMATRIX(DATA) returns an adjacency matrix
            %  calculated with pearson correlation. May return the p-values
            %  correlation matrix P.
            %
            % [A, P] = GETADJACENCYMATRIX(DATA, CORRELATION_RULE) returns an
            %  adjacency matrix calculated with the specified correlation rule.
            %  May return the p-values correlation matrix P. 
            %  Admissible CORRELTION_RULE are:
            %   'CORRELTION_RULE'   = 'Spearman' - pairwise correlations Spearman's rho
            %                         'Kendall'  - pairwise correlations Kendall's tau
            %                         'Pearson'(default)  - Pearson's linear correlation coefficient
            %
            % [A, P] = GETADJACENCYMATRIX(DATA, CORRELATION_RULE, NEGATIVE_WEIGHT_RULE) 
            %  returns an adjacency matrix calculated with the specified correlation rule.
            %  It filters the values with the NEGATIVE_WEIGHT_RULE.
            %  May return the p-values correlation matrix P.
            %  Admissible NEGATIVE_WEIGHT_RULE are:
            %   'NEGATIVE_WEIGHT_RULE' = 'none'   - does not filter the output
            %                            'abs'    - output is the absolute value
            %                            'zero'(default) - changes all negative values to zero
            %
            % [A, P] = GETADJACENCYMATRIX(DATA, CORRELATION_RULE, NEGATIVE_WEIGHT_RULE, COVARIATES)
            %  returns an adjacency matrix calculated with the specified correlation rule and 
            %  negative weight rule.
            %  It uses COVARIATES age and sex for the partial correlation.
            %  May return the p-values correlation matrix P.
            %  Admissible CORRELTION_RULE are:
            %   'CORRELTION_RULE'   = 'Pearson with covariates'  - linear partial Pearson correlations
            %                         'Spearman with covariates' - Spearman's rank partial correlations 
            %
            % See also Analysis, Measurement, corr, corrcoef, partialcorr.
            
            switch correlation_rule
                case Correlation.SPEARMAN
                    [A, P] = corr(data, 'Type', 'Spearman');
                case Correlation.KENDALL
                    [A, P] = corr(data, 'Type','Kendall');
                case Correlation.PEARSON_CV
                    [A, P] = partialcorr(data, covariates, 'Type', 'Pearson');
                case Correlation.SPEARMAN_CV
                    [A, P] = partialcorr(data, covariates, 'Type', 'Spearman');
                otherwise  % Correlation.PEARSON default
                    [A, P] = corrcoef(data);
            end
            
            switch negative_weight_rule
                case Correlation.NONE

                case Correlation.ABS
                    A = abs(A);
                otherwise  % Correlation.ZERO default
                    A(A < 0) = 0;
            end
        end
    end
end