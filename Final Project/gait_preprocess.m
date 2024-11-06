classdef gait_preprocess    
    properties
        Path
        Events_Table
        Devices_Table
        Model_Table
        Trajectories_Table
    end
    methods
        function obj = gait_preprocess(Path, event_dataLines, devices_dataLines, model_dataLines, trajectories_dataLines)
            obj.Path = Path;
            obj.Events_Table = grab_events(obj, event_dataLines);
            obj.Devices_Table = grab_devices(obj, devices_dataLines);
            obj.Model_Table = grab_model(obj, model_dataLines);
            obj.Trajectories_Table = grab_trajectories(obj, trajectories_dataLines);
        end

        function event_table = grab_events(obj, dataLines)
            %% Set up the Import Options and import the data
            opts = delimitedTextImportOptions("NumVariables", 274, "Encoding", "UTF-8");
           
            % Specify range and delimiter
            opts.DataLines = dataLines;
            opts.Delimiter = ",";
            
            % Specify column names and types
            opts.VariableNames = ["Subject", "Context", "Name", "Times", "Description", "Var6", "Var7", "Var8", "Var9", "Var10", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18", "Var19", "Var20", "Var21", "Var22", "Var23", "Var24", "Var25", "Var26", "Var27", "Var28", "Var29", "Var30", "Var31", "Var32", "Var33", "Var34", "Var35", "Var36", "Var37", "Var38", "Var39", "Var40", "Var41", "Var42", "Var43", "Var44", "Var45", "Var46", "Var47", "Var48", "Var49", "Var50", "Var51", "Var52", "Var53", "Var54", "Var55", "Var56", "Var57", "Var58", "Var59", "Var60", "Var61", "Var62", "Var63", "Var64", "Var65", "Var66", "Var67", "Var68", "Var69", "Var70", "Var71", "Var72", "Var73", "Var74", "Var75", "Var76", "Var77", "Var78", "Var79", "Var80", "Var81", "Var82", "Var83", "Var84", "Var85", "Var86", "Var87", "Var88", "Var89", "Var90", "Var91", "Var92", "Var93", "Var94", "Var95", "Var96", "Var97", "Var98", "Var99", "Var100", "Var101", "Var102", "Var103", "Var104", "Var105", "Var106", "Var107", "Var108", "Var109", "Var110", "Var111", "Var112", "Var113", "Var114", "Var115", "Var116", "Var117", "Var118", "Var119", "Var120", "Var121", "Var122", "Var123", "Var124", "Var125", "Var126", "Var127", "Var128", "Var129", "Var130", "Var131", "Var132", "Var133", "Var134", "Var135", "Var136", "Var137", "Var138", "Var139", "Var140", "Var141", "Var142", "Var143", "Var144", "Var145", "Var146", "Var147", "Var148", "Var149", "Var150", "Var151", "Var152", "Var153", "Var154", "Var155", "Var156", "Var157", "Var158", "Var159", "Var160", "Var161", "Var162", "Var163", "Var164", "Var165", "Var166", "Var167", "Var168", "Var169", "Var170", "Var171", "Var172", "Var173", "Var174", "Var175", "Var176", "Var177", "Var178", "Var179", "Var180", "Var181", "Var182", "Var183", "Var184", "Var185", "Var186", "Var187", "Var188", "Var189", "Var190", "Var191", "Var192", "Var193", "Var194", "Var195", "Var196", "Var197", "Var198", "Var199", "Var200", "Var201", "Var202", "Var203", "Var204", "Var205", "Var206", "Var207", "Var208", "Var209", "Var210", "Var211", "Var212", "Var213", "Var214", "Var215", "Var216", "Var217", "Var218", "Var219", "Var220", "Var221", "Var222", "Var223", "Var224", "Var225", "Var226", "Var227", "Var228", "Var229", "Var230", "Var231", "Var232", "Var233", "Var234", "Var235", "Var236", "Var237", "Var238", "Var239", "Var240", "Var241", "Var242", "Var243", "Var244", "Var245", "Var246", "Var247", "Var248", "Var249", "Var250", "Var251", "Var252", "Var253", "Var254", "Var255", "Var256", "Var257", "Var258", "Var259", "Var260", "Var261", "Var262", "Var263", "Var264", "Var265", "Var266", "Var267", "Var268", "Var269", "Var270", "Var271", "Var272", "Var273", "Var274"];
            opts.SelectedVariableNames = ["Subject", "Context", "Name", "Times", "Description"];
            opts.VariableTypes = ["string", "string", "string", "double", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string"];
            
            % Specify file level properties
            opts.ExtraColumnsRule = "ignore";
            opts.EmptyLineRule = "read";
            
            % Specify variable properties
            opts = setvaropts(opts, ["Context", "Name", "Description", "Var6", "Var7", "Var8", "Var9", "Var10", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18", "Var19", "Var20", "Var21", "Var22", "Var23", "Var24", "Var25", "Var26", "Var27", "Var28", "Var29", "Var30", "Var31", "Var32", "Var33", "Var34", "Var35", "Var36", "Var37", "Var38", "Var39", "Var40", "Var41", "Var42", "Var43", "Var44", "Var45", "Var46", "Var47", "Var48", "Var49", "Var50", "Var51", "Var52", "Var53", "Var54", "Var55", "Var56", "Var57", "Var58", "Var59", "Var60", "Var61", "Var62", "Var63", "Var64", "Var65", "Var66", "Var67", "Var68", "Var69", "Var70", "Var71", "Var72", "Var73", "Var74", "Var75", "Var76", "Var77", "Var78", "Var79", "Var80", "Var81", "Var82", "Var83", "Var84", "Var85", "Var86", "Var87", "Var88", "Var89", "Var90", "Var91", "Var92", "Var93", "Var94", "Var95", "Var96", "Var97", "Var98", "Var99", "Var100", "Var101", "Var102", "Var103", "Var104", "Var105", "Var106", "Var107", "Var108", "Var109", "Var110", "Var111", "Var112", "Var113", "Var114", "Var115", "Var116", "Var117", "Var118", "Var119", "Var120", "Var121", "Var122", "Var123", "Var124", "Var125", "Var126", "Var127", "Var128", "Var129", "Var130", "Var131", "Var132", "Var133", "Var134", "Var135", "Var136", "Var137", "Var138", "Var139", "Var140", "Var141", "Var142", "Var143", "Var144", "Var145", "Var146", "Var147", "Var148", "Var149", "Var150", "Var151", "Var152", "Var153", "Var154", "Var155", "Var156", "Var157", "Var158", "Var159", "Var160", "Var161", "Var162", "Var163", "Var164", "Var165", "Var166", "Var167", "Var168", "Var169", "Var170", "Var171", "Var172", "Var173", "Var174", "Var175", "Var176", "Var177", "Var178", "Var179", "Var180", "Var181", "Var182", "Var183", "Var184", "Var185", "Var186", "Var187", "Var188", "Var189", "Var190", "Var191", "Var192", "Var193", "Var194", "Var195", "Var196", "Var197", "Var198", "Var199", "Var200", "Var201", "Var202", "Var203", "Var204", "Var205", "Var206", "Var207", "Var208", "Var209", "Var210", "Var211", "Var212", "Var213", "Var214", "Var215", "Var216", "Var217", "Var218", "Var219", "Var220", "Var221", "Var222", "Var223", "Var224", "Var225", "Var226", "Var227", "Var228", "Var229", "Var230", "Var231", "Var232", "Var233", "Var234", "Var235", "Var236", "Var237", "Var238", "Var239", "Var240", "Var241", "Var242", "Var243", "Var244", "Var245", "Var246", "Var247", "Var248", "Var249", "Var250", "Var251", "Var252", "Var253", "Var254", "Var255", "Var256", "Var257", "Var258", "Var259", "Var260", "Var261", "Var262", "Var263", "Var264", "Var265", "Var266", "Var267", "Var268", "Var269", "Var270", "Var271", "Var272", "Var273", "Var274"], "WhitespaceRule", "preserve");
            opts = setvaropts(opts, ["Context", "Name", "Description", "Var6", "Var7", "Var8", "Var9", "Var10", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18", "Var19", "Var20", "Var21", "Var22", "Var23", "Var24", "Var25", "Var26", "Var27", "Var28", "Var29", "Var30", "Var31", "Var32", "Var33", "Var34", "Var35", "Var36", "Var37", "Var38", "Var39", "Var40", "Var41", "Var42", "Var43", "Var44", "Var45", "Var46", "Var47", "Var48", "Var49", "Var50", "Var51", "Var52", "Var53", "Var54", "Var55", "Var56", "Var57", "Var58", "Var59", "Var60", "Var61", "Var62", "Var63", "Var64", "Var65", "Var66", "Var67", "Var68", "Var69", "Var70", "Var71", "Var72", "Var73", "Var74", "Var75", "Var76", "Var77", "Var78", "Var79", "Var80", "Var81", "Var82", "Var83", "Var84", "Var85", "Var86", "Var87", "Var88", "Var89", "Var90", "Var91", "Var92", "Var93", "Var94", "Var95", "Var96", "Var97", "Var98", "Var99", "Var100", "Var101", "Var102", "Var103", "Var104", "Var105", "Var106", "Var107", "Var108", "Var109", "Var110", "Var111", "Var112", "Var113", "Var114", "Var115", "Var116", "Var117", "Var118", "Var119", "Var120", "Var121", "Var122", "Var123", "Var124", "Var125", "Var126", "Var127", "Var128", "Var129", "Var130", "Var131", "Var132", "Var133", "Var134", "Var135", "Var136", "Var137", "Var138", "Var139", "Var140", "Var141", "Var142", "Var143", "Var144", "Var145", "Var146", "Var147", "Var148", "Var149", "Var150", "Var151", "Var152", "Var153", "Var154", "Var155", "Var156", "Var157", "Var158", "Var159", "Var160", "Var161", "Var162", "Var163", "Var164", "Var165", "Var166", "Var167", "Var168", "Var169", "Var170", "Var171", "Var172", "Var173", "Var174", "Var175", "Var176", "Var177", "Var178", "Var179", "Var180", "Var181", "Var182", "Var183", "Var184", "Var185", "Var186", "Var187", "Var188", "Var189", "Var190", "Var191", "Var192", "Var193", "Var194", "Var195", "Var196", "Var197", "Var198", "Var199", "Var200", "Var201", "Var202", "Var203", "Var204", "Var205", "Var206", "Var207", "Var208", "Var209", "Var210", "Var211", "Var212", "Var213", "Var214", "Var215", "Var216", "Var217", "Var218", "Var219", "Var220", "Var221", "Var222", "Var223", "Var224", "Var225", "Var226", "Var227", "Var228", "Var229", "Var230", "Var231", "Var232", "Var233", "Var234", "Var235", "Var236", "Var237", "Var238", "Var239", "Var240", "Var241", "Var242", "Var243", "Var244", "Var245", "Var246", "Var247", "Var248", "Var249", "Var250", "Var251", "Var252", "Var253", "Var254", "Var255", "Var256", "Var257", "Var258", "Var259", "Var260", "Var261", "Var262", "Var263", "Var264", "Var265", "Var266", "Var267", "Var268", "Var269", "Var270", "Var271", "Var272", "Var273", "Var274"], "EmptyFieldRule", "auto");
            
            % Import the data
            event_table = readtable(obj.Path, opts);
        end

        function devices_table = grab_devices(obj, dataLines)
            %% Set up the Import Options and import the data
            opts = delimitedTextImportOptions("NumVariables", 275, "Encoding", "UTF-8");
            
            % Specify range and delimiter
            opts.DataLines = dataLines;
            opts.Delimiter = ",";
            
            % Specify column names and types
            opts.VariableNames = ["Frame", "SubFrame", "Fx", "Fy", "Fz", "Mx", "My", "Mz", "Cx", "Cy", "Cz", "Pin1", "Pin2", "Pin3", "Pin4", "Pin5", "Pin6", "Fx1", "Fy1", "Fz1", "Mx1", "My1", "Mz1", "Cx1", "Cy1", "Cz1", "Pin7", "Pin8", "Pin9", "Pin10", "Pin11", "Pin12", "VarName33", "VarName34", "VarName35", "VarName36", "VarName37", "VarName38", "VarName39", "VarName40", "VarName41", "VarName42", "VarName43", "VarName44", "VarName45", "VarName46", "VarName47", "VarName48", "FSWA", "FSWB", "EMG1", "EMG2", "EMG3", "EMG4", "EMG5", "EMG6", "EMG7", "EMG8", "EMG9", "EMG10", "EMG11", "EMG12", "EMG13", "EMG14", "EMG15", "EMG16", "ACCX1", "ACCY1", "ACCZ1", "ACCX2", "ACCY2", "ACCZ2", "ACCX3", "ACCY3", "ACCZ3", "ACCX4", "ACCY4", "ACCZ4", "ACCX5", "ACCY5", "ACCZ5", "ACCX6", "ACCY6", "ACCZ6", "ACCX7", "ACCY7", "ACCZ7", "ACCX8", "ACCY8", "ACCZ8", "ACCX9", "ACCY9", "ACCZ9", "ACCX10", "ACCY10", "ACCZ10", "ACCX11", "ACCY11", "ACCZ11", "ACCX12", "ACCY12", "ACCZ12", "ACCX13", "ACCY13", "ACCZ13", "ACCX14", "ACCY14", "ACCZ14", "ACCX15", "ACCY15", "ACCZ15", "ACCX16", "ACCY16", "ACCZ16", "IMEMG1", "IMEMG2", "IMEMG3", "IMEMG4", "IMEMG5", "IMEMG6", "IMEMG7", "IMEMG8", "IMEMG9", "IMEMG10", "IMEMG11", "IMEMG12", "IMEMG13", "IMEMG14", "IMEMG15", "IMEMG16", "ACCX17", "ACCY17", "ACCZ17", "GYROX1", "GYROY1", "GYROZ1", "MAGX1", "MAGY1", "MAGZ1", "ACCX18", "ACCY18", "ACCZ18", "GYROX2", "GYROY2", "GYROZ2", "MAGX2", "MAGY2", "MAGZ2", "ACCX19", "ACCY19", "ACCZ19", "GYROX3", "GYROY3", "GYROZ3", "MAGX3", "MAGY3", "MAGZ3", "ACCX20", "ACCY20", "ACCZ20", "GYROX4", "GYROY4", "GYROZ4", "MAGX4", "MAGY4", "MAGZ4", "ACCX21", "ACCY21", "ACCZ21", "GYROX5", "GYROY5", "GYROZ5", "MAGX5", "MAGY5", "MAGZ5", "ACCX22", "ACCY22", "ACCZ22", "GYROX6", "GYROY6", "GYROZ6", "MAGX6", "MAGY6", "MAGZ6", "ACCX23", "ACCY23", "ACCZ23", "GYROX7", "GYROY7", "GYROZ7", "MAGX7", "MAGY7", "MAGZ7", "ACCX24", "ACCY24", "ACCZ24", "GYROX8", "GYROY8", "GYROZ8", "MAGX8", "MAGY8", "MAGZ8", "ACCX25", "ACCY25", "ACCZ25", "GYROX9", "GYROY9", "GYROZ9", "MAGX9", "MAGY9", "MAGZ9", "ACCX26", "ACCY26", "ACCZ26", "GYROX10", "GYROY10", "GYROZ10", "MAGX10", "MAGY10", "MAGZ10", "ACCX27", "ACCY27", "ACCZ27", "GYROX11", "GYROY11", "GYROZ11", "MAGX11", "MAGY11", "MAGZ11", "ACCX28", "ACCY28", "ACCZ28", "GYROX12", "GYROY12", "GYROZ12", "MAGX12", "MAGY12", "MAGZ12", "ACCX29", "ACCY29", "ACCZ29", "GYROX13", "GYROY13", "GYROZ13", "MAGX13", "MAGY13", "MAGZ13", "ACCX30", "ACCY30", "ACCZ30", "GYROX14", "GYROY14", "GYROZ14", "MAGX14", "MAGY14", "MAGZ14", "ACCX31", "ACCY31", "ACCZ31", "GYROX15", "GYROY15", "GYROZ15", "MAGX15", "MAGY15", "MAGZ15", "ACCX32", "ACCY32", "ACCZ32", "GYROX16", "GYROY16", "GYROZ16", "MAGX16", "MAGY16", "MAGZ16", "VarName275"];
            opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "string"];
            
            % Specify file level properties
            opts.ExtraColumnsRule = "ignore";
            opts.EmptyLineRule = "read";
            
            % Specify variable properties
            opts = setvaropts(opts, "VarName275", "WhitespaceRule", "preserve");
            opts = setvaropts(opts, "VarName275", "EmptyFieldRule", "auto");
            
            % Import the data
            devices_table = readtable(obj.Path, opts);
            
            % Devices table Order:
            % FP1 - Force   FP1 - Moment	FP1 - CoP	FP1 - Raw	FP2 - Force	FP2 - Moment	FP2 - CoP	FP2 - Raw
        end
    
        function model_table = grab_model(obj, dataLines)            
            %% Set up the Import Options and import the data
            opts = delimitedTextImportOptions("NumVariables", 200, "Encoding", "UTF-8");
            
            % Specify range and delimiter
            opts.DataLines = dataLines;
            opts.Delimiter = ",";

            % Specify column names and types
            opts.VariableNames = ["Frame", "SubFrame", "X", "Y", "Z", "X1", "Y1", "Z1", "X2", "Y2", "Z2", "X3", "Y3", "Z3", "X4", "Y4", "Z4", "RX", "RY", "RZ", "TX", "TY", "TZ", "SX", "SY", "SZ", "RX1", "RY1", "RZ1", "TX1", "TY1", "TZ1", "SX1", "SY1", "SZ1", "X5", "Y5", "Z5", "X6", "Y6", "Z6", "X7", "Y7", "Z7", "X8", "Y8", "Z8", "X9", "Y9", "Z9", "X10", "Y10", "Z10", "X11", "Y11", "Z11", "X12", "Y12", "Z12", "X13", "Y13", "Z13", "X14", "Y14", "Z14", "X15", "Y15", "Z15", "X16", "Y16", "Z16", "X17", "Y17", "Z17", "RX2", "RY2", "RZ2", "TX2", "TY2", "TZ2", "SX2", "SY2", "SZ2", "RX3", "RY3", "RZ3", "TX3", "TY3", "TZ3", "SX3", "SY3", "SZ3", "RX4", "RY4", "RZ4", "TX4", "TY4", "TZ4", "SX4", "SY4", "SZ4", "RX5", "RY5", "RZ5", "TX5", "TY5", "TZ5", "SX5", "SY5", "SZ5", "X18", "Y18", "Z18", "X19", "Y19", "Z19", "X20", "Y20", "Z20", "X21", "Y21", "Z21", "X22", "Y22", "Z22", "RX6", "RY6", "RZ6", "TX6", "TY6", "TZ6", "SX6", "SY6", "SZ6", "RX7", "RY7", "RZ7", "TX7", "TY7", "TZ7", "SX7", "SY7", "SZ7", "X23", "Y23", "Z23", "X24", "Y24", "Z24", "X25", "Y25", "Z25", "X26", "Y26", "Z26", "X27", "Y27", "Z27", "X28", "Y28", "Z28", "X29", "Y29", "Z29", "X30", "Y30", "Z30", "X31", "Y31", "Z31", "X32", "Y32", "Z32", "X33", "Y33", "Z33", "X34", "Y34", "Z34", "X35", "Y35", "Z35", "RX8", "RY8", "RZ8", "TX8", "TY8", "TZ8", "SX8", "SY8", "SZ8", "RX9", "RY9", "RZ9", "TX9", "TY9", "TZ9", "SX9", "SY9", "SZ9"];
            opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
            
            % Specify file level properties
            opts.ExtraColumnsRule = "ignore";
            opts.EmptyLineRule = "read";
            
            % Import the data
            model_table = readtable(obj.Path, opts);
            
            % Model table Order:
            % LAbsAnkleAngle    LAnkleAngles	LAnkleForce	LAnkleMoment	LAnklePower	    LFE	    LFO	    LFootProgressAngles		LGroundReactionForce		LGroundReactionMoment		LHipAngles		LHipForce		LHipMoment		LHipPower		LKneeAngles		LKneeForce		LKneeMoment		LKneePower		LNormalisedGRF		LPelvisAngles		LTI     LTO     PEL			Pelvis			RAbsAnkleAngle		RAnkleAngles		RAnkleForce		RAnkleMoment		RAnklePower		RFE			RFO		RFootProgressAngles	    RGroundReactionForce			RGroundReactionMoment			RHipAngles			RHipForce			RHipMoment			RHipPower			RKneeAngles			RKneeForce		RKneeMoment		RKneePower		RNormalisedGRF		RPelvisAngles			RTI     RTO
        end

        function trajectories_table = grab_trajectories(obj, dataLines)
            %% Set up the Import Options and import the data
            opts = delimitedTextImportOptions("NumVariables", 50, "Encoding", "UTF-8");
            
            % Specify range and delimiter
            opts.DataLines = dataLines;
            opts.Delimiter = ",";

            % Specify column names and types
            opts.VariableNames = ["Frame", "SubFrame", "X", "Y", "Z", "X1", "Y1", "Z1", "X2", "Y2", "Z2", "X3", "Y3", "Z3", "X4", "Y4", "Z4", "X5", "Y5", "Z5", "X6", "Y6", "Z6", "X7", "Y7", "Z7", "X8", "Y8", "Z8", "X9", "Y9", "Z9", "X10", "Y10", "Z10", "X11", "Y11", "Z11", "X12", "Y12", "Z12", "X13", "Y13", "Z13", "X14", "Y14", "Z14", "X15", "Y15", "Z15"];
            opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
            
            % Specify file level properties
            opts.ExtraColumnsRule = "ignore";
            opts.EmptyLineRule = "read";
            
            % Import the data
            trajectories_table = readtable(obj.Path, opts);
        end
    
        function devices_timevec = get_devices_timevec(obj, fs)
            frame = table2array(obj.Devices_Table(:, "Frame"));
            subframe = table2array(obj.Devices_Table(:, "SubFrame"));
            subframes_per_frame = 18;
            devices_timevec = (frame*subframes_per_frame + subframe)/fs;
        end

        function model_timevec = get_model_timevec(obj, fs)
            frame = table2array(obj.Model_Table(:, "Frame"));
            model_timevec = frame/fs;
        end
        
        function traj_timevec = get_traj_timevec(obj, fs)
            frame = table2array(obj.Trajectories_Table(:, "Frame"));
            traj_timevec = frame/fs;
        end

        function left_FS = left_FS(obj)
            left_FS_table = obj.Events_Table((obj.Events_Table.Context == "Left") & (obj.Events_Table.Name == "Foot Strike"), "Times");
            left_FS = table2array(left_FS_table);
        end
        
        function left_FO = left_FO(obj)
            left_FO_table = obj.Events_Table((obj.Events_Table.Context == "Left") & (obj.Events_Table.Name == "Foot Off"), "Times");
            left_FO = table2array(left_FO_table);
        end

        function right_FS = right_FS(obj)
            right_FS_table = obj.Events_Table((obj.Events_Table.Context == "Right") & (obj.Events_Table.Name == "Foot Strike"), "Times");
            right_FS = table2array(right_FS_table);
        end
        
        function right_FO = right_FO(obj)
            right_FO_table = obj.Events_Table((obj.Events_Table.Context == "Right") & (obj.Events_Table.Name == "Foot Off"), "Times");
            right_FO = table2array(right_FO_table);
        end
    end
end

