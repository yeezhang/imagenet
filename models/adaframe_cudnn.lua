function createModel(nGPU)
   require 'cudnn'
   assert(nGPU == 1 or nGPU == 2, '1-GPU or 2-GPU supported for AlexNet')
   local features
   if nGPU == 1 then
      features = nn.Concat(2)
   else
      features = nn.ModelParallel(2)
   end

   local model = nn.Sequential() -- branch 1
   model:add(cudnn.SpatialConvolution(3,25,5,5,1,1,2,2))       -- 224 -> 224
   model:add(nn.SoftShrink(opt.threshold))

   return model
end
