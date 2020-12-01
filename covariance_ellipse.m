function covariance_ellipse(Y,std_devs,dot_size,dot_color,line_color,line_width)
%% Draws covariance ellipse around 2-dimensional set of points - by EV
%% INPUTS (REQUIRED):
%% Y - 2-dimensional points - n x 2
%% std_devs - how many standard deviatons should the contour cover (default 3 --- 99% of probability mass)
%% INPUTS (OPTIONAL):
%% dot_size - size of dots
%% dot_color - color of dots
%% line_color - color of contour line
%% line_width - color of contour line

%% by E.V.

if nargin<2
    Y=mvnrnd([0;0],[1 0.2;0.2 1],1000); %% demo points
    std_devs=3; %% 3 standard deviations contour
end

if nargin<3
    dot_size=10;
    dot_color='b';
    line_color='r';
    line_width=2;
end

%%sample grid that covers the range of points
x1 = linspace(min(Y(:,1)),max(Y(:,1)),256); 
x2 = linspace(min(Y(:,2)),max(Y(:,2)),256);
[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)]; 

%% compute mean and covariance of sample points
mu=mean(Y,1);
sigma=cov(Y);

%% estimate probability contour at grid locations
y = mvnpdf(X,mu,sigma*std_devs);
y = reshape(y,length(x2),length(x1));

%% plot original dots
plot(Y(:,1),Y(:,2),'.','MarkerSize',dot_size,'MarkerEdgeColor',dot_color);
hold on
%% plot the confidence band contour
contour(x1,x2,y,1,'LineColor',line_color,'LineWidth',line_width);
hold off
end