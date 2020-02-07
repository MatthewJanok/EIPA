clc
clear


nx = 50;
ny = 50;
B = zeros((nx*ny),1);
E = zeros((nx*ny),1);

G = sparse((nx*ny), (nx*ny));



%Set diagonal
for j = 1:ny
    for i = 1:nx
        %Mapping
        n = i+(j-1)*nx;
        nxm = (i-1)+(j-1)*nx;
        nxp = (i+1)+(j-1)*nx;
        nym = (i)+(j-2)*nx;
        nyp = (i)+(j)*nx;
        
       
        
        %Set the Boundary Nodes
        if i == 1
            G(n,n) = 1;
        elseif i == nx
            G(n,n) = 1;
        elseif j == 1
            G(n,n) = 1;
        elseif j == ny
            G(n,n) = 1;
        else

            %Set the Bulk Nodes
            if i < 20 && i > 10 && j<20 && j>10
                G(n,n) = -2
            else
                G(n,n) = -4;
            end
                G(n,nxm) = 1;
                G(n,nxp) = 1;
                G(n,nym) = 1;
                G(n,nyp) = 1;
        end
           
       
        
        
    end
end

spy(G)

[E,D] = eigs(G,9,'SM');
Dv = zeros(9,1);

xlbl = linspace(1, 9, 9);
for k = 1:9
    Dv(k,1) = D(k,k);
end

plot(xlbl, Dv)

Select = zeros(nx,ny);
for C = 1:9
    for j = 1:ny
        for i = 1:nx
            n = i+(j-1)*nx;
            Select(i,j) = E(n,C);
        end
    end
    figure(C)
    surf(Select)
end













