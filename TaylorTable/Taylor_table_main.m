%%% This main function is used to show the Taylor table and the accuracy of approximation
%%% Besides, it can also handle some exception because of wrong inputs.
%%% The Taylor table is stored in the table with heads.

% P_in = 2;
% Q_in = 2;
% m_in = 2;

addpath('SubFolder');

m_in = input('Please input the positive integer(Order of derivate) M:');
P_in = input('Please input the positive integer(the leftest distance) P_in:');
Q_in = input('Please input the positive integer(the rightest distance) Q_in:');

% Test the basic capabilities of Taylor_table_fun
% [Coeff, A_mat, Taylor_table_without_1, Taylot_table_with_1, Accuracy_r]...
%         = Taylor_table_fun(m_in, P_in, Q_in);
    

try 
%     Because these mistakes will not lead to MEexceptions, but they are
%     meaningless and do not meet the requirement of this given question.
    if P_in < 0 || Q_in < 0  
        ME = MException('MATLAB:DistNotAllPositive','Input parameters p or q are negative');
        throw(ME)
    else
%%%       Calling the Taylor_table_fun to get the taylor table and relevant
%%%       data, such coeff and A_matrix
        [Coeff, A_mat, Taylor_table_without_1, Taylor_table_with_1, Accuracy_r]...
        = Taylor_table_fun(m_in, P_in, Q_in);
        
        fprintf('Coefficients are: \n')
        fprintf(1,'%f\t\t',Coeff)
        fprintf('\n')
        fprintf('The accuracy value r is %d. \n', Accuracy_r)
%%%     Show Taylor table
        size_matrix = P_in + Q_in + 1;
        %%%     Generate the row head of the Taylor table
        Table_row_name = cell(max(size(Taylor_table_with_1)),1);
        Table_row_name(1) = {'h_2_u_2'};
        for i = -P_in:Q_in
            Table_row_name(i+P_in+2) = {strcat('C_',num2str(i+P_in+1),'_u_i_',num2str(i))};     
        end
        
%%%     Generate the column head of the Taylor table
        Table_col_name = cell(1, P_in + Q_in + 1);
        Table_col_name(1) = {'u'};
        for i = 2 : P_in + Q_in + 1
            Table_col_name(i) = {strcat('h_',num2str(i-1),'_u_',num2str(i-1))};
        end
        
%%% show the final Taylor table and save it to a csv file
%%% Show the Taylor table
    figure();
    Final_Taylor_table = uitable('Data',Taylor_table_with_1,'ColumnName',Table_col_name,'RowName',Table_row_name,'Position',[50 50 120*size_matrix 30*size_matrix]);

%%% save it to a csv file
    Vector_1 = ones(1, min(size(Taylor_table_with_1)));
    Vector_2 = ones(1, max(size(Taylor_table_with_1)));
    Cell_Taylor_table = mat2cell(Taylor_table_with_1,Vector_2,Vector_1);
    Final_Taylor_table_csv = cell2table(Cell_Taylor_table,'VariableNames',Table_col_name,'RowNames',Table_row_name);
    writetable(Final_Taylor_table_csv,'Final_Taylor_table.csv','WriteRowNames',true) 


    end
   

    
catch ME
    switch ME.identifier
        case('MATLAB:badsubscript')
            warning('The index m is not positive and intergal. ')
            fprintf('\nPlease check and reinput again!\n')
        case('MATLAB:dimagree')
            warning('The index m is bigger than p + q'); 
            fprintf('\nPlease check and reinput again!\n')
        case('MATLAB:NonIntegerInput')
            warning('Input parameters p or q are not integer')
            fprintf('\nPlease check and reinput again!\n')
        case('MATLAB:DistNotAllPositive')
            warning('Input parameters p or q are negative')
            fprintf('\nPlease check and reinput again!\n')
        otherwise
            rethrow(ME)
    end
end

rmpath('SubFolder');

