%% Plot EC onto cortical model
close all
clear all


% Run
% matlab nodisplay -nosplash < plot_EC.m

load CortexModel V1cartx V2cartx V3cartx V1carty V2carty V3carty complexGrid

folder = '/home/nicogravel/Laminar_VisualFieldMapping/HCP_7T_prep/figures/'
conditions = {'RET','MOV','REST'};
dirCons = {'feedback','feedforward'};

prctl = '_95'
load EC_7HCP_links_95 EC_links

%prctl = '_90'
%load EC_7HCP_links_90 EC_links

for cond = 1:3
    for dir = 1:2
        
        condition = conditions{cond};
        dirCon = dirCons{dir};
        
        % 'FU,PU,FL,PL...
        ecc= [0.78 3.25 0.78 3.25];
        pol= [-0.3 -1.25 0.3 1.25];
        q = 0.15;
        d = -5;
        
        switch condition
           
            case 'RET';
                %load EC_7HCP_links EC_links
                EClinksmean = EC_links(1,:);
                A = zeros(1,576);
                A(find(EClinksmean))=1;
                sA = reshape(A,24,24)';
                C =  reshape(EClinksmean,24,24)';
                EC = C.*sA;
            case 'MOV';
                %load EC_7HCP_links EC_links
                EClinksmean = EC_links(2,:);
                A = zeros(1,576);
                A(find(EClinksmean))=1;
                sA = reshape(A,24,24)';
                C =  reshape(EClinksmean,24,24)';
                EC = C.*sA;
            case 'REST';
                %load EC_7HCP_links EC_links
                EClinksmean = EC_links(3,:);
                A = zeros(1,576);
                A(find(EClinksmean))=1;
                sA = reshape(A,24,24)';
                C =  reshape(EClinksmean,24,24)';
                EC = C.*sA;
        end
        
        %figure,hist(nonzeros(EC(:)))
        
        minV = min(nonzeros(EC(:)));
        maxV = max(EC(:));
        
        ranges{cond,dir} = [minV,maxV];
        
        minV = 0.0018;
        maxV = 0.0059;
        
        switch dirCon
            case 'feedback';
                B = zeros(size(C));
                up = triu(ones(size(C)/2),1);
                B(1:12,13:24) = up;
                B(1:12,1:12) = up;
                B(13:24,13:24) = up;
                B(13:24,1:12) = up;
                
                L = [ones(4) zeros(4) zeros(4) ones(4) zeros(4) zeros(4);...
                    zeros(4) ones(4) zeros(4) zeros(4) ones(4) zeros(4);...
                    zeros(4) zeros(4) ones(4) zeros(4) zeros(4) ones(4);...
                    ones(4) zeros(4) zeros(4) ones(4) zeros(4) zeros(4);...
                    zeros(4) ones(4) zeros(4) zeros(4) ones(4) zeros(4);...
                    zeros(4) zeros(4) ones(4) zeros(4) zeros(4) ones(4)]
                B = B.*imcomplement(L);
            case 'feedforward';
                B = zeros(size(C));
                low = tril(ones(size(C)/2),-1);
                B(1:12,13:24) = low;
                B(1:12,1:12) = low;
                B(13:24,13:24) = low;
                B(13:24,1:12) = low;
                L = [ones(4) zeros(4) zeros(4) ones(4) zeros(4) zeros(4);...
                    zeros(4) ones(4) zeros(4) zeros(4) ones(4) zeros(4);...
                    zeros(4) zeros(4) ones(4) zeros(4) zeros(4) ones(4);...
                    ones(4) zeros(4) zeros(4) ones(4) zeros(4) zeros(4);...
                    zeros(4) ones(4) zeros(4) zeros(4) ones(4) zeros(4);...
                    zeros(4) zeros(4) ones(4) zeros(4) zeros(4) ones(4)]
                B = B.*imcomplement(L);
        end
        
        %% Match EC topography with cortical model
        Idx = knnsearch(complexGrid',[ecc;pol]');
        complexGrid(1,Idx);
        complexGrid(2,Idx);
        coordsV1_lh = [...
            [V1cartx(Idx(1)),V1carty(Idx(1))];...
            [V1cartx(Idx(2)),V1carty(Idx(2))];...
            [V1cartx(Idx(3)),V1carty(Idx(3))];...
            [V1cartx(Idx(4)),V1carty(Idx(4))]];
        coordsV2_lh = [...
            [V2cartx(Idx(1))+q,V2carty(Idx(1))];...
            [V2cartx(Idx(2))+q,V2carty(Idx(2))];...
            [V2cartx(Idx(3))+q,V2carty(Idx(3))];...
            [V2cartx(Idx(4))+q,V2carty(Idx(4))]];
        coordsV3_lh = [...
            [V3cartx(Idx(1)),V3carty(Idx(1))];...
            [V3cartx(Idx(2)),V3carty(Idx(2))];...
            [V3cartx(Idx(3)),V3carty(Idx(3))];...
            [V3cartx(Idx(4)),V3carty(Idx(4))]];
        
        coordsV1_rh = [...
            [-1*V1cartx(Idx(1))+d,V1carty(Idx(1))];...
            [-1*V1cartx(Idx(2))+d,V1carty(Idx(2))];...
            [-1*V1cartx(Idx(3))+d,V1carty(Idx(3))];...
            [-1*V1cartx(Idx(4))+d,V1carty(Idx(4))]];
        coordsV2_rh = [...
            [-1*V2cartx(Idx(1))+d-q,V2carty(Idx(1))];...
            [-1*V2cartx(Idx(2))+d-q,V2carty(Idx(2))];...
            [-1*V2cartx(Idx(3))+d-q,V2carty(Idx(3))];...
            [-1*V2cartx(Idx(4))+d-q,V2carty(Idx(4))]];
        coordsV3_rh = [...
            [-1*V3cartx(Idx(1))+d,V3carty(Idx(1))];...
            [-1*V3cartx(Idx(2))+d,V3carty(Idx(2))];...
            [-1*V3cartx(Idx(3))+d,V3carty(Idx(3))];...
            [-1*V3cartx(Idx(4))+d,V3carty(Idx(4))]];
        
        
        %% Figure
        figure,
        pos = get(gcf, 'Position');
        set(gcf, 'Position', [pos(1) pos(2) 800, 800]); % Set plot size,
        %% Cortical model
        colors=[0.6 0.6 0.6; 0.6 0.6 0.6; 0.6 0.6 0.6];
        % L
        hh=plot(V1cartx,V1carty,'.'); set(hh,'color',colors(1,:));
        hold on
        hh=plot(V2cartx,V2carty,'.'); set(hh,'color',colors(2,:));
        hh=plot(V3cartx,V3carty,'.'); set(hh,'color',colors(3,:));
        % R
        hh=plot(-1*V1cartx+d,V1carty,'.'); set(hh,'color',colors(1,:));
        hh=plot(-1*V2cartx+d,V2carty,'.'); set(hh,'color',colors(2,:));
        hh=plot(-1*V3cartx+d,V3carty,'.'); set(hh,'color',colors(3,:));
        
        %% Within hemisphere EC (no lateral)
        A = [ones(12) zeros(12) ; zeros(12) ones(12)];
        L = [ones(4) zeros(4) zeros(4) zeros(4) zeros(4) zeros(4);...
            zeros(4) ones(4) zeros(4) zeros(4) zeros(4) zeros(4);...
            zeros(4) zeros(4) ones(4) zeros(4) zeros(4) zeros(4);...
            zeros(4) zeros(4) zeros(4) ones(4) zeros(4) zeros(4);...
            zeros(4) zeros(4) zeros(4) zeros(4) ones(4) zeros(4);...
            zeros(4) zeros(4) zeros(4) zeros(4) zeros(4) ones(4)]
        D = (B.*sA).*A.*imcomplement(L);
        % D = (B.*sA).*A;
        idx = find(D);
        nnz(D);
        switch dirCon
            case 'feedback';
                [xx,yy] = adjacency_plot_und(D,[coordsV1_lh;coordsV2_lh;coordsV3_lh;...
                    coordsV1_rh;coordsV2_rh;coordsV3_rh]);
            case 'feedforward'
                [xx,yy] = adjacency_plot_und(rot90(fliplr(D),1),[coordsV1_lh;coordsV2_lh;coordsV3_lh;...
                    coordsV1_rh;coordsV2_rh;coordsV3_rh]);
        end
        cmap = C(idx);
        maxv = max(cmap);
        cmap = floor((double(cmap) ./ maxV) .* 100);
        l = 0;
        colorMatrix = parula(100);
        
        for n = 1:numel(cmap)
            l = l+3;
            if cmap(n)==0;
                col = [0 0 0];
            else
                col = colorMatrix(cmap(n),:);
            end
            x = xx(l-2:l-1);
            y = yy(l-2:l-1);
            p0 = [x(1),y(1)];
            p1 = [x(2),y(2)];
            global ColorOrder, ColorOrder=[];
            set(gca,'ColorOrder',colorMatrix(cmap(n),:));
            global LineWidthOrder, LineWidthOrder= [3];
            switch dirCon
                case 'feedback';
                    arrow3(p1,p0,'o/',1,1);
                case 'feedforward'
                    arrow3(p0,p1,'o/',1,1);
            end
            %     patchline(xx(l-2:l-1),yy(l-2:l-1),'linestyle','-','edgecolor',colorMatrix(cmap(n),:),'linewidth',3,'edgealpha',1);
        end
        
        %% Inter
        A = [ones(12) zeros(12) ; zeros(12) ones(12)];
        A = flipud(A);
        %% Left to rigth hemisphere
        D = (B.*sA).*tril(A,-1);
        idx = find(D);
        nnz(D)
        [xx,yy] = adjacency_plot_und(rot90(fliplr(D),1),[coordsV1_lh;coordsV2_lh;coordsV3_lh;...
            coordsV1_rh;coordsV2_rh;coordsV3_rh]);
        cmap = C(idx);
        maxv = max(cmap)
        cmap = floor((double(cmap) ./ maxV) .* 100);
        colorMatrix = parula(100);
        l = 0;
        for n = 1:numel(cmap)
            l = l+3;
            if cmap(n)==0;
                col = [0 0 0];
            else
                col = colorMatrix(cmap(n),:);
            end
            x = xx(l-2:l-1);
            y = yy(l-2:l-1);
            p0 = [x(1),y(1)];
            p1 = [x(2),y(2)];
            global ColorOrder, ColorOrder=[];
            set(gca,'ColorOrder',colorMatrix(cmap(n),:));
            global LineWidthOrder, LineWidthOrder= [3];
            switch dirCon
                case 'feedback';
                    arrow3(p0,p1,'o/',1,1);
                case 'feedforward'
                    arrow3(p0,p1,'o/',1,1);
            end
        end
        
        %% R to L
        D = (B.*sA).*triu(A,1);
        idx = find(D);
        nnz(D)
        [xx,yy] = adjacency_plot_und(D,[coordsV1_lh;coordsV2_lh;coordsV3_lh;...
            coordsV1_rh;coordsV2_rh;coordsV3_rh]);
        cmap = C(idx);
        maxv = max(cmap)
        cmap = floor((double(cmap) ./ maxV) .* 100);
        colorMatrix = parula(100);
        l = 0;
        for n = 1:numel(cmap)
            l = l+3
            if cmap(n)==0;
                col = [0 0 0];
            else
                col = colorMatrix(cmap(n),:);
            end
            x = xx(l-2:l-1);
            y = yy(l-2:l-1);
            p0 = [x(1),y(1)];
            p1 = [x(2),y(2)];
            global ColorOrder, ColorOrder=[];
            set(gca,'ColorOrder',colorMatrix(cmap(n),:));
            global LineWidthOrder, LineWidthOrder= [3];
            switch dirCon
                case 'feedback';
                    arrow3(p1,p0,'o/',1,1);
                case 'feedforward'
                    arrow3(p1,p0,'o/',1,1);
            end
        end
        colormap parula
        axis equal, axis off;
        set(gca,'XTick', '');
        set(gca,'YTick', '');
        set(gca,'box','off');
        set(gcf, 'color', 'k');
        set(gca, 'color', 'k','FontName','Helvetica Neue','FontSize',22,'LineWidth', 2);
        caxis([minV maxV]);
        
        %h = colorbar('YTickLabel',{num2str(0),'','','','',num2str(maxv)},...
        %    'FontSize',18,'FontWeight','Bold','Position',[.8 .7 .05 .2],'Color','w');
        % h =
        %colorbar('YTickLabel',{num2str(0),'','','','',num2str(round(maxv),2))},...
        %     'FontSize',18,'FontWeight','Bold','Position',[.8 .7 .05 .2],'Color','w'); ylabel(h, 'EC','FontSize',22); caxis([0 100]);
        %view([-20 20]); view([-32 -6]); % camzoom(0.8);
        
        %% Save
        switch dirCon
            case 'feedback';
                switch condition
                    case 'RS';
                        title('Feedback RS','FontSize',28,'FontWeight','Bold','Color','w');
                        fname = 'CortexModel_EC_fb_rs';
                    case 'VFM';
                        title('Feedback VFM','FontSize',28,'FontWeight','Bold','Color','w');
                        fname = 'CortexModel_EC_fb_vfm';
                    case 'MOV';
                        title('Feedback MOVIE','FontSize',28,'FontWeight','Bold','Color','w');
                        fname = 'CortexModel_HCP_EC_fb_mov';
                    case 'REST';
                        title('Feedback RS','FontSize',28,'FontWeight','Bold','Color','w');
                        fname = 'CortexModel_HCP_EC_fb_rest';
                    case 'RET';
                        title('Feedback VFM','FontSize',28,'FontWeight','Bold','Color','w');
                        fname = 'CortexModel_HCP_EC_fb_vfm';
                end
            case 'feedforward'
                title('Feedforward','FontSize',28,'FontWeight','Bold','Color','w');
                switch condition
                    case 'RS';
                        title('Feedforward RS','FontSize',28,'FontWeight','Bold','Color','w');
                        fname = 'CortexModel_EC_ff_rs';
                    case 'VFM';
                        title('Feedforward VFM','FontSize',28,'FontWeight','Bold','Color','w');
                        fname = 'CortexModel_EC_ff_vfm';         
                    case 'MOV';
                        title('Feedforward MOVIE','FontSize',28,'FontWeight','Bold','Color','w');
                        fname = 'CortexModel_HCP_EC_ff_mov';
                    case 'REST';
                        title('Feedforward RS','FontSize',28,'FontWeight','Bold','Color','w');
                        fname = 'CortexModel_HCP_EC_ff_rest';
                    case 'RET';
                        title('Feedforward VFM','FontSize',28,'FontWeight','Bold','Color','w');
                        fname = 'CortexModel_HCP_EC_ff_vfm';
                end
        end
        set(gcf, 'InvertHardCopy', 'off');
        print(gcf, strcat(folder, fname,num2str(prctl),'.png'), '-dpng', '-r300', '-painters')
    end
end