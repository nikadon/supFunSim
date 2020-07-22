close all

% load grid file here
load ftGRD0

ft_plot_mesh(ftLFG4_sshell.pos(ftLFG4_sshell.inside,:));
ft_plot_sens(ftGRD0,'unit', 'cm');

ccrender([-16,16],'finish','matte');

srcs = [RES(6).sources.candidate_number];
colors = jet(length(srcs))

for i = 1:length(srcs)
    ftLFG4_num = srcs(i);

    translX=ftLFG4_sshell.pos(ftLFG4_num,1);
    translY=ftLFG4_sshell.pos(ftLFG4_num,2);
    translZ=ftLFG4_sshell.pos(ftLFG4_num,3);
    radius=1;
    [posX,posY,posZ]=sphere(50);
    posX=posX*radius+translX;
    posY=posY*radius+translY;
    posZ=posZ*radius+translZ;

    % if only certain sources are to be plotted
    if(ismember(i,[1 2 3 4]))
        surface(posX,posY,posZ,'FaceColor',colors(i,:),'EdgeColor',colors(i,:),'FaceAlpha',0.50,'EdgeAlpha',0.50);
        zlabel('Z axis [cm]')
        ylabel('Y axis [cm]')
        xlabel('X axis [cm]')
    end
end

% coefficients correspond to the perceived centres of left- and right auditory areas on MEG ASSR data
for k = 1:8
    pdist2([-5 62 58; 3 -55 41],ftLFG4_sshell.pos([RES(k).sources.candidate_number],:)*10,'chebychev','Smallest',1)
    m(k) = mean(pdist2([-5 62 58; 3 -55 41],ftLFG4_sshell.pos([RES(k).sources.candidate_number],:)*10,'chebychev','Smallest',1));
end

m
find(m==min(m))
