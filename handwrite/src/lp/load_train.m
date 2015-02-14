printf("Loading ...\n"); fflush(stdout);
root_data = "../../data";

tic();
X=get_pixels(sprintf("%s/train-images-idx3-ubyte",root_data));
y=get_labels(sprintf("%s/train-labels-idx1-ubyte",root_data));
toc();
printf("Ready :) \n")
