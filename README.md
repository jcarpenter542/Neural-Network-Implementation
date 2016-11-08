# Neural-Networks-Implementation
This implementation of neural networks takes scholarly articles in the field of Cognitive Psychology and classifies them into a category.

If you are interested in the bigger picture of the project, please see "Final Project Writeup.docx". This document specifies the steps it took to go from 120 scholarly article PDFs to classified documents according to relative word frequency. Additionally, it mentions how we can take a novel article and find the top 30 most similar articles to that article (from within the set of preprocessed text files). Note that this was a class project completed in only 3 weeks.

There are two different types of neural network implementations included in this repository:
1) Supervised learning via a Perceptron with backpropagation. To test the Perceptron, run the file "perceptronFinal.m".
2) Semi-supervised learning via a Self-Organizing Map (SOM) of various lattice sizes. To test the SOM, run the file "SOMFinal.m". 
    Both of these files make use of the "variables20.mat" file, which has all of the documents already preprocessed, placed into a feature matrix, and with Principal Components Analysis (PCA) performed on them. These steps are removed for simplicity of the repository. If you would like to run the code from the beginning and do the first few steps yourself, please contact the repository creator, Jason Carpenter and he will send you the code. However, the preprocessed "Text Files.zip" are included for your reference so you can see what the result of preprocessing looks like.



