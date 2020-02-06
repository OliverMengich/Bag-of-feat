category ={'stem_rust','leaf_rust','healthy_wheat'};
imds = imageDatastore(fullfile(category),'IncludeSubfolders',true,'LabelSource','foldernames');

%% Now to extract the features with bag of features technique


%bag = bagOfFeatures(imds,'VocabularySize',10000,'PointSelection','Detector');



%% 
%tic
%sceneData = double(encode(bag,imds));
%toc

%%
function [features,metrics] = exampleBagOfFeaturesColorExtractor(I)

[~,~,P] = size(I);
isColorImage = P == 3;
if isColorImage 
     Ilab = rgb2lab(I);
     Ilab = imresize(Ilab, 1/16); 
      [Mr,Nr,~] = size(Ilab);        
      colorFeatures = reshape(Ilab, Mr*Nr, []);
       rowNorm = sqrt(sum(colorFeatures.^2,2));    
       colorFeatures = bsxfun(@rdivide, colorFeatures, rowNorm + eps);
       xnorm = linspace(-0.5, 0.5, Nr);   
       ynorm = linspace(-0.5, 0.5, Mr); 
         [x, y] = meshgrid(xnorm, ynorm); 
          features = [colorFeatures y(:) x(:)]; 
           metrics  = var(colorFeatures(:,1:3),0,2); 
else
     features = zeros(0,5);  
     metrics  = zeros(0,1);
end
end
     

