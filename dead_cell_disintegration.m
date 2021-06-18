function [pointsmat] = dead_cell_disintegration(pointsmat,dead_cells,dage)


    % check is cell has finished "dying"/"disintegrating"
    locs_finished_dying = find(pointsmat(dead_cells,6) == dage);
    locs_notfinished_dying = find(pointsmat(dead_cells,6) ~= dage);
    
    %cell is now an empty cell
    pointsmat(dead_cells(locs_finished_dying),5) = 5; %change cell type to empty
    pointsmat(dead_cells(locs_finished_dying),6) = NaN; %cell has no age
    
    %cell is still dying
    pointsmat(dead_cells(locs_notfinished_dying),6) = pointsmat(dead_cells(locs_notfinished_dying),6)+1; %increase age in death
    pointsmat(locs_notfinished_dying,3) = pointsmat(locs_notfinished_dying,3)/8; %reduce spring length (further disintegration)
 
end