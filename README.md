# USFCA-Computer-Vision-Project

This Project was completed as part of a school project at the University of San Francisco. I alone cannot claim 100% credit for completing this project as it was a group effort.

The advising professor for this project was Shivani G. Shukla. Many thanks to her for her continuing support throughout the project!

	⁃	Our Objective: Create a computer vision model capable of using street cam imagery to differentiate between cars, bicycles, motorbikes, buses and pedestrians. Additional objectives would be detecting red light runners, average speed and other similar metrics.
	⁃	Problems Encountered: We initially struggled with getting the Keras library to operate properly in R but were able to solve the issue with help from Stack Overflow. We then noticed our model was not training properly. We had further issues due to the lack of data (images) outside of regular cars and pedestrians. Due to our timeframe constraints we settled on simply getting the model to track the number of cars and pedestrians in the data set. We did NOT optimize this model for use on a live video source due to lack of resources.
	⁃	Final Product: We were able to complete the project with our self-imposed restrictions within the timeframe. Our final product can successfully detect cars and pedestrians in it’s dataset, and in theory from other photo data sets or potentially even in live video.


The initial resources and reference for the project are here:
https://shirinsplayground.netlify.com/2018/06/keras_fruits/

https://blogs.rstudio.com/tensorflow/posts/2017-12-14-image-classification-on-small-datasets/

https://tensorflow.rstudio.com/tutorials/beginners/basic-ml/tutorial_basic_classification/

The street cam used to gather data is located here:
https://www.webcamtaxi.com/en/usa/california/castro-street-san-francisco.html