#install.packages("keras")
#install.packages("tensorflow")

library(keras)
library(tensorflow)
library(reticulate)



#List of image types to model
image_list <- c("car","pedestrian")

output_result <- length(image_list) #restricting outputs to image types

#Scaling images
img_width <-100
img_height <- 100
target_size <- c(img_height,img_width)

# RGB = 3 channels
channels <- 3

#Creating pathway to images ----- YOU MUST CREATE YOUR OWN PATHWAY IN ORDER FOR THE MODEL TO CORRECTLY ACCESS THE DATASET ------

#training_images_pathway <- "/Users/MK//Downloads/Project/train"

#test_images_pathway <- "/Users/MK/Downloads/Project/test"


#-----Loading images into memory--

train_data_gen = image_data_generator(rescale = 1/255, 
                                      width_shift_range = 0.1,
                                      height_shift_range = 0.1)

test_data_gen = image_data_generator(rescale = 1/255)




#training images

training_array_gen <- flow_images_from_directory(training_images_pathway, train_data_gen,
                                                 target_size = target_size,
                                                 class_mode = "categorical",
                                                 classes = image_list)

test_image_array_gen <- flow_images_from_directory(test_images_pathway, test_data_gen,
                                                   target_size = target_size,
                                                   class_mode = "categorical",
                                                   classes = image_list)
cat("Number of images: ")

table(factor(training_array_gen$classes))

training_array_gen$class_indices

table(factor(test_image_array_gen$classes))

test_image_array_gen$class_indices

###################################################################





# number of training samples
train_samples <- training_array_gen$n
# number of validation samples
valid_samples <- test_image_array_gen$n

# define batch size and number of epochs
batch_size <- 100
epochs <- 10


# initialise model
model <- keras_model_sequential()

# add layers
model %>%
  layer_conv_2d(filter = 32, kernel_size = c(3,3), padding = "same", input_shape = c(img_width, img_height, channels)) %>%
  layer_activation("relu") %>%
  
  # Second hidden layer
  layer_conv_2d(filter = 16, kernel_size = c(3,3), padding = "same") %>%
  layer_activation_leaky_relu(0.5) %>%
  layer_batch_normalization() %>%
  
  # Use max pooling
  layer_max_pooling_2d(pool_size = c(2,2)) %>%
  layer_dropout(0.25) %>%
  
  # Flatten max filtered output into feature vector 
  # and feed into dense layer
  layer_flatten() %>%
  layer_dense(100) %>%
  layer_activation("relu") %>%
  layer_dropout(0.5) %>%
  
  # Outputs from dense layer are projected onto output layer
  layer_dense(output_result) %>% 
  layer_activation("softmax")

# compile
model %>% compile(
  loss = "categorical_crossentropy",
  optimizer = optimizer_rmsprop(lr = 0.0001, decay = 1e-6),
  metrics = "accuracy"
)


hist <- model %>% fit_generator(
  # training data
  training_array_gen,
  
  # epochs
  steps_per_epoch = as.integer(train_samples / batch_size), 
  epochs = epochs, 
  
  # validation data
  validation_data = test_image_array_gen,
  validation_steps = as.integer(valid_samples / batch_size),
  verbose = 2
)



